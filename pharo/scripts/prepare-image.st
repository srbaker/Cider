Metacello new
	baseline: 'Cider';
	repository: 'tonel://' , FileLocator workingDirectory fullName , '/pharo/src';
	load: 'Tests'.

Smalltalk snapshot: true andQuit: true
