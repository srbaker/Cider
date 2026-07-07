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
CiderWireEmitter >> boxLayoutBuilt: aNode direction: aString [

	self emit: {
		#receiver -> 'SpBoxLayout'.
		#selector -> 'build'.
		#id -> aNode id.
		#adapter -> 'BoxAdapter'.
		#direction -> aString }
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
CiderWireEmitter >> codePresenterBuilt: aNode text: aString lineNumbers: lineNumbersBoolean syntaxHighlight: syntaxHighlightBoolean [

	self emit: {
		#receiver -> 'SpCodePresenter'.
		#selector -> 'build'.
		#id -> aNode id.
		#adapter -> 'CodeAdapter'.
		#text -> aString.
		#lineNumbers -> lineNumbersBoolean.
		#syntaxHighlight -> syntaxHighlightBoolean }
]

{ #category : 'emitting' }
CiderWireEmitter >> checkBoxPresenterBuilt: aNode label: aString state: stateBoolean enabled: enabledBoolean [

	self emit: {
		#receiver -> 'SpCheckBoxPresenter'.
		#selector -> 'build'.
		#id -> aNode id.
		#adapter -> 'CheckBoxAdapter'.
		#label -> aString.
		#state -> stateBoolean.
		#enabled -> enabledBoolean }
]

{ #category : 'emitting' }
CiderWireEmitter >> checkBoxPresenter: aNode stateChangedTo: stateBoolean [

	self emit: {
		#receiver -> 'SpCheckBoxPresenter'.
		#selector -> 'state:'.
		#id -> aNode id.
		#state -> stateBoolean }
]

{ #category : 'emitting' }
CiderWireEmitter >> dropListPresenterBuilt: aNode items: itemStrings selectedIndex: selectedIndex [

	self emit: {
		#receiver -> 'SpDropListPresenter'.
		#selector -> 'build'.
		#id -> aNode id.
		#adapter -> 'DropListAdapter'.
		#items -> itemStrings.
		#selectedIndex -> selectedIndex }
]

{ #category : 'emitting' }
CiderWireEmitter >> dropListPresenter: aNode selectedIndexChangedTo: selectedIndex [

	self emit: {
		#receiver -> 'SpDropListPresenter'.
		#selector -> 'selectIndex:'.
		#id -> aNode id.
		#selectedIndex -> selectedIndex }
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
CiderWireEmitter >> labelPresenter: aNode labelChangedTo: aString [

	self emit: {
		#receiver -> 'SpLabelPresenter'.
		#selector -> 'label:'.
		#id -> aNode id.
		#label -> aString }
]

{ #category : 'emitting' }
CiderWireEmitter >> imagePresenterBuilt: aNode width: width height: height autoScale: aBoolean [

	self emit: {
		#receiver -> 'SpImagePresenter'.
		#selector -> 'build'.
		#id -> aNode id.
		#adapter -> 'ImageAdapter'.
		#width -> width.
		#height -> height.
		#autoScale -> aBoolean }
]

{ #category : 'emitting' }
CiderWireEmitter >> listPresenterBuilt: aNode items: itemStrings selectedIndexes: indexes [

	self emit: {
		#receiver -> 'SpListPresenter'.
		#selector -> 'build'.
		#id -> aNode id.
		#adapter -> 'ListAdapter'.
		#items -> itemStrings.
		#selectedIndexes -> indexes }
]

{ #category : 'emitting' }
CiderWireEmitter >> listPresenter: aNode selectedIndexesChangedTo: indexes [

	self emit: {
		#receiver -> 'SpListPresenter'.
		#selector -> 'selectedIndexes:'.
		#id -> aNode id.
		#selectedIndexes -> indexes }
]

{ #category : 'emitting' }
CiderWireEmitter >> tablePresenterBuilt: aNode columns: columnStrings rows: rowStrings selectedIndexes: indexes [

	self emit: {
		#receiver -> 'SpTablePresenter'.
		#selector -> 'build'.
		#id -> aNode id.
		#adapter -> 'TableAdapter'.
		#columns -> columnStrings.
		#rows -> rowStrings.
		#selectedIndexes -> indexes }
]

{ #category : 'emitting' }
CiderWireEmitter >> tablePresenter: aNode selectedIndexesChangedTo: indexes [

	self emit: {
		#receiver -> 'SpTablePresenter'.
		#selector -> 'selectedIndexes:'.
		#id -> aNode id.
		#selectedIndexes -> indexes }
]

{ #category : 'emitting' }
CiderWireEmitter >> millerLayout: aNode added: childNode [

	self emit: {
		#receiver -> 'SpMillerLayout'.
		#selector -> 'add:'.
		#id -> aNode id.
		#child -> childNode id }
]

{ #category : 'emitting' }
CiderWireEmitter >> millerLayoutBuilt: aNode direction: aString visiblePages: aNumber [

	self emit: {
		#receiver -> 'SpMillerLayout'.
		#selector -> 'build'.
		#id -> aNode id.
		#adapter -> 'MillerAdapter'.
		#direction -> aString.
		#visiblePages -> aNumber }
]

{ #category : 'emitting' }
CiderWireEmitter >> micScrolledTextMorphBuilt: aNode text: aString [

	self emit: {
		#receiver -> 'MicScrolledTextMorph'.
		#selector -> 'build'.
		#id -> aNode id.
		#adapter -> 'MorphAdapter'.
		#text -> aString }
]

{ #category : 'emitting' }
CiderWireEmitter >> nativeWidgetBuilt: aNode widgetClass: aString text: textString [

	self emit: {
		#receiver -> 'SpNativeWidget'.
		#selector -> 'build'.
		#id -> aNode id.
		#adapter -> 'NativeAdapter'.
		#widgetClass -> aString.
		#text -> textString }
]

{ #category : 'emitting' }
CiderWireEmitter >> paginatorPresenterBuilt: aNode pages: pageCount selectedPage: selectedPage visiblePages: visiblePages [

	self emit: {
		#receiver -> 'SpPaginatorPresenter'.
		#selector -> 'build'.
		#id -> aNode id.
		#adapter -> 'PaginatorAdapter'.
		#pages -> pageCount.
		#selectedPage -> selectedPage.
		#visiblePages -> visiblePages }
]

{ #category : 'emitting' }
CiderWireEmitter >> panedLayout: aNode added: childNode [

	self emit: {
		#receiver -> 'SpPanedLayout'.
		#selector -> 'add:'.
		#id -> aNode id.
		#child -> childNode id }
]

{ #category : 'emitting' }
CiderWireEmitter >> panedLayoutBuilt: aNode direction: aString [

	self emit: {
		#receiver -> 'SpPanedLayout'.
		#selector -> 'build'.
		#id -> aNode id.
		#adapter -> 'PanedAdapter'.
		#direction -> aString }
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

{ #category : 'emitting' }
CiderWireEmitter >> textInputFieldPresenter: aNode textChangedTo: aString [

	self emit: {
		#receiver -> 'SpTextInputFieldPresenter'.
		#selector -> 'text:'.
		#id -> aNode id.
		#text -> aString }
]

{ #category : 'emitting' }
CiderWireEmitter >> treePresenterBuilt: aNode roots: rootStrings selectedPaths: selectedPaths [

	self
		treePresenterBuilt: aNode
		roots: rootStrings
		nodes: #()
		selectedPaths: selectedPaths
]

{ #category : 'emitting' }
CiderWireEmitter >> treePresenterBuilt: aNode roots: rootStrings nodes: nodeDictionaries selectedPaths: selectedPaths [

	self emit: {
		#receiver -> 'SpTreePresenter'.
		#selector -> 'build'.
		#id -> aNode id.
		#adapter -> 'TreeAdapter'.
		#roots -> rootStrings.
		#nodes -> nodeDictionaries.
		#selectedPaths -> selectedPaths }
]

{ #category : 'emitting' }
CiderWireEmitter >> treePresenter: aNode selectedPathsChangedTo: selectedPaths [

	self emit: {
		#receiver -> 'SpTreePresenter'.
		#selector -> 'selectedPaths:'.
		#id -> aNode id.
		#selectedPaths -> selectedPaths }
]

{ #category : 'emitting' }
CiderWireEmitter >> treeTablePresenterBuilt: aNode columns: columnStrings nodes: nodeDictionaries selectedPaths: selectedPaths [

	self emit: {
		#receiver -> 'SpTreeTablePresenter'.
		#selector -> 'build'.
		#id -> aNode id.
		#adapter -> 'TreeTableAdapter'.
		#columns -> columnStrings.
		#treeTableNodes -> nodeDictionaries.
		#selectedPaths -> selectedPaths }
]

{ #category : 'emitting' }
CiderWireEmitter >> treeTablePresenter: aNode selectedPathsChangedTo: selectedPaths [

	self emit: {
		#receiver -> 'SpTreeTablePresenter'.
		#selector -> 'selectedPaths:'.
		#id -> aNode id.
		#selectedPaths -> selectedPaths }
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
CiderWireEmitter >> jsonEscapedCharacter: aCharacter [
	| hex |

	hex := aCharacter asciiValue printStringBase: 16.
	^ '\u' , (('0000' , hex) last: 4)
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
			| codePoint |
			codePoint := character asciiValue.
			character = $" ifTrue: [ json nextPutAll: '\"' ] ifFalse: [
			character = $\ ifTrue: [ json nextPutAll: '\\' ] ifFalse: [
			character = Character lf ifTrue: [ json nextPutAll: '\n' ] ifFalse: [
			character = Character cr ifTrue: [ json nextPutAll: '\r' ] ifFalse: [
			character = Character tab ifTrue: [ json nextPutAll: '\t' ] ifFalse: [
			(codePoint < 32 or: [ codePoint > 126 ]) ifTrue: [ json nextPutAll: (self jsonEscapedCharacter: character) ] ifFalse: [
				json nextPut: character ] ] ] ] ] ] ].
		json nextPut: $" ]
]

{ #category : 'private' }
CiderWireEmitter >> jsonValue: anObject [

	(anObject == true or: [ anObject == false ])
		ifTrue: [ ^ self jsonBoolean: anObject ].
	anObject isString ifTrue: [ ^ self jsonString: anObject ].
	anObject isSymbol ifTrue: [ ^ self jsonString: anObject asString ].
	anObject isNumber ifTrue: [ ^ anObject asString ].
	anObject isDictionary ifTrue: [ ^ self jsonObjectFrom: anObject associations ].
	anObject isCollection ifTrue: [ ^ self jsonArrayFrom: anObject ].
	anObject ifNil: [ ^ 'null' ].
	^ self jsonString: anObject asString
]

{ #category : 'private' }
CiderWireEmitter >> jsonArrayFrom: aCollection [

	^ String streamContents: [ :json |
		json nextPut: $[.
		aCollection doWithIndex: [ :item :index |
			index > 1 ifTrue: [ json nextPut: $, ].
			json nextPutAll: (self jsonValue: item) ].
		json nextPut: $] ]
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

	self boxLayoutBuilt: aNode direction: 'topToBottom'
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
