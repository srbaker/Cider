import Foundation

public struct CiderWireEvent: Codable, Equatable, Sendable {
    public enum Kind: Equatable, Sendable {
        case windowOpen
        case boxLayoutBuild
        case panedLayoutBuild
        case millerLayoutBuild
        case labelPresenterBuild
        case imagePresenterBuild
        case buttonPresenterBuild
        case checkBoxPresenterBuild
        case dropListPresenterBuild
        case textInputFieldPresenterBuild
        case listPresenterBuild
        case codePresenterBuild
        case micScrolledTextMorphBuild
        case nativeWidgetBuild
        case paginatorPresenterBuild
        case boxLayoutAdd
        case panedLayoutAdd
        case millerLayoutAdd
        case windowPresenterSet
        case unknown(receiver: String, selector: String)
    }

    public var receiver: String
    public var selector: String
    public var id: String
    public var adapter: String?
    public var presenter: String?
    public var title: String?
    public var direction: String?
    public var visiblePages: Int?
    public var label: String?
    public var width: Int?
    public var height: Int?
    public var autoScale: Bool?
    public var enabled: Bool?
    public var state: Bool?
    public var text: String?
    public var placeholder: String?
    public var editable: Bool?
    public var password: Bool?
    public var items: [String]?
    public var selectedIndexes: [Int]?
    public var selectedIndex: Int?
    public var lineNumbers: Bool?
    public var syntaxHighlight: Bool?
    public var widgetClass: String?
    public var pages: Int?
    public var selectedPage: Int?
    public var child: String?
    public var expand: Bool?
    public var presenterLayout: String?

    public init(
        receiver: String,
        selector: String,
        id: String,
        adapter: String? = nil,
        presenter: String? = nil,
        title: String? = nil,
        direction: String? = nil,
        visiblePages: Int? = nil,
        label: String? = nil,
        width: Int? = nil,
        height: Int? = nil,
        autoScale: Bool? = nil,
        enabled: Bool? = nil,
        state: Bool? = nil,
        text: String? = nil,
        placeholder: String? = nil,
        editable: Bool? = nil,
        password: Bool? = nil,
        items: [String]? = nil,
        selectedIndexes: [Int]? = nil,
        selectedIndex: Int? = nil,
        lineNumbers: Bool? = nil,
        syntaxHighlight: Bool? = nil,
        widgetClass: String? = nil,
        pages: Int? = nil,
        selectedPage: Int? = nil,
        child: String? = nil,
        expand: Bool? = nil,
        presenterLayout: String? = nil
    ) {
        self.receiver = receiver
        self.selector = selector
        self.id = id
        self.adapter = adapter
        self.presenter = presenter
        self.title = title
        self.direction = direction
        self.visiblePages = visiblePages
        self.label = label
        self.width = width
        self.height = height
        self.autoScale = autoScale
        self.enabled = enabled
        self.state = state
        self.text = text
        self.placeholder = placeholder
        self.editable = editable
        self.password = password
        self.items = items
        self.selectedIndexes = selectedIndexes
        self.selectedIndex = selectedIndex
        self.lineNumbers = lineNumbers
        self.syntaxHighlight = syntaxHighlight
        self.widgetClass = widgetClass
        self.pages = pages
        self.selectedPage = selectedPage
        self.child = child
        self.expand = expand
        self.presenterLayout = presenterLayout
    }

    public var kind: Kind {
        switch (receiver, selector) {
        case ("SpWindowPresenter", "open"):
            .windowOpen
        case ("SpBoxLayout", "build"):
            .boxLayoutBuild
        case ("SpPanedLayout", "build"):
            .panedLayoutBuild
        case ("SpMillerLayout", "build"):
            .millerLayoutBuild
        case ("SpLabelPresenter", "build"):
            .labelPresenterBuild
        case ("SpImagePresenter", "build"):
            .imagePresenterBuild
        case ("SpButtonPresenter", "build"):
            .buttonPresenterBuild
        case ("SpCheckBoxPresenter", "build"):
            .checkBoxPresenterBuild
        case ("SpDropListPresenter", "build"):
            .dropListPresenterBuild
        case ("SpTextInputFieldPresenter", "build"):
            .textInputFieldPresenterBuild
        case ("SpListPresenter", "build"):
            .listPresenterBuild
        case ("SpCodePresenter", "build"):
            .codePresenterBuild
        case ("MicScrolledTextMorph", "build"):
            .micScrolledTextMorphBuild
        case ("SpNativeWidget", "build"):
            .nativeWidgetBuild
        case ("SpPaginatorPresenter", "build"):
            .paginatorPresenterBuild
        case ("SpBoxLayout", "add:expand:"):
            .boxLayoutAdd
        case ("SpPanedLayout", "add:"):
            .panedLayoutAdd
        case ("SpMillerLayout", "add:"):
            .millerLayoutAdd
        case ("SpWindowPresenter", "presenter:"):
            .windowPresenterSet
        default:
            .unknown(receiver: receiver, selector: selector)
        }
    }
}
