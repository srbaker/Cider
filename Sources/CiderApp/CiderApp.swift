import CiderCore
import SwiftUI

@main
struct CiderApp: App {
    private static let demoScript = "pharo/scripts/emit-calypso-browser.st"

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
            } onListActivation: { id, index in
                Task {
                    await activateListIndex(id: id, index: index)
                }
            } onTableSelection: { id, indexes in
                Task {
                    await selectTableIndexes(id: id, indexes: indexes)
                }
            } onTableActivation: { id, index in
                Task {
                    await activateTableIndex(id: id, index: index)
                }
            } onTreeSelection: { id, paths in
                Task {
                    await selectTreePaths(id: id, paths: paths)
                }
            } onTreeActivation: { id, path in
                Task {
                    await activateTreePath(id: id, path: path)
                }
            } onTreeTableSelection: { id, paths in
                Task {
                    await selectTreeTablePaths(id: id, paths: paths)
                }
            } onTreeTableActivation: { id, path in
                Task {
                    await activateTreeTablePath(id: id, path: path)
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
    private func activateListIndex(id: String, index: Int) async {
        try? await session?.activateListIndex(id: id, index: index)
    }

    @MainActor
    private func selectTableIndexes(id: String, indexes: [Int]) async {
        try? await session?.selectTableIndexes(id: id, indexes: indexes)
    }

    @MainActor
    private func activateTableIndex(id: String, index: Int) async {
        try? await session?.activateTableIndex(id: id, index: index)
    }

    @MainActor
    private func selectTreePaths(id: String, paths: [[Int]]) async {
        try? await session?.selectTreePaths(id: id, paths: paths)
    }

    @MainActor
    private func activateTreePath(id: String, path: [Int]) async {
        try? await session?.activateTreePath(id: id, path: path)
    }

    @MainActor
    private func selectTreeTablePaths(id: String, paths: [[Int]]) async {
        try? await session?.selectTreeTablePaths(id: id, paths: paths)
    }

    @MainActor
    private func activateTreeTablePath(id: String, path: [Int]) async {
        try? await session?.activateTreeTablePath(id: id, path: path)
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
