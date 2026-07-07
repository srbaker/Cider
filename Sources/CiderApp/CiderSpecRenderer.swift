import CiderCore
import SwiftUI

struct CiderSpecRenderer: View {
    let model: CiderSpecModel
    let onButtonClick: (String) -> Void
    let onTextInputChange: (String, String) -> Void
    let onDropListSelection: (String, Int) -> Void
    let onListSelection: (String, [Int]) -> Void
    let onTreeSelection: (String, [[Int]]) -> Void

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
        } else if let millerLayout = model.millerLayouts[id] {
            return renderMillerLayout(millerLayout)
        } else if let label = model.labels[id] {
            return AnyView(Text(label.label))
        } else if let image = model.images[id] {
            return renderImage(image)
        } else if let button = model.buttons[id] {
            return AnyView(Button(button.label) {
                onButtonClick(button.id)
            }
                .disabled(!button.enabled))
        } else if let checkBox = model.checkBoxes[id] {
            return renderCheckBox(checkBox)
        } else if let dropList = model.dropLists[id] {
            return renderDropList(dropList)
        } else if let textInputField = model.textInputFields[id] {
            return renderTextInputField(textInputField)
        } else if let list = model.lists[id] {
            return renderList(list)
        } else if let tree = model.trees[id] {
            return renderTree(tree)
        } else if let codePresenter = model.codePresenters[id] {
            return renderCodePresenter(codePresenter)
        } else if let micScrolledTextMorph = model.micScrolledTextMorphs[id] {
            return renderMicScrolledTextMorph(micScrolledTextMorph)
        } else if let nativeWidget = model.nativeWidgets[id] {
            return renderNativeWidget(nativeWidget)
        } else if let paginator = model.paginators[id] {
            return renderPaginator(paginator)
        } else {
            return AnyView(EmptyView())
        }
    }

    private func renderCodePresenter(_ codePresenter: CiderSpecModel.SpCodePresenter) -> AnyView {
        AnyView(ScrollView([.horizontal, .vertical]) {
            HStack(alignment: .top, spacing: 12) {
                if codePresenter.lineNumbers {
                    Text(lineNumbers(for: codePresenter.text))
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.trailing)
                }

                Text(codePresenter.text)
                    .textSelection(.enabled)
            }
            .font(.system(.body, design: .monospaced))
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding(8)
        }
        .frame(minHeight: 160))
    }

    private func lineNumbers(for text: String) -> String {
        let lineCount = max(text.split(separator: "\n", omittingEmptySubsequences: false).count, 1)
        return (1...lineCount)
            .map(String.init)
            .joined(separator: "\n")
    }

    private func renderImage(_ image: CiderSpecModel.SpImagePresenter) -> AnyView {
        let width = image.width > 0 ? CGFloat(image.width) : 80
        let height = image.height > 0 ? CGFloat(image.height) : 80
        let displayWidth = min(width, 240)
        let displayHeight = min(height, 180)

        if width <= 32, height <= 32 {
            return AnyView(Color.clear.frame(width: width, height: height))
        }

        return AnyView(Rectangle()
            .fill(Color.secondary.opacity(0.06))
            .frame(
                width: image.autoScale ? nil : displayWidth,
                height: image.autoScale ? nil : displayHeight
            )
            .frame(
                maxWidth: image.autoScale ? .infinity : nil,
                maxHeight: image.autoScale ? .infinity : nil
            ))
    }

    private func renderCheckBox(_ checkBox: CiderSpecModel.SpCheckBoxPresenter) -> AnyView {
        AnyView(Toggle(checkBox.label, isOn: .constant(checkBox.state))
            .toggleStyle(.checkbox)
            .disabled(!checkBox.enabled))
    }

    private func renderDropList(_ dropList: CiderSpecModel.SpDropListPresenter) -> AnyView {
        let selection = Binding(
            get: { dropList.selectedIndex },
            set: { onDropListSelection(dropList.id, $0) }
        )

        return AnyView(Picker("", selection: selection) {
            ForEach(Array(dropList.items.enumerated()), id: \.offset) { index, item in
                Text(item).tag(index + 1)
            }
        }
        .labelsHidden())
    }

    private func renderNativeWidget(_ nativeWidget: CiderSpecModel.SpNativeWidget) -> AnyView {
        let text = nativeWidget.text.trimmingCharacters(in: .whitespacesAndNewlines)

        if text.isEmpty {
            return AnyView(EmptyView())
        }

        return AnyView(ScrollView([.horizontal, .vertical]) {
            Text(text)
                .textSelection(.enabled)
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .padding(8)
        }
        .frame(minHeight: 120)
        .background(Color.secondary.opacity(0.04)))
    }

    private func renderMicScrolledTextMorph(_ morph: CiderSpecModel.MicScrolledTextMorph) -> AnyView {
        AnyView(ScrollView([.horizontal, .vertical]) {
            Text(morph.text)
                .textSelection(.enabled)
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .padding(8)
        }
        .frame(minHeight: 120)
        .background(Color.secondary.opacity(0.04)))
    }

    private func renderPaginator(_ paginator: CiderSpecModel.SpPaginatorPresenter) -> AnyView {
        AnyView(HStack(spacing: 4) {
            ForEach(1...max(paginator.pages, 1), id: \.self) { page in
                Capsule()
                    .fill(page == paginator.selectedPage ? Color.accentColor : Color.secondary.opacity(0.22))
                    .frame(width: page == paginator.selectedPage ? 28 : 16, height: 6)
            }
        }
        .padding(.vertical, 6))
    }

    private func renderList(_ list: CiderSpecModel.SpListPresenter) -> AnyView {
        AnyView(List(Array(list.items.enumerated()), id: \.offset) { index, item in
            Button {
                onListSelection(list.id, [index + 1])
            } label: {
                Text(item)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, 2)
            }
            .buttonStyle(.plain)
            .listRowBackground(
                list.selectedIndexes.contains(index + 1)
                    ? Color.accentColor.opacity(0.18)
                    : Color.clear
            )
        }
        .frame(minHeight: 120))
    }

    private func renderTree(_ tree: CiderSpecModel.SpTreePresenter) -> AnyView {
        AnyView(List(tree.nodes, id: \.path) { node in
            Button {
                onTreeSelection(tree.id, [node.path])
            } label: {
                Text(node.label)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, CGFloat(max(node.path.count - 1, 0) * 14))
                    .padding(.vertical, 2)
            }
            .buttonStyle(.plain)
            .listRowBackground(
                tree.selectedPaths.contains(node.path)
                    ? Color.accentColor.opacity(0.18)
                    : Color.clear
            )
        }
        .frame(minHeight: 120))
    }

    private func renderTextInputField(_ textInputField: CiderSpecModel.SpTextInputFieldPresenter) -> AnyView {
        let text = Binding(
            get: { textInputField.text },
            set: { onTextInputChange(textInputField.id, $0) }
        )

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

    private func renderMillerLayout(_ millerLayout: CiderSpecModel.SpMillerLayout) -> AnyView {
        switch millerLayout.direction {
        case "topToBottom":
            return AnyView(ScrollView(.vertical) {
                VStack(alignment: .leading, spacing: 8) {
                    renderChildren(of: millerLayout)
                }
            })
        default:
            return AnyView(ScrollView(.horizontal) {
                HStack(alignment: .top, spacing: 8) {
                    renderChildren(of: millerLayout)
                }
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

    @ViewBuilder
    private func renderChildren(of millerLayout: CiderSpecModel.SpMillerLayout) -> some View {
        ForEach(millerLayout.children, id: \.self) { child in
            renderNode(id: child)
        }
    }
}
