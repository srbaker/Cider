Class {
	#name : 'CiderSpecTextInputFieldAdapter',
	#superclass : 'CiderSpecAbstractAdapter',
	#instVars : [
		'node'
	],
	#category : 'Cider-Spec-Adapters',
	#package : 'Cider-Spec',
	#tag : 'Adapters'
}

{ #category : 'factory' }
CiderSpecTextInputFieldAdapter >> buildWidget [

	node := self emitter newNodeFor: #TextInputFieldAdapter.
	self presenter application backend registerAdapter: self forNode: node.
	self presenter whenTextChangedDo: [ :newText |
		self emitter
			textInputFieldPresenter: node
			textChangedTo: newText asString ].
	self emitter
		textInputFieldPresenterBuilt: node
		text: self presenter text asString
		placeholder: self presenter placeholder asString
		editable: self presenter isEditable
		password: self presenter isPassword.
	^ node
]

{ #category : 'events' }
CiderSpecTextInputFieldAdapter >> text: aString [

	self presenter text: aString
]
