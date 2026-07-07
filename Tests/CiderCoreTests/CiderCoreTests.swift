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
    #expect(events[10].selectedIndexes == [])
    #expect(events[11].child == "n7")
    #expect(events[12].presenterLayout == "n2")
}

@Test func ciderSpecModelReconstructsHelloWorldTree() throws {
    let model = try CiderWireFixture.helloWorldModel()

    #expect(model.primaryWindow?.title == "Cider Hello")
    #expect(CiderAppModel(specModel: model).title == "Cider Hello")
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
    #expect(model.lists["n7"]?.selectedIndexes == [])
}

@Test func ciderSpecModelReconstructsCodePresenter() throws {
    let events = try CiderWireOutput.decodeEvents(from: """
    CIDER:{"receiver":"SpCodePresenter","selector":"build","id":"n1","adapter":"CodeAdapter","text":"Object subclass: #CiderDemo","lineNumbers":true,"syntaxHighlight":true}
    """)

    let model = try CiderSpecModel.build(from: events)

    #expect(events.first?.kind == .codePresenterBuild)
    #expect(model.codePresenters["n1"] == CiderSpecModel.SpCodePresenter(
        id: "n1",
        text: "Object subclass: #CiderDemo",
        lineNumbers: true,
        syntaxHighlight: true
    ))
}

@Test func ciderSpecModelAppliesLabelPresenterUpdates() throws {
    let events = try CiderWireOutput.decodeEvents(from: """
    CIDER:{"receiver":"SpLabelPresenter","selector":"build","id":"n1","adapter":"LabelAdapter","label":"Not clicked"}
    CIDER:{"receiver":"SpLabelPresenter","selector":"label:","id":"n1","label":"Clicked"}
    """)

    let model = try CiderSpecModel.build(from: events)

    #expect(events.map(\.kind) == [
        .labelPresenterBuild,
        .labelPresenterSet
    ])
    #expect(model.labels["n1"] == CiderSpecModel.SpLabelPresenter(
        id: "n1",
        label: "Clicked"
    ))
}

@Test func ciderSpecModelAppliesListSelectionUpdates() throws {
    let events = try CiderWireOutput.decodeEvents(from: """
    CIDER:{"receiver":"SpListPresenter","selector":"build","id":"n1","adapter":"ListAdapter","items":["Alpha","Beta","Gamma"],"selectedIndexes":[]}
    CIDER:{"receiver":"SpListPresenter","selector":"selectedIndexes:","id":"n1","selectedIndexes":[2]}
    """)

    let model = try CiderSpecModel.build(from: events)

    #expect(events.map(\.kind) == [
        .listPresenterBuild,
        .listPresenterSetSelectedIndexes
    ])
    #expect(model.lists["n1"] == CiderSpecModel.SpListPresenter(
        id: "n1",
        items: ["Alpha", "Beta", "Gamma"],
        selectedIndexes: [2]
    ))
}

@Test func ciderSpecModelReconstructsMillerLayout() throws {
    let events = try CiderWireOutput.decodeEvents(from: """
    CIDER:{"receiver":"SpMillerLayout","selector":"build","id":"n1","adapter":"MillerAdapter","direction":"leftToRight","visiblePages":2}
    CIDER:{"receiver":"SpLabelPresenter","selector":"build","id":"n2","adapter":"LabelAdapter","label":"Page"}
    CIDER:{"receiver":"SpMillerLayout","selector":"add:","id":"n1","child":"n2"}
    """)

    let model = try CiderSpecModel.build(from: events)

    #expect(events.map(\.kind) == [
        .millerLayoutBuild,
        .labelPresenterBuild,
        .millerLayoutAdd
    ])
    #expect(model.millerLayouts["n1"] == CiderSpecModel.SpMillerLayout(
        id: "n1",
        direction: "leftToRight",
        visiblePages: 2,
        children: ["n2"]
    ))
}

@Test func ciderSpecModelReconstructsImagePresenter() throws {
    let events = try CiderWireOutput.decodeEvents(from: """
    CIDER:{"receiver":"SpImagePresenter","selector":"build","id":"n1","adapter":"ImageAdapter","width":128,"height":64,"autoScale":true}
    """)

    let model = try CiderSpecModel.build(from: events)

    #expect(events.first?.kind == .imagePresenterBuild)
    #expect(model.images["n1"] == CiderSpecModel.SpImagePresenter(
        id: "n1",
        width: 128,
        height: 64,
        autoScale: true
    ))
}

@Test func ciderSpecModelReconstructsNativeWidgetPlaceholder() throws {
    let events = try CiderWireOutput.decodeEvents(from: """
    CIDER:{"receiver":"SpNativeWidget","selector":"build","id":"n1","adapter":"NativeAdapter","widgetClass":"UnknownMorph","text":"Fallback"}
    """)

    let model = try CiderSpecModel.build(from: events)

    #expect(events.first?.kind == .nativeWidgetBuild)
    #expect(model.nativeWidgets["n1"] == CiderSpecModel.SpNativeWidget(
        id: "n1",
        widgetClass: "UnknownMorph",
        text: "Fallback"
    ))
}

