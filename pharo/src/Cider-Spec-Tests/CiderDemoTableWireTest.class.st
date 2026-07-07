Class {
	#name : 'CiderDemoTableWireTest',
	#superclass : 'TestCase',
	#category : 'Cider-Spec-Tests',
	#package : 'Cider-Spec-Tests'
}

{ #category : 'tests' }
CiderDemoTableWireTest >> testSpDemoTablePresenterEmitsTableShape [
	| stream emitter application presenter lines tableLine |

	stream := WriteStream on: String new.
	emitter := CiderWireEmitter on: stream.
	application := StPharoApplication new.
	application useBackend: #Cider.
	application backend emitter: emitter.

	presenter := application newPresenter: SpDemoTablePresenter.
	presenter open.

	lines := stream contents lines.
	tableLine := lines detect: [ :line |
		line includesSubstring: '"receiver":"SpTablePresenter"' ].
	self assert: (tableLine includesSubstring: '"columns":[" ","Icon","Name","Number of subclasses"]').
	self assert: (tableLine includesSubstring: '"rows":[').
	self assert: (tableLine includesSubstring: '"selectedIndexes":[]').
	self assert: lines last equals: 'CIDER:{"receiver":"SpWindowPresenter","selector":"presenter:","id":"n1","presenterLayout":"n2"}'
]
