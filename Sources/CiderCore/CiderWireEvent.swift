import Foundation

public struct CiderWireEvent: Codable, Equatable, Sendable {
    public enum Kind: Equatable, Sendable {
        case windowOpen
        case boxLayoutBuild
        case labelPresenterBuild
        case buttonPresenterBuild
        case textInputFieldPresenterBuild
        case listPresenterBuild
        case boxLayoutAdd
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
    public var label: String?
    public var enabled: Bool?
    public var text: String?
    public var placeholder: String?
    public var editable: Bool?
    public var password: Bool?
    public var items: [String]?
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
        label: String? = nil,
        enabled: Bool? = nil,
        text: String? = nil,
        placeholder: String? = nil,
        editable: Bool? = nil,
        password: Bool? = nil,
        items: [String]? = nil,
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
        self.label = label
        self.enabled = enabled
        self.text = text
        self.placeholder = placeholder
        self.editable = editable
        self.password = password
        self.items = items
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
        case ("SpLabelPresenter", "build"):
            .labelPresenterBuild
        case ("SpButtonPresenter", "build"):
            .buttonPresenterBuild
        case ("SpTextInputFieldPresenter", "build"):
            .textInputFieldPresenterBuild
        case ("SpListPresenter", "build"):
            .listPresenterBuild
        case ("SpBoxLayout", "add:expand:"):
            .boxLayoutAdd
        case ("SpWindowPresenter", "presenter:"):
            .windowPresenterSet
        default:
            .unknown(receiver: receiver, selector: selector)
        }
    }
}
