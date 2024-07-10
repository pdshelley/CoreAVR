# CoreAVR

The goal of this library is to be a sort of "Digital Datasheet" for microcontrollers starting with AVR and more specifically the ATmega328. 

<h2>Roadmap: </h2>

<h3>Version 0.1.0</h3> will be an ATmega328 only CoreAVR and have most of the major features supported. 
The key will be to get the current implementation cleaned up and setup for distribution with a version number so it can be included in projects. 
Then I want to refine the ATmega328 version of CoreAVR through feedback. As that starts to feel more solid then work on getting generated code for other chips. 
The generated code would go in chunks of feature sets.

<h3>Version 0.2.0</h3> will start to add support for other AVR microcontrollers. The most commonly used features will be added for other chips, lagging 
behind the ATmega328. Once sections of the ATmega328 are feeling more stable then these will be ported over to `HALGEN` which will use the ATmega328 code 
as a template to then generate the same code for other AVR chips. 

<h4>Releases will be tagged and follow Semantic Versioning. </h4>

<h2>TODO: </h2>
Using GitHub Projects for managment of tasks and issues: https://github.com/orgs/swiftforarduino/projects/1 


