Class {
	#name : 'CiderHelloWorldWireTest',
	#superclass : 'TestCase',
	#category : 'Cider-Spec-Tests',
	#package : 'Cider-Spec-Tests'
}

{ #category : 'tests' }
CiderHelloWorldWireTest >> testHelloWorldPresenterEmitsWindowBoxLabelAndEdges [
	| stream emitter application output lines |

	stream := WriteStream on: String new.
	emitter := CiderWireEmitter on: stream.
	application := CiderHelloWorldApplication new.
	application useBackend: #Cider.
	application backend emitter: emitter.

	application run.

	output := stream contents.
	lines := output lines.
	self assert: lines size equals: 5.
	self assert: (lines first beginsWith: 'CIDER:').
	self assert: lines first equals: 'CIDER:{"receiver":"SpWindowPresenter","selector":"open","id":"n1","adapter":"WindowAdapter","presenter":"CiderHelloWorldPresenter","title":"Cider Hello"}'.
	self assert: lines second equals: 'CIDER:{"receiver":"SpBoxLayout","selector":"build","id":"n2","adapter":"BoxAdapter","direction":"topToBottom"}'.
	self assert: lines third equals: 'CIDER:{"receiver":"SpLabelPresenter","selector":"build","id":"n3","adapter":"LabelAdapter","label":"Hello, World!"}'.
	self assert: lines fourth equals: 'CIDER:{"receiver":"SpBoxLayout","selector":"add:expand:","id":"n2","child":"n3","expand":false}'.
	self assert: lines fifth equals: 'CIDER:{"receiver":"SpWindowPresenter","selector":"presenter:","id":"n1","presenterLayout":"n2"}'
]
