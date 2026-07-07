import CiderCore
import SwiftUI

struct ContentView: View {
    let model: CiderAppModel
    let onButtonClick: (String) -> Void
    let onTextInputChange: (String, String) -> Void
    let onCheckBoxStateChange: (String, Bool) -> Void
    let onDropListSelection: (String, Int) -> Void
    let onListSelection: (String, [Int]) -> Void
    let onListActivation: (String, Int) -> Void
    let onTableSelection: (String, [Int]) -> Void
    let onTableActivation: (String, Int) -> Void
    let onTreeSelection: (String, [[Int]]) -> Void
    let onTreeActivation: (String, [Int]) -> Void
    let onTreeTableSelection: (String, [[Int]]) -> Void
    let onTreeTableActivation: (String, [Int]) -> Void

    var body: some View {
        Group {
            if let specModel = model.specModel {
                CiderSpecRenderer(
                    model: specModel,
                    onButtonClick: onButtonClick,
                    onTextInputChange: onTextInputChange,
                    onCheckBoxStateChange: onCheckBoxStateChange,
                    onDropListSelection: onDropListSelection,
                    onListSelection: onListSelection,
                    onListActivation: onListActivation,
                    onTableSelection: onTableSelection,
                    onTableActivation: onTableActivation,
                    onTreeSelection: onTreeSelection,
                    onTreeActivation: onTreeActivation,
                    onTreeTableSelection: onTreeTableSelection,
                    onTreeTableActivation: onTreeTableActivation
                )
            } else {
                Text(model.title)
                    .font(.title)
            }
        }
        .padding(24)
    }
}
