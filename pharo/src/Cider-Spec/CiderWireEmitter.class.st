Class {
	#name : 'CiderWireEmitter',
	#superclass : 'Object',
	#instVars : [
		'stream',
		'nextIdentifier',
		'prefix'
	],
	#category : 'Cider-Spec-Wire',
	#package : 'Cider-Spec',
	#tag : 'Wire'
}

{ #category : 'instance creation' }
CiderWireEmitter class >> on: aStream [

	^ self new
		stream: aStream;
		yourself
]

{ #category : 'instance creation' }
CiderWireEmitter class >> stdout [

	^ self on: Stdio stdout
]

{ #category : 'emitting' }
CiderWireEmitter >> boxLayout: aNode added: childNode expand: aBoolean [

	self emit: {
		#receiver -> 'SpBoxLayout'.
		#selector -> 'add:expand:'.
		#id -> aNode id.
		#child -> childNode id.
		#expand -> aBoolean }
]

{ #category : 'emitting' }
CiderWireEmitter >> buttonPresenterBuilt: aNode label: aString enabled: aBoolean [

	self emit: {
		#receiver -> 'SpButtonPresenter'.
		#selector -> 'build'.
		#id -> aNode id.
		#adapter -> 'ButtonAdapter'.
		#label -> aString.
		#enabled -> aBoolean }
]

{ #category : 'emitting' }
CiderWireEmitter >> emit: associations [

	stream
		nextPutAll: prefix;
		nextPutAll: (self jsonObjectFrom: associations);
		lf.
	(stream respondsTo: #flush)
		ifTrue: [ stream flush ]
]

{ #category : 'emitting' }
CiderWireEmitter >> labelPresenterBuilt: aNode text: aString [

	self emit: {
		#receiver -> 'SpLabelPresenter'.
		#selector -> 'build'.
		#id -> aNode id.
		#adapter -> 'LabelAdapter'.
		#label -> aString }
]

{ #category : 'emitting' }
CiderWireEmitter >> textInputFieldPresenterBuilt: aNode text: aString placeholder: placeholderString editable: editableBoolean password: passwordBoolean [

	self emit: {
		#receiver -> 'SpTextInputFieldPresenter'.
		#selector -> 'build'.
		#id -> aNode id.
		#adapter -> 'TextInputFieldAdapter'.
		#text -> aString.
		#placeholder -> placeholderString.
		#editable -> editableBoolean.
		#password -> passwordBoolean }
]

{ #category : 'initialization' }
CiderWireEmitter >> initialize [

	super initialize.
	nextIdentifier := 0.
	prefix := 'CIDER:'
]

{ #category : 'private' }
CiderWireEmitter >> jsonBoolean: aBoolean [

	^ aBoolean
		ifTrue: [ 'true' ]
		ifFalse: [ 'false' ]
]

{ #category : 'private' }
CiderWireEmitter >> jsonObjectFrom: associations [

	^ String streamContents: [ :json |
		json nextPut: ${.
		associations doWithIndex: [ :association :index |
			index > 1 ifTrue: [ json nextPut: $, ].
			json
				nextPutAll: (self jsonString: association key asString);
				nextPut: $:;
				nextPutAll: (self jsonValue: association value) ].
		json nextPut: $} ]
]

{ #category : 'private' }
CiderWireEmitter >> jsonString: aString [

	^ String streamContents: [ :json |
		json nextPut: $".
		aString do: [ :character |
			character = $" ifTrue: [ json nextPutAll: '\"' ] ifFalse: [
			character = $\ ifTrue: [ json nextPutAll: '\\' ] ifFalse: [
			character = Character lf ifTrue: [ json nextPutAll: '\n' ] ifFalse: [
			character = Character cr ifTrue: [ json nextPutAll: '\r' ] ifFalse: [
			character = Character tab ifTrue: [ json nextPutAll: '\t' ] ifFalse: [
				json nextPut: character ] ] ] ] ] ].
		json nextPut: $" ]
]

{ #category : 'private' }
CiderWireEmitter >> jsonValue: anObject [

	(anObject == true or: [ anObject == false ])
		ifTrue: [ ^ self jsonBoolean: anObject ].
	anObject isString ifTrue: [ ^ self jsonString: anObject ].
	anObject isSymbol ifTrue: [ ^ self jsonString: anObject asString ].
	anObject isNumber ifTrue: [ ^ anObject asString ].
	anObject ifNil: [ ^ 'null' ].
	^ self jsonString: anObject asString
]

{ #category : 'instance creation' }
CiderWireEmitter >> newNodeFor: aKind [

	nextIdentifier := nextIdentifier + 1.
	^ CiderWireNode id: ('n' , nextIdentifier asString) kind: aKind
]

{ #category : 'accessing' }
CiderWireEmitter >> prefix [

	^ prefix
]

{ #category : 'accessing' }
CiderWireEmitter >> prefix: aString [

	prefix := aString
]

{ #category : 'accessing' }
CiderWireEmitter >> stream [

	^ stream
]

{ #category : 'accessing' }
CiderWireEmitter >> stream: aStream [

	stream := aStream
]

{ #category : 'emitting' }
CiderWireEmitter >> topToBottomBoxLayoutBuilt: aNode [

	self emit: {
		#receiver -> 'SpBoxLayout'.
		#selector -> 'build'.
		#id -> aNode id.
		#adapter -> 'BoxAdapter'.
		#direction -> 'topToBottom' }
]

{ #category : 'emitting' }
CiderWireEmitter >> windowPresenter: aWindowNode addedPresenterLayout: aPresenterNode [

	self emit: {
		#receiver -> 'SpWindowPresenter'.
		#selector -> 'presenter:'.
		#id -> aWindowNode id.
		#presenterLayout -> aPresenterNode id }
]

{ #category : 'emitting' }
CiderWireEmitter >> windowPresenterOpened: aNode title: aString presenterClass: aPresenterClassName [

	self emit: {
		#receiver -> 'SpWindowPresenter'.
		#selector -> 'open'.
		#id -> aNode id.
		#adapter -> 'WindowAdapter'.
		#presenter -> aPresenterClassName.
		#title -> aString }
]
