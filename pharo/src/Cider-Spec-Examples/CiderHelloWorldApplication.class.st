Class {
	#name : 'CiderHelloWorldApplication',
	#superclass : 'SpApplication',
	#category : 'Cider-Spec-Examples',
	#package : 'Cider-Spec-Examples'
}

{ #category : 'running' }
CiderHelloWorldApplication >> start [

	(self newPresenter: CiderHelloWorldPresenter) open
]
