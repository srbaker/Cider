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

	childNode := (anAdapter respondsTo: #widget)
		ifTrue: [ anAdapter widget ]
		ifFalse: [ anAdapter build ].
	self widget addChild: childNode.
	self emitter
		boxLayout: self widget
		added: childNode
		expand: constraints isExpand
]

{ #category : 'factory' }
CiderSpecBoxAdapter >> buildWidget [
	| node |

	node := self emitter newNodeFor: #BoxAdapter.
	self emitter topToBottomBoxLayoutBuilt: node.
	^ node
]
