Class {
	#name : 'CiderSpecTreeAdapter',
	#superclass : 'CiderSpecAbstractAdapter',
	#category : 'Cider-Spec-Adapters',
	#package : 'Cider-Spec',
	#tag : 'Adapters'
}

{ #category : 'factory' }
CiderSpecTreeAdapter >> buildWidget [
	| node roots |

	node := self emitter newNodeFor: #TreeAdapter.
	roots := self presenter roots collect: [ :each |
		(self presenter display cull: each) asString ].
	self emitter
		treePresenterBuilt: node
		roots: roots asArray
		selectedPaths: #().
	^ node
]

{ #category : 'accessing' }
CiderSpecTreeAdapter >> collapseAll [
]

{ #category : 'accessing' }
CiderSpecTreeAdapter >> collapsePath: anArray [
]

{ #category : 'accessing' }
CiderSpecTreeAdapter >> expandAll [
]

{ #category : 'accessing' }
CiderSpecTreeAdapter >> expandPath: anArray [
]

{ #category : 'accessing' }
CiderSpecTreeAdapter >> expandRoots [
]

{ #category : 'testing' }
CiderSpecTreeAdapter >> isExpanded: aPath [

	^ false
]

{ #category : 'accessing' }
CiderSpecTreeAdapter >> selectedPaths [

	^ #()
]
