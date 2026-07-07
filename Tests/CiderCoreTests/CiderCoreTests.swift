import CiderCore
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
