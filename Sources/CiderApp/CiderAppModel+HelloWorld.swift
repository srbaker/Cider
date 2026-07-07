import CiderCore

extension CiderAppModel {
    static var helloWorld: CiderAppModel {
        CiderAppModel(specModel: makeHelloWorldSpecModel())
    }

    private static func makeHelloWorldSpecModel() -> CiderSpecModel? {
        let ndjson = """
        CIDER:{"receiver":"SpWindowPresenter","selector":"open","id":"n1","adapter":"WindowAdapter","presenter":"CiderHelloWorldPresenter","title":"Cider Hello"}
        CIDER:{"receiver":"SpBoxLayout","selector":"build","id":"n2","adapter":"BoxAdapter","direction":"topToBottom"}
        CIDER:{"receiver":"SpLabelPresenter","selector":"build","id":"n3","adapter":"LabelAdapter","label":"Hello, World!"}
        CIDER:{"receiver":"SpBoxLayout","selector":"add:expand:","id":"n2","child":"n3","expand":false}
        CIDER:{"receiver":"SpWindowPresenter","selector":"presenter:","id":"n1","presenterLayout":"n2"}
        """

        guard let events = try? CiderWireEventDecoder.decodeEvents(from: ndjson) else {
            return nil
        }

        return try? CiderSpecModel.build(from: events)
    }
}
