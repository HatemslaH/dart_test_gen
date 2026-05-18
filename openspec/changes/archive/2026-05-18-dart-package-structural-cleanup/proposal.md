## Why

After the initial clean-architecture refactor, several large `lib/*.dart` files and a few layer violations remain: application code still imports CLI helpers and calls `exit()`, domain config performs file I/O, and infrastructure types leak through the public `lib/` surface. The package is harder to navigate, test in isolation, and extend without touching god-files. This change completes the structural cleanup described in the refactoring plan—**without** altering CLI output, tests, or external behavior.

## What Changes

- **Split god-files** (`test_generator.dart`, `snapshot.dart`, `source_parser.dart`) into domain models, domain services, and infrastructure adapters (codegen, AST, JSON, I/O) per single-responsibility units.
- **Fix layer violations**: application returns dry-run text instead of calling `CliLog`; CLI-only `exit()`; `GeneratorConfig` becomes a plain data class with `ConfigReader` port and infrastructure loader; pure logic moves from `application/` to `domain/services/`; presentation formatting moves to `cli/`.
- **Introduce `ProcessRunner` port** and inject `IoProcessRunner` at the composition root; replace direct `Process.runSync` in snapshot flow.
- **Clean public API**: move `resolved_dependencies.dart` to infrastructure (rename to `library_path_resolver.dart`); top-level `lib/*.dart` files become re-exports or thin facades only; slim `generate_pipeline.dart` (no static path helpers, no re-export of internal types).
- **Naming and CLI hygiene**: drop redundant `cli_` prefixes under `lib/src/cli/`; rename `test_generator.dart` → `boundary_test_generator.dart` (with backward-compatible re-export if needed); remove useless `cli/cli.dart` barrel; split help/version/early-exit concerns.
- **Reduce coupling**: `SnapshotRunContext` replaces long `runSnapshots` parameter lists; pass `List<ClassInfo> allFileClasses` explicitly instead of whole `ParsedClass` into codegen/JSON paths.
- **Validation gate**: every incremental step must compile and pass `dart test`; manual CLI spot-checks confirm identical output.

**BREAKING (minimize)**: Published `package:dart_test_gen/...` import paths may change only where unavoidable (e.g. `test_generator.dart` rename); prefer keeping stable entrypoints via re-exports. Any unavoidable path change must be documented for semver.

## Capabilities

### New Capabilities

- `god-file-decomposition`: Requirements for splitting `test_generator`, `snapshot`, and `source_parser` into domain models/services and infrastructure modules while preserving behavior.
- `layer-boundary-compliance`: Requirements that application/domain obey the inward dependency rule (no CLI, no `exit()`, no `dart:io`/`package:analyzer` in domain/application except via ports), including file placement for services and CLI formatting.
- `infrastructure-ports`: Requirements for `ProcessRunner`, `ConfigReader`, and composition-root injection of real adapters.
- `public-api-facades`: Requirements for thin `lib/*.dart` public surface, pipeline facade simplification, CLI file naming/barrel cleanup, and `SnapshotRunContext` / explicit `allFileClasses` parameters.

### Modified Capabilities

- `internal-library-layers`: Strengthen requirements with concrete placement rules (domain models under `domain/models/`, codegen under `infrastructure/codegen/`, etc.) and verification that god-files and infrastructure do not remain in public `lib/` entrypoints.

## Impact

- **Primary**: `lib/test_generator.dart`, `lib/snapshot.dart`, `lib/source_parser.dart`, `lib/generate_pipeline.dart`, `lib/gen_config.dart`, `lib/resolved_dependencies.dart`, `lib/cli/*`, all of `lib/src/{application,domain,infrastructure,cli,wiring}/`, `bin/`, and package tests importing moved symbols.
- **Tests**: Import path updates only; no assertion or golden changes expected.
- **Consumers**: External packages importing `package:dart_test_gen/...` should keep working via re-exports; document any renamed public library file.
- **Dependencies**: No new pub dependencies; continues using `dart:io`, `package:analyzer` only in infrastructure/CLI layers.
