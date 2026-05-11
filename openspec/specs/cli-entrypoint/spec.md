## Requirements

### Requirement: Unified `dart_test_gen` executable

The package SHALL expose a single executable named `dart_test_gen` whose source file is `bin/dart_test_gen.dart`, and SHALL register it in `pubspec.yaml` under the `executables:` section so the tool is invocable as `dart run dart_test_gen` and via `dart pub global activate`.

#### Scenario: Invocation via `dart run dart_test_gen`
- **WHEN** a user runs `dart run dart_test_gen lib/usecases/calculator.dart` from a package that depends on `dart_test_gen`
- **THEN** the generator runs against `lib/usecases/calculator.dart` with the same behavior as the legacy `dart run bin/generate.dart lib/usecases/calculator.dart`
- **AND** the process exits with code `0` on success and a non-zero code on failure

#### Scenario: `pubspec.yaml` declares the executable
- **WHEN** `pubspec.yaml` is read
- **THEN** it contains an `executables:` mapping with a key `dart_test_gen`

### Requirement: Legacy `bin/generate.dart` entrypoint remains compatible

The package SHALL keep `bin/generate.dart` as a working entrypoint that delegates to the same CLI logic as `bin/dart_test_gen.dart`, and SHALL emit exactly one deprecation warning line on stderr each time it is invoked.

#### Scenario: Legacy entrypoint still runs the generator
- **WHEN** a user runs `dart run bin/generate.dart lib/usecases/calculator.dart`
- **THEN** the generator produces the same `test/usecases/calculator_test.dart` output as `dart run dart_test_gen lib/usecases/calculator.dart`

#### Scenario: Legacy entrypoint prints a deprecation warning
- **WHEN** `bin/generate.dart` is invoked
- **THEN** stderr contains a single line that mentions `deprecated` and recommends using `dart run dart_test_gen`
- **AND** stdout is not polluted by the warning

### Requirement: `--help` flag

The CLI SHALL accept a top-level `--help` (also `-h`) flag that prints usage information and exits with code `0` without running the generator.

#### Scenario: Help is shown
- **WHEN** the user runs `dart run dart_test_gen --help`
- **THEN** stdout contains: the program name `dart_test_gen`, a usage line showing input arguments, and a description of every documented flag (`--class`, `-v`/`--verbose`, `--strategy`, `--max-cases`, `--seed`, `--use-close-for-double`, `--double-epsilon`, `--config`, `--keep-runner`, `--help`, `--version`)
- **AND** the process exits with code `0`
- **AND** no test files are generated

### Requirement: `--version` flag

The CLI SHALL accept a top-level `--version` flag that prints the package version (as declared in `pubspec.yaml`) and exits with code `0` without running the generator.

#### Scenario: Version is read from `pubspec.yaml`
- **WHEN** the user runs `dart run dart_test_gen --version`
- **AND** `pubspec.yaml` declares `version: 1.0.0`
- **THEN** stdout contains the string `1.0.0`
- **AND** the process exits with code `0`

#### Scenario: Version unknown
- **WHEN** the CLI cannot locate `pubspec.yaml` at runtime (e.g. AOT-compiled, global activation without source)
- **THEN** stdout contains the literal `unknown`
- **AND** the process exits with code `0`
