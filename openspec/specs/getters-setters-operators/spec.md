## Requirements

### Requirement: Parse Getters, Setters, and Operators
The system SHALL identify getters, setters, and operators as testable methods when parsing Dart files.

#### Scenario: Class has getters, setters, and operators
- **WHEN** the source parser encounters `get myProp`, `set myProp(value)`, or `operator +(other)`
- **THEN** it records them with their specific invocation type and arguments.

### Requirement: Generate Getter tests
The system SHALL generate correct syntax for invoking getters.

#### Scenario: Testing a getter
- **WHEN** the generator creates a test for a getter
- **THEN** the test code uses property access syntax `actual = obj.myProp;` instead of method call syntax `actual = obj.myProp();`.

### Requirement: Generate Setter tests
The system SHALL generate correct syntax for invoking setters.

#### Scenario: Testing a setter
- **WHEN** the generator creates a test for a setter
- **THEN** the test code uses assignment syntax `obj.myProp = value;` and does not attempt to assign the result to an `actual` variable (since setters return void).

### Requirement: Generate Operator tests
The system SHALL generate correct syntax for operators.

#### Scenario: Testing binary operators
- **WHEN** the generator creates a test for a binary operator (like `+`)
- **THEN** the test code uses binary expression syntax `actual = obj + arg;`.

#### Scenario: Testing index operators
- **WHEN** the generator creates a test for an index operator (`[]`)
- **THEN** the test code uses index expression syntax `actual = obj[arg];`.
