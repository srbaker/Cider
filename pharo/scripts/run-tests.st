Metacello new
	baseline: 'Cider';
	repository: 'tonel://' , FileLocator workingDirectory fullName , '/pharo/src';
	load: 'Tests'.

Smalltalk globals at: #CiderHelloWorldWireTest ifPresent: [ :testClass |
	| result |
	result := testClass suite run.
	result hasPassed
		ifTrue: [ Smalltalk snapshot: false andQuit: true ]
		ifFalse: [
			Stdio stderr
				nextPutAll: result printString;
				lf;
				flush.
			Smalltalk exitFailure ] ].

Stdio stderr
	nextPutAll: 'CiderHelloWorldWireTest was not loaded.';
	lf;
	flush.
Smalltalk exitFailure
