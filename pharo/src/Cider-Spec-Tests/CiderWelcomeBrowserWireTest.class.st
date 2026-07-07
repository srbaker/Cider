Class {
	#name : 'CiderWelcomeBrowserWireTest',
	#superclass : 'TestCase',
	#category : 'Cider-Spec-Tests',
	#package : 'Cider-Spec-Tests'
}

{ #category : 'tests' }
CiderWelcomeBrowserWireTest >> testWelcomeBrowserEmitsRealNewToolsSpecTree [
	| stream emitter application browser lines |

	stream := WriteStream on: String new.
	emitter := CiderWireEmitter on: stream.
	application := StPharoApplication new.
	application useBackend: #Cider.
	application backend emitter: emitter.

	browser := application newPresenter: StWelcomeBrowser.
	browser open.

	lines := stream contents lines.
	self assert: lines notEmpty.
	self assert: lines first equals: 'CIDER:{"receiver":"SpWindowPresenter","selector":"open","id":"n1","adapter":"WindowAdapter","presenter":"StWelcomeBrowser","title":"Welcome"}'.
	self assert: (lines anySatisfy: [ :line | line includesSubstring: '"receiver":"SpMillerLayout"' ]).
	self assert: (lines anySatisfy: [ :line | line includesSubstring: '"receiver":"SpImagePresenter"' ]).
	self assert: (lines anySatisfy: [ :line | line includesSubstring: '"receiver":"SpCheckBoxPresenter"' ]).
	self assert: (lines anySatisfy: [ :line | line includesSubstring: '"receiver":"SpPaginatorPresenter"' ]).
	self assert: (lines anySatisfy: [ :line | line includesSubstring: '"receiver":"MicScrolledTextMorph"' ]).
	self deny: (lines anySatisfy: [ :line | line includesSubstring: '"widgetClass":"MicScrolledTextMorph"' ]).
	self assert: lines last equals: 'CIDER:{"receiver":"SpWindowPresenter","selector":"presenter:","id":"n1","presenterLayout":"n2"}'
]
