Class {
	#name : 'CiderHelloWorldPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'label',
		'button',
		'input'
	],
	#category : 'Cider-Spec-Examples',
	#package : 'Cider-Spec-Examples'
}

{ #category : 'layout' }
CiderHelloWorldPresenter >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		add: label expand: false;
		add: button expand: false;
		add: input expand: false;
		yourself
]

{ #category : 'initialization' }
CiderHelloWorldPresenter >> initializePresenters [

	label := self newLabel.
	label label: 'Hello, World!'.

	button := self newButton.
	button label: 'Click me!'.

	input := self newTextInput.
	input
		placeholder: 'Type here';
		text: 'Editable text'
]

{ #category : 'accessing' }
CiderHelloWorldPresenter >> button [

	^ button
]

{ #category : 'accessing' }
CiderHelloWorldPresenter >> input [

	^ input
]

{ #category : 'accessing' }
CiderHelloWorldPresenter >> label [

	^ label
]

{ #category : 'accessing' }
CiderHelloWorldPresenter >> windowTitle [

	^ 'Cider Hello'
]
