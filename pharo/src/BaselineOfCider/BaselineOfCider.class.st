Class {
	#name : 'BaselineOfCider',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfCider',
	#package : 'BaselineOfCider'
}

{ #category : 'baseline' }
BaselineOfCider >> baseline: spec [
	<baseline>

	spec for: #common do: [
		spec
			package: 'Cider-Spec';
			package: 'Cider-Spec-Examples' with: [ spec requires: #( 'Cider-Spec' ) ];
			package: 'Cider-Spec-Tests' with: [ spec requires: #( 'Cider-Spec' 'Cider-Spec-Examples' ) ].

		spec
			group: 'Core' with: #( 'Cider-Spec' );
			group: 'Examples' with: #( 'Cider-Spec-Examples' );
			group: 'Tests' with: #( 'Cider-Spec-Tests' );
			group: 'default' with: #( 'Core' 'Examples' 'Tests' ) ]
]
