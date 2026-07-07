Class {
	#name : 'CiderSpecDropListAdapter',
	#superclass : 'CiderSpecAbstractAdapter',
	#category : 'Cider-Spec-Adapters',
	#package : 'Cider-Spec',
	#tag : 'Adapters'
}

{ #category : 'factory' }
CiderSpecDropListAdapter >> buildWidget [
	| node items |

	node := self emitter newNodeFor: #DropListAdapter.
	items := self presenter items collect: [ :each |
		(self presenter display cull: each) asString ].
	self emitter
		dropListPresenterBuilt: node
		items: items asArray
		selectedIndex: self presenter selectedIndex.
	^ node
]
