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
        } else if let panedLayout = model.panedLayouts[id] {
            return renderPanedLayout(panedLayout)
        } else if let label = model.labels[id] {
            return AnyView(Text(label.label))
        } else if let button = model.buttons[id] {
            return AnyView(Button(button.label) {}
                .disabled(!button.enabled))
        } else if let textInputField = model.textInputFields[id] {
            return renderTextInputField(textInputField)
        } else if let list = model.lists[id] {
            return renderList(list)
        } else if let codePresenter = model.codePresenters[id] {
            return renderCodePresenter(codePresenter)
        } else {
            return AnyView(EmptyView())
        }
    }

    private func renderCodePresenter(_ codePresenter: CiderSpecModel.SpCodePresenter) -> AnyView {
        AnyView(ScrollView([.horizontal, .vertical]) {
            Text(codePresenter.text)
                .font(.system(.body, design: .monospaced))
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding(8)
                .textSelection(.enabled)
        }
        .frame(minHeight: 160))
    }

    private func renderList(_ list: CiderSpecModel.SpListPresenter) -> AnyView {
        AnyView(List(Array(list.items.enumerated()), id: \.offset) { index, item in
            Text(item)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 2)
                .listRowBackground(
                    list.selectedIndexes.contains(index + 1)
                        ? Color.accentColor.opacity(0.18)
                        : Color.clear
                )
        }
        .frame(minHeight: 120))
    }

    private func renderTextInputField(_ textInputField: CiderSpecModel.SpTextInputFieldPresenter) -> AnyView {
        let text = Binding.constant(textInputField.text)

        if textInputField.password {
            return AnyView(SecureField(textInputField.placeholder, text: text)
                .disabled(!textInputField.editable))
        } else {
            return AnyView(TextField(textInputField.placeholder, text: text)
                .disabled(!textInputField.editable))
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

    private func renderPanedLayout(_ panedLayout: CiderSpecModel.SpPanedLayout) -> AnyView {
        switch panedLayout.direction {
        case "topToBottom":
            return AnyView(VSplitView {
                renderChildren(of: panedLayout)
            })
        default:
            return AnyView(HSplitView {
                renderChildren(of: panedLayout)
            })
        }
    }

    @ViewBuilder
    private func renderChildren(of boxLayout: CiderSpecModel.SpBoxLayout) -> some View {
        ForEach(boxLayout.children, id: \.id) { child in
            renderNode(id: child.id)
        }
    }

    @ViewBuilder
    private func renderChildren(of panedLayout: CiderSpecModel.SpPanedLayout) -> some View {
        ForEach(panedLayout.children, id: \.self) { child in
            renderNode(id: child)
        }
    }
}
