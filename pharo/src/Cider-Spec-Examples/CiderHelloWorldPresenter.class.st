Class {
	#name : 'CiderHelloWorldPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'label',
		'button'
	],
	#category : 'Cider-Spec-Examples',
	#package : 'Cider-Spec-Examples'
}

{ #category : 'layout' }
CiderHelloWorldPresenter >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		add: label expand: false;
		add: button expand: false;
		yourself
]

{ #category : 'initialization' }
CiderHelloWorldPresenter >> initializePresenters [

	label := self newLabel.
	label label: 'Hello, World!'.

	button := self newButton.
	button label: 'Click me!'
]

{ #category : 'accessing' }
CiderHelloWorldPresenter >> button [

	^ button
]

{ #category : 'accessing' }
CiderHelloWorldPresenter >> label [

	^ label
]

{ #category : 'accessing' }
CiderHelloWorldPresenter >> windowTitle [

	^ 'Cider Hello'
]