@Test func ciderSpecModelReconstructsMicScrolledTextMorph() throws {
    let events = try CiderWireOutput.decodeEvents(from: """
    CIDER:{"receiver":"MicScrolledTextMorph","selector":"build","id":"n1","adapter":"MorphAdapter","text":"Welcome\\u0001to Pharo"}
    """)

    let model = try CiderSpecModel.build(from: events)

    #expect(events.first?.kind == .micScrolledTextMorphBuild)
    #expect(model.micScrolledTextMorphs["n1"] == CiderSpecModel.MicScrolledTextMorph(
        id: "n1",
        text: "Welcome\u{1}to Pharo"
    ))
}

@Test func ciderSpecModelReconstructsCheckBoxPresenter() throws {
    let events = try CiderWireOutput.decodeEvents(from: """
    CIDER:{"receiver":"SpCheckBoxPresenter","selector":"build","id":"n1","adapter":"CheckBoxAdapter","label":"Full Screen","state":true,"enabled":false}
    """)

    let model = try CiderSpecModel.build(from: events)

    #expect(events.first?.kind == .checkBoxPresenterBuild)
    #expect(model.checkBoxes["n1"] == CiderSpecModel.SpCheckBoxPresenter(
        id: "n1",
        label: "Full Screen",
        state: true,
        enabled: false
    ))
}

@Test func ciderSpecModelReconstructsDropListPresenter() throws {
    let events = try CiderWireOutput.decodeEvents(from: """
    CIDER:{"receiver":"SpDropListPresenter","selector":"build","id":"n1","adapter":"DropListAdapter","items":["Tests Runner","Coverage"],"selectedIndex":1}
    """)

    let model = try CiderSpecModel.build(from: events)

    #expect(events.first?.kind == .dropListPresenterBuild)
    #expect(model.dropLists["n1"] == CiderSpecModel.SpDropListPresenter(
        id: "n1",
        items: ["Tests Runner", "Coverage"],
        selectedIndex: 1
    ))
}

@Test func ciderSpecModelReconstructsTreePresenter() throws {
    let events = try CiderWireOutput.decodeEvents(from: """
    CIDER:{"receiver":"SpTreePresenter","selector":"build","id":"n1","adapter":"TreeAdapter","roots":["Passed","Failures"],"nodes":[{"path":[1],"label":"Passed"},{"path":[1,1],"label":"CiderWireEmitterTest>>#testWideStringValuesStayByteOriented"},{"path":[2],"label":"Failures"}],"selectedPaths":[[1]]}
    """)

    let model = try CiderSpecModel.build(from: events)

    #expect(events.first?.kind == .treePresenterBuild)
    #expect(events.first?.nodes == [
        CiderWireEvent.TreeNode(path: [1], label: "Passed"),
        CiderWireEvent.TreeNode(path: [1, 1], label: "CiderWireEmitterTest>>#testWideStringValuesStayByteOriented"),
        CiderWireEvent.TreeNode(path: [2], label: "Failures")
    ])
    #expect(model.trees["n1"] == CiderSpecModel.SpTreePresenter(
        id: "n1",
        roots: ["Passed", "Failures"],
        nodes: [
            CiderSpecModel.SpTreePresenter.Node(path: [1], label: "Passed"),
            CiderSpecModel.SpTreePresenter.Node(
                path: [1, 1],
                label: "CiderWireEmitterTest>>#testWideStringValuesStayByteOriented"
            ),
            CiderSpecModel.SpTreePresenter.Node(path: [2], label: "Failures")
        ],
        selectedPaths: [[1]]
    ))
}

@Test func ciderSpecModelAppliesTreeSelectionUpdates() throws {
    let events = try CiderWireOutput.decodeEvents(from: """
    CIDER:{"receiver":"SpTreePresenter","selector":"build","id":"n1","adapter":"TreeAdapter","roots":["Smalltalk"],"nodes":[{"path":[1],"label":"Smalltalk"},{"path":[1,1],"label":"Spec"}],"selectedPaths":[]}
    CIDER:{"receiver":"SpTreePresenter","selector":"selectedPaths:","id":"n1","selectedPaths":[[1,1]]}
    """)

    let model = try CiderSpecModel.build(from: events)

    #expect(events.map(\.kind) == [
        .treePresenterBuild,
        .treePresenterSetSelectedPaths
    ])
    #expect(model.trees["n1"] == CiderSpecModel.SpTreePresenter(
        id: "n1",
        roots: ["Smalltalk"],
        nodes: [
            CiderSpecModel.SpTreePresenter.Node(path: [1], label: "Smalltalk"),
            CiderSpecModel.SpTreePresenter.Node(path: [1, 1], label: "Spec")
        ],
        selectedPaths: [[1, 1]]
    ))
}

@Test func ciderSpecModelReconstructsPaginatorPresenter() throws {
    let events = try CiderWireOutput.decodeEvents(from: """
    CIDER:{"receiver":"SpPaginatorPresenter","selector":"build","id":"n1","adapter":"PaginatorAdapter","pages":7,"selectedPage":3,"visiblePages":2}
    """)

    let model = try CiderSpecModel.build(from: events)

    #expect(events.first?.kind == .paginatorPresenterBuild)
    #expect(model.paginators["n1"] == CiderSpecModel.SpPaginatorPresenter(
        id: "n1",
        pages: 7,
        selectedPage: 3,
        visiblePages: 2
    ))
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
