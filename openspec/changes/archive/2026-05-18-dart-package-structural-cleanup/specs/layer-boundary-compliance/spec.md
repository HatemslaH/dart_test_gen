## ADDED Requirements

### Requirement: Application does not import CLI logging

Application-layer snapshot unit-test generation SHALL NOT import CLI logging modules. Dry-run preview text SHALL be returned to the caller (for example as `String? dryRunOutput` or part of a result object), and the CLI layer SHALL perform any `stdout` emission.

#### Scenario: Dry-run defers printing to CLI

- **WHEN** generation runs with dry-run enabled
- **THEN** the application use-case returns the preview text without calling CLI log helpers
- **AND** the CLI orchestrator prints that text using CLI-layer logging

### Requirement: CLI argument parsing does not call exit

`lib/src/application/cli_args.dart` (or equivalent application parser) SHALL NOT call `exit()`. Invalid arguments SHALL be reported via a typed exception (for example `InvalidCliArgumentsException`) or an explicit failure result. The CLI entry layer SHALL catch failures and invoke `exit(64)` (or the appropriate code) there.

#### Scenario: Invalid flag handled at CLI boundary

- **WHEN** the user passes mutually exclusive or malformed CLI flags
- **THEN** the application parser throws or returns a failure without terminating the process
- **AND** the CLI orchestrator exits with code 64 after printing the error message

### Requirement: Pure domain services live under domain

Files containing pure logic with no I/O (`dynamic_input_generator.dart`, `method_logic_analyzer.dart`) SHALL reside under `lib/src/domain/services/` and SHALL NOT remain under `lib/src/application/`.

#### Scenario: Logic analyzers are domain services

- **WHEN** a contributor locates dynamic input or method-body analysis logic
- **THEN** those implementations are found under `lib/src/domain/services/`
- **AND** application orchestration imports them as domain dependencies

### Requirement: Snapshot failure formatting is CLI presentation

Human-readable formatting of snapshot runner failures SHALL live under `lib/src/cli/` (not application), and application code SHALL import formatting only from CLI when assembling user-visible messages at the orchestration boundary—or receive pre-formatted strings from CLI helpers called by the orchestrator.

#### Scenario: Failure formatter not in application folder

- **WHEN** listing files under `lib/src/application/`
- **THEN** `snapshot_failure_formatting.dart` is not present there
- **AND** an equivalent module exists under `lib/src/cli/`

### Requirement: Application and domain remain free of direct I/O imports

Files under `lib/src/domain/` and `lib/src/application/` SHALL NOT import `dart:io` or `package:analyzer`, except through port interfaces defined under `lib/src/domain/ports/` whose implementations live in infrastructure.

#### Scenario: Post-refactor import audit

- **WHEN** searching imports in `lib/src/domain/**` and `lib/src/application/**`
- **THEN** no file imports `dart:io` or `package:analyzer` directly
- **AND** filesystem and analyzer access occur only in infrastructure or CLI layers
