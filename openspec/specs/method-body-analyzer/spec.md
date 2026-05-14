# method-body-analyzer Specification

## Purpose
TBD - created by archiving change method-body-analysis. Update Purpose after archive.
## Requirements
### Requirement: Method body literal extraction
The system SHALL parse the AST of a method body to extract integer and string literals used in binary expressions, switch cases, and if statements.

#### Scenario: Extracting literals from comparison
- **WHEN** a method body contains `if (length > 10)`
- **THEN** the analyzer extracts the integer literal `10`

#### Scenario: Extracting literals from equality check
- **WHEN** a method body contains `if (input == "admin")`
- **THEN** the analyzer extracts the string literal `"admin"`

### Requirement: API call inference
The system SHALL identify common standard library API calls (e.g., `toLowerCase`, `isOdd`) on parameters to infer required input characteristics.

#### Scenario: Identifying string transformations
- **WHEN** a method body calls `input.toLowerCase()`
- **THEN** the analyzer records that a case-sensitive string transformation is applied to `input`

#### Scenario: Identifying collection operations
- **WHEN** a method body calls `list.where((x) => x.isOdd)`
- **THEN** the analyzer records that odd/even filtering is applied to `list` elements

