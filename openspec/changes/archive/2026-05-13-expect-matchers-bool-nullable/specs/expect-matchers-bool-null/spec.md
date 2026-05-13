## ADDED Requirements

### Requirement: Configurable matcher emission

The system SHALL treat bool/null literal matchers as **enabled by default** when `use_expect_matchers_bool_null` is absent. The system SHALL load `use_expect_matchers_bool_null` (boolean) from the root of `dart_test_gen.yaml` and from per-method entries under `methods:`, using the same merge rules as other method-level YAML options. The CLI SHALL support `--expect-matchers-bool-null` (force enabled) and `--no-expect-matchers-bool-null` (force disabled); when either flag is present on a run, its value SHALL override the YAML-derived setting.

#### Scenario: Default without config file

- **WHEN** no `dart_test_gen.yaml` is present or the key is omitted
- **THEN** matcher emission is enabled and bool/null literal rows use `isTrue` / `isFalse` / `isNull` as specified below

#### Scenario: Disabled via YAML

- **WHEN** effective config has `use_expect_matchers_bool_null: false` for a method
- **THEN** success rows with bool or null literals are generated with `final expected = <literal>;` and `expect(actual, expected)`

#### Scenario: CLI overrides YAML

- **WHEN** YAML sets `use_expect_matchers_bool_null: true` and the invocation passes `--no-expect-matchers-bool-null`
- **THEN** the effective setting is false for that invocation

### Requirement: Boolean literals use isTrue / isFalse

When matcher emission is enabled, the generator SHALL emit `expect(actual, isTrue)` when the snapshot expected Dart literal is `true` and the method snapshot return type denotes `bool` (including nullable `bool?`). The generator SHALL emit `expect(actual, isFalse)` when the literal is `false` under the same type condition. The generator SHALL NOT emit a separate `final expected = …` binding solely for these assertions when the matcher fully describes the expectation.

#### Scenario: Sync bool success

- **WHEN** a non-throwing test row has snapshot return type `bool` and expected literal `true`
- **THEN** the generated test body contains `expect(actual, isTrue)` and does not declare `final expected = true;` for that assertion

#### Scenario: Nullable bool false

- **WHEN** a non-throwing test row has snapshot return type `bool?` and expected literal `false`
- **THEN** the generated test body contains `expect(actual, isFalse)`

### Requirement: Null literal uses isNull

When matcher emission is enabled, the generator SHALL emit `expect(actual, isNull)` when the snapshot expected Dart literal is `null` for a success row. The generator SHALL NOT emit `final expected = null;` when the assertion uses `isNull` alone.

#### Scenario: Nullable type returns null

- **WHEN** a non-throwing test row has expected literal `null`
- **THEN** the generated test body contains `expect(actual, isNull)` and omits an `expected` local used only for that comparison

### Requirement: Other types unchanged

The generator SHALL keep emitting `expect(actual, expected)` with an `expected` local for success rows that are not classified as bool literal, null literal, or existing double `closeTo` handling.

#### Scenario: Int comparison unchanged

- **WHEN** a success row has snapshot return type `int` and a numeric literal
- **THEN** the generated test still uses `final expected = <literal>;` and `expect(actual, expected)`
