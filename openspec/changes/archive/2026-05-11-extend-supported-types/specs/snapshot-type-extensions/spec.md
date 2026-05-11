## ADDED Requirements

### Requirement: Collection-typed parameters produce non-empty boundary literals

The generator SHALL recognize selected collection parameter types beyond `List<int>` (initial milestone: `Set<int>`, `Iterable<int>`, and `List<String>`) and SHALL produce at least one valid argument literal per parameter for boundary expansion, such that methods using only these collection types together with already-supported types do not collapse to zero snapshot rows solely due to missing literals.

#### Scenario: Set of int parameters

- **WHEN** a public instance method declares a parameter of type `Set<int>` (or nullable / default variants already supported by the parser)
- **THEN** the boundary-case builder SHALL emit valid `Set<int>` literals that compile in the snapshot runner and in generated tests

#### Scenario: Iterable of int parameters

- **WHEN** a public instance method declares a parameter of type `Iterable<int>`
- **THEN** the boundary-case builder SHALL emit valid `Iterable<int>` literals (or equivalent compile-time constructs such as typed spreads from lists) usable in the snapshot runner

### Requirement: Snapshot and literals for extended collection returns

The snapshot pipeline SHALL serialize and decode return values for collection types that are added in the same milestone as parameter support (e.g. `List<String>`, `Set<int>`), producing Dart literals that match runtime values under the same normalization rules used for `List<int>` and `Map<String, int>` today.

#### Scenario: List of String return

- **WHEN** a method returns `List<String>` and the snapshot runner captures a value
- **THEN** `dartLiteralFromJson` (or its successor) SHALL emit a `List<String>` literal that round-trips the captured elements without throwing `unsupported json value`

#### Scenario: Set of int return

- **WHEN** a method returns `Set<int>` and the snapshot captures a JSON representation
- **THEN** the decoded Dart literal SHALL be a `Set<int>` literal equivalent to the captured value for test expectations
