Class {
	#name : 'CiderSpecPanedAdapter',
	#superclass : 'CiderSpecAbstractAdapter',
	#category : 'Cider-Spec-Adapters',
	#package : 'Cider-Spec',
	#tag : 'Adapters'
}

{ #category : 'protocol' }
CiderSpecPanedAdapter >> add: anAdapter constraints: constraints [
	| childNode |

	childNode := (anAdapter respondsTo: #widget)
		ifTrue: [ anAdapter widget ]
		ifFalse: [ anAdapter build ].
	self widget addChild: childNode.
	self emitter
		panedLayout: self widget
		added: childNode
]

{ #category : 'factory' }
CiderSpecPanedAdapter >> buildWidget [

	^ self emitter newNodeFor: #PanedAdapter
]

{ #category : 'protocol' }
CiderSpecPanedAdapter >> layout: aLayout [

	self emitter
		panedLayoutBuilt: self widget
		direction: (aLayout isHorizontal
			ifTrue: [ 'leftToRight' ]
			ifFalse: [ 'topToBottom' ])
]
