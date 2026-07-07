Class {
	#name : 'CiderSpecMillerAdapter',
	#superclass : 'CiderSpecAbstractAdapter',
	#category : 'Cider-Spec-Adapters',
	#package : 'Cider-Spec',
	#tag : 'Adapters'
}

{ #category : 'protocol' }
CiderSpecMillerAdapter >> add: anAdapter constraints: constraints [
	| childNode |

	childNode := self nodeFrom: anAdapter.
	self widget addChild: childNode.
	self emitter
		millerLayout: self widget
		added: childNode
]

{ #category : 'factory' }
CiderSpecMillerAdapter >> buildWidget [

	^ self emitter newNodeFor: #MillerAdapter
]

{ #category : 'protocol' }
CiderSpecMillerAdapter >> layout: aLayout [

	self emitter
		millerLayoutBuilt: self widget
		direction: (aLayout isHorizontal
			ifTrue: [ 'leftToRight' ]
			ifFalse: [ 'topToBottom' ])
		visiblePages: aLayout visiblePages
]
