import CiderCore
import SwiftUI

struct CiderSpecRenderer: View {
    let model: CiderSpecModel

    private var rootWindow: CiderSpecModel.SpWindowPresenter? {
        model.windows.values.sorted { $0.id < $1.id }.first
    }

    var body: some View {
        if let presenterLayout = rootWindow?.presenterLayout {
            renderNode(id: presenterLayout)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        } else {
            EmptyView()
        }
    }

    private func renderNode(id: String) -> AnyView {
        if let boxLayout = model.boxLayouts[id] {
            return renderBoxLayout(boxLayout)
        } else if let label = model.labels[id] {
            return AnyView(Text(label.label))
        } else {
            return AnyView(EmptyView())
        }
    }

    private func renderBoxLayout(_ boxLayout: CiderSpecModel.SpBoxLayout) -> AnyView {
        switch boxLayout.direction {
        case "topToBottom":
            return AnyView(VStack(alignment: .leading, spacing: 8) {
                renderChildren(of: boxLayout)
            })
        default:
            return AnyView(HStack(alignment: .center, spacing: 8) {
                renderChildren(of: boxLayout)
            })
        }
    }

    @ViewBuilder
    private func renderChildren(of boxLayout: CiderSpecModel.SpBoxLayout) -> some View {
        ForEach(boxLayout.children, id: \.id) { child in
            renderNode(id: child.id)
        }
    }
}
