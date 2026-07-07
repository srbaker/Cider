Class {
	#name : 'CiderClassMethodBrowserWireTest',
	#superclass : 'TestCase',
	#category : 'Cider-Spec-Tests',
	#package : 'Cider-Spec-Tests'
}

{ #category : 'tests' }
CiderClassMethodBrowserWireTest >> testClassMethodBrowserEmitsExistingSpecBrowserShape [
	| stream emitter application browser output lines |

	stream := WriteStream on: String new.
	emitter := CiderWireEmitter on: stream.
	application := SpApplication new.
	application useBackend: #Cider.
	application backend emitter: emitter.

	browser := application newPresenter: SpClassMethodBrowser.
	browser classes: { Object. String. Array }.
	browser open.

	output := stream contents.
	lines := output lines.
	self assert: lines size equals: 11.
	self assert: lines first equals: 'CIDER:{"receiver":"SpWindowPresenter","selector":"open","id":"n1","adapter":"WindowAdapter","presenter":"SpClassMethodBrowser","title":"Class Method Browser"}'.
	self assert: lines second equals: 'CIDER:{"receiver":"SpPanedLayout","selector":"build","id":"n2","adapter":"PanedAdapter","direction":"topToBottom"}'.
	self assert: lines third equals: 'CIDER:{"receiver":"SpPanedLayout","selector":"build","id":"n3","adapter":"PanedAdapter","direction":"leftToRight"}'.
	self assert: lines fourth equals: 'CIDER:{"receiver":"SpListPresenter","selector":"build","id":"n4","adapter":"ListAdapter","items":["Object","String","Array"]}'.
	self assert: lines fifth equals: 'CIDER:{"receiver":"SpPanedLayout","selector":"add:","id":"n3","child":"n4"}'.
	self assert: (lines sixth beginsWith: 'CIDER:{"receiver":"SpListPresenter","selector":"build","id":"n5","adapter":"ListAdapter","items":[').
	self assert: lines seventh equals: 'CIDER:{"receiver":"SpPanedLayout","selector":"add:","id":"n3","child":"n5"}'.
	self assert: lines eighth equals: 'CIDER:{"receiver":"SpPanedLayout","selector":"add:","id":"n2","child":"n3"}'.
	self assert: (lines ninth beginsWith: 'CIDER:{"receiver":"SpCodePresenter","selector":"build","id":"n6","adapter":"CodeAdapter","text":"').
	self assert: (lines ninth includesSubstring: '","lineNumbers":true,"syntaxHighlight":true}').
	self assert: (lines at: 10) equals: 'CIDER:{"receiver":"SpPanedLayout","selector":"add:","id":"n2","child":"n6"}'.
	self assert: (lines at: 11) equals: 'CIDER:{"receiver":"SpWindowPresenter","selector":"presenter:","id":"n1","presenterLayout":"n2"}'
]
