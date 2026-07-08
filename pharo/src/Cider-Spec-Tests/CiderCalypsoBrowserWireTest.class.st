Class {
	#name : 'CiderCalypsoBrowserWireTest',
	#superclass : 'TestCase',
	#category : 'Cider-Spec-Tests',
	#package : 'Cider-Spec-Tests'
}

{ #category : 'tests' }
CiderCalypsoBrowserWireTest >> testDefaultSystemBrowserEmitsCalypsoMorphPaneSnapshot [
	| stream emitter browser lines browserLine |

	stream := WriteStream on: String new.
	emitter := CiderWireEmitter on: stream.
	browser := ClyFullBrowserMorph on: ClyNavigationEnvironment currentImage.

	(CiderCalypsoBrowserSnapshot emitter: emitter)
		rowLimit: 5;
		emitBrowser: browser.

	lines := stream contents lines.
	self assert: lines size equals: 1.
	browserLine := lines first.
	self assert: (browserLine includesSubstring: '"receiver":"ClyFullBrowserMorph"').
	self assert: (browserLine includesSubstring: '"selector":"build"').
	self assert: (browserLine includesSubstring: '"title":"Packages"').
	self assert: (browserLine includesSubstring: '"title":"Classes"').
	self assert: (browserLine includesSubstring: '"title":"Protocols"').
	self assert: (browserLine includesSubstring: '"title":"Methods"').
	self assert: (browserLine includesSubstring: '"totalRows":').
	self assert: (browserLine includesSubstring: '"selectedIndex":').
	self assert: (browserLine includesSubstring: '"items":[')
]

{ #category : 'tests' }
CiderCalypsoBrowserWireTest >> testSelectingPackagePanePopulatesClassPane [
	| stream emitter browser snapshot node lines browserLine |

	stream := WriteStream on: String new.
	emitter := CiderWireEmitter on: stream.
	browser := ClyFullBrowserMorph on: ClyNavigationEnvironment currentImage.
	snapshot := CiderCalypsoBrowserSnapshot emitter: emitter.
	snapshot rowLimit: 5.

	node := snapshot emitBrowser: browser.
	snapshot
		selectPane: 1
		row: 1
		inBrowser: browser.
	snapshot emitBrowser: browser node: node.

	lines := stream contents lines.
	self assert: lines size equals: 2.
	browserLine := lines second.
	self assert: (browserLine includesSubstring: '"title":"Packages"').
	self assert: (browserLine includesSubstring: '"selectedIndex":1').
	self assert: (browserLine includesSubstring: '"title":"Classes"').
	self assert: (browserLine includesSubstring: '"AIGraphAlgorithm"')
]

{ #category : 'tests' }
CiderCalypsoBrowserWireTest >> testSelectingClassPanePopulatesProtocolAndMethodPanes [
	| stream emitter browser snapshot node lines browserLine |

	stream := WriteStream on: String new.
	emitter := CiderWireEmitter on: stream.
	browser := ClyFullBrowserMorph on: ClyNavigationEnvironment currentImage.
	snapshot := CiderCalypsoBrowserSnapshot emitter: emitter.
	snapshot rowLimit: 5.

	node := snapshot emitBrowser: browser.
	snapshot
		selectPane: 1
		row: 1
		inBrowser: browser.
	snapshot
		selectPane: 2
		row: 1
		inBrowser: browser.
	snapshot emitBrowser: browser node: node.

	lines := stream contents lines.
	self assert: lines size equals: 2.
	browserLine := lines second.
	self assert: (browserLine includesSubstring: '"title":"Classes"').
	self assert: (browserLine includesSubstring: '"selectedIndex":1').
	self assert: (browserLine includesSubstring: '"title":"Protocols"').
	self assert: (browserLine includesSubstring: '"instance side"').
	self assert: (browserLine includesSubstring: '"title":"Methods"').
	self assert: (browserLine includesSubstring: '"addEdge:from:to:"')
]
