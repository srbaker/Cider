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
		nodes: (self treeNodesFrom: self presenter roots pathPrefix: #())
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

{ #category : 'private' }
CiderSpecTreeAdapter >> treeNodesFrom: items pathPrefix: pathPrefix [
	| nodes |

	nodes := OrderedCollection new.
	items withIndexDo: [ :item :index |
		| path node children |
		path := pathPrefix copyWith: index.
		node := Dictionary new
			at: #path put: path asArray;
			at: #label put: (self presenter display cull: item) asString;
			yourself.
		nodes add: node.
		children := [ self presenter childrenFor: item ]
			on: Error
			do: [ #() ].
		nodes addAll: (self treeNodesFrom: children pathPrefix: path) ].
	^ nodes asArray
]
