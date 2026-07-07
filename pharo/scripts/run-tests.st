[
	| testClasses failureCount errorCount |
	Metacello new
		baseline: 'Cider';
		repository: 'tonel://' , FileLocator workingDirectory fullName , '/pharo/src';
		load: 'Tests'.

	testClasses := Smalltalk globals values
		select: [ :each |
			each isBehavior
				and: [
					(each includesBehavior: TestCase)
						and: [ each package name = 'Cider-Spec-Tests' ] ] ].
	testClasses := testClasses sorted: [ :left :right | left name < right name ].

	failureCount := 0.
	errorCount := 0.
	testClasses do: [ :testClass |
		| result |
		result := testClass suite run.
		failureCount := failureCount + result failureCount.
		errorCount := errorCount + result errorCount ].

	Stdio stdout
		nextPutAll: testClasses size asString;
		nextPutAll: ' Cider SUnit classes passed.';
		lf;
		flush.

	(failureCount + errorCount) = 0
		ifTrue: [ Smalltalk snapshot: false andQuit: true ].

	Stdio stderr
		nextPutAll: 'Cider Pharo tests failed with ';
		nextPutAll: failureCount asString;
		nextPutAll: ' failures and ';
		nextPutAll: errorCount asString;
		nextPutAll: ' errors.';
		lf;
		flush.
	Smalltalk exitFailure ]
	on: Error
	do: [ :error |
		Stdio stderr
			nextPutAll: error printString;
			lf;
			flush.
		Smalltalk exitFailure ]
