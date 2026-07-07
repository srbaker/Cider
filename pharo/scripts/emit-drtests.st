[
	| application runner package |
	Metacello new
		baseline: 'Cider';
		repository: 'tonel://' , FileLocator workingDirectory fullName , '/pharo/src';
		load: 'Tests'.

	application := StPharoApplication new.
	application useBackend: #Cider.
	application backend emitter: CiderWireEmitter stdout.

	runner := application newPresenter: DrTests.
	package := runner pluginPresenter packagesList items
		detect: [ :each | each name = 'Cider-Spec-Tests' ]
		ifNone: [ Error signal: 'Could not find Cider-Spec-Tests for the DrTests demo.' ].
	runner pluginPresenter packagesList selectItems: { package }.
	runner runPlugin.
	runner open.

	Smalltalk snapshot: false andQuit: true ]
	on: Error
	do: [ :error |
		Stdio stderr
			nextPutAll: error printString;
			lf;
			flush.
		Smalltalk exitFailure ]
