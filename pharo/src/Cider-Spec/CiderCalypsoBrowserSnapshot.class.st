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
		panes: (self panesFrom: aBrowser)
		source: (self selectedSourceFrom: aBrowser)
		sourceTitle: (self selectedSourceTitleFrom: aBrowser).
	^ aNode
]

{ #category : 'accessing' }
CiderCalypsoBrowserSnapshot >> emitter: aCiderWireEmitter [

	emitter := aCiderWireEmitter
]

{ #category : 'initialization' }
CiderCalypsoBrowserSnapshot >> initialize [

	super initialize.
	rowLimit := 1000
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

{ #category : 'private' }
CiderCalypsoBrowserSnapshot >> selectedMethodSourceFrom: aBrowser [
	| views methodView selectedIndexes methodItem actualObject |

	views := aBrowser navigationViews asArray.
	views size < 4
		ifTrue: [ ^ '' ].
	methodView := views at: 4.
	selectedIndexes := methodView table selectedIndexes.
	selectedIndexes ifEmpty: [ ^ '' ].
	methodItem := [
		methodView dataSource elementAt: selectedIndexes first ]
		on: Error
		do: [ ^ '' ].
	(methodItem respondsTo: #actualObject)
		ifFalse: [ ^ '' ].
	actualObject := methodItem actualObject.
	(actualObject respondsTo: #sourceCode)
		ifFalse: [ ^ '' ].
	^ actualObject sourceCode
]

{ #category : 'private' }
CiderCalypsoBrowserSnapshot >> selectedClassSourceFrom: aBrowser [
	| views classView selectedIndexes classItem actualObject source |

	views := aBrowser navigationViews asArray.
	views size < 2
		ifTrue: [ ^ '' ].
	classView := views at: 2.
	selectedIndexes := classView table selectedIndexes.
	selectedIndexes ifEmpty: [ ^ '' ].
	classItem := [
		classView dataSource elementAt: selectedIndexes first ]
		on: Error
		do: [ ^ '' ].
	(classItem respondsTo: #actualObject)
		ifFalse: [ ^ '' ].
	actualObject := classItem actualObject.
	source := (actualObject respondsTo: #definitionString)
		ifTrue: [ actualObject definitionString asString ]
		ifFalse: [ actualObject name asString ].
	(actualObject respondsTo: #comment)
		ifTrue: [
			actualObject comment asString ifNotEmpty: [ :comment |
				source := source , String cr , String cr , comment ] ].
	^ source
]

{ #category : 'private' }
CiderCalypsoBrowserSnapshot >> selectedClassTitleFrom: aBrowser [
	| views classView selectedIndexes classItem actualObject |

	views := aBrowser navigationViews asArray.
	views size < 2
		ifTrue: [ ^ '' ].
	classView := views at: 2.
	selectedIndexes := classView table selectedIndexes.
	selectedIndexes ifEmpty: [ ^ '' ].
	classItem := [
		classView dataSource elementAt: selectedIndexes first ]
		on: Error
		do: [ ^ '' ].
	(classItem respondsTo: #actualObject)
		ifFalse: [ ^ '' ].
	actualObject := classItem actualObject.
	(actualObject respondsTo: #name)
		ifTrue: [ ^ actualObject name asString ].
	^ actualObject printString
]

{ #category : 'private' }
CiderCalypsoBrowserSnapshot >> selectedMethodTitleFrom: aBrowser [
	| views methodView selectedIndexes methodItem actualObject |

	views := aBrowser navigationViews asArray.
	views size < 4
		ifTrue: [ ^ '' ].
	methodView := views at: 4.
	selectedIndexes := methodView table selectedIndexes.
	selectedIndexes ifEmpty: [ ^ '' ].
	methodItem := [
		methodView dataSource elementAt: selectedIndexes first ]
		on: Error
		do: [ ^ '' ].
	(methodItem respondsTo: #actualObject)
		ifFalse: [ ^ '' ].
	actualObject := methodItem actualObject.
	^ actualObject printString
]

{ #category : 'private' }
CiderCalypsoBrowserSnapshot >> selectedSourceFrom: aBrowser [
	| methodSource |

	methodSource := self selectedMethodSourceFrom: aBrowser.
	methodSource ifNotEmpty: [ ^ methodSource ].
	^ self selectedClassSourceFrom: aBrowser
]

{ #category : 'private' }
CiderCalypsoBrowserSnapshot >> selectedSourceTitleFrom: aBrowser [
	| methodTitle |

	methodTitle := self selectedMethodTitleFrom: aBrowser.
	methodTitle ifNotEmpty: [ ^ methodTitle ].
	^ self selectedClassTitleFrom: aBrowser
]
