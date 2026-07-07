import CiderCore
import SwiftUI

@main
struct CiderApp: App {
    @State private var model = CiderAppModel.helloWorld

    var body: some Scene {
        WindowGroup(model.title) {
            ContentView(model: model)
                .frame(minWidth: 720, minHeight: 480)
        }
    }
}
