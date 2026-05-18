# `lib/src/` layout

This package keeps **stable** `package:dart_test_gen/<name>.dart` entrypoints at `lib/*.dart` while implementation moves under `lib/src/` by layer.

## Layers (dependency direction: entry → application → domain & ports ← infrastructure)

| Folder | Role |
|--------|------|
| `domain/` | Core types with no I/O: generator contract, models (`enums`, `test_models`, `parsed_models`, `snapshot_models`), check failure DTO, `logic_profile`, pure services (e.g. `dynamic_input_generator`, `boundary_case_generator`). |
| `ports/` | Abstract boundaries (`GenerationFilesystem`, `ProcessRunner`, `ConfigReader`) — no `dart:io` / `dart:isolate`. |
| `application/` | Orchestration and use-cases: CLI run, path expansion, snapshot unit-test generation, isolate bridge. |
| `cli/` | CLI presentation: `log`, `progress`, `help` (text only), `early_exit_handler`, `snapshot_failure_formatting`. |
| `infrastructure/` | Adapters: `dart:io` filesystem, config YAML load, AST parsing (`dart_ast_parser`, `method_logic_analyzer`), codegen (`test_file_renderer`, `snapshot_runner_generator`), JSON merge, analyzer-based `library_path_resolver`, `version_resolver` (pubspec version lookup). |
| `wiring/` | Composition root: `AppDependencies` registers default adapters (`IoGenerationFilesystem`, `IoConfigReader`, `IoProcessRunner` via callers). |

## Public entrypoints (`lib/*.dart`)

- `package:dart_test_gen/boundary_test_generator.dart` — canonical boundary-test API (re-exported from `test_generator.dart` for compatibility).
- `package:dart_test_gen/test_generator.dart` — re-export shim for legacy imports.
- `package:dart_test_gen/snapshot.dart` — snapshot run + exports for parser models and `ProcessRunner`.
- `package:dart_test_gen/source_parser.dart` — re-exports `dart_ast_parser`, `parsed_models`, `package_path_resolver`.
- `package:dart_test_gen/generate_pipeline.dart` — CLI entry + path helpers delegating to application.
- `package:dart_test_gen/gen_config.dart` — config data classes only (load via `IoConfigReader` in `src/infrastructure/config/`).
- `package:dart_test_gen/resolved_dependencies.dart` — re-export of `library_path_resolver` (analyzer-based lib path resolution).
- `package:dart_test_gen/cli/cli_*.dart` — stable re-exports of `src/cli/log.dart`, `progress.dart`, and help/version/early-exit (`help.dart`, `early_exit_handler.dart`, `version_resolver.dart`).

## Internal graph (post–structural cleanup)

- `generate_pipeline.dart` → orchestrator, `gen_config`, `sampling`, `snapshot`, `source_parser`, `test_generator` (boundary), `wiring/app_dependencies`
- `snapshot.dart` → `SnapshotRunContext`, codegen + JSON merge, `IoProcessRunner`
- `source_parser.dart` → `infrastructure/ast/dart_ast_parser`, `domain/models/parsed_models`, `infrastructure/io/package_path_resolver`
- `sampling.dart` → `gen_config`, `test_generator`

After this change, `generate_pipeline.dart` delegates orchestration to `src/application/cli_generation_orchestrator.dart` and snapshot generation to `src/application/snapshot_unit_test_generation.dart`.
