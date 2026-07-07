import Foundation

public final class CiderPharoLiveSession: @unchecked Sendable {
    public enum Failure: Error, Equatable, Sendable {
        case processEnded
    }

    private let process: Process
    private let input: FileHandle
    private let output: FileHandle
    private let readQueue = DispatchQueue(label: "dev.sidechain.Cider.live-pharo-session.read")
    private let writeQueue = DispatchQueue(label: "dev.sidechain.Cider.live-pharo-session.write")
    private var outputBuffer = Data()

    public init(configuration: CiderPharoBridge.Configuration, script: String) throws {
        let process = Process()
        let inputPipe = Pipe()
        let outputPipe = Pipe()
        let errorPipe = Pipe()

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
        process.standardInput = inputPipe
        process.standardOutput = outputPipe
        process.standardError = errorPipe

        self.process = process
        input = inputPipe.fileHandleForWriting
        output = outputPipe.fileHandleForReading

        try process.run()
    }

    deinit {
        close()
    }

    public static func preparedLocal(
        script: String,
        workingDirectory: URL = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
    ) throws -> CiderPharoLiveSession {
        try CiderPharoLiveSession(
            configuration: .preparedLocal(workingDirectory: workingDirectory),
            script: script
        )
    }

    public func readInitialEvents() async throws -> [CiderWireEvent] {
        try await withCheckedThrowingContinuation { continuation in
            readQueue.async {
                do {
                    var events: [CiderWireEvent] = []
                    while true {
                        let event = try self.readEventLocked()
                        events.append(event)
                        if event.kind == .windowPresenterSet {
                            continuation.resume(returning: events)
                            return
                        }
                    }
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }

    public func readEvent() async throws -> CiderWireEvent {
        try await withCheckedThrowingContinuation { continuation in
            readQueue.async {
                do {
                    continuation.resume(returning: try self.readEventLocked())
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }

    public func clickButton(id: String) async throws {
        let event = CiderWireEvent(
            receiver: "SpButtonPresenter",
            selector: "click",
            id: id
        )
        try await send(event)
    }

    public func selectListIndexes(id: String, indexes: [Int]) async throws {
        let event = CiderWireEvent(
            receiver: "SpListPresenter",
            selector: "selectedIndexes:",
            id: id,
            selectedIndexes: indexes
        )
        try await send(event)
    }

    public func selectTreePaths(id: String, paths: [[Int]]) async throws {
        let event = CiderWireEvent(
            receiver: "SpTreePresenter",
            selector: "selectedPaths:",
            id: id,
            selectedPaths: paths
        )
        try await send(event)
    }

    public func setTextInput(id: String, text: String) async throws {
        let event = CiderWireEvent(
            receiver: "SpTextInputFieldPresenter",
            selector: "text:",
            id: id,
            text: text
        )
        try await send(event)
    }

    public func send(_ event: CiderWireEvent) async throws {
        try await withCheckedThrowingContinuation { continuation in
            writeQueue.async {
                do {
                    let payload = try JSONEncoder().encode(event)
                    var line = Data("CIDER:".utf8)
                    line.append(payload)
                    line.append(0x0A)
                    try self.input.write(contentsOf: line)
                    continuation.resume()
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }

    public func close() {
        writeQueue.sync {
            try? input.close()
            if process.isRunning {
                process.terminate()
            }
        }
    }

    private func readEventLocked() throws -> CiderWireEvent {
        while true {
            guard let line = try readLineLocked() else {
                throw Failure.processEnded
            }
            guard line.hasPrefix(CiderWireEventDecoder.linePrefix) else {
                continue
            }
            return try CiderWireEventDecoder.decodeLine(line)
        }
    }

    private func readLineLocked() throws -> String? {
        while true {
            if let newlineRange = outputBuffer.firstRange(of: Data([0x0A])) {
                let lineData = outputBuffer[..<newlineRange.lowerBound]
                outputBuffer.removeSubrange(...newlineRange.lowerBound)
                return String(data: lineData, encoding: .utf8)
            }

            let data = output.availableData
            if data.isEmpty {
                if outputBuffer.isEmpty {
                    return nil
                }
                let line = String(data: outputBuffer, encoding: .utf8)
                outputBuffer.removeAll()
                return line
            }
            outputBuffer.append(data)
        }
    }
}
