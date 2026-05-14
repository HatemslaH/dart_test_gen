## ADDED Requirements

### Requirement: Dynamic boundary generation for integers
The system SHALL generate dynamic test inputs for integer parameters based on extracted literals, including the exact value, value - 1, and value + 1.

#### Scenario: Generating boundaries for greater-than condition
- **WHEN** the analyzer extracts the literal `10` from an integer comparison
- **THEN** the generator produces test inputs `9`, `10`, and `11` for that parameter

### Requirement: Dynamic boundary generation for strings
The system SHALL generate dynamic test inputs for string parameters based on extracted literals and API calls.

#### Scenario: Generating boundaries for string equality
- **WHEN** the analyzer extracts the literal `"admin"`
- **THEN** the generator produces test inputs `"admin"`, `""`, and `"admin_"` (or similar variations)

#### Scenario: Generating inputs for case transformations
- **WHEN** the analyzer detects a `toLowerCase()` call
- **THEN** the generator produces test inputs with mixed case (e.g., `"UPPER"`, `"mixedCase"`)

### Requirement: Integration with fixed boundaries
The system SHALL merge dynamically generated inputs with the existing fixed boundary inputs, removing duplicates, before generating test cases.

#### Scenario: Merging dynamic and fixed inputs
- **WHEN** dynamic inputs `[9, 10, 11]` are generated and fixed inputs are `[-1, 0, 1]`
- **THEN** the final input set for the parameter is `[-1, 0, 1, 9, 10, 11]`
