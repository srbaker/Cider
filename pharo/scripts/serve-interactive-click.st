[
	| application presenter line event |
	Metacello new
		baseline: 'Cider';
		repository: 'tonel://' , FileLocator workingDirectory fullName , '/pharo/src';
		load: 'Tests'.

	application := StPharoApplication new.
	application useBackend: #Cider.
	application backend emitter: CiderWireEmitter stdout.

	presenter := application newPresenter: CiderInteractiveClickPresenter.
	presenter open.

	[ Stdio stdin atEnd ] whileFalse: [
		line := (Stdio stdin upTo: Character lf asciiValue) asString trimBoth.
		line ifNotEmpty: [
			(line beginsWith: 'CIDER:')
				ifTrue: [ line := line allButFirst: 6 ].
			event := STONJSON fromString: line.
			application backend dispatchIncomingEvent: event ] ].

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
