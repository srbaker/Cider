import CiderCore
import SwiftUI

@main
struct CiderApp: App {
    @State private var model = CiderAppModel.helloWorld

    var body: some Scene {
        WindowGroup(model.title) {
            ContentView(model: model)
                .frame(minWidth: 720, minHeight: 480)
                .task {
                    await loadHelloWorldFromPharo()
                }
        }
    }

    @MainActor
    private func loadHelloWorldFromPharo() async {
        guard let bridge = try? CiderPharoBridge.preparedLocal() else {
            return
        }
        guard let specModel = try? await bridge.helloWorldModel() else {
            return
        }

        model = CiderAppModel(specModel: specModel)
    }
}
