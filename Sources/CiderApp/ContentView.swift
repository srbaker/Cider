import CiderCore
import SwiftUI

struct ContentView: View {
    let model: CiderAppModel

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(model.title)
                .font(.title)
            Text("Ready for a Pharo Spec adapter connection.")
                .foregroundStyle(.secondary)
        }
        .padding(24)
    }
}
