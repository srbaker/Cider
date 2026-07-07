Class {
	#name : 'CiderDrTestsWireTest',
	#superclass : 'TestCase',
	#category : 'Cider-Spec-Tests',
	#package : 'Cider-Spec-Tests'
}

{ #category : 'tests' }
CiderDrTestsWireTest >> testDrTestsEmitsRealSUnitRunnerShape [
	| stream emitter application runner lines |

	stream := WriteStream on: String new.
	emitter := CiderWireEmitter on: stream.
	application := StPharoApplication new.
	application useBackend: #Cider.
	application backend emitter: emitter.

	runner := application newPresenter: DrTests.
	runner open.

	lines := stream contents lines.
	self assert: lines notEmpty.
	self assert: lines first equals: 'CIDER:{"receiver":"SpWindowPresenter","selector":"open","id":"n1","adapter":"WindowAdapter","presenter":"DrTests","title":"Dr Tests - Tests Runner"}'.
	self assert: (lines anySatisfy: [ :line | line includesSubstring: '"receiver":"SpDropListPresenter"' ]).
	self assert: (lines anySatisfy: [ :line | line includesSubstring: 'Dr Tests - Tests Runner' ]).
	self assert: (lines anySatisfy: [ :line | line includesSubstring: '"DTTestsRunnerPlugin"' ]).
	self assert: (lines anySatisfy: [ :line | line includesSubstring: '"receiver":"SpListPresenter"' ]).
	self assert: (lines anySatisfy: [ :line | line includesSubstring: '"Cider-Spec-Tests"' ]).
	self assert: (lines anySatisfy: [ :line | line includesSubstring: '"receiver":"SpTreePresenter"' ]).
	self assert: (lines anySatisfy: [ :line | line includesSubstring: '"label":"Run Tests"' ]).
	self assert: lines last equals: 'CIDER:{"receiver":"SpWindowPresenter","selector":"presenter:","id":"n1","presenterLayout":"n2"}'
]
