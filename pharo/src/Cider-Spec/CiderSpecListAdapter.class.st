Class {
	#name : 'CiderSpecListAdapter',
	#superclass : 'CiderSpecAbstractAdapter',
	#category : 'Cider-Spec-Adapters',
	#package : 'Cider-Spec',
	#tag : 'Adapters'
}

{ #category : 'factory' }
CiderSpecListAdapter >> buildWidget [
	| node items |

	node := self emitter newNodeFor: #ListAdapter.
	items := self presenter items collect: [ :each |
		(self presenter displayValueFor: each) asString ].
	self emitter
		listPresenterBuilt: node
		items: items asArray.
	^ node
]
