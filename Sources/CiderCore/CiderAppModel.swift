public struct CiderAppModel: Equatable, Sendable {
    public var specModel: CiderSpecModel?

    public init(specModel: CiderSpecModel? = nil) {
        self.specModel = specModel
    }

    public var title: String {
        if let title = specModel?.primaryWindow?.title {
            return title
        }

        if specModel?.clyFullBrowserMorphs.isEmpty == false {
            return "Cider Browser"
        }

        return "Cider"
    }
}
