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
        .panedLayoutBuild,
        .boxLayoutBuild,
        .labelPresenterBuild,
        .boxLayoutAdd,
        .buttonPresenterBuild,
        .boxLayoutAdd,
        .textInputFieldPresenterBuild,
        .boxLayoutAdd,
        .panedLayoutAdd,
        .listPresenterBuild,
        .panedLayoutAdd,
        .windowPresenterSet
    ])
    #expect(events[0].presenter == "CiderHelloWorldPresenter")
    #expect(events[0].title == "Cider Hello")
    #expect(events[1].direction == "leftToRight")
    #expect(events[2].direction == "topToBottom")
    #expect(events[3].label == "Hello, World!")
    #expect(events[4].child == "n4")
    #expect(events[4].expand == false)
    #expect(events[5].label == "Click me!")
    #expect(events[5].enabled == true)
    #expect(events[6].child == "n5")
    #expect(events[6].expand == false)
    #expect(events[7].text == "Editable text")
    #expect(events[7].placeholder == "Type here")
    #expect(events[7].editable == true)
    #expect(events[7].password == false)
    #expect(events[8].child == "n6")
    #expect(events[8].expand == false)
    #expect(events[9].child == "n3")
    #expect(events[10].items == ["Packages", "Classes", "Protocols", "Methods"])
    #expect(events[11].child == "n7")
    #expect(events[12].presenterLayout == "n2")
}

@Test func ciderSpecModelReconstructsHelloWorldTree() throws {
    let model = try CiderWireFixture.helloWorldModel()

    #expect(model.windows["n1"]?.presenter == "CiderHelloWorldPresenter")
    #expect(model.windows["n1"]?.title == "Cider Hello")
    #expect(model.windows["n1"]?.presenterLayout == "n2")
    #expect(model.panedLayouts["n2"]?.direction == "leftToRight")
    #expect(model.panedLayouts["n2"]?.children == ["n3", "n7"])
    #expect(model.boxLayouts["n3"]?.direction == "topToBottom")
    #expect(model.boxLayouts["n3"]?.children == [
        CiderSpecModel.SpBoxLayout.Child(id: "n4", expand: false),
        CiderSpecModel.SpBoxLayout.Child(id: "n5", expand: false),
        CiderSpecModel.SpBoxLayout.Child(id: "n6", expand: false)
    ])
    #expect(model.labels["n4"]?.label == "Hello, World!")
    #expect(model.buttons["n5"]?.label == "Click me!")
    #expect(model.buttons["n5"]?.enabled == true)
    #expect(model.textInputFields["n6"]?.text == "Editable text")
    #expect(model.textInputFields["n6"]?.placeholder == "Type here")
    #expect(model.textInputFields["n6"]?.editable == true)
    #expect(model.textInputFields["n6"]?.password == false)
    #expect(model.lists["n7"]?.items == ["Packages", "Classes", "Protocols", "Methods"])
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
