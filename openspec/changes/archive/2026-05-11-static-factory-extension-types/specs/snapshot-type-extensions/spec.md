## ADDED Requirements

### Requirement: Support for static methods
The system SHALL parse static methods of classes and generate tests that invoke them without creating an instance of the class.

#### Scenario: Generating tests for a static method
- **WHEN** the generator parses a class with a static method
- **THEN** the generated snapshot runner invokes the method as `ClassName.methodName(args)`
- **THEN** the generated test file contains assertions invoking `ClassName.methodName(args)`

### Requirement: Support for factory constructors
The system SHALL parse factory constructors of classes and generate tests that invoke them to create instances.

#### Scenario: Generating tests for a factory constructor
- **WHEN** the generator parses a class with a factory constructor
- **THEN** the generated snapshot runner invokes the factory as `ClassName.factoryName(args)` or `ClassName(args)`
- **THEN** the generated test file contains assertions verifying the result of the factory invocation

### Requirement: Support for extension types
The system SHALL parse extension types, their primary constructors, and their methods, and generate tests for them.

#### Scenario: Generating tests for an extension type method
- **WHEN** the generator parses an extension type with a method
- **THEN** the generated snapshot runner instantiates the extension type using its primary constructor and invokes the method
- **THEN** the generated test file contains assertions verifying the result of the extension type method

### Requirement: Comprehensive showcase usecase
The system SHALL include a new usecase in `lib/usecases/type_extensions_showcase/` (or similar) that demonstrates static methods, factory constructors, and extension types, and generates corresponding tests.

#### Scenario: Running the generator on the showcase usecase
- **WHEN** the user runs the test generator on the new showcase usecase
- **THEN** the generator successfully creates a test file with passing tests covering static methods, factories, and extension types