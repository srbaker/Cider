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
	self presenter application backend registerAdapter: self forNode: node.
	self emitter
		buttonPresenterBuilt: node
		label: self presenter label
		enabled: self presenter isEnabled.
	^ node
]

{ #category : 'events' }
CiderSpecButtonAdapter >> click [

	self presenter action ifNotNil: [ :action | action value ]
]
