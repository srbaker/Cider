import CiderCore
import SwiftUI

@main
struct CiderApp: App {
    private static let demoScript = "pharo/scripts/serve-interactive-click.st"

    @State private var model = CiderAppModel.helloWorld
    @State private var session: CiderPharoLiveSession?
    @State private var events: [CiderWireEvent] = []

    var body: some Scene {
        WindowGroup(model.title) {
            ContentView(model: model) { id in
                Task {
                    await clickButton(id: id)
                }
            }
                .frame(minWidth: 720, minHeight: 480)
                .task {
                    await startLiveDemo()
                }
        }
    }

    @MainActor
    private func startLiveDemo() async {
        guard session == nil else {
            return
        }
        guard let session = try? CiderPharoLiveSession.preparedLocal(script: Self.demoScript) else {
            return
        }
        self.session = session

        do {
            events = try await session.readInitialEvents()
            model = CiderAppModel(specModel: try CiderSpecModel.build(from: events))
            await listenForUpdates(from: session)
        } catch {
            session.close()
            self.session = nil
        }
    }

    @MainActor
    private func clickButton(id: String) async {
        try? await session?.clickButton(id: id)
    }

    @MainActor
    private func listenForUpdates(from session: CiderPharoLiveSession) async {
        while !Task.isCancelled {
            do {
                let event = try await session.readEvent()
                events.append(event)
                model = CiderAppModel(specModel: try CiderSpecModel.build(from: events))
            } catch {
                return
            }
        }
    }
}
