Class {
	#name : 'CiderSpecButtonAdapter',
	#superclass : 'CiderSpecAbstractAdapter',
	#category : 'Cider-Spec-Adapters',
	#package : 'Cider-Spec',
	#tag : 'Adapters'
}

{ #category : 'factory' }
CiderSpecButtonAdapter >> buildWidget [
	| node |

	node := self emitter newNodeFor: #ButtonAdapter.
	self emitter
		buttonPresenterBuilt: node
		label: self presenter label
		enabled: self presenter isEnabled.
	^ node
]
