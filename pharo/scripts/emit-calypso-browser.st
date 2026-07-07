[
	| emitter browser |
	Metacello new
		baseline: 'Cider';
		repository: 'tonel://' , FileLocator workingDirectory fullName , '/pharo/src';
		load: 'Tests'.

	emitter := CiderWireEmitter stdout.
	browser := ClyFullBrowserMorph on: ClyNavigationEnvironment currentImage.
	(CiderCalypsoBrowserSnapshot emitter: emitter)
		emitBrowser: browser.

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
