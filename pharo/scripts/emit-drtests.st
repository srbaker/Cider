[
	| application runner |
	Metacello new
		baseline: 'Cider';
		repository: 'tonel://' , FileLocator workingDirectory fullName , '/pharo/src';
		load: 'Tests'.

	application := StPharoApplication new.
	application useBackend: #Cider.
	application backend emitter: CiderWireEmitter stdout.

	runner := application newPresenter: DrTests.
	runner open.

	Smalltalk snapshot: false andQuit: true ]
	on: Error
	do: [ :error |
		Stdio stderr
			nextPutAll: error printString;
			lf;
			flush.
		Smalltalk exitFailure ]
