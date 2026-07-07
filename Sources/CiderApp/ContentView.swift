import CiderCore
import SwiftUI

struct ContentView: View {
    let model: CiderAppModel
    let onButtonClick: (String) -> Void
    let onListSelection: (String, [Int]) -> Void
    let onTreeSelection: (String, [[Int]]) -> Void

    var body: some View {
        Group {
            if let specModel = model.specModel {
                CiderSpecRenderer(
                    model: specModel,
                    onButtonClick: onButtonClick,
                    onListSelection: onListSelection,
                    onTreeSelection: onTreeSelection
                )
            } else {
                Text(model.title)
                    .font(.title)
            }
        }
        .padding(24)
    }
}
