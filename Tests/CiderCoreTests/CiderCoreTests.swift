import CiderCore
import Foundation
import Testing

@Test func ciderCoreModuleIsImportable() {
    let model = CiderAppModel()

    #expect(model.title == "Cider")
}

@Test func ciderWireDecoderParsesSpecShapedEvents() throws {
    let events = try CiderWireFixture.helloWorldEvents()

    #expect(events.map(\.kind) == [
        .windowOpen,
        .boxLayoutBuild,
        .labelPresenterBuild,
        .boxLayoutAdd,
        .windowPresenterSet
    ])
    #expect(events[0].presenter == "CiderHelloWorldPresenter")
    #expect(events[0].title == "Cider Hello")
    #expect(events[1].direction == "topToBottom")
    #expect(events[2].label == "Hello, World!")
    #expect(events[3].child == "n3")
    #expect(events[3].expand == false)
    #expect(events[4].presenterLayout == "n2")
}

@Test func ciderSpecModelReconstructsHelloWorldTree() throws {
    let model = try CiderWireFixture.helloWorldModel()

    #expect(model.windows["n1"]?.presenter == "CiderHelloWorldPresenter")
    #expect(model.windows["n1"]?.title == "Cider Hello")
    #expect(model.windows["n1"]?.presenterLayout == "n2")
    #expect(model.boxLayouts["n2"]?.direction == "topToBottom")
    #expect(model.boxLayouts["n2"]?.children == [
        CiderSpecModel.SpBoxLayout.Child(id: "n3", expand: false)
    ])
    #expect(model.labels["n3"]?.label == "Hello, World!")
}

@Test func ciderWireOutputIgnoresNonProtocolLines() throws {
    let output = """
    MetacelloNotification: Loading baseline of BaselineOfCider...
    CIDER:{"receiver":"SpWindowPresenter","selector":"open","id":"n1","adapter":"WindowAdapter","presenter":"CiderHelloWorldPresenter","title":"Cider Hello"}
    CIDER:{"receiver":"SpLabelPresenter","selector":"build","id":"n3","adapter":"LabelAdapter","label":"Hello, World!"}
    MetacelloNotification: ...finished baseline
    """

    let events = try CiderWireOutput.decodeEvents(from: output)

    #expect(events.map(\.kind) == [
        .windowOpen,
        .labelPresenterBuild
    ])
}

@Test func ciderPharoBridgeConfigurationLoadsPreparedEnvironment() throws {
    let directory = FileManager.default.temporaryDirectory
        .appendingPathComponent("CiderCoreTests-\(UUID().uuidString)", isDirectory: true)
    let buildDirectory = directory.appendingPathComponent(".build/pharo", isDirectory: true)
    try FileManager.default.createDirectory(at: buildDirectory, withIntermediateDirectories: true)
    defer {
        try? FileManager.default.removeItem(at: directory)
    }

    let envFile = buildDirectory.appendingPathComponent("env")
    try """
    CIDER_PHARO_VM=/tmp/Pharo
    CIDER_PHARO_IMAGE=/tmp/Cider.image
    """.write(to: envFile, atomically: true, encoding: .utf8)

    let configuration = try CiderPharoBridge.Configuration.preparedLocal(
        envFile: envFile,
        workingDirectory: directory
    )

    #expect(configuration.pharoExecutable.path == "/tmp/Pharo")
    #expect(configuration.image.path == "/tmp/Cider.image")
    #expect(configuration.workingDirectory.path == directory.standardizedFileURL.path)
    #expect(configuration.home.path == buildDirectory.appendingPathComponent("home").path)
}
