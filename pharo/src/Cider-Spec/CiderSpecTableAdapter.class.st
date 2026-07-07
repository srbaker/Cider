Class {
	#name : 'CiderSpecTableAdapter',
	#superclass : 'CiderSpecAbstractAdapter',
	#category : 'Cider-Spec-Adapters',
	#package : 'Cider-Spec',
	#tag : 'Adapters'
}

{ #category : 'factory' }
CiderSpecTableAdapter >> buildWidget [
	| node columns rows selectedIndexes |

	node := self emitter newNodeFor: #TableAdapter.
	columns := self presenter columns collect: [ :column | column title asString ].
	rows := (1 to: self presenter items size) collect: [ :rowIndex |
		(1 to: self presenter columns size) collect: [ :columnIndex |
			[ (self presenter valueAtColumn: columnIndex row: rowIndex) asString ]
				on: Error
				do: [ '' ] ] ].
	selectedIndexes := self presenter selection selectedIndexes asArray.
	self emitter
		tablePresenterBuilt: node
		columns: columns asArray
		rows: rows asArray
		selectedIndexes: selectedIndexes.
	^ node
]
