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
        .buttonPresenterBuild,
        .boxLayoutAdd,
        .textInputFieldPresenterBuild,
        .boxLayoutAdd,
        .listPresenterBuild,
        .boxLayoutAdd,
        .windowPresenterSet
    ])
    #expect(events[0].presenter == "CiderHelloWorldPresenter")
    #expect(events[0].title == "Cider Hello")
    #expect(events[1].direction == "topToBottom")
    #expect(events[2].label == "Hello, World!")
    #expect(events[3].child == "n3")
    #expect(events[3].expand == false)
    #expect(events[4].label == "Click me!")
    #expect(events[4].enabled == true)
    #expect(events[5].child == "n4")
    #expect(events[5].expand == false)
    #expect(events[6].text == "Editable text")
    #expect(events[6].placeholder == "Type here")
    #expect(events[6].editable == true)
    #expect(events[6].password == false)
    #expect(events[7].child == "n5")
    #expect(events[7].expand == false)
    #expect(events[8].items == ["Packages", "Classes", "Protocols", "Methods"])
    #expect(events[9].child == "n6")
    #expect(events[9].expand == true)
    #expect(events[10].presenterLayout == "n2")
}

@Test func ciderSpecModelReconstructsHelloWorldTree() throws {
    let model = try CiderWireFixture.helloWorldModel()

    #expect(model.windows["n1"]?.presenter == "CiderHelloWorldPresenter")
    #expect(model.windows["n1"]?.title == "Cider Hello")
    #expect(model.windows["n1"]?.presenterLayout == "n2")
    #expect(model.boxLayouts["n2"]?.direction == "topToBottom")
    #expect(model.boxLayouts["n2"]?.children == [
        CiderSpecModel.SpBoxLayout.Child(id: "n3", expand: false),
        CiderSpecModel.SpBoxLayout.Child(id: "n4", expand: false),
        CiderSpecModel.SpBoxLayout.Child(id: "n5", expand: false),
        CiderSpecModel.SpBoxLayout.Child(id: "n6", expand: true)
    ])
    #expect(model.labels["n3"]?.label == "Hello, World!")
    #expect(model.buttons["n4"]?.label == "Click me!")
    #expect(model.buttons["n4"]?.enabled == true)
    #expect(model.textInputFields["n5"]?.text == "Editable text")
    #expect(model.textInputFields["n5"]?.placeholder == "Type here")
    #expect(model.textInputFields["n5"]?.editable == true)
    #expect(model.textInputFields["n5"]?.password == false)
    #expect(model.lists["n6"]?.items == ["Packages", "Classes", "Protocols", "Methods"])
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
