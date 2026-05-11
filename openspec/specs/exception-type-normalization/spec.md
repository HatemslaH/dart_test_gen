## ADDED Requirements

### Requirement: Snapshot runner emits public exception type names

When capturing the type of a thrown value, the snapshot runner SHALL emit a public Dart identifier — never a private (`_`-prefixed) class name. For the known dart:core mapping the runner SHALL produce the following:

| `runtimeType.toString()` of caught value | emitted name |
|---|---|
| `_Exception` | `Exception` |
| `_AssertionError` | `AssertionError` |
| `_TypeError` | `TypeError` |
| `_CastError` | `TypeError` |

For any other runtime type whose name starts with `_`, the runner SHALL emit `Error` if the caught value `is Error`, `Exception` if it `is Exception`, otherwise `Object`. For runtime type names that do not start with `_`, the original name SHALL be emitted unchanged.

#### Scenario: `Exception(...)` produces `Exception`
- **WHEN** a captured method throws `Exception('boom')`
- **THEN** the snapshot row carries `'exception': 'Exception'`
- **AND** the generated test contains `throwsA(isA<Exception>())`
- **AND** the generated test file compiles under `dart analyze`

#### Scenario: Known mapped private types
- **WHEN** the runtime type of the caught value is `_AssertionError`, `_TypeError`, or `_CastError`
- **THEN** the snapshot row carries `'AssertionError'`, `'TypeError`, or `'TypeError'` respectively (i.e. the corresponding public name from the mapping table)

#### Scenario: Unknown private type falls back to supertype
- **WHEN** the caught value is an `Exception` whose runtime type starts with `_` but is not in the mapping table
- **THEN** the snapshot row carries `'Exception'`
- **WHEN** the caught value is an `Error` whose runtime type starts with `_` but is not in the mapping table
- **THEN** the snapshot row carries `'Error'`

#### Scenario: Public names pass through
- **WHEN** the caught value's runtime type is `ArgumentError`, `StateError`, `FormatException`, or any other public identifier
- **THEN** the snapshot row carries that exact name

### Requirement: Host-side normalization is idempotent

The host-side decoder (`_mergeDecoded` in `lib/snapshot.dart`) SHALL apply the same name normalization to the `'exception'` string read from the runner output, so that any stale or externally produced snapshot with a private name is repaired before reaching the test generator. The transformation MUST be idempotent: applying it twice yields the same result as applying it once.

#### Scenario: Stale snapshot with `_Exception` is repaired
- **WHEN** the JSON payload from the runner contains `'exception': '_Exception'`
- **THEN** the decoded `SnapshotRow.throwsExceptionType` is `'Exception'`

#### Scenario: Already-public names are unchanged
- **WHEN** the JSON payload contains `'exception': 'ArgumentError'`
- **THEN** the decoded `SnapshotRow.throwsExceptionType` is `'ArgumentError'`

### Requirement: Regression usecase exercises the mapping

The repository SHALL include a usecase library that, after running the generator against it, produces a test file whose every exception case uses a public exception identifier and which passes `dart test`.

#### Scenario: New showcase produces compilable, passing tests
- **WHEN** the user runs `dart run dart_test_gen lib/usecases/exception_throws_showcase.dart`
- **THEN** the generated file `test/usecases/exception_throws_showcase_test.dart` contains at least one `throwsA(isA<Exception>())` and uses no `_`-prefixed identifiers
- **AND** `dart test test/usecases/exception_throws_showcase_test.dart` exits with code 0
