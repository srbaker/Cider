Class {
	#name : 'CiderSpecBoxAdapter',
	#superclass : 'CiderSpecAbstractAdapter',
	#category : 'Cider-Spec-Adapters',
	#package : 'Cider-Spec',
	#tag : 'Adapters'
}

{ #category : 'protocol' }
CiderSpecBoxAdapter >> add: anAdapter constraints: constraints [
	| childNode |

	childNode := self nodeFrom: anAdapter.
	self widget addChild: childNode.
	self emitter
		boxLayout: self widget
		added: childNode
		expand: constraints isExpand
]

{ #category : 'factory' }
CiderSpecBoxAdapter >> buildWidget [

	^ self emitter newNodeFor: #BoxAdapter
]

{ #category : 'protocol' }
CiderSpecBoxAdapter >> layout: aLayout [

	self emitter
		boxLayoutBuilt: self widget
		direction: (aLayout isHorizontal
			ifTrue: [ 'leftToRight' ]
			ifFalse: [ 'topToBottom' ])
]
