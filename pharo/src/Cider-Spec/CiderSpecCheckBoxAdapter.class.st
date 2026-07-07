Class {
	#name : 'CiderSpecCheckBoxAdapter',
	#superclass : 'CiderSpecAbstractAdapter',
	#instVars : [
		'node'
	],
	#category : 'Cider-Spec-Adapters',
	#package : 'Cider-Spec',
	#tag : 'Adapters'
}

{ #category : 'factory' }
CiderSpecCheckBoxAdapter >> buildWidget [

	node := self emitter newNodeFor: #CheckBoxAdapter.
	self presenter application backend registerAdapter: self forNode: node.
	self presenter whenChangedDo: [ :state |
		self emitter
			checkBoxPresenter: node
			stateChangedTo: state ].
	self emitter
		checkBoxPresenterBuilt: node
		label: self presenter label asString
		state: self presenter state
		enabled: self presenter isEnabled.
	^ node
]

{ #category : 'events' }
CiderSpecCheckBoxAdapter >> state: aBoolean [

	self presenter state: aBoolean
]
