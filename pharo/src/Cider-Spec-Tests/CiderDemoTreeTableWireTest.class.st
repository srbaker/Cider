Class {
	#name : 'CiderDemoTreeTableWireTest',
	#superclass : 'TestCase',
	#category : 'Cider-Spec-Tests',
	#package : 'Cider-Spec-Tests'
}

{ #category : 'private' }
CiderDemoTreeTableWireTest >> idFromLine: aString [
	| start stop |

	start := (aString findString: '"id":"') + 6.
	stop := aString indexOf: $" startingAt: start.
	^ aString copyFrom: start to: stop - 1
]

{ #category : 'tests' }
CiderDemoTreeTableWireTest >> testSpDemoTreeTablePresenterDispatchesSelection [
	| stream emitter application presenter lines treeTableLine treeTableId |

	stream := WriteStream on: String new.
	emitter := CiderWireEmitter on: stream.
	application := StPharoApplication new.
	application useBackend: #Cider.
	application backend emitter: emitter.

	presenter := application newPresenter: SpDemoTreeTablePresenter.
	presenter open.

	lines := stream contents lines.
	treeTableLine := lines detect: [ :line |
		line includesSubstring: '"receiver":"SpTreeTablePresenter"' ].
	treeTableId := self idFromLine: treeTableLine.

	application backend dispatchIncomingEvent: (Dictionary new
		at: 'receiver' put: 'SpTreeTablePresenter';
		at: 'selector' put: 'selectedPaths:';
		at: 'id' put: treeTableId;
		at: 'selectedPaths' put: #( #( 1 ) );
		yourself).

	self assert: (stream contents lines anySatisfy: [ :line |
		line = ('CIDER:{"receiver":"SpTreeTablePresenter","selector":"selectedPaths:","id":"' , treeTableId , '","selectedPaths":[[1]]}') ])
]

{ #category : 'tests' }
CiderDemoTreeTableWireTest >> testSpDemoTreeTablePresenterEmitsTreeTableShape [
	| stream emitter application presenter lines treeTableLine |

	stream := WriteStream on: String new.
	emitter := CiderWireEmitter on: stream.
	application := StPharoApplication new.
	application useBackend: #Cider.
	application backend emitter: emitter.

	presenter := application newPresenter: SpDemoTreeTablePresenter.
	presenter open.

	lines := stream contents lines.
	treeTableLine := lines detect: [ :line |
		line includesSubstring: '"receiver":"SpTreeTablePresenter"' ].
	self assert: (treeTableLine includesSubstring: '"columns":["Classes","Number of subclasses","Number of methods"]').
	self assert: (treeTableLine includesSubstring: '"treeTableNodes":[').
	self assert: (treeTableLine includesSubstring: '"path":[1]').
	self assert: (treeTableLine includesSubstring: '"Object"').
	self assert: (treeTableLine includesSubstring: '"selectedPaths":[]').
	self assert: lines last equals: 'CIDER:{"receiver":"SpWindowPresenter","selector":"presenter:","id":"n1","presenterLayout":"n2"}'
]
