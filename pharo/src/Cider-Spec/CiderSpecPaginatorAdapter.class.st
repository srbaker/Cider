Class {
	#name : 'CiderSpecPaginatorAdapter',
	#superclass : 'CiderSpecAbstractAdapter',
	#category : 'Cider-Spec-Adapters',
	#package : 'Cider-Spec',
	#tag : 'Adapters'
}

{ #category : 'factory' }
CiderSpecPaginatorAdapter >> buildWidget [
	| node selectedPage |

	node := self emitter newNodeFor: #PaginatorAdapter.
	selectedPage := self presenter selectedPage
		ifNil: [ self presenter pages size ].
	self emitter
		paginatorPresenterBuilt: node
		pages: self presenter pages size
		selectedPage: selectedPage
		visiblePages: self presenter visiblePages.
	^ node
]

{ #category : 'paginator' }
CiderSpecPaginatorAdapter >> withoutResizingEdges [
]
