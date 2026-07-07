import Foundation

public enum CiderWireFixture {
    public enum Failure: Error, Equatable, Sendable {
        case missingResource(String)
    }

    public static func helloWorldText() throws -> String {
        guard let url = Bundle.module.url(
            forResource: "hello-world",
            withExtension: "ndjson"
        ) else {
            throw Failure.missingResource("hello-world.ndjson")
        }

        return try String(contentsOf: url, encoding: .utf8)
    }

    public static func helloWorldEvents() throws -> [CiderWireEvent] {
        try CiderWireEventDecoder.decodeEvents(from: helloWorldText())
    }

    public static func helloWorldModel() throws -> CiderSpecModel {
        try CiderSpecModel.build(from: helloWorldEvents())
    }
}
