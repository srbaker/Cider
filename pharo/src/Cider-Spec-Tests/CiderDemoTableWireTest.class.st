Class {
	#name : 'CiderDemoTableWireTest',
	#superclass : 'TestCase',
	#category : 'Cider-Spec-Tests',
	#package : 'Cider-Spec-Tests'
}

{ #category : 'private' }
CiderDemoTableWireTest >> idFromLine: aString [
	| start stop |

	start := (aString findString: '"id":"') + 6.
	stop := aString indexOf: $" startingAt: start.
	^ aString copyFrom: start to: stop - 1
]

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

{ #category : 'tests' }
CiderDemoTableWireTest >> testSpDemoTablePresenterDispatchesSelection [
	| stream emitter application presenter lines tableLine tableId |

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
	tableId := self idFromLine: tableLine.

	application backend dispatchIncomingEvent: (Dictionary new
		at: 'receiver' put: 'SpTablePresenter';
		at: 'selector' put: 'selectedIndexes:';
		at: 'id' put: tableId;
		at: 'selectedIndexes' put: #( 2 );
		yourself).

	self assert: (stream contents lines anySatisfy: [ :line |
		line = ('CIDER:{"receiver":"SpTablePresenter","selector":"selectedIndexes:","id":"' , tableId , '","selectedIndexes":[2]}') ])
]
