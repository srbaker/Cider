Class {
	#name : 'CiderSpecTextInputFieldAdapter',
	#superclass : 'CiderSpecAbstractAdapter',
	#category : 'Cider-Spec-Adapters',
	#package : 'Cider-Spec',
	#tag : 'Adapters'
}

{ #category : 'factory' }
CiderSpecTextInputFieldAdapter >> buildWidget [
	| node |

	node := self emitter newNodeFor: #TextInputFieldAdapter.
	self emitter
		textInputFieldPresenterBuilt: node
		text: self presenter text asString
		placeholder: self presenter placeholder asString
		editable: self presenter isEditable
		password: self presenter isPassword.
	^ node
]
