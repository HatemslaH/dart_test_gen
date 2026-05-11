# Project context — dart_test_gen

Use this file as background when proposing or implementing changes. It summarizes purpose, stack, layout, and conventions for this repository.

## What this is

**dart_test_gen** is a Dart CLI tool that generates unit tests from library code under `lib/`. It uses the **analyzer** to discover public instance methods, builds argument combinations, runs the real implementation in a **helper isolate** to capture outputs (“snapshots”), and writes `test/.../<name>_test.dart` files with `expect(actual, expected)` (or exception matchers when the snapshot throws).

Primary user-facing docs and roadmap live in the root **README.md** (Russian). Code comments are partly Russian (especially orchestration / CLI).

## Tech stack

| Area | Choice |
|------|--------|
| Language | **Dart**, SDK **>=3.0.0 \<4.0.0** |
| Parsing / static API | **`analyzer`** (^8.x) |
| Paths | **`path`** (^1.9) |
| Default CLI config | **`yaml`** (^3.1) — file `dart_test_gen.yaml` at package root |
| Tests | **`package:test`** (^1.24) |
| Analysis | **`analysis_options.yaml`** includes **`package:lints/recommended.yaml`** |

No Flutter; plain Dart package. Concurrency: **`dart:isolate`** for snapshot runs; **`dart:io`** for filesystem and CLI.

## Repository layout

- **`bin/dart_test_gen.dart`** — primary CLI entrypoint, registered in `pubspec.yaml` under `executables:`; delegates to `lib/generate_pipeline.dart` (handles `--help` / `--version` early-exit via `lib/cli_help.dart`).
- **`bin/generate.dart`** — legacy compatibility shim: emits a single deprecation warning on stderr, then delegates to the same pipeline.
- **`lib/`** — core implementation:
  - `source_parser.dart` — API extraction from sources.
  - `snapshot.dart` — executing code and capturing literals / exceptions; defines `SnapshotRunnerFailure` for structured compile/parse errors. Temporary runner files live under `${TMP}/dart_test_gen/` and are preserved on failure.
  - `test_generator.dart` — emitted test file content.
  - `generate_pipeline.dart` — CLI args, orchestration, isolate wiring; `formatSnapshotRunnerFailure` renders structured diagnostics.
  - `cli_help.dart` — `--help` text, `--version` lookup from `pubspec.yaml`, early-exit handling.
  - `gen_config.dart`, `sampling.dart` — YAML + CLI sampling (`full` | `random` | `happy_path`), `max_cases`, `seed`, per-method overrides; top-level `keep_runner` flag.
  - `cli_log.dart`, `cli_progress.dart` — logging / progress (verbose on stderr pattern).
  - `resolved_dependencies.dart` — dependency resolution for generation.
  - `usecases/` — example / showcase libraries used by the tool and mirrored tests (calculator, data_toolbox, optional_types, async_showcase, getters_setters_operators_showcase, floating_point_showcase, static_factory_extension_showcase, type_extensions_showcase, stress_showcase).
- **`test/`** — mirrors `lib/usecases/...` with generated-style `*_test.dart` files; treat as regression fixtures for the generator.

## CLI conventions (for consistency)

- Invocation from package root: `dart pub get`, then `dart run dart_test_gen <path-to-lib-or-dir>`. The legacy `dart run bin/generate.dart …` still works but prints a deprecation warning on stderr.
- Notable flags: `--class`, `-v` / `--verbose`, `--strategy`, `--max-cases`, `--seed`, `--use-close-for-double`, `--double-epsilon`, `--config` (default config path `dart_test_gen.yaml`), `--keep-runner` (also `keep_runner: true` in YAML), `-h` / `--help`, `--version`.
- Progress vs logs: design keeps **progress on stdout**, **verbose / errors on stderr** where applicable (see `generate_pipeline` / `EmitGenerationUi`).
- Snapshot runner failures (compile or unparseable stdout) are reported as a structured multi-line message on stderr (stage, lib path, class/method, preserved runner path under `${TMP}/dart_test_gen/`, tail of `dart` stderr, actionable hints) — see `formatSnapshotRunnerFailure`.

## Code style and engineering conventions

- **Naming**: Dart idioms — `snake_case` for libraries/files, `UpperCamelCase` for types, `lowerCamelCase` for members; generated tests follow `*_test.dart` next to mirrored `lib/` paths under `test/`.
- **Imports**: prefer `package:` for dependencies; both `bin/dart_test_gen.dart` and `bin/generate.dart` import the pipeline via `package:dart_test_gen/...`.
- **Privacy**: generator focuses on **public instance methods** of a chosen class (default: class with the most suitable methods in a file).
- **Types supported in snapshots** (evolving): primitives, `String`, `List<int>`, **`List<String>`**, **`Set<int>`**, **`Iterable<int>`** (params + matching return literals), enums from merged compilation units, **user-defined classes** resolved via `ClassInfo` (same entry + dependency-merged `lib` files — e.g. `RgbColor` from `rgb_color.dart`), nullable / defaults / omitted named args, async (`Future`) / `Stream` (stream expected as list in snapshot). **Static methods, factory constructors, extension types, getters, setters, and operators** are supported. **Floating-point stability** is opt-in via `use_close_for_double` / `--use-close-for-double` (per-method override allowed). Unsupported or partial areas are listed in README **TODO** (broader generics, `Map<K,V>` in parameters, `Set<String>`, etc.).
- **Determinism**: sampling strategies and `--seed` matter for reproducibility; snapshot behavior can still depend on **SDK / platform** (called out in README roadmap).

## How to verify changes

- `dart pub get`
- `dart analyze` (respects `analysis_options.yaml`)
- `dart test`

## OpenSpec / AI workflow (this repo)

Experimental OpenSpec assets live under **`openspec/`** (e.g. `config.yaml`). This **`project.md`** is the long-form **project context** for proposals and implementation; keep it updated when stack, CLI, or supported Dart surface changes materially.
