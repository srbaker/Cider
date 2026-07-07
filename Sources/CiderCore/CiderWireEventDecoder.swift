import Foundation

public enum CiderWireEventDecoder {
    public enum Failure: Error, Equatable, Sendable {
        case invalidLine(String)
    }

    public static let linePrefix = "CIDER:"

    public static func decodeEvents(from text: String) throws -> [CiderWireEvent] {
        try text
            .split(whereSeparator: \.isNewline)
            .map(String.init)
            .filter { !$0.isEmpty }
            .map(decodeLine)
    }

    public static func decodeLine(_ line: String) throws -> CiderWireEvent {
        guard line.hasPrefix(linePrefix) else {
            throw Failure.invalidLine(line)
        }

        let json = line.dropFirst(linePrefix.count)
        let data = Data(json.utf8)
        return try JSONDecoder().decode(CiderWireEvent.self, from: data)
    }
}
