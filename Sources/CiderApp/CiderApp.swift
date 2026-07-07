import CiderCore
import SwiftUI

@main
struct CiderApp: App {
    private static let helloWorldScript = "pharo/scripts/emit-hello-world.st"

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
        guard let specModel = try? await bridge.model(from: Self.helloWorldScript) else {
            return
        }

        model = CiderAppModel(specModel: specModel)
    }
}
