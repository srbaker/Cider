Metacello new
	baseline: 'Cider';
	repository: 'tonel://' , FileLocator workingDirectory fullName , '/pharo/src';
	load: 'Tests'.

Smalltalk globals at: #CiderHelloWorldWireTest ifPresent: [ :testClass |
	[
		testClass new testHelloWorldPresenterEmitsWindowBoxLabelAndEdges.
		Smalltalk snapshot: false andQuit: true ]
		on: Error
		do: [ :error |
			Stdio stderr
				nextPutAll: error printString;
				lf;
				flush.
			Smalltalk exitFailure ] ].

Stdio stderr
	nextPutAll: 'CiderHelloWorldWireTest was not loaded.';
	lf;
	flush.
Smalltalk exitFailure
