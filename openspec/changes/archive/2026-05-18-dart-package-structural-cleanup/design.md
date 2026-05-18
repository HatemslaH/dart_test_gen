## Context

The `dart_test_gen` package already documents layers in `lib/src/README.md` (entry → application → domain & ports ← infrastructure) and has a partial `lib/src/` layout from the prior `lib-clean-architecture-refactor`. However, three large public files (`test_generator.dart` ~500 lines, `snapshot.dart` ~600 lines, `source_parser.dart` ~700 lines) still mix domain models, pure logic, codegen string building, and I/O. Application code still imports `cli_log.dart` and calls `exit(64)` from `cli_args.dart`; `GeneratorConfig.load()` performs file I/O in `gen_config.dart`; `snapshot.dart` calls `Process.runSync` directly.

**Constraint:** Zero change to CLI stdout/stderr semantics, test expectations, or generated test file content. Refactor incrementally; run `dart test` after each numbered step in tasks.

**Stakeholders:** Package maintainers adding generators or ports; downstream packages importing `package:dart_test_gen/...`.

## Goals / Non-Goals

**Goals:**

- Decompose god-files into `domain/models/`, `domain/services/`, `infrastructure/codegen|ast|serialization|io|analyzer|config/`, and thin `lib/*.dart` facades.
- Enforce layer boundaries: application never imports CLI or calls `exit()`; domain/application never import `dart:io` or `package:analyzer` except through port interfaces.
- Introduce `ProcessRunner` and `ConfigReader` ports with infrastructure implementations wired in `AppDependencies` / CLI.
- Simplify public surface: `generate_pipeline.dart` orchestrates only; path helpers colocated with consumers; explicit `List<ClassInfo> allFileClasses` at codegen boundaries; `SnapshotRunContext` for `runSnapshots`.
- Consistent naming under `lib/src/cli/` and accurate file names (`boundary_test_generator.dart`, `library_path_resolver.dart`).

**Non-Goals:**

- New generator kinds, new CLI flags, or behavior changes to boundary-case algorithms, snapshot JSON format, or sampling.
- Rewriting tests or golden files beyond import path updates.
- Full extraction of snapshot I/O orchestration out of `lib/snapshot.dart` facade (facade may still coordinate; codegen and process execution are abstracted).

## Decisions

### 1. Target folder map (god-file splits)

| Source | Extract to |
|--------|------------|
| `test_generator.dart` enums/models | `domain/models/enums.dart`, `domain/models/test_models.dart` |
| Boundary logic | `domain/services/boundary_case_generator.dart` |
| `_render*`, `generateTestFile` | `infrastructure/codegen/test_file_renderer.dart` |
| Public API | `lib/boundary_test_generator.dart` re-exports (keep `test_generator.dart` as deprecated export if tests/bin still use old path) |
| `snapshot.dart` DTOs | `domain/models/snapshot_models.dart` |
| JSON decoding | `infrastructure/serialization/json_decoder.dart` |
| Runner `StringBuffer` codegen | `infrastructure/codegen/snapshot_runner_generator.dart` |
| `runSnapshots` coordination | stays in facade module, uses injected `ProcessRunner` |
| `source_parser.dart` models | `domain/models/parsed_models.dart` |
| AST parsing | `infrastructure/ast/dart_ast_parser.dart` |
| Package paths | `infrastructure/io/package_path_resolver.dart` |
| `resolved_dependencies.dart` | `infrastructure/analyzer/library_path_resolver.dart` |

**Rationale:** Matches existing README layers; keeps pure logic testable without I/O.

**Alternative considered:** Single `domain/models.dart` barrel — rejected to keep files single-purpose per refactoring plan.

### 2. Application ↔ CLI boundary

- `snapshot_unit_test_generation.dart` returns `String? dryRunOutput` (or a small result DTO) instead of `CliLog.out`.
- `cli_args.dart` throws `InvalidCliArgumentsException` (or returns `Result`) — CLI orchestrator catches and `exit(64)`.
- `snapshot_failure_formatting.dart` moves to `lib/src/cli/` (presentation).

**Rationale:** Application must not depend on presentation or process exit codes.

### 3. Config loading port

```dart
// domain/ports/config_reader.dart
abstract class ConfigReader {
  GeneratorConfig loadConfig(String path);
}
```

- `GeneratorConfig` in `gen_config.dart` (or `domain/models/generator_config.dart`) — immutable fields, no `load()`.
- `ConfigLoader` in `infrastructure/config/config_loader.dart` implements `ConfigReader` using `dart:io`.
- `AppDependencies` exposes `ConfigReader`; orchestrator calls `loadConfig` instead of static load.

