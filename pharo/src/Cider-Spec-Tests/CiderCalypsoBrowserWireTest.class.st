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
	self assert: (browserLine includesSubstring: '"items":[')
]
