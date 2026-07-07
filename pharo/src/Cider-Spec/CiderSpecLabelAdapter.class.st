Class {
	#name : 'CiderSpecLabelAdapter',
	#superclass : 'CiderSpecAbstractAdapter',
	#category : 'Cider-Spec-Adapters',
	#package : 'Cider-Spec',
	#tag : 'Adapters'
}

{ #category : 'factory' }
CiderSpecLabelAdapter >> buildWidget [
	| node |

	node := self emitter newNodeFor: #LabelAdapter.
	self emitter
		labelPresenterBuilt: node
		text: self presenter label.
	^ node
]
