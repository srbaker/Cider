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

    public struct SpPanedLayout: Equatable, Sendable {
        public var id: String
        public var direction: String
        public var children: [String]

        public init(id: String, direction: String, children: [String] = []) {
            self.id = id
            self.direction = direction
            self.children = children
        }
    }

    public struct SpMillerLayout: Equatable, Sendable {
        public var id: String
        public var direction: String
        public var visiblePages: Int
        public var children: [String]

        public init(id: String, direction: String, visiblePages: Int, children: [String] = []) {
            self.id = id
            self.direction = direction
            self.visiblePages = visiblePages
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

    public struct SpImagePresenter: Equatable, Sendable {
        public var id: String
        public var width: Int
        public var height: Int
        public var autoScale: Bool

        public init(id: String, width: Int, height: Int, autoScale: Bool) {
            self.id = id
            self.width = width
            self.height = height
            self.autoScale = autoScale
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

    public struct SpCheckBoxPresenter: Equatable, Sendable {
        public var id: String
        public var label: String
        public var state: Bool
        public var enabled: Bool

        public init(id: String, label: String, state: Bool, enabled: Bool) {
            self.id = id
            self.label = label
            self.state = state
            self.enabled = enabled
        }
    }

    public struct SpDropListPresenter: Equatable, Sendable {
        public var id: String
        public var items: [String]
        public var selectedIndex: Int

        public init(id: String, items: [String], selectedIndex: Int) {
            self.id = id
            self.items = items
            self.selectedIndex = selectedIndex
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

    public struct SpListPresenter: Equatable, Sendable {
        public var id: String
        public var items: [String]
        public var selectedIndexes: [Int]

        public init(id: String, items: [String], selectedIndexes: [Int] = []) {
            self.id = id
            self.items = items
            self.selectedIndexes = selectedIndexes
        }
    }

    public struct SpTablePresenter: Equatable, Sendable {
        public var id: String
        public var columns: [String]
        public var rows: [[String]]
        public var selectedIndexes: [Int]

        public init(id: String, columns: [String], rows: [[String]], selectedIndexes: [Int]) {
            self.id = id
            self.columns = columns
            self.rows = rows
            self.selectedIndexes = selectedIndexes
        }
    }

    public struct SpTreePresenter: Equatable, Sendable {
        public struct Node: Equatable, Sendable {
            public var path: [Int]
            public var label: String

            public init(path: [Int], label: String) {
                self.path = path
                self.label = label
            }
        }

        public var id: String
        public var roots: [String]
        public var nodes: [Node]
        public var selectedPaths: [[Int]]

        public init(id: String, roots: [String], nodes: [Node] = [], selectedPaths: [[Int]] = []) {
            self.id = id
            self.roots = roots
            self.nodes = nodes
            self.selectedPaths = selectedPaths
        }
    }

    public struct SpTreeTablePresenter: Equatable, Sendable {
        public struct Node: Equatable, Sendable {
            public var path: [Int]
            public var values: [String]

            public init(path: [Int], values: [String]) {
                self.path = path
                self.values = values
            }
        }

        public var id: String
        public var columns: [String]
        public var nodes: [Node]
        public var selectedPaths: [[Int]]

        public init(id: String, columns: [String], nodes: [Node], selectedPaths: [[Int]]) {
            self.id = id
            self.columns = columns
            self.nodes = nodes
            self.selectedPaths = selectedPaths
        }
    }

    public struct SpCodePresenter: Equatable, Sendable {
        public var id: String
        public var text: String
        public var lineNumbers: Bool
        public var syntaxHighlight: Bool

        public init(id: String, text: String, lineNumbers: Bool, syntaxHighlight: Bool) {
            self.id = id
            self.text = text
            self.lineNumbers = lineNumbers
            self.syntaxHighlight = syntaxHighlight
        }
    }

    public struct SpNativeWidget: Equatable, Sendable {
        public var id: String
        public var widgetClass: String
        public var text: String

        public init(id: String, widgetClass: String, text: String) {
            self.id = id
            self.widgetClass = widgetClass
            self.text = text
        }
    }

    public struct MicScrolledTextMorph: Equatable, Sendable {
        public var id: String
        public var text: String

        public init(id: String, text: String) {
            self.id = id
            self.text = text
        }
    }

    public struct ClyFullBrowserMorph: Equatable, Sendable {
        public struct Pane: Equatable, Sendable {
            public var title: String
            public var items: [String]
            public var totalRows: Int
            public var selectedIndex: Int

            public init(title: String, items: [String], totalRows: Int, selectedIndex: Int = 0) {
                self.title = title
                self.items = items
                self.totalRows = totalRows
                self.selectedIndex = selectedIndex
            }
        }

        public var id: String
        public var panes: [Pane]
        public var source: String
        public var sourceTitle: String

        public init(id: String, panes: [Pane], source: String = "", sourceTitle: String = "") {
            self.id = id
            self.panes = panes
            self.source = source
            self.sourceTitle = sourceTitle
        }
    }

    public struct SpPaginatorPresenter: Equatable, Sendable {
        public var id: String
        public var pages: Int
        public var selectedPage: Int
        public var visiblePages: Int

        public init(id: String, pages: Int, selectedPage: Int, visiblePages: Int) {
            self.id = id
            self.pages = pages
            self.selectedPage = selectedPage
            self.visiblePages = visiblePages
        }
    }

    public enum BuildError: Error, Equatable, Sendable {
        case missingWindowPayload(String)
        case missingBoxPayload(String)
        case missingPanedPayload(String)
        case missingMillerPayload(String)
        case missingLabelPayload(String)
        case missingImagePayload(String)
        case missingButtonPayload(String)
        case missingCheckBoxPayload(String)
        case missingDropListPayload(String)
        case missingTextInputFieldPayload(String)
        case missingListPayload(String)
        case missingTablePayload(String)
        case missingTreePayload(String)
        case missingTreeTablePayload(String)
        case missingCodePayload(String)
        case missingMicScrolledTextMorphPayload(String)
        case missingClyFullBrowserMorphPayload(String)
        case missingNativeWidgetPayload(String)
        case missingPaginatorPayload(String)
        case missingBoxChildPayload(String)
        case missingPanedChildPayload(String)
        case missingMillerChildPayload(String)
        case missingWindowPresenterPayload(String)
        case unknownBox(String)
        case unknownPaned(String)
        case unknownMiller(String)
        case unknownWindow(String)
    }

    public var windows: [String: SpWindowPresenter]
    public var boxLayouts: [String: SpBoxLayout]
    public var panedLayouts: [String: SpPanedLayout]
    public var millerLayouts: [String: SpMillerLayout]
    public var labels: [String: SpLabelPresenter]
    public var images: [String: SpImagePresenter]
    public var buttons: [String: SpButtonPresenter]
    public var checkBoxes: [String: SpCheckBoxPresenter]
    public var dropLists: [String: SpDropListPresenter]
    public var textInputFields: [String: SpTextInputFieldPresenter]
    public var lists: [String: SpListPresenter]
    public var tables: [String: SpTablePresenter]
    public var trees: [String: SpTreePresenter]
    public var treeTables: [String: SpTreeTablePresenter]
    public var codePresenters: [String: SpCodePresenter]
    public var micScrolledTextMorphs: [String: MicScrolledTextMorph]
    public var clyFullBrowserMorphs: [String: ClyFullBrowserMorph]
    public var nativeWidgets: [String: SpNativeWidget]
    public var paginators: [String: SpPaginatorPresenter]

    public init(
        windows: [String: SpWindowPresenter] = [:],
        boxLayouts: [String: SpBoxLayout] = [:],
        panedLayouts: [String: SpPanedLayout] = [:],
        millerLayouts: [String: SpMillerLayout] = [:],
        labels: [String: SpLabelPresenter] = [:],
        images: [String: SpImagePresenter] = [:],
        buttons: [String: SpButtonPresenter] = [:],
        checkBoxes: [String: SpCheckBoxPresenter] = [:],
        dropLists: [String: SpDropListPresenter] = [:],
        textInputFields: [String: SpTextInputFieldPresenter] = [:],
        lists: [String: SpListPresenter] = [:],
        tables: [String: SpTablePresenter] = [:],
        trees: [String: SpTreePresenter] = [:],
        treeTables: [String: SpTreeTablePresenter] = [:],
        codePresenters: [String: SpCodePresenter] = [:],
        micScrolledTextMorphs: [String: MicScrolledTextMorph] = [:],
        clyFullBrowserMorphs: [String: ClyFullBrowserMorph] = [:],
        nativeWidgets: [String: SpNativeWidget] = [:],
        paginators: [String: SpPaginatorPresenter] = [:]
    ) {
        self.windows = windows
        self.boxLayouts = boxLayouts
        self.panedLayouts = panedLayouts
        self.millerLayouts = millerLayouts
        self.labels = labels
        self.images = images
        self.buttons = buttons
        self.checkBoxes = checkBoxes
        self.dropLists = dropLists
        self.textInputFields = textInputFields
        self.lists = lists
        self.tables = tables
        self.trees = trees
        self.treeTables = treeTables
        self.codePresenters = codePresenters
        self.micScrolledTextMorphs = micScrolledTextMorphs
        self.clyFullBrowserMorphs = clyFullBrowserMorphs
        self.nativeWidgets = nativeWidgets
        self.paginators = paginators
    }

    public var primaryWindow: SpWindowPresenter? {
        windows.values.sorted { $0.id < $1.id }.first
    }

    public var primaryRootID: String? {
        primaryWindow?.presenterLayout
            ?? clyFullBrowserMorphs.keys.sorted().first
            ?? micScrolledTextMorphs.keys.sorted().first
            ?? nativeWidgets.keys.sorted().first
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

            case .panedLayoutBuild:
                guard let direction = event.direction else {
                    throw BuildError.missingPanedPayload(event.id)
                }
                model.panedLayouts[event.id] = SpPanedLayout(id: event.id, direction: direction)

            case .millerLayoutBuild:
                guard let direction = event.direction, let visiblePages = event.visiblePages else {
                    throw BuildError.missingMillerPayload(event.id)
                }
                model.millerLayouts[event.id] = SpMillerLayout(
                    id: event.id,
                    direction: direction,
                    visiblePages: visiblePages
                )

            case .labelPresenterBuild:
                guard let label = event.label else {
                    throw BuildError.missingLabelPayload(event.id)
                }
                model.labels[event.id] = SpLabelPresenter(id: event.id, label: label)

            case .labelPresenterSet:
                guard let label = event.label else {
                    throw BuildError.missingLabelPayload(event.id)
                }
                model.labels[event.id] = SpLabelPresenter(id: event.id, label: label)

            case .imagePresenterBuild:
                guard
                    let width = event.width,
                    let height = event.height,
                    let autoScale = event.autoScale
                else {
                    throw BuildError.missingImagePayload(event.id)
                }
                model.images[event.id] = SpImagePresenter(
                    id: event.id,
                    width: width,
                    height: height,
                    autoScale: autoScale
                )

            case .buttonPresenterBuild:
                guard let label = event.label, let enabled = event.enabled else {
                    throw BuildError.missingButtonPayload(event.id)
                }
                model.buttons[event.id] = SpButtonPresenter(
                    id: event.id,
                    label: label,
                    enabled: enabled
                )

            case .checkBoxPresenterBuild:
                guard
                    let label = event.label,
                    let state = event.state,
                    let enabled = event.enabled
                else {
                    throw BuildError.missingCheckBoxPayload(event.id)
                }
                model.checkBoxes[event.id] = SpCheckBoxPresenter(
                    id: event.id,
                    label: label,
                    state: state,
                    enabled: enabled
                )

            case .checkBoxPresenterSetState:
                guard let state = event.state else {
                    throw BuildError.missingCheckBoxPayload(event.id)
                }
                guard var checkBox = model.checkBoxes[event.id] else {
                    throw BuildError.missingCheckBoxPayload(event.id)
                }
                checkBox.state = state
                model.checkBoxes[event.id] = checkBox

            case .dropListPresenterBuild:
                guard let items = event.items, let selectedIndex = event.selectedIndex else {
                    throw BuildError.missingDropListPayload(event.id)
                }
                model.dropLists[event.id] = SpDropListPresenter(
                    id: event.id,
                    items: items,
                    selectedIndex: selectedIndex
                )

            case .dropListPresenterSelectIndex:
                guard let selectedIndex = event.selectedIndex else {
                    throw BuildError.missingDropListPayload(event.id)
                }
                guard var dropList = model.dropLists[event.id] else {
                    throw BuildError.missingDropListPayload(event.id)
                }
                dropList.selectedIndex = selectedIndex
                model.dropLists[event.id] = dropList

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

            case .textInputFieldSetText:
                guard let text = event.text else {
                    throw BuildError.missingTextInputFieldPayload(event.id)
                }
                guard var textInputField = model.textInputFields[event.id] else {
                    throw BuildError.missingTextInputFieldPayload(event.id)
                }
                textInputField.text = text
                model.textInputFields[event.id] = textInputField

            case .listPresenterBuild:
                guard let items = event.items, let selectedIndexes = event.selectedIndexes else {
                    throw BuildError.missingListPayload(event.id)
                }
                model.lists[event.id] = SpListPresenter(
                    id: event.id,
                    items: items,
                    selectedIndexes: selectedIndexes
                )

            case .listPresenterSetSelectedIndexes:
                guard let selectedIndexes = event.selectedIndexes else {
                    throw BuildError.missingListPayload(event.id)
                }
                guard var list = model.lists[event.id] else {
                    throw BuildError.missingListPayload(event.id)
                }
                list.selectedIndexes = selectedIndexes
                model.lists[event.id] = list

            case .listPresenterActivateAtIndex:
                break

            case .tablePresenterBuild:
                guard
                    let columns = event.columns,
                    let rows = event.rows,
                    let selectedIndexes = event.selectedIndexes
                else {
                    throw BuildError.missingTablePayload(event.id)
                }
                model.tables[event.id] = SpTablePresenter(
                    id: event.id,
                    columns: columns,
                    rows: rows,
                    selectedIndexes: selectedIndexes
                )

            case .tablePresenterSetSelectedIndexes:
                guard let selectedIndexes = event.selectedIndexes else {
                    throw BuildError.missingTablePayload(event.id)
                }
                guard var table = model.tables[event.id] else {
                    throw BuildError.missingTablePayload(event.id)
                }
                table.selectedIndexes = selectedIndexes
                model.tables[event.id] = table

            case .tablePresenterActivateAtIndex:
                break

            case .treePresenterBuild:
                guard let roots = event.roots, let selectedPaths = event.selectedPaths else {
                    throw BuildError.missingTreePayload(event.id)
                }
                let nodes = event.nodes?.map {
                    SpTreePresenter.Node(path: $0.path, label: $0.label)
                } ?? roots.enumerated().map { index, root in
                    SpTreePresenter.Node(path: [index + 1], label: root)
                }
                model.trees[event.id] = SpTreePresenter(
                    id: event.id,
                    roots: roots,
                    nodes: nodes,
                    selectedPaths: selectedPaths
                )

            case .treePresenterSetSelectedPaths:
                guard let selectedPaths = event.selectedPaths else {
                    throw BuildError.missingTreePayload(event.id)
                }
                guard var tree = model.trees[event.id] else {
                    throw BuildError.missingTreePayload(event.id)
                }
                tree.selectedPaths = selectedPaths
                model.trees[event.id] = tree

            case .treePresenterActivateAtPath:
                break

            case .treeTablePresenterBuild:
                guard
                    let columns = event.columns,
                    let treeTableNodes = event.treeTableNodes,
                    let selectedPaths = event.selectedPaths
                else {
                    throw BuildError.missingTreeTablePayload(event.id)
                }
                model.treeTables[event.id] = SpTreeTablePresenter(
                    id: event.id,
                    columns: columns,
                    nodes: treeTableNodes.map {
                        SpTreeTablePresenter.Node(path: $0.path, values: $0.values)
                    },
                    selectedPaths: selectedPaths
                )

            case .treeTablePresenterSetSelectedPaths:
                guard let selectedPaths = event.selectedPaths else {
                    throw BuildError.missingTreeTablePayload(event.id)
                }
                guard var treeTable = model.treeTables[event.id] else {
                    throw BuildError.missingTreeTablePayload(event.id)
                }
                treeTable.selectedPaths = selectedPaths
                model.treeTables[event.id] = treeTable

            case .treeTablePresenterActivateAtPath:
                break

            case .codePresenterBuild:
                guard
                    let text = event.text,
                    let lineNumbers = event.lineNumbers,
                    let syntaxHighlight = event.syntaxHighlight
                else {
                    throw BuildError.missingCodePayload(event.id)
                }
                model.codePresenters[event.id] = SpCodePresenter(
                    id: event.id,
                    text: text,
                    lineNumbers: lineNumbers,
                    syntaxHighlight: syntaxHighlight
                )

            case .micScrolledTextMorphBuild:
                guard let text = event.text else {
                    throw BuildError.missingMicScrolledTextMorphPayload(event.id)
                }
                model.micScrolledTextMorphs[event.id] = MicScrolledTextMorph(
                    id: event.id,
                    text: text
                )

            case .clyFullBrowserMorphBuild:
                guard let panes = event.panes else {
                    throw BuildError.missingClyFullBrowserMorphPayload(event.id)
                }
                model.clyFullBrowserMorphs[event.id] = ClyFullBrowserMorph(
                    id: event.id,
                    panes: panes.map {
                        ClyFullBrowserMorph.Pane(
                            title: $0.title,
                            items: $0.items,
                            totalRows: $0.totalRows,
                            selectedIndex: $0.selectedIndex
                        )
                    },
                    source: event.source ?? "",
                    sourceTitle: event.sourceTitle ?? ""
                )

            case .clyFullBrowserMorphSelectPaneRow:
                break

            case .nativeWidgetBuild:
                guard let widgetClass = event.widgetClass else {
                    throw BuildError.missingNativeWidgetPayload(event.id)
                }
                model.nativeWidgets[event.id] = SpNativeWidget(
                    id: event.id,
                    widgetClass: widgetClass,
                    text: event.text ?? ""
                )

            case .paginatorPresenterBuild:
                guard
                    let pages = event.pages,
                    let selectedPage = event.selectedPage,
                    let visiblePages = event.visiblePages
                else {
                    throw BuildError.missingPaginatorPayload(event.id)
                }
                model.paginators[event.id] = SpPaginatorPresenter(
                    id: event.id,
                    pages: pages,
                    selectedPage: selectedPage,
                    visiblePages: visiblePages
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

            case .panedLayoutAdd:
                guard let child = event.child else {
                    throw BuildError.missingPanedChildPayload(event.id)
                }
                guard var panedLayout = model.panedLayouts[event.id] else {
                    throw BuildError.unknownPaned(event.id)
                }
                panedLayout.children.append(child)
                model.panedLayouts[event.id] = panedLayout

            case .millerLayoutAdd:
                guard let child = event.child else {
                    throw BuildError.missingMillerChildPayload(event.id)
                }
                guard var millerLayout = model.millerLayouts[event.id] else {
                    throw BuildError.unknownMiller(event.id)
                }
                millerLayout.children.append(child)
                model.millerLayouts[event.id] = millerLayout

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
