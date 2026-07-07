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
			baseline: 'Spec2'
			with: [
				spec
					repository: 'github://pharo-spec/Spec:Pharo13/src';
					loads: #( 'Core' 'Tests' ) ].

		spec
			package: 'Cider-Spec' with: [ spec requires: #( 'Spec2' ) ];
			package: 'Cider-Spec-Examples' with: [ spec requires: #( 'Cider-Spec' ) ];
			package: 'Cider-Spec-Tests' with: [ spec requires: #( 'Cider-Spec' 'Cider-Spec-Examples' ) ].

		spec
			group: 'Core' with: #( 'Cider-Spec' );
			group: 'Examples' with: #( 'Cider-Spec-Examples' );
			group: 'Tests' with: #( 'Cider-Spec-Tests' );
			group: 'default' with: #( 'Core' 'Examples' 'Tests' ) ]
]
