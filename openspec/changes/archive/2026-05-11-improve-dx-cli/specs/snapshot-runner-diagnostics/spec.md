## ADDED Requirements

### Requirement: Structured error message on snapshot runner failure

When the temporary snapshot runner fails to compile or its stdout cannot be parsed as the expected snapshot payload, the CLI SHALL emit a structured multi-line error message on stderr that includes: the failure stage (`compile` or `parse`), the absolute path of the source library being processed, the class name and (when known) the method name, the absolute path of the preserved temporary runner file, and at least the last lines of the `dart` process stderr output.

#### Scenario: Runner fails to compile
- **WHEN** the snapshot runner for class `Foo` method `bar` in `lib/usecases/foo.dart` fails to compile (the `dart` subprocess exits with a non-zero code before producing the snapshot)
- **THEN** stderr contains lines that:
  - identify the stage as `compile`
  - reference the absolute path of `lib/usecases/foo.dart`
  - reference the class name `Foo` and the method name `bar` when available
  - include the absolute path of the preserved runner file under the system temp directory
  - include a tail (at most ~40 lines) of the `dart` subprocess stderr
- **AND** the process exits with a non-zero code

#### Scenario: Runner output is not parseable
- **WHEN** the snapshot runner finishes but its stdout does not match the expected snapshot payload format
- **THEN** stderr contains a structured message with stage `parse`, the library path, and the path to the preserved runner file
- **AND** the process exits with a non-zero code

### Requirement: Preserve temporary runner on failure

The CLI SHALL preserve the temporary runner file on disk whenever a snapshot generation step fails, and SHALL delete it on successful generation unless `--keep-runner` is set.

#### Scenario: Runner preserved on failure
- **WHEN** snapshot generation fails for any method
- **THEN** the temporary runner file referenced in the structured error message still exists on disk after the CLI exits

#### Scenario: Runner removed on success
- **WHEN** snapshot generation succeeds for all methods
- **AND** `--keep-runner` is NOT passed
- **THEN** no temporary runner files remain in the system temp directory subfolder used by `dart_test_gen`

#### Scenario: `--keep-runner` forces retention
- **WHEN** the user passes `--keep-runner` and snapshot generation succeeds
- **THEN** the temporary runner file path is printed to the verbose log
- **AND** the file still exists on disk after the CLI exits

### Requirement: Actionable hints in the error message

The structured snapshot runner error message SHALL include a "hints" section with at least the following actionable guidance: re-running with `-v` for the full log, opening the preserved runner file for inspection, and a pointer to where to report a generator bug along with the runner file.

#### Scenario: Hints section present
- **WHEN** the structured snapshot runner error message is emitted
- **THEN** stderr contains a `hints:` section
- **AND** the section mentions `-v` (verbose flag)
- **AND** the section mentions opening the preserved runner file
- **AND** the section mentions attaching the runner file to a bug report
