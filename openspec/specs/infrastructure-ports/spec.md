# infrastructure-ports Specification

## Purpose
TBD - created by archiving change dart-package-structural-cleanup. Update Purpose after archive.
## Requirements
### Requirement: Generator config is a plain data type

`GeneratorConfig` SHALL be an immutable (or effectively immutable) data class with no static `load()` method and no file I/O. Loading configuration from disk SHALL occur only in infrastructure via a dedicated loader.

#### Scenario: Domain config has no filesystem access

- **WHEN** inspecting `GeneratorConfig` and related domain types
- **THEN** they do not import `dart:io` or read files
- **AND** configuration values are supplied by callers or ports

### Requirement: ConfigReader port abstracts config loading

The package SHALL define `lib/src/domain/ports/config_reader.dart` with an abstract method `GeneratorConfig loadConfig(String path)`. An infrastructure implementation SHALL use `dart:io` to read and parse config files. Application orchestration SHALL obtain config through the port injected at the composition root.

#### Scenario: Production wiring uses real config loader

- **WHEN** the CLI runs generation with a config path
- **THEN** `AppDependencies` (or equivalent wiring) supplies a `ConfigReader` implementation
- **AND** the orchestrator calls `loadConfig` rather than a static method on `GeneratorConfig`

### Requirement: ProcessRunner port abstracts subprocess execution

The package SHALL define `lib/src/domain/ports/process_runner.dart` with an abstract `ProcessRunner` exposing process execution (sync `runSync` matching current snapshot usage unless intentionally migrated). Infrastructure SHALL provide `IoProcessRunner` using `Process.runSync`. Snapshot execution SHALL use the injected runner instead of calling `Process.runSync` directly.

#### Scenario: Snapshot flow uses injected runner

- **WHEN** `runSnapshots` executes the generated snapshot runner via subprocess
- **THEN** it delegates to `ProcessRunner.runSync` (or equivalent) on the injected instance
- **AND** no direct `Process.runSync` call remains in the snapshot coordination module after refactor

#### Scenario: Tests can fake process execution

- **WHEN** unit tests need to avoid spawning a real `dart` subprocess
- **THEN** they can provide a fake `ProcessRunner` at the composition root or test harness
- **AND** production wiring registers `IoProcessRunner` by default

