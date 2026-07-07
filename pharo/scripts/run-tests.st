Metacello new
	baseline: 'Cider';
	repository: 'tonel://' , FileLocator workingDirectory fullName , '/pharo/src';
	load: 'Tests'.

Smalltalk globals at: #CiderHelloWorldWireTest ifPresent: [ :testClass |
	Smalltalk globals at: #CiderClassMethodBrowserWireTest ifPresent: [ :browserTestClass |
		[
			testClass new testHelloWorldPresenterEmitsWindowBoxLabelAndEdges.
			browserTestClass new testClassMethodBrowserEmitsExistingSpecBrowserShape.
			Smalltalk snapshot: false andQuit: true ]
			on: Error
			do: [ :error |
				Stdio stderr
					nextPutAll: error printString;
					lf;
					flush.
				Smalltalk exitFailure ] ] ].

Stdio stderr
	nextPutAll: 'Cider Pharo tests were not loaded.';
	lf;
	flush.
Smalltalk exitFailure
