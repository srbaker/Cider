Class {
	#name : 'CiderInteractiveClickPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'label',
		'button',
		'list',
		'tree',
		'input',
		'dropList',
		'checkBox'
	],
	#category : 'Cider-Spec-Examples',
	#package : 'Cider-Spec-Examples'
}

{ #category : 'layout' }
CiderInteractiveClickPresenter >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		add: label expand: false;
		add: button expand: false;
		add: input expand: false;
		add: dropList expand: false;
		add: checkBox expand: false;
		add: list expand: true;
		add: tree expand: true;
		yourself
]

{ #category : 'initialization' }
CiderInteractiveClickPresenter >> initializePresenters [

	label := self newLabel.
	label label: 'Not clicked'.

	button := self newButton.
	button
		label: 'Click';
		action: [ label label: 'Clicked' ].

	input := self newTextInput.
	input
		placeholder: 'Type here';
		text: 'Editable text'.
	input whenTextChangedDo: [ :text |
		label label: 'Typed ' , text asString ].

	dropList := self newDropList.
	dropList items: #( 'One' 'Two' 'Three' ).
	dropList whenSelectionChangedDo: [
		dropList selectedItem ifNotNil: [ :item |
			label label: 'Choice ' , item ] ].

	checkBox := self newCheckBox.
	checkBox
		label: 'Enabled';
		state: false.
	checkBox whenChangedDo: [ :state |
		label label: (state
			ifTrue: [ 'Checked' ]
			ifFalse: [ 'Unchecked' ]) ].

	list := self newList.
	list items: #( 'Alpha' 'Beta' 'Gamma' ).
	list whenSelectionChangedDo: [ :selection |
		selection selectedItem ifNotNil: [ :item |
			label label: 'Selected ' , item ] ].
	list whenActivatedDo: [ :selection |
		selection selectedItem ifNotNil: [ :item |
			label label: 'Activated ' , item ] ].

	tree := self newTree.
	tree
		roots: #( 'Smalltalk' 'Swift' );
		children: [ :item |
			item = 'Smalltalk'
				ifTrue: [ #( 'Spec' 'SUnit' ) ]
				ifFalse: [
					item = 'Swift'
						ifTrue: [ #( 'SwiftUI' 'Swift Testing' ) ]
						ifFalse: [ #() ] ] ].
	tree whenSelectionChangedDo: [ :selection |
		selection selectedItem ifNotNil: [ :item |
			label label: 'Tree ' , item ] ].
	tree whenActivatedDo: [ :selection |
		selection selectedItem ifNotNil: [ :item |
			label label: 'Activated Tree ' , item ] ]
]

{ #category : 'accessing' }
CiderInteractiveClickPresenter >> button [

	^ button
]

{ #category : 'accessing' }
CiderInteractiveClickPresenter >> label [

	^ label
]

{ #category : 'accessing' }
CiderInteractiveClickPresenter >> input [

	^ input
]

{ #category : 'accessing' }
CiderInteractiveClickPresenter >> dropList [

	^ dropList
]

{ #category : 'accessing' }
CiderInteractiveClickPresenter >> checkBox [

	^ checkBox
]

{ #category : 'accessing' }
CiderInteractiveClickPresenter >> list [

	^ list
]

{ #category : 'accessing' }
CiderInteractiveClickPresenter >> tree [

	^ tree
]

{ #category : 'accessing' }
CiderInteractiveClickPresenter >> windowTitle [

	^ 'Cider Interactive Click'
]
