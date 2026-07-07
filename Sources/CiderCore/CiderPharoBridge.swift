import Foundation

public struct CiderPharoBridge: Sendable {
    public struct Configuration: Equatable, Sendable {
        public var pharoExecutable: URL
        public var image: URL
        public var workingDirectory: URL
        public var home: URL

        public init(
            pharoExecutable: URL,
            image: URL,
            workingDirectory: URL,
            home: URL
        ) {
            self.pharoExecutable = pharoExecutable
            self.image = image
            self.workingDirectory = workingDirectory
            self.home = home
        }

        public static func preparedLocal(
            workingDirectory: URL = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
        ) throws -> Configuration {
            let root = workingDirectory.standardizedFileURL
            let buildDirectory = root.appendingPathComponent(".build/pharo", isDirectory: true)
            return try preparedLocal(
                envFile: buildDirectory.appendingPathComponent("env"),
                workingDirectory: root
            )
        }

        public static func preparedLocal(envFile: URL, workingDirectory: URL) throws -> Configuration {
            let root = workingDirectory.standardizedFileURL
            let env = try EnvironmentFile.load(from: envFile)

            guard let pharoExecutable = env["CIDER_PHARO_VM"] else {
                throw Failure.missingEnvironmentValue("CIDER_PHARO_VM")
            }
            guard let image = env["CIDER_PHARO_IMAGE"] else {
                throw Failure.missingEnvironmentValue("CIDER_PHARO_IMAGE")
            }

            return Configuration(
                pharoExecutable: URL(fileURLWithPath: pharoExecutable),
                image: URL(fileURLWithPath: image),
                workingDirectory: root,
                home: URL(
                    fileURLWithPath: env["CIDER_PHARO_HOME"]
                        ?? envFile.deletingLastPathComponent().appendingPathComponent("home").path
                )
            )
        }
    }

    public enum Failure: Error, Equatable, Sendable {
        case missingEnvironmentFile(String)
        case missingEnvironmentValue(String)
        case pharoFailed(status: Int32, stderr: String)
    }

    private enum EnvironmentFile {
        static func load(from url: URL) throws -> [String: String] {
            guard FileManager.default.fileExists(atPath: url.path) else {
                throw Failure.missingEnvironmentFile(url.path)
            }

            let contents = try String(contentsOf: url, encoding: .utf8)
            return contents
                .split(whereSeparator: \.isNewline)
                .map(String.init)
                .reduce(into: [:]) { values, line in
                    let parts = line.split(separator: "=", maxSplits: 1).map(String.init)
                    guard parts.count == 2 else {
                        return
                    }
                    values[parts[0]] = parts[1]
                }
        }
    }

    public var configuration: Configuration

    public init(configuration: Configuration) {
        self.configuration = configuration
    }

    public static func preparedLocal(
        workingDirectory: URL = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
    ) throws -> CiderPharoBridge {
        try CiderPharoBridge(configuration: .preparedLocal(workingDirectory: workingDirectory))
    }

    public func run(script: String) async throws -> String {
        try await Task.detached(priority: .userInitiated) {
            try runPharo(configuration: configuration, script: script)
        }.value
    }

    public func events(from script: String) async throws -> [CiderWireEvent] {
        let output = try await run(script: script)
        return try CiderWireOutput.decodeEvents(from: output)
    }

    public func model(from script: String) async throws -> CiderSpecModel {
        try await CiderSpecModel.build(from: events(from: script))
    }
}

private func runPharo(configuration: CiderPharoBridge.Configuration, script: String) throws -> String {
    let process = Process()
    let output = Pipe()
    let error = Pipe()

    process.executableURL = configuration.pharoExecutable
    process.arguments = [
        "--headless",
        configuration.image.path,
        "st",
        script
    ]
    process.currentDirectoryURL = configuration.workingDirectory
    process.environment = ProcessInfo.processInfo.environment.merging([
        "HOME": configuration.home.path
    ]) { _, new in new }
    process.standardOutput = output
    process.standardError = error

    try process.run()
    process.waitUntilExit()

    let outputData = output.fileHandleForReading.readDataToEndOfFile()
    let errorData = error.fileHandleForReading.readDataToEndOfFile()
    let stderr = String(data: errorData, encoding: .utf8) ?? ""

    guard process.terminationStatus == 0 else {
        throw CiderPharoBridge.Failure.pharoFailed(
            status: process.terminationStatus,
            stderr: stderr
        )
    }

    return String(data: outputData, encoding: .utf8) ?? ""
}
