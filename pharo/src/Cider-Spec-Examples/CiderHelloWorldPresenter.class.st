Class {
	#name : 'CiderHelloWorldPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'label'
	],
	#category : 'Cider-Spec-Examples',
	#package : 'Cider-Spec-Examples'
}

{ #category : 'layout' }
CiderHelloWorldPresenter >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		add: label expand: false;
		yourself
]

{ #category : 'initialization' }
CiderHelloWorldPresenter >> initializePresenters [

	label := self newLabel.
	label label: 'Hello, World!'
]

{ #category : 'accessing' }
CiderHelloWorldPresenter >> label [

	^ label
]

{ #category : 'accessing' }
CiderHelloWorldPresenter >> windowTitle [

	^ 'Cider Hello'
]
