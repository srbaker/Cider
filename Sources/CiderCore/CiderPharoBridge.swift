import Foundation

public struct CiderPharoBridge: Sendable {
    public struct Configuration: Equatable, Sendable {
        public var pharoExecutable: URL
        public var image: URL
        public var workingDirectory: URL
        public var home: URL
        public var script: String

        public init(
            pharoExecutable: URL,
            image: URL,
            workingDirectory: URL,
            home: URL,
            script: String = "pharo/scripts/emit-hello-world.st"
        ) {
            self.pharoExecutable = pharoExecutable
            self.image = image
            self.workingDirectory = workingDirectory
            self.home = home
            self.script = script
        }

        public static func preparedLocal(
            workingDirectory: URL = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
        ) throws -> Configuration {
            let root = workingDirectory.standardizedFileURL
            let buildDirectory = root.appendingPathComponent(".build/pharo", isDirectory: true)
            let env = try EnvironmentFile.load(from: buildDirectory.appendingPathComponent("env"))

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
                home: URL(fileURLWithPath: env["CIDER_PHARO_HOME"] ?? buildDirectory.appendingPathComponent("home").path)
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

    public func helloWorldEvents() async throws -> [CiderWireEvent] {
        let output = try await runHelloWorld()
        return try CiderWireOutput.decodeEvents(from: output)
    }

    public func helloWorldModel() async throws -> CiderSpecModel {
        try await CiderSpecModel.build(from: helloWorldEvents())
    }

    private func runHelloWorld() async throws -> String {
        try await Task.detached(priority: .userInitiated) {
            try runPharo(configuration: configuration)
        }.value
    }
}

private func runPharo(configuration: CiderPharoBridge.Configuration) throws -> String {
    let process = Process()
    let output = Pipe()
    let error = Pipe()

    process.executableURL = configuration.pharoExecutable
    process.arguments = [
        "--headless",
        configuration.image.path,
        "st",
        configuration.script
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
