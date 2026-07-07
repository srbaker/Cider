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
CiderInteractiveClickWireTest >> testTextInputDispatchesTextAndEmitsLabelUpdate [
	| stream emitter application presenter lines inputLine inputId labelLine labelId |

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
	inputLine := lines detect: [ :line |
		(line includesSubstring: '"receiver":"SpTextInputFieldPresenter"')
			and: [ line includesSubstring: '"text":"Editable text"' ] ].
	inputId := self idFromLine: inputLine.

	application backend dispatchIncomingEvent: (Dictionary new
		at: 'receiver' put: 'SpTextInputFieldPresenter';
		at: 'selector' put: 'text:';
		at: 'id' put: inputId;
		at: 'text' put: 'Edited';
		yourself).

	self assert: presenter input text equals: 'Edited'.
	self assert: presenter label label equals: 'Typed Edited'.
	self assert: (stream contents lines anySatisfy: [ :line |
		line = ('CIDER:{"receiver":"SpTextInputFieldPresenter","selector":"text:","id":"' , inputId , '","text":"Edited"}') ]).
	self assert: (stream contents lines anySatisfy: [ :line |
		line = ('CIDER:{"receiver":"SpLabelPresenter","selector":"label:","id":"' , labelId , '","label":"Typed Edited"}') ])
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

{ #category : 'tests' }
CiderInteractiveClickWireTest >> testTreeSelectionDispatchesSelectionAndEmitsLabelUpdate [
	| stream emitter application presenter lines treeLine treeId labelLine labelId |

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
	treeLine := lines detect: [ :line |
		(line includesSubstring: '"receiver":"SpTreePresenter"')
			and: [ line includesSubstring: '"Spec"' ] ].
	treeId := self idFromLine: treeLine.

	application backend dispatchIncomingEvent: (Dictionary new
		at: 'receiver' put: 'SpTreePresenter';
		at: 'selector' put: 'selectedPaths:';
		at: 'id' put: treeId;
		at: 'selectedPaths' put: #( #( 1 1 ) );
		yourself).

	self assert: presenter tree selection selectedPaths asArray equals: #( #( 1 1 ) ).
	self assert: presenter label label equals: 'Tree Spec'.
	self assert: (stream contents lines anySatisfy: [ :line |
		line = ('CIDER:{"receiver":"SpTreePresenter","selector":"selectedPaths:","id":"' , treeId , '","selectedPaths":[[1,1]]}') ]).
	self assert: (stream contents lines anySatisfy: [ :line |
		line = ('CIDER:{"receiver":"SpLabelPresenter","selector":"label:","id":"' , labelId , '","label":"Tree Spec"}') ])
]
