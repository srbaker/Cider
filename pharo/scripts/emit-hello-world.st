[
	| application |
	Metacello new
		baseline: 'Cider';
		repository: 'tonel://' , FileLocator workingDirectory fullName , '/pharo/src';
		load: 'Tests'.

	application := CiderHelloWorldApplication new.
	application useBackend: #Cider.
	application backend emitter: CiderWireEmitter stdout.
	application run.
	Smalltalk snapshot: false andQuit: true ]
	on: Error
	do: [ :error |
		Stdio stderr
			nextPutAll: error printString;
			lf;
			flush.
		Smalltalk exitFailure ]
