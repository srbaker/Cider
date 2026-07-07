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
        } else if let millerLayout = model.millerLayouts[id] {
            return renderMillerLayout(millerLayout)
        } else if let label = model.labels[id] {
            return AnyView(Text(label.label))
        } else if let image = model.images[id] {
            return renderImage(image)
        } else if let button = model.buttons[id] {
            return AnyView(Button(button.label) {}
                .disabled(!button.enabled))
        } else if let checkBox = model.checkBoxes[id] {
            return renderCheckBox(checkBox)
        } else if let textInputField = model.textInputFields[id] {
            return renderTextInputField(textInputField)
        } else if let list = model.lists[id] {
            return renderList(list)
        } else if let codePresenter = model.codePresenters[id] {
            return renderCodePresenter(codePresenter)
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

        return AnyView(RoundedRectangle(cornerRadius: 4)
            .fill(Color.secondary.opacity(0.16))
            .overlay {
                Text("\(image.width)x\(image.height)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .frame(
                width: image.autoScale ? nil : min(width, 240),
                height: image.autoScale ? nil : min(height, 180)
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

    private func renderNativeWidget(_ nativeWidget: CiderSpecModel.SpNativeWidget) -> AnyView {
        AnyView(Text(nativeWidget.widgetClass)
            .font(.caption)
            .foregroundStyle(.secondary)
            .frame(maxWidth: .infinity, minHeight: 80, alignment: .center)
            .background(Color.secondary.opacity(0.08)))
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
