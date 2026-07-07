import CiderCore
import SwiftUI

@main
struct CiderApp: App {
    private static let demoScript = "pharo/scripts/emit-welcome-browser.st"

    @State private var model = CiderAppModel.helloWorld

    var body: some Scene {
        WindowGroup(model.title) {
            ContentView(model: model)
                .frame(minWidth: 720, minHeight: 480)
                .task {
                    await loadDemoFromPharo()
                }
        }
    }

    @MainActor
    private func loadDemoFromPharo() async {
        guard let bridge = try? CiderPharoBridge.preparedLocal() else {
            return
        }
        guard let specModel = try? await bridge.model(from: Self.demoScript) else {
            return
        }

        model = CiderAppModel(specModel: specModel)
    }
}
