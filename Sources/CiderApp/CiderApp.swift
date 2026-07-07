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
            } onTextInputChange: { id, text in
                Task {
                    await setTextInput(id: id, text: text)
                }
            } onCheckBoxStateChange: { id, state in
                Task {
                    await setCheckBoxState(id: id, state: state)
                }
            } onDropListSelection: { id, index in
                Task {
                    await selectDropListIndex(id: id, index: index)
                }
            } onListSelection: { id, indexes in
                Task {
                    await selectListIndexes(id: id, indexes: indexes)
                }
            } onTableSelection: { id, indexes in
                Task {
                    await selectTableIndexes(id: id, indexes: indexes)
                }
            } onTreeSelection: { id, paths in
                Task {
                    await selectTreePaths(id: id, paths: paths)
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
    private func setTextInput(id: String, text: String) async {
        try? await session?.setTextInput(id: id, text: text)
    }

    @MainActor
    private func setCheckBoxState(id: String, state: Bool) async {
        try? await session?.setCheckBoxState(id: id, state: state)
    }

    @MainActor
    private func selectDropListIndex(id: String, index: Int) async {
        try? await session?.selectDropListIndex(id: id, index: index)
    }

    @MainActor
    private func selectListIndexes(id: String, indexes: [Int]) async {
        try? await session?.selectListIndexes(id: id, indexes: indexes)
    }

    @MainActor
    private func selectTableIndexes(id: String, indexes: [Int]) async {
        try? await session?.selectTableIndexes(id: id, indexes: indexes)
    }

    @MainActor
    private func selectTreePaths(id: String, paths: [[Int]]) async {
        try? await session?.selectTreePaths(id: id, paths: paths)
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
