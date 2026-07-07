import CiderCore

extension CiderAppModel {
    static var helloWorld: CiderAppModel {
        CiderAppModel(specModel: makeHelloWorldSpecModel())
    }

    private static func makeHelloWorldSpecModel() -> CiderSpecModel? {
        try? CiderWireFixture.helloWorldModel()
    }
}
