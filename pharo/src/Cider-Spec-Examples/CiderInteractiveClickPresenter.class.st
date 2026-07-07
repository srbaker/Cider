Class {
	#name : 'CiderInteractiveClickPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'label',
		'button'
	],
	#category : 'Cider-Spec-Examples',
	#package : 'Cider-Spec-Examples'
}

{ #category : 'layout' }
CiderInteractiveClickPresenter >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		add: label expand: false;
		add: button expand: false;
		yourself
]

{ #category : 'initialization' }
CiderInteractiveClickPresenter >> initializePresenters [

	label := self newLabel.
	label label: 'Not clicked'.

	button := self newButton.
	button
		label: 'Click';
		action: [ label label: 'Clicked' ]
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
CiderInteractiveClickPresenter >> windowTitle [

	^ 'Cider Interactive Click'
]
