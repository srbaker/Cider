Class {
	#name : 'CiderInteractiveClickPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'label',
		'button',
		'list'
	],
	#category : 'Cider-Spec-Examples',
	#package : 'Cider-Spec-Examples'
}

{ #category : 'layout' }
CiderInteractiveClickPresenter >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		add: label expand: false;
		add: button expand: false;
		add: list expand: true;
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

	list := self newList.
	list items: #( 'Alpha' 'Beta' 'Gamma' ).
	list whenSelectionChangedDo: [ :selection |
		selection selectedItem ifNotNil: [ :item |
			label label: 'Selected ' , item ] ]
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
CiderInteractiveClickPresenter >> list [

	^ list
]

{ #category : 'accessing' }
CiderInteractiveClickPresenter >> windowTitle [

	^ 'Cider Interactive Click'
]
