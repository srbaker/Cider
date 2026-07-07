Class {
	#name : 'CiderSpecCodeAdapter',
	#superclass : 'CiderSpecAbstractAdapter',
	#category : 'Cider-Spec-Adapters',
	#package : 'Cider-Spec',
	#tag : 'Adapters'
}

{ #category : 'factory' }
CiderSpecCodeAdapter >> buildWidget [
	| node |

	node := self emitter newNodeFor: #CodeAdapter.
	self emitter
		codePresenterBuilt: node
		text: self presenter text asString
		lineNumbers: self presenter hasLineNumbers
		syntaxHighlight: self presenter hasSyntaxHighlight.
	^ node
]
