Class {
	#name : 'CiderWireNode',
	#superclass : 'Object',
	#instVars : [
		'id',
		'kind',
		'children'
	],
	#category : 'Cider-Spec-Wire',
	#package : 'Cider-Spec',
	#tag : 'Wire'
}

{ #category : 'instance creation' }
CiderWireNode class >> id: anId kind: aKind [

	^ self new
		id: anId;
		kind: aKind;
		yourself
]

{ #category : 'accessing' }
CiderWireNode >> addChild: aNode [

	self children add: aNode
]

{ #category : 'accessing' }
CiderWireNode >> children [

	^ children ifNil: [ children := OrderedCollection new ]
]

{ #category : 'accessing' }
CiderWireNode >> id [

	^ id
]

{ #category : 'accessing' }
CiderWireNode >> id: aString [

	id := aString
]

{ #category : 'accessing' }
CiderWireNode >> kind [

	^ kind
]

{ #category : 'accessing' }
CiderWireNode >> kind: aSymbol [

	kind := aSymbol
]
