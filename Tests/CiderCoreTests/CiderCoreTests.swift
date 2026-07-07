import CiderCore
import Testing

@Test func ciderCoreModuleIsImportable() {
    let model = CiderAppModel()

    #expect(model.title == "Cider")
    #expect(CiderWireProtocol.Placeholder() == CiderWireProtocol.Placeholder())
}
