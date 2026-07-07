public struct CiderAppModel: Equatable, Sendable {
    public var specModel: CiderSpecModel?

    public init(specModel: CiderSpecModel? = nil) {
        self.specModel = specModel
    }

    public var title: String {
        "Cider"
    }
}
