Class {
	#name : 'CiderSpecCheckBoxAdapter',
	#superclass : 'CiderSpecAbstractAdapter',
	#category : 'Cider-Spec-Adapters',
	#package : 'Cider-Spec',
	#tag : 'Adapters'
}

{ #category : 'factory' }
CiderSpecCheckBoxAdapter >> buildWidget [
	| node |

	node := self emitter newNodeFor: #CheckBoxAdapter.
	self emitter
		checkBoxPresenterBuilt: node
		label: self presenter label asString
		state: self presenter state
		enabled: self presenter isEnabled.
	^ node
]
