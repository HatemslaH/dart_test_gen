## Requirements

### Requirement: Success test titles state the expected outcome

The generator SHALL emit `test` descriptions for non-void **success** cases that include both enough invocation context to identify the case and a clear statement of the expected result, except when a documented length guard triggers compact fallback.

#### Scenario: Boolean method with literal expected true

- **WHEN** the generator emits a synchronous success test for a method with arguments and expected literal `true`
- **THEN** the `test` name SHALL include the call-style fragment (for example `isEven(0)`) and SHALL state the expected outcome in natural language using the chosen product phrasing (for example `returns true`)

#### Scenario: Non-bool return value

- **WHEN** the generator emits a success test whose expected value is a non-boolean literal (for example an `int` or `String`)
- **THEN** the `test` name SHALL include that expected literal (or equivalent paraphrase for `closeTo` as defined in implementation) alongside the invocation fragment

#### Scenario: Escaping in titles

- **WHEN** the invocation label or expected literal contains `'` or `\`
- **THEN** the emitted `test('…')` string SHALL remain valid Dart single-quoted string content (generator-side escaping preserved)

#### Scenario: Very long composed title

- **WHEN** the composed descriptive title would exceed the configured maximum length
- **THEN** the generator SHALL fall back to the compact invocation-only title behavior used prior to this capability

### Requirement: Void and throw tests keep stable naming patterns

The generator SHALL NOT remove existing void or throw title conventions (`runs without error`, `throws <Type>`) unless a separate change explicitly updates those requirements.

#### Scenario: Void success test

- **WHEN** the generator emits a void success test
- **THEN** the `test` description SHALL continue to include the `runs without error` suffix pattern as today

#### Scenario: Throwing test

- **WHEN** the generator emits a test that expects an exception type
- **THEN** the `test` description SHALL continue to include the `throws <exception type>` suffix pattern as today
