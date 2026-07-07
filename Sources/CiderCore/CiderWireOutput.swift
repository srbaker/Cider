public enum CiderWireOutput {
    public static func ciderLines(in text: String) -> [String] {
        text
            .split(whereSeparator: \.isNewline)
            .map(String.init)
            .filter { $0.hasPrefix(CiderWireEventDecoder.linePrefix) }
    }

    public static func decodeEvents(from text: String) throws -> [CiderWireEvent] {
        try ciderLines(in: text).map(CiderWireEventDecoder.decodeLine)
    }
}
