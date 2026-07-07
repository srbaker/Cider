Class {
	#name : 'CiderSpecListAdapter',
	#superclass : 'CiderSpecAbstractAdapter',
	#instVars : [
		'node'
	],
	#category : 'Cider-Spec-Adapters',
	#package : 'Cider-Spec',
	#tag : 'Adapters'
}

{ #category : 'factory' }
CiderSpecListAdapter >> buildWidget [
	| items |

	node := self emitter newNodeFor: #ListAdapter.
	self presenter application backend registerAdapter: self forNode: node.
	items := self presenter items collect: [ :each |
		(self presenter displayValueFor: each) asString ].
	self emitter
		listPresenterBuilt: node
		items: items asArray
		selectedIndexes: self presenter selection selectedIndexes asArray.
	^ node
]

{ #category : 'accessing' }
CiderSpecListAdapter >> elementAt: anIndex [

	^ self presenter items at: anIndex
]

{ #category : 'events' }
CiderSpecListAdapter >> activateAtIndex: anIndex [

	self presenter doActivateAtIndex: anIndex
]

{ #category : 'events' }
CiderSpecListAdapter >> selectedIndexes: indexes [

	self presenter selection selectIndexes: indexes
]

{ #category : 'refreshing' }
CiderSpecListAdapter >> refreshWidgetSelection [

	node ifNil: [ ^ self ].
	self emitter
		listPresenter: node
		selectedIndexesChangedTo: self presenter selection selectedIndexes asArray
]
