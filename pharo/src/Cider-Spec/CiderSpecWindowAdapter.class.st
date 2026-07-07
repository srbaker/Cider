Class {
	#name : 'CiderSpecWindowAdapter',
	#superclass : 'CiderSpecAbstractAdapter',
	#category : 'Cider-Spec-Adapters',
	#package : 'Cider-Spec',
	#tag : 'Adapters'
}

{ #category : 'factory' }
CiderSpecWindowAdapter >> addContent: aNode toWindow: aWindowNode [

	aWindowNode addChild: aNode.
	self emitter
		windowPresenter: aWindowNode
		addedPresenterLayout: aNode
]

{ #category : 'factory' }
CiderSpecWindowAdapter >> addPresenterIn: widgetToBuild withSpecLayout: aSpec [

	self
		addContent: (self presenter presenter buildWithLayout: aSpec)
		toWindow: widgetToBuild
]

{ #category : 'factory' }
CiderSpecWindowAdapter >> beep [
]

{ #category : 'factory' }
CiderSpecWindowAdapter >> buildWidget [
	| node |

	node := self emitter newNodeFor: #WindowAdapter.
	self emitter
		windowPresenterOpened: node
		title: self presenter presenter windowTitle
		presenterClass: self presenter presenter class name.
	^ node
]

{ #category : 'factory' }
CiderSpecWindowAdapter >> close [
]

{ #category : 'factory' }
CiderSpecWindowAdapter >> delete [
]

{ #category : 'factory' }
CiderSpecWindowAdapter >> open [

	self presenter windowIsOpened
]

{ #category : 'factory' }
CiderSpecWindowAdapter >> openWithDeferredAction: aBlock [

	self presenter windowIsOpened.
	aBlock value
]

{ #category : 'factory' }
CiderSpecWindowAdapter >> title: aString [
]
