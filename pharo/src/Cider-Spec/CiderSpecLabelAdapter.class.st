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
	self presenter application backend registerAdapter: self forNode: node.
	self presenter whenLabelChangedDo: [ :newLabel |
		self emitter
			labelPresenter: node
			labelChangedTo: newLabel ].
	self emitter
		labelPresenterBuilt: node
		text: self presenter label.
	^ node
]
