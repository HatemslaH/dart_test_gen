# `lib/src/` layout

This package keeps **stable** `package:dart_test_gen/<name>.dart` entrypoints at `lib/*.dart` while implementation moves under `lib/src/` by layer.

## Layers (dependency direction: entry → application → domain & ports ← infrastructure)

| Folder | Role |
|--------|------|
| `domain/` | Core types with no I/O: generator contract, check failure DTO. |
| `ports/` | Abstract boundaries (`GenerationFilesystem`) — no `dart:io` / `dart:isolate`. |
| `application/` | Orchestration and use-cases: CLI run, path expansion, snapshot unit-test generation. |
| `infrastructure/` | Adapters: real filesystem backed by `dart:io`. |
| `generators/` | Concrete `GeneratorModule` implementations (today: snapshot unit tests). |
| `wiring/` | Composition root: default adapters and module registration. |

## Import graph (pre-refactor public consumers)

Entrypoints imported from `bin/` and `test/`:

- `package:dart_test_gen/cli_help.dart`
- `package:dart_test_gen/generate_pipeline.dart`
- `package:dart_test_gen/test_generator.dart`
- `package:dart_test_gen/gen_config.dart`
- `package:dart_test_gen/source_parser.dart`
- `package:dart_test_gen/snapshot.dart`
- `package:dart_test_gen/sampling.dart`

Internal `lib/` graph (high level):

- `generate_pipeline.dart` → `cli_*`, `gen_config`, `resolved_dependencies`, `sampling`, `snapshot`, `source_parser`, `test_generator`
- `snapshot.dart` → `source_parser`, `test_generator`
- `source_parser.dart` → `test_generator` (params / `MethodKind`)
- `sampling.dart` → `gen_config`, `test_generator`
- `resolved_dependencies.dart` → `source_parser`

After this change, `generate_pipeline.dart` stays the façade for CLI helpers and delegates orchestration to `src/application/cli_generation_orchestrator.dart` and generation to `src/generators/`.
