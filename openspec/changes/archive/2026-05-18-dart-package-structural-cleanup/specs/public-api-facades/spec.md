## ADDED Requirements

### Requirement: Analyzer adapter lives in infrastructure

The resolved-dependencies / library-path resolution logic currently in `lib/resolved_dependencies.dart` SHALL move to `lib/src/infrastructure/analyzer/library_path_resolver.dart` (or equivalent accurate name). Internal imports SHALL target the new path. The top-level `lib/resolved_dependencies.dart` file SHALL be deleted or limited to a re-export shim if required for compatibility.

#### Scenario: No analyzer adapter in public lib root

- **WHEN** inspecting `lib/resolved_dependencies.dart` after migration
- **THEN** it contains at most export directives to the infrastructure module
- **AND** implementation code importing `package:analyzer` resides only under `lib/src/infrastructure/`

### Requirement: Generate pipeline is a thin orchestration facade

`lib/generate_pipeline.dart` SHALL expose only orchestration entrypoints needed externally (for example `generateFromCli`, `generateSingleLibraryFile`). Static helpers (`dartFilesUnderDirectory`, `expandGenerationTargets`, `testOutputPathForLib`, `shortLibLabel`) SHALL move to the module that uses them. The pipeline SHALL NOT re-export internal application/domain types (`GeneratorRunOutcome`, `EmitGenerationUi`, `GeneratorRunContext`, etc.).

#### Scenario: Pipeline consumers import internals directly

- **WHEN** package-internal code needs `GeneratorRunOutcome` or similar types
- **THEN** it imports from `lib/src/domain/` or `lib/src/application/` directly
- **AND** `generate_pipeline.dart` export list does not include those symbols

### Requirement: CLI modules use consistent naming without redundant prefix

Under `lib/src/cli/`, modules SHALL be named `log.dart`, `progress.dart`, and `help.dart` (not `cli_log.dart`, etc.). The useless barrel `lib/src/cli/cli.dart` SHALL be removed; consumers import specific modules.

#### Scenario: No cli.dart barrel

- **WHEN** searching the codebase for `cli/cli.dart` imports
- **THEN** no imports remain
- **AND** each former consumer imports `log.dart`, `progress.dart`, or `help.dart` explicitly

### Requirement: Help concerns split from version and early exit

`help.dart` SHALL contain help text and a pure print helper only. Reading version from `pubspec.yaml` SHALL live in `lib/src/infrastructure/io/version_resolver.dart`. Early-exit flag handling (`handleEarlyExitFlags`) SHALL live in `lib/src/cli/early_exit_handler.dart`.

#### Scenario: Help module has no pubspec I/O

- **WHEN** inspecting `lib/src/cli/help.dart`
- **THEN** it does not read `pubspec.yaml` from disk
- **AND** version resolution is invoked from infrastructure via CLI wiring

### Requirement: SnapshotRunContext replaces long parameter lists

`runSnapshots` SHALL accept a single `SnapshotRunContext` (or equivalent) bundling optional callbacks, flags, paths, and the `ProcessRunner`. The refactor MAY split internal steps (runner generation, execution, decoding) but the public signature MUST shrink to context plus required inputs.

#### Scenario: Call sites use context object

- **WHEN** application code invokes `runSnapshots`
- **THEN** it constructs a `SnapshotRunContext` instead of passing many optional named parameters
- **AND** behavior of snapshot execution is unchanged from before the refactor

### Requirement: Explicit allFileClasses at codegen boundaries

Functions in snapshot runner codegen and JSON deserialization that only need peer class metadata SHALL accept `List<ClassInfo> allFileClasses` rather than a full `ParsedClass`. Callers SHALL extract the list at the application boundary where `ParsedClass` is still available.

#### Scenario: Codegen does not require ParsedClass

- **WHEN** inspecting infrastructure codegen and JSON decoder signatures affected by this change
- **THEN** they take `List<ClassInfo> allFileClasses` where that is the only use of parsed class metadata
- **AND** they do not take `ParsedClass` solely to access `allFileClasses`

### Requirement: Behavior and test suite unchanged

After all structural changes, `dart test` SHALL pass without modifying test assertions. CLI output for equivalent invocations SHALL remain byte-identical for representative example targets (manual verification documented in tasks).

#### Scenario: CI-equivalent validation

- **WHEN** the refactor branch is complete
- **THEN** the full package test suite passes
- **AND** no test file changes alter expected strings or exit codes except import path updates
