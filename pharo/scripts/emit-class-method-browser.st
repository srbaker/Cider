[
	| application browser |
	Metacello new
		baseline: 'Cider';
		repository: 'tonel://' , FileLocator workingDirectory fullName , '/pharo/src';
		load: 'Tests'.

	application := SpApplication new.
	application useBackend: #Cider.
	application backend emitter: CiderWireEmitter stdout.

	browser := application newPresenter: SpClassMethodBrowser.
	browser classes: { Object. String. Array }.
	browser open.

	Smalltalk snapshot: false andQuit: true ]
	on: Error
	do: [ :error |
		Stdio stderr
			nextPutAll: error printString;
			lf;
			flush.
		Smalltalk exitFailure ]
