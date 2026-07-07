Class {
	#name : 'CiderSpecDropListAdapter',
	#superclass : 'CiderSpecAbstractAdapter',
	#instVars : [
		'node'
	],
	#category : 'Cider-Spec-Adapters',
	#package : 'Cider-Spec',
	#tag : 'Adapters'
}

{ #category : 'factory' }
CiderSpecDropListAdapter >> buildWidget [
	| items |

	node := self emitter newNodeFor: #DropListAdapter.
	self presenter application backend registerAdapter: self forNode: node.
	self presenter whenSelectionChangedDo: [
		self emitter
			dropListPresenter: node
			selectedIndexChangedTo: self presenter selectedIndex ].
	items := self presenter items collect: [ :each | each asString ].
	self emitter
		dropListPresenterBuilt: node
		items: items asArray
		selectedIndex: self presenter selectedIndex.
	^ node
]

{ #category : 'accessing' }
CiderSpecDropListAdapter >> elementAt: anIndex [

	^ self presenter getList at: anIndex
]

{ #category : 'events' }
CiderSpecDropListAdapter >> selectIndex: anInteger [

	self presenter selection selectIndex: anInteger
]
