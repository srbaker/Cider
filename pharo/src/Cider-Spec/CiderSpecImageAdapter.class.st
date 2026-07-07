Class {
	#name : 'CiderSpecImageAdapter',
	#superclass : 'CiderSpecAbstractAdapter',
	#category : 'Cider-Spec-Adapters',
	#package : 'Cider-Spec',
	#tag : 'Adapters'
}

{ #category : 'factory' }
CiderSpecImageAdapter >> buildWidget [
	| node image extent |

	node := self emitter newNodeFor: #ImageAdapter.
	image := self presenter image.
	extent := image
		ifNil: [ 0 @ 0 ]
		ifNotNil: [ image extent ].
	self emitter
		imagePresenterBuilt: node
		width: extent x
		height: extent y
		autoScale: self isPresenterAutoScale.
	^ node
]

{ #category : 'private' }
CiderSpecImageAdapter >> isPresenterAutoScale [

	^ (self presenter respondsTo: #isAutoScale)
		ifTrue: [ self presenter isAutoScale ]
		ifFalse: [ self presenter autoScale ]
]
