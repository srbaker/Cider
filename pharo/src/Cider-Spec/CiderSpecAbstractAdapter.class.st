Class {
	#name : 'CiderSpecAbstractAdapter',
	#superclass : 'SpAbstractAdapter',
	#category : 'Cider-Spec-Adapters',
	#package : 'Cider-Spec',
	#tag : 'Adapters'
}

{ #category : 'accessing' }
CiderSpecAbstractAdapter class >> adaptingName [

	^ (self name withoutPrefix: 'CiderSpec') asSymbol
]

{ #category : 'accessing' }
CiderSpecAbstractAdapter class >> allAdapters [

	^ self allSubclasses
]

{ #category : 'testing' }
CiderSpecAbstractAdapter class >> isAbstract [

	^ self = CiderSpecAbstractAdapter
]

{ #category : 'protocol' }
CiderSpecAbstractAdapter >> add: anAdapter [
]

{ #category : 'compatibility' }
CiderSpecAbstractAdapter >> bindKeyCombination: aShortcut toAction: aBlock [
]

{ #category : 'factory' }
CiderSpecAbstractAdapter >> buildWidget [

	^ self emitter newNodeFor: self class adaptingName
]

{ #category : 'accessing' }
CiderSpecAbstractAdapter >> emitter [

	^ self presenter application backend emitter
]

{ #category : 'protocol' }
CiderSpecAbstractAdapter >> hRigid [
]

{ #category : 'protocol' }
CiderSpecAbstractAdapter >> hShrinkWrap [
]

{ #category : 'protocol' }
CiderSpecAbstractAdapter >> hSpaceFill [
]

{ #category : 'testing' }
CiderSpecAbstractAdapter >> isRedrawable [

	^ true
]

{ #category : 'testing' }
CiderSpecAbstractAdapter >> isVisible [

	^ self presenter isVisible
]

{ #category : 'protocol' }
CiderSpecAbstractAdapter >> layout: aLayout [
]

{ #category : 'protocol' }
CiderSpecAbstractAdapter >> removeSubWidgets [

	self widget ifNotNil: [ self widget children removeAll ]
]

{ #category : 'emulating' }
CiderSpecAbstractAdapter >> sendRightClickEvent [
]

{ #category : 'factory' }
CiderSpecAbstractAdapter >> takeKeyboardFocus [
]

{ #category : 'protocol' }
CiderSpecAbstractAdapter >> vRigid [
]

{ #category : 'protocol' }
CiderSpecAbstractAdapter >> vShrinkWrap [
]

{ #category : 'protocol' }
CiderSpecAbstractAdapter >> vSpaceFill [
]
