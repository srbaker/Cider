Class {
	#name : 'CiderInteractiveClickWireTest',
	#superclass : 'TestCase',
	#category : 'Cider-Spec-Tests',
	#package : 'Cider-Spec-Tests'
}

{ #category : 'private' }
CiderInteractiveClickWireTest >> idFromLine: aString [
	| start stop |

	start := (aString findString: '"id":"') + 6.
	stop := aString indexOf: $" startingAt: start.
	^ aString copyFrom: start to: stop - 1
]

{ #category : 'tests' }
CiderInteractiveClickWireTest >> testButtonClickDispatchesActionAndEmitsLabelUpdate [
	| stream emitter application presenter lines buttonLine buttonId labelLine labelId |

	stream := WriteStream on: String new.
	emitter := CiderWireEmitter on: stream.
	application := StPharoApplication new.
	application useBackend: #Cider.
	application backend emitter: emitter.

	presenter := application newPresenter: CiderInteractiveClickPresenter.
	presenter open.

	lines := stream contents lines.
	labelLine := lines detect: [ :line |
		(line includesSubstring: '"receiver":"SpLabelPresenter"')
			and: [ line includesSubstring: '"label":"Not clicked"' ] ].
	labelId := self idFromLine: labelLine.
	buttonLine := lines detect: [ :line |
		(line includesSubstring: '"receiver":"SpButtonPresenter"')
			and: [ line includesSubstring: '"label":"Click"' ] ].
	buttonId := self idFromLine: buttonLine.

	application backend dispatchIncomingEvent: (Dictionary new
		at: 'receiver' put: 'SpButtonPresenter';
		at: 'selector' put: 'click';
		at: 'id' put: buttonId;
		yourself).

	self assert: presenter label label equals: 'Clicked'.
	self assert: (stream contents lines anySatisfy: [ :line |
		line = ('CIDER:{"receiver":"SpLabelPresenter","selector":"label:","id":"' , labelId , '","label":"Clicked"}') ])
]

{ #category : 'tests' }
CiderInteractiveClickWireTest >> testListSelectionDispatchesSelectionAndEmitsLabelUpdate [
	| stream emitter application presenter lines listLine listId labelLine labelId |

	stream := WriteStream on: String new.
	emitter := CiderWireEmitter on: stream.
	application := StPharoApplication new.
	application useBackend: #Cider.
	application backend emitter: emitter.

	presenter := application newPresenter: CiderInteractiveClickPresenter.
	presenter open.

	lines := stream contents lines.
	labelLine := lines detect: [ :line |
		(line includesSubstring: '"receiver":"SpLabelPresenter"')
			and: [ line includesSubstring: '"label":"Not clicked"' ] ].
	labelId := self idFromLine: labelLine.
	listLine := lines detect: [ :line |
		(line includesSubstring: '"receiver":"SpListPresenter"')
			and: [ line includesSubstring: '"Alpha"' ] ].
	listId := self idFromLine: listLine.

	application backend dispatchIncomingEvent: (Dictionary new
		at: 'receiver' put: 'SpListPresenter';
		at: 'selector' put: 'selectedIndexes:';
		at: 'id' put: listId;
		at: 'selectedIndexes' put: #( 2 );
		yourself).

	self assert: presenter list selection selectedIndexes asArray equals: #( 2 ).
	self assert: presenter label label equals: 'Selected Beta'.
	self assert: (stream contents lines anySatisfy: [ :line |
		line = ('CIDER:{"receiver":"SpListPresenter","selector":"selectedIndexes:","id":"' , listId , '","selectedIndexes":[2]}') ]).
	self assert: (stream contents lines anySatisfy: [ :line |
		line = ('CIDER:{"receiver":"SpLabelPresenter","selector":"label:","id":"' , labelId , '","label":"Selected Beta"}') ])
]
