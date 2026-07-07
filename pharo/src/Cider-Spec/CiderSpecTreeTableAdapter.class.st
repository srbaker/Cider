Class {
	#name : 'CiderSpecTreeTableAdapter',
	#superclass : 'CiderSpecAbstractAdapter',
	#instVars : [
		'node'
	],
	#category : 'Cider-Spec-Adapters',
	#package : 'Cider-Spec',
	#tag : 'Adapters'
}

{ #category : 'factory' }
CiderSpecTreeTableAdapter >> buildWidget [
	| columns |

	node := self emitter newNodeFor: #TreeTableAdapter.
	self presenter application backend registerAdapter: self forNode: node.
	self presenter whenSelectionChangedDo: [ :selection |
		self emitter
			treeTablePresenter: node
			selectedPathsChangedTo: selection selectedPaths asArray ].
	columns := self presenter columns collect: [ :column | column title asString ].
	self emitter
		treeTablePresenterBuilt: node
		columns: columns asArray
		nodes: (self treeTableNodesFrom: self presenter roots pathPrefix: #())
		selectedPaths: self selectedPaths.
	^ node
]

{ #category : 'private' }
CiderSpecTreeTableAdapter >> column: aColumn valueFor: anItem [

	^ [ aColumn readObject: anItem ]
		on: Error
		do: [ '' ]
]

{ #category : 'private' }
CiderSpecTreeTableAdapter >> columnValuesFor: anItem [

	^ self presenter columns collect: [ :column |
		((self column: column valueFor: anItem) asString) ]
]

{ #category : 'accessing' }
CiderSpecTreeTableAdapter >> itemAtPath: aPath [
	| items item |

	items := self presenter roots.
	aPath do: [ :index |
		item := items at: index.
		items := self presenter childrenFor: item ].
	^ item
]

{ #category : 'updating' }
CiderSpecTreeTableAdapter >> refreshWidgetSelection [
]

{ #category : 'accessing' }
CiderSpecTreeTableAdapter >> selectedPaths [

	^ self presenter selection selectedPaths asArray
]

{ #category : 'events' }
CiderSpecTreeTableAdapter >> selectedPaths: paths [

	self presenter selectPaths: paths
]

{ #category : 'private' }
CiderSpecTreeTableAdapter >> treeTableNodesFrom: items pathPrefix: pathPrefix [
	| nodes |

	nodes := OrderedCollection new.
	items withIndexDo: [ :item :index |
		| path nodeDictionary children |
		path := pathPrefix copyWith: index.
		nodeDictionary := Dictionary new
			at: #path put: path asArray;
			at: #values put: (self columnValuesFor: item) asArray;
			yourself.
		nodes add: nodeDictionary.
		children := [ self presenter childrenFor: item ]
			on: Error
			do: [ #() ].
		nodes addAll: (self treeTableNodesFrom: children pathPrefix: path) ].
	^ nodes asArray
]
