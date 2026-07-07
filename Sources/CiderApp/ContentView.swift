import CiderCore
import SwiftUI

struct ContentView: View {
    let model: CiderAppModel
    let onButtonClick: (String) -> Void

    var body: some View {
        Group {
            if let specModel = model.specModel {
                CiderSpecRenderer(model: specModel, onButtonClick: onButtonClick)
            } else {
                Text(model.title)
                    .font(.title)
            }
        }
        .padding(24)
    }
}
