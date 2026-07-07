public struct CiderSpecModel: Equatable, Sendable {
    public struct SpWindowPresenter: Equatable, Sendable {
        public var id: String
        public var presenter: String
        public var title: String
        public var presenterLayout: String?

        public init(id: String, presenter: String, title: String, presenterLayout: String? = nil) {
            self.id = id
            self.presenter = presenter
            self.title = title
            self.presenterLayout = presenterLayout
        }
    }

    public struct SpBoxLayout: Equatable, Sendable {
        public struct Child: Equatable, Sendable {
            public var id: String
            public var expand: Bool

            public init(id: String, expand: Bool) {
                self.id = id
                self.expand = expand
            }
        }

        public var id: String
        public var direction: String
        public var children: [Child]

        public init(id: String, direction: String, children: [Child] = []) {
            self.id = id
            self.direction = direction
            self.children = children
        }
    }

    public struct SpLabelPresenter: Equatable, Sendable {
        public var id: String
        public var label: String

        public init(id: String, label: String) {
            self.id = id
            self.label = label
        }
    }

    public struct SpButtonPresenter: Equatable, Sendable {
        public var id: String
        public var label: String
        public var enabled: Bool

        public init(id: String, label: String, enabled: Bool) {
            self.id = id
            self.label = label
            self.enabled = enabled
        }
    }

    public struct SpTextInputFieldPresenter: Equatable, Sendable {
        public var id: String
        public var text: String
        public var placeholder: String
        public var editable: Bool
        public var password: Bool

        public init(
            id: String,
            text: String,
            placeholder: String,
            editable: Bool,
            password: Bool
        ) {
            self.id = id
            self.text = text
            self.placeholder = placeholder
            self.editable = editable
            self.password = password
        }
    }

    public enum BuildError: Error, Equatable, Sendable {
        case missingWindowPayload(String)
        case missingBoxPayload(String)
        case missingLabelPayload(String)
        case missingButtonPayload(String)
        case missingTextInputFieldPayload(String)
        case missingBoxChildPayload(String)
        case missingWindowPresenterPayload(String)
        case unknownBox(String)
        case unknownWindow(String)
    }

    public var windows: [String: SpWindowPresenter]
    public var boxLayouts: [String: SpBoxLayout]
    public var labels: [String: SpLabelPresenter]
    public var buttons: [String: SpButtonPresenter]
    public var textInputFields: [String: SpTextInputFieldPresenter]

    public init(
        windows: [String: SpWindowPresenter] = [:],
        boxLayouts: [String: SpBoxLayout] = [:],
        labels: [String: SpLabelPresenter] = [:],
        buttons: [String: SpButtonPresenter] = [:],
        textInputFields: [String: SpTextInputFieldPresenter] = [:]
    ) {
        self.windows = windows
        self.boxLayouts = boxLayouts
        self.labels = labels
        self.buttons = buttons
        self.textInputFields = textInputFields
    }

    public static func build(from events: [CiderWireEvent]) throws -> CiderSpecModel {
        var model = CiderSpecModel()

        for event in events {
            switch event.kind {
            case .windowOpen:
                guard let presenter = event.presenter, let title = event.title else {
                    throw BuildError.missingWindowPayload(event.id)
                }
                model.windows[event.id] = SpWindowPresenter(
                    id: event.id,
                    presenter: presenter,
                    title: title
                )

            case .boxLayoutBuild:
                guard let direction = event.direction else {
                    throw BuildError.missingBoxPayload(event.id)
                }
                model.boxLayouts[event.id] = SpBoxLayout(id: event.id, direction: direction)

            case .labelPresenterBuild:
                guard let label = event.label else {
                    throw BuildError.missingLabelPayload(event.id)
                }
                model.labels[event.id] = SpLabelPresenter(id: event.id, label: label)

            case .buttonPresenterBuild:
                guard let label = event.label, let enabled = event.enabled else {
                    throw BuildError.missingButtonPayload(event.id)
                }
                model.buttons[event.id] = SpButtonPresenter(
                    id: event.id,
                    label: label,
                    enabled: enabled
                )

            case .textInputFieldPresenterBuild:
                guard
                    let text = event.text,
                    let placeholder = event.placeholder,
                    let editable = event.editable,
                    let password = event.password
                else {
                    throw BuildError.missingTextInputFieldPayload(event.id)
                }
                model.textInputFields[event.id] = SpTextInputFieldPresenter(
                    id: event.id,
                    text: text,
                    placeholder: placeholder,
                    editable: editable,
                    password: password
                )

            case .boxLayoutAdd:
                guard let child = event.child, let expand = event.expand else {
                    throw BuildError.missingBoxChildPayload(event.id)
                }
                guard var boxLayout = model.boxLayouts[event.id] else {
                    throw BuildError.unknownBox(event.id)
                }
                boxLayout.children.append(SpBoxLayout.Child(id: child, expand: expand))
                model.boxLayouts[event.id] = boxLayout

            case .windowPresenterSet:
                guard let presenterLayout = event.presenterLayout else {
                    throw BuildError.missingWindowPresenterPayload(event.id)
                }
                guard var window = model.windows[event.id] else {
                    throw BuildError.unknownWindow(event.id)
                }
                window.presenterLayout = presenterLayout
                model.windows[event.id] = window

            case .unknown:
                continue
            }
        }

        return model
    }
}
