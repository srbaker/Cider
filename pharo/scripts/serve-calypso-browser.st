[
	| emitter browser snapshot node line event |
	Metacello new
		baseline: 'Cider';
		repository: 'tonel://' , FileLocator workingDirectory fullName , '/pharo/src';
		load: 'Tests'.

	emitter := CiderWireEmitter stdout.
	browser := ClyFullBrowserMorph on: ClyNavigationEnvironment currentImage.
	snapshot := CiderCalypsoBrowserSnapshot emitter: emitter.
	node := snapshot emitBrowser: browser.

	[ Stdio stdin atEnd ] whileFalse: [
		line := (Stdio stdin upTo: Character lf asciiValue) asString trimBoth.
		line ifNotEmpty: [
			(line beginsWith: 'CIDER:')
				ifTrue: [ line := line allButFirst: 6 ].
			event := STONJSON fromString: line.
			((event at: 'receiver' ifAbsent: [ '' ]) = 'ClyFullBrowserMorph'
				and: [ (event at: 'selector' ifAbsent: [ '' ]) = 'selectPane:row:' ])
					ifTrue: [
						snapshot
							selectPane: (event at: 'paneIndex' ifAbsent: [ 0 ])
							row: (event at: 'index' ifAbsent: [ 0 ])
							inBrowser: browser.
						snapshot emitBrowser: browser node: node ] ] ].

	Smalltalk snapshot: false andQuit: true ]
	on: Error
	do: [ :error |
		Stdio stderr
			nextPutAll: error printString;
			lf;
			nextPutAll: error signalerContext shortStack;
			lf;
			flush.
		Smalltalk exitFailure ]
