Class {
	#name : 'CiderSpecBackend',
	#superclass : 'SpApplicationBackend',
	#instVars : [
		'emitter',
		'adaptersByNodeId'
	],
	#category : 'Cider-Spec-Backend',
	#package : 'Cider-Spec',
	#tag : 'Backend'
}

{ #category : 'accessing' }
CiderSpecBackend class >> backendName [

	^ #Cider
]

{ #category : 'private' }
CiderSpecBackend >> adapterBindingsClass [

	^ CiderSpecAdapterBindings
]

{ #category : 'accessing' }
CiderSpecBackend >> adapterForNodeId: aString [

	^ self adaptersByNodeId at: aString ifAbsent: [ nil ]
]

{ #category : 'accessing' }
CiderSpecBackend >> adaptersByNodeId [

	^ adaptersByNodeId ifNil: [ adaptersByNodeId := Dictionary new ]
]

{ #category : 'accessing' }
CiderSpecBackend >> componentListClass [

	^ SpComponentListPresenter
]

{ #category : 'accessing' }
CiderSpecBackend >> defaultConfigurationFor: anApplication [

	^ SpApplicationConfiguration new
]

{ #category : 'events' }
CiderSpecBackend >> dispatchIncomingEvent: aDictionary [
	| receiver selector id adapter |

	receiver := aDictionary at: 'receiver' ifAbsent: [ '' ].
	selector := aDictionary at: 'selector' ifAbsent: [ '' ].
	id := aDictionary at: 'id' ifAbsent: [ '' ].

	(receiver = 'SpButtonPresenter' and: [ selector = 'click' ])
		ifFalse: [ ^ self ].

	adapter := self adapterForNodeId: id.
	(adapter notNil and: [ adapter respondsTo: #click ])
		ifTrue: [ adapter click ]
]

{ #category : 'ui' }
CiderSpecBackend >> defer: aBlock [

	aBlock value
]

{ #category : 'accessing' }
CiderSpecBackend >> dropListClass [

	^ SpDropListPresenter
]

{ #category : 'accessing' }
CiderSpecBackend >> emitter [

	^ emitter ifNil: [ emitter := CiderWireEmitter stdout ]
]

{ #category : 'accessing' }
CiderSpecBackend >> emitter: aCiderWireEmitter [

	emitter := aCiderWireEmitter
]

{ #category : 'ui' }
CiderSpecBackend >> forceDefer: aBlock [

	aBlock value
]

{ #category : 'ui - dialogs' }
CiderSpecBackend >> inform: aString [

	self emitter emit: {
		#type -> 'notice'.
		#text -> aString }
]

{ #category : 'accessing' }
CiderSpecBackend >> listClass [

	^ SpListPresenter
]

{ #category : 'ui - notifying' }
CiderSpecBackend >> notifyError: aSpecNotification [

	self inform: aSpecNotification message
]

{ #category : 'ui - notifying' }
CiderSpecBackend >> notifyInfo: aSpecNotification [

	self inform: aSpecNotification message
]

{ #category : 'accessing' }
CiderSpecBackend >> registerAdapter: anAdapter forNode: aNode [

	self adaptersByNodeId at: aNode id put: anAdapter
]

{ #category : 'ui - dialogs' }
CiderSpecBackend >> openFileDialog: aFileDialog [

	^ nil
]

{ #category : 'display' }
CiderSpecBackend >> showWaitCursorWhile: aBlock inApplication: anApplication [

	^ aBlock value
]

{ #category : 'accessing' }
CiderSpecBackend >> tableClass [

	^ SpTablePresenter
]

{ #category : 'accessing' }
CiderSpecBackend >> treeClass [

	^ SpTreePresenter
]

{ #category : 'accessing' }
CiderSpecBackend >> treeTableClass [

	^ SpTreeTablePresenter
]