### 4. Process runner port

```dart
// domain/ports/process_runner.dart
abstract class ProcessRunner {
  ProcessResult runSync(String executable, List<String> arguments, {String? workingDirectory, Map<String, String>? environment});
}
```

- `IoProcessRunner` in `infrastructure/io/io_process_runner.dart` delegates to `Process.runSync`.
- `runSnapshots` accepts `ProcessRunner` (via `SnapshotRunContext` or constructor param from wiring).
- Tests inject a fake runner recording commands without spawning.

**Alternative:** Async `Future<ProcessResult> run` — deferred unless snapshot flow is refactored to async; sync matches current `runSync` usage.

### 5. `SnapshotRunContext`

Bundle optional callbacks, verbosity, paths, `ProcessRunner`, and flags currently passed as many named parameters to `runSnapshots`. Single required context object; internal steps: generate runner source → write/run process → decode stdout.

### 6. Explicit `allFileClasses`

At application→infrastructure boundaries (snapshot runner codegen, JSON decoder), pass `List<ClassInfo> allFileClasses` extracted once from `ParsedClass` in `snapshot_unit_test_generation.dart`. Codegen functions do not accept full `ParsedClass` if they only need the list.

### 7. Public API and re-exports

- `lib/*.dart` top-level files: re-export stable types + thin wrappers only.
- `generate_pipeline.dart`: keep `generateFromCli`, `generateSingleLibraryFile`; move `dartFilesUnderDirectory`, `expandGenerationTargets`, `testOutputPathForLib`, `shortLibLabel` into `snapshot_unit_test_generation.dart` or `infrastructure/io/path_helpers.dart`.
- Stop exporting `GeneratorRunOutcome`, `EmitGenerationUi`, etc. from pipeline — consumers import from `src/domain/` or `src/application/` directly (package-internal).

### 8. CLI file renames

| Old | New |
|-----|-----|
| `lib/cli/cli_log.dart` | `lib/src/cli/log.dart` (update `package:` exports if public) |
| `lib/cli/cli_progress.dart` | `lib/src/cli/progress.dart` |
| `lib/cli/cli_help.dart` | split: `help.dart`, `early_exit_handler.dart`; `version_resolver.dart` in infrastructure |
| Delete `lib/src/cli/cli.dart` barrel | direct imports |

Note: Current tree shows `lib/cli/` not `lib/src/cli/` for some files — tasks must move/rename consistently and update `package:dart_test_gen/cli_*.dart` export shims if they exist.

### 9. `SnapshotUnitTestGeneratorModule`

If the class only delegates to `generateSingleLibraryFile`, inline into `snapshot_unit_test_generation.dart` or keep as thin `GeneratorModule` adapter in `generators/` — prefer keeping module for registry extensibility but remove duplicate indirection.

### 10. Incremental validation order

Implement tasks in proposal section order (1 → 11). After each major step: `dart analyze` / `dart test`. Manual CLI: run against `example/` with and without `--dry-run`.

## Risks / Trade-offs

| Risk | Mitigation |
|------|------------|
| Missed import after file moves breaks `bin/` or `test/` | Grep for old paths; run full test suite each step |
| Accidental behavior change in string codegen | No edits to generation algorithms—move code verbatim first, refactor later |
| **BREAKING** public import `test_generator.dart` | Keep re-export shim `export 'boundary_test_generator.dart';` with deprecation comment |
| `SnapshotRunContext` migration breaks many call sites | Update all call sites in same commit as context introduction; compile-time errors guide completeness |
| Duplicate types during transition | Move types first, update imports, delete from god-file last |

## Migration Plan

1. Create new files with moved code (copy-paste), switch imports, delete from source file.
2. Update `AppDependencies` with new ports.
3. Rename CLI files and add export shims at old `package:` URIs if needed for one release.
4. Final pass: grep `dart:io` / `package:analyzer` under `lib/src/domain` and `lib/src/application`.
5. Archive change after `/opsx:apply` and green CI.

**Rollback:** Revert branch; no data migration.

## Open Questions

- Whether `lib/cli/*.dart` remain as one-line export shims to `lib/src/cli/*` for external consumers (recommended: yes for one minor version).
- Exact name for public library: `boundary_test_generator.dart` vs keeping `test_generator.dart` filename with internal split only (proposal allows either if re-export preserves API).
