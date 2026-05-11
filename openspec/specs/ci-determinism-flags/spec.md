## Requirements

### Requirement: `--dry-run` performs generation without writing test files

The CLI SHALL accept a `--dry-run` flag. When set, the generation pipeline SHALL execute to completion (including the snapshot subprocess) but SHALL NOT create or modify any file under the package's `test/` tree. For each target library that would have produced a test file, the CLI SHALL print the absolute path of the would-be output on stdout, one path per line.

#### Scenario: Dry-run reports paths and writes nothing
- **WHEN** the user runs `dart run dart_test_gen --dry-run lib/usecases/calculator.dart`
- **AND** `test/usecases/calculator_test.dart` does not exist before the run
- **THEN** stdout contains a line equal to the absolute path of `test/usecases/calculator_test.dart`
- **AND** the file `test/usecases/calculator_test.dart` does NOT exist after the run
- **AND** the process exits with code `0`

#### Scenario: Dry-run preserves an existing test file unchanged
- **WHEN** the user runs `--dry-run` against a target whose `*_test.dart` already exists
- **THEN** the modification time and contents of that test file are unchanged after the run

### Requirement: `--check` compares generated content against existing files

The CLI SHALL accept a `--check` flag. When set, the pipeline SHALL execute to completion but instead of writing the generated content to disk it SHALL compare the generated string to the corresponding existing test file on disk, ignoring the generated-banner timestamp line. The process SHALL exit with code `0` if all targets match, and with code `1` if any target is missing on disk, has no auto-generated banner, or differs in any non-timestamp line. The CLI SHALL emit a short diff summary on stderr for each differing target.

#### Scenario: All files match
- **WHEN** every target's generated content matches the existing test file (after timestamp normalization)
- **THEN** stderr contains no `[check] differs:` lines
- **AND** the process exits with code `0`

#### Scenario: Missing file is treated as a diff
- **WHEN** a target's expected `*_test.dart` does not exist on disk
- **THEN** stderr contains a line that mentions the target path and the marker `<missing>`
- **AND** the process exits with code `1`

#### Scenario: Content differs in a non-timestamp line
- **WHEN** the existing file and the freshly generated content differ in at least one line other than the `// Generated:` (or legacy `// Сгенерировано:`) banner
- **THEN** stderr contains a `[check] differs:` line referencing the target
- **AND** stderr contains a `first diff at line <N>:` block with the two diverging lines (truncated to a reasonable width)
- **AND** the process exits with code `1`

#### Scenario: Timestamp-only differences are ignored
- **WHEN** the only difference between existing file and generated content is the `// Generated:` / `// Сгенерировано:` timestamp line
- **THEN** the file is reported as matching
- **AND** the process exits with code `0`

### Requirement: `--dry-run` and `--check` are mutually exclusive

The CLI SHALL reject invocations that pass both `--dry-run` and `--check`, exiting with code `64` and a clear stderr message.

#### Scenario: Both flags rejected
- **WHEN** the user runs `dart run dart_test_gen --dry-run --check lib/usecases/calculator.dart`
- **THEN** stderr contains a message identifying the conflict and recommending picking one
- **AND** the process exits with code `64`

### Requirement: Timestamp normalization helper is reusable

The library SHALL expose a pure function `stripGeneratedTimestamp(String content)` in `lib/test_generator.dart` that removes the `// Generated:` (and the legacy Russian `// Сгенерировано:`) line from generator output, leaving all other lines untouched.

#### Scenario: Strips the timestamp line
- **WHEN** the input is `"// Auto-generated\n// Generated: 2026-05-11T18:00:00.000\nvoid main() {}\n"`
- **THEN** `stripGeneratedTimestamp(input)` returns `"// Auto-generated\nvoid main() {}\n"`

#### Scenario: Strips legacy Russian timestamp line too
- **WHEN** the input is `"// Auto-generated\n// Сгенерировано: 2026-01-01T00:00:00.000\nvoid main() {}\n"`
- **THEN** `stripGeneratedTimestamp(input)` returns `"// Auto-generated\nvoid main() {}\n"`

#### Scenario: No-op when no timestamp present
- **WHEN** the input contains no matching prefix
- **THEN** `stripGeneratedTimestamp(input)` returns the input unchanged
