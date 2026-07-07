Class {
	#name : 'CiderSpecBoxAdapter',
	#superclass : 'CiderSpecAbstractAdapter',
	#category : 'Cider-Spec-Adapters',
	#package : 'Cider-Spec',
	#tag : 'Adapters'
}

{ #category : 'protocol' }
CiderSpecBoxAdapter >> add: anAdapter constraints: constraints [

	self widget addChild: anAdapter widget.
	self emitter
		boxLayout: self widget
		added: anAdapter widget
		expand: constraints isExpand
]

{ #category : 'factory' }
CiderSpecBoxAdapter >> buildWidget [
	| node |

	node := self emitter newNodeFor: #BoxAdapter.
	self emitter topToBottomBoxLayoutBuilt: node.
	^ node
]
