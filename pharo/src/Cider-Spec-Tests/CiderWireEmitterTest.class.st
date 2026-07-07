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
CiderWireEmitterTest >> testTextInputFieldTextUpdateBuildsSpecShapedEvent [
	| stream emitter node |

	stream := WriteStream on: String new.
	emitter := CiderWireEmitter on: stream.
	node := CiderWireNode id: 'n1' kind: #TextInputFieldAdapter.

	emitter
		textInputFieldPresenter: node
		textChangedTo: 'Edited'.

	self
		assert: stream contents trimBoth
		equals: 'CIDER:{"receiver":"SpTextInputFieldPresenter","selector":"text:","id":"n1","text":"Edited"}'
]

{ #category : 'tests' }
CiderWireEmitterTest >> testLabelPresenterUpdateBuildsSpecShapedEvent [
	| stream emitter node |

	stream := WriteStream on: String new.
	emitter := CiderWireEmitter on: stream.
	node := CiderWireNode id: 'n1' kind: #LabelAdapter.

	emitter
		labelPresenter: node
		labelChangedTo: 'Clicked'.

	self
		assert: stream contents trimBoth
		equals: 'CIDER:{"receiver":"SpLabelPresenter","selector":"label:","id":"n1","label":"Clicked"}'
]

{ #category : 'tests' }
CiderWireEmitterTest >> testCheckBoxPresenterStateUpdateBuildsSpecShapedEvent [
	| stream emitter node |

	stream := WriteStream on: String new.
	emitter := CiderWireEmitter on: stream.
	node := CiderWireNode id: 'n1' kind: #CheckBoxAdapter.

	emitter
		checkBoxPresenter: node
		stateChangedTo: true.

	self
		assert: stream contents trimBoth
		equals: 'CIDER:{"receiver":"SpCheckBoxPresenter","selector":"state:","id":"n1","state":true}'
]

{ #category : 'tests' }
CiderWireEmitterTest >> testListPresenterSelectionUpdateBuildsSpecShapedEvent [
	| stream emitter node |

	stream := WriteStream on: String new.
	emitter := CiderWireEmitter on: stream.
	node := CiderWireNode id: 'n1' kind: #ListAdapter.

	emitter
		listPresenter: node
		selectedIndexesChangedTo: #( 2 ).

	self
		assert: stream contents trimBoth
		equals: 'CIDER:{"receiver":"SpListPresenter","selector":"selectedIndexes:","id":"n1","selectedIndexes":[2]}'
]

{ #category : 'tests' }
CiderWireEmitterTest >> testTablePresenterBuildsSpecShapedEvent [
	| stream emitter node |

	stream := WriteStream on: String new.
	emitter := CiderWireEmitter on: stream.
	node := CiderWireNode id: 'n1' kind: #TableAdapter.

	emitter
		tablePresenterBuilt: node
		columns: #( 'Name' 'Result' )
		rows: #( #( 'CiderWireEmitterTest' 'passed' ) #( 'CiderCoreTests' 'passed' ) )
		selectedIndexes: #( 1 ).

	self
		assert: stream contents trimBoth
		equals: 'CIDER:{"receiver":"SpTablePresenter","selector":"build","id":"n1","adapter":"TableAdapter","columns":["Name","Result"],"rows":[["CiderWireEmitterTest","passed"],["CiderCoreTests","passed"]],"selectedIndexes":[1]}'
]

{ #category : 'tests' }
CiderWireEmitterTest >> testTablePresenterSelectionUpdateBuildsSpecShapedEvent [
	| stream emitter node |

	stream := WriteStream on: String new.
	emitter := CiderWireEmitter on: stream.
	node := CiderWireNode id: 'n1' kind: #TableAdapter.

	emitter
		tablePresenter: node
		selectedIndexesChangedTo: #( 2 ).

	self
		assert: stream contents trimBoth
		equals: 'CIDER:{"receiver":"SpTablePresenter","selector":"selectedIndexes:","id":"n1","selectedIndexes":[2]}'
]

{ #category : 'tests' }
CiderWireEmitterTest >> testTreePresenterSelectionUpdateBuildsSpecShapedEvent [
	| stream emitter node |

	stream := WriteStream on: String new.
	emitter := CiderWireEmitter on: stream.
	node := CiderWireNode id: 'n1' kind: #TreeAdapter.

	emitter
		treePresenter: node
		selectedPathsChangedTo: #( #( 1 1 ) ).

	self
		assert: stream contents trimBoth
		equals: 'CIDER:{"receiver":"SpTreePresenter","selector":"selectedPaths:","id":"n1","selectedPaths":[[1,1]]}'
]

{ #category : 'tests' }
CiderWireEmitterTest >> testTreeTablePresenterBuildsSpecShapedEvent [
	| stream emitter node treeNode |

	stream := WriteStream on: String new.
	emitter := CiderWireEmitter on: stream.
	node := CiderWireNode id: 'n1' kind: #TreeTableAdapter.
	treeNode := Dictionary new
		at: #path put: #( 1 );
		at: #values put: #( 'Object' '512' );
		yourself.

	emitter
		treeTablePresenterBuilt: node
		columns: #( 'Class' 'Methods' )
		nodes: { treeNode }
		selectedPaths: #( #( 1 ) ).

	self
		assert: stream contents trimBoth
		equals: 'CIDER:{"receiver":"SpTreeTablePresenter","selector":"build","id":"n1","adapter":"TreeTableAdapter","columns":["Class","Methods"],"treeTableNodes":[{"path":[1],"values":["Object","512"]}],"selectedPaths":[[1]]}'
]

{ #category : 'tests' }
CiderWireEmitterTest >> testTreeTablePresenterSelectionUpdateBuildsSpecShapedEvent [
	| stream emitter node |

	stream := WriteStream on: String new.
	emitter := CiderWireEmitter on: stream.
	node := CiderWireNode id: 'n1' kind: #TreeTableAdapter.

	emitter
		treeTablePresenter: node
		selectedPathsChangedTo: #( #( 1 1 ) ).

	self
		assert: stream contents trimBoth
		equals: 'CIDER:{"receiver":"SpTreeTablePresenter","selector":"selectedPaths:","id":"n1","selectedPaths":[[1,1]]}'
]

{ #category : 'tests' }
CiderWireEmitterTest >> testTreePresenterBuildsSpecShapedEvent [
	| stream emitter node output treeNode |

	stream := WriteStream on: String new.
	emitter := CiderWireEmitter on: stream.
	node := CiderWireNode id: 'n1' kind: #TreeAdapter.
	treeNode := Dictionary new
		at: #path put: #( 1 );
		at: #label put: 'Passed';
		yourself.

	emitter
		treePresenterBuilt: node
		roots: #( 'Passed' 'Failures' )
		nodes: { treeNode }
		selectedPaths: #( #( 1 ) ).

	output := stream contents trimBoth.
	self assert: (output includesSubstring: '"receiver":"SpTreePresenter"').
	self assert: (output includesSubstring: '"selector":"build"').
	self assert: (output includesSubstring: '"roots":["Passed","Failures"]').
	self assert: (output includesSubstring: '"nodes":[').
	self assert: (output includesSubstring: '"path":[1]').
	self assert: (output includesSubstring: '"label":"Passed"').
	self assert: (output includesSubstring: '"selectedPaths":[[1]]')
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
CiderWireEmitterTest >> testDropListPresenterSelectionUpdateBuildsSpecShapedEvent [
	| stream emitter node |

	stream := WriteStream on: String new.
	emitter := CiderWireEmitter on: stream.
	node := CiderWireNode id: 'n1' kind: #DropListAdapter.

	emitter
		dropListPresenter: node
		selectedIndexChangedTo: 2.

	self
		assert: stream contents trimBoth
		equals: 'CIDER:{"receiver":"SpDropListPresenter","selector":"selectIndex:","id":"n1","selectedIndex":2}'
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
