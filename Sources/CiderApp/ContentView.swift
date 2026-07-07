import CiderCore
import SwiftUI

struct ContentView: View {
    let model: CiderAppModel

    var body: some View {
        Group {
            if let specModel = model.specModel {
                CiderSpecRenderer(model: specModel)
            } else {
                Text(model.title)
                    .font(.title)
            }
        }
        .padding(24)
    }
}
