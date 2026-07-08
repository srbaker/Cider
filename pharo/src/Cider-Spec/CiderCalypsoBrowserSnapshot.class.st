Class {
	#name : 'CiderCalypsoBrowserSnapshot',
	#superclass : 'Object',
	#instVars : [
		'emitter',
		'rowLimit'
	],
	#category : 'Cider-Spec-Morphic',
	#package : 'Cider-Spec',
	#tag : 'Morphic'
}

{ #category : 'instance creation' }
CiderCalypsoBrowserSnapshot class >> emitter: aCiderWireEmitter [

	^ self new
		emitter: aCiderWireEmitter;
		yourself
]

{ #category : 'emitting' }
CiderCalypsoBrowserSnapshot >> emitBrowser: aBrowser [
	| node |

	node := emitter newNodeFor: #ClyFullBrowserMorph.
	self emitBrowser: aBrowser node: node.
	^ node
]

{ #category : 'emitting' }
CiderCalypsoBrowserSnapshot >> emitBrowser: aBrowser node: aNode [

	aBrowser ensureInitialState.
	emitter
		clyFullBrowserMorphBuilt: aNode
		panes: (self panesFrom: aBrowser).
	^ aNode
]

{ #category : 'accessing' }
CiderCalypsoBrowserSnapshot >> emitter: aCiderWireEmitter [

	emitter := aCiderWireEmitter
]

{ #category : 'initialization' }
CiderCalypsoBrowserSnapshot >> initialize [

	super initialize.
	rowLimit := 50
]

{ #category : 'private' }
CiderCalypsoBrowserSnapshot >> itemNameAt: rowIndex in: aDataSource [

	^ [
		(aDataSource elementAt: rowIndex) name asString ]
		on: Error
		do: [ '' ]
]

{ #category : 'private' }
CiderCalypsoBrowserSnapshot >> paneFrom: aQueryView title: titleString [
	| dataSource totalRows rowCount items selectedIndex |

	dataSource := aQueryView dataSource.
	totalRows := dataSource numberOfRows.
	rowCount := totalRows min: rowLimit.
	items := (1 to: rowCount) collect: [ :index |
		self itemNameAt: index in: dataSource ].
	selectedIndex := aQueryView table selectedIndexes
		ifEmpty: [ 0 ]
		ifNotEmpty: [ :indexes | indexes first ].
	^ Dictionary new
		at: #title put: titleString;
		at: #items put: items asArray;
		at: #totalRows put: totalRows;
		at: #selectedIndex put: selectedIndex;
		yourself
]

{ #category : 'private' }
CiderCalypsoBrowserSnapshot >> panesFrom: aBrowser [
	| titles views |

	titles := #( 'Packages' 'Classes' 'Protocols' 'Methods' ).
	views := aBrowser navigationViews asArray.
	^ views withIndexCollect: [ :view :index |
		self
			paneFrom: view
			title: (titles at: index ifAbsent: [ 'Pane ' , index asString ]) ]
]

{ #category : 'accessing' }
CiderCalypsoBrowserSnapshot >> rowLimit: anInteger [

	rowLimit := anInteger
]

{ #category : 'selection' }
CiderCalypsoBrowserSnapshot >> selectPane: paneIndex row: rowIndex inBrowser: aBrowser [
	| views view |

	views := aBrowser navigationViews asArray.
	(paneIndex between: 1 and: views size)
		ifFalse: [ ^ self ].
	view := views at: paneIndex.
	(rowIndex between: 1 and: view dataSource numberOfRows)
		ifFalse: [ ^ self ].
	view table selectIndexes: { rowIndex }.
	view selectionChanged
]
