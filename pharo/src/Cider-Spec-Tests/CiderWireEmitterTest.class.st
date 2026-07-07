Class {
	#name : 'CiderWireEmitterTest',
	#superclass : 'TestCase',
	#category : 'Cider-Spec-Tests',
	#package : 'Cider-Spec-Tests'
}

{ #category : 'tests' }
CiderWireEmitterTest >> testStringValuesEscapeJsonControlCharacters [
	| stream emitter node text |

	stream := WriteStream on: String new.
	emitter := CiderWireEmitter on: stream.
	node := CiderWireNode id: 'n1' kind: #LabelAdapter.
	text := 'before' , (String with: (Character value: 1)) , 'after'.

	emitter labelPresenterBuilt: node text: text.

	self
		assert: stream contents trimBoth
		equals: 'CIDER:{"receiver":"SpLabelPresenter","selector":"build","id":"n1","adapter":"LabelAdapter","label":"before\u0001after"}'
]

{ #category : 'tests' }
CiderWireEmitterTest >> testTreePresenterBuildsSpecShapedEvent [
	| stream emitter node |

	stream := WriteStream on: String new.
	emitter := CiderWireEmitter on: stream.
	node := CiderWireNode id: 'n1' kind: #TreeAdapter.

	emitter
		treePresenterBuilt: node
		roots: #( 'Passed' 'Failures' )
		selectedPaths: #( #( 1 ) ).

	self
		assert: stream contents trimBoth
		equals: 'CIDER:{"receiver":"SpTreePresenter","selector":"build","id":"n1","adapter":"TreeAdapter","roots":["Passed","Failures"],"selectedPaths":[[1]]}'
]

{ #category : 'tests' }
CiderWireEmitterTest >> testDropListPresenterBuildsSpecShapedEvent [
	| stream emitter node |

	stream := WriteStream on: String new.
	emitter := CiderWireEmitter on: stream.
	node := CiderWireNode id: 'n1' kind: #DropListAdapter.

	emitter
		dropListPresenterBuilt: node
		items: #( 'Tests Runner' 'Coverage' )
		selectedIndex: 1.

	self
		assert: stream contents trimBoth
		equals: 'CIDER:{"receiver":"SpDropListPresenter","selector":"build","id":"n1","adapter":"DropListAdapter","items":["Tests Runner","Coverage"],"selectedIndex":1}'
]

{ #category : 'tests' }
CiderWireEmitterTest >> testMicScrolledTextMorphBuildsAsNamedMorph [
	| stream emitter node |

	stream := WriteStream on: String new.
	emitter := CiderWireEmitter on: stream.
	node := CiderWireNode id: 'n1' kind: #NativeAdapter.

	emitter micScrolledTextMorphBuilt: node text: 'Welcome'.

	self
		assert: stream contents trimBoth
		equals: 'CIDER:{"receiver":"MicScrolledTextMorph","selector":"build","id":"n1","adapter":"MorphAdapter","text":"Welcome"}'
]

{ #category : 'tests' }
CiderWireEmitterTest >> testWideStringValuesStayByteOriented [
	| stream emitter node text |

	stream := WriteStream on: String new.
	emitter := CiderWireEmitter on: stream.
	node := CiderWireNode id: 'n1' kind: #LabelAdapter.
	text := WideString withAll: 'caf' , (String with: (Character value: 233)).

	emitter labelPresenterBuilt: node text: text.

	self
		assert: stream contents trimBoth
		equals: 'CIDER:{"receiver":"SpLabelPresenter","selector":"build","id":"n1","adapter":"LabelAdapter","label":"caf\u00E9"}'
]
