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

- **`bin/generate.dart`** — CLI entrypoint; delegates to `lib/generate_pipeline.dart`.
- **`lib/`** — core implementation:
  - `source_parser.dart` — API extraction from sources.
  - `snapshot.dart` — executing code and capturing literals / exceptions.
  - `test_generator.dart` — emitted test file content.
  - `generate_pipeline.dart` — CLI args, orchestration, isolate wiring.
  - `gen_config.dart`, `sampling.dart` — YAML + CLI sampling (`full` | `random` | `happy_path`), `max_cases`, `seed`, per-method overrides.
  - `cli_log.dart`, `cli_progress.dart` — logging / progress (verbose on stderr pattern).
  - `resolved_dependencies.dart` — dependency resolution for generation.
  - `usecases/` — example / showcase libraries used by the tool and mirrored tests (calculator, data_toolbox, optional_types, async_showcase).
- **`test/`** — mirrors `lib/usecases/...` with generated-style `*_test.dart` files; treat as regression fixtures for the generator.

## CLI conventions (for consistency)

- Invocation from package root: `dart pub get`, then `dart run bin/generate.dart <path-to-lib-or-dir>`.
- Notable flags: `--class`, `-v` / `--verbose`, `--strategy`, `--max-cases`, `--seed`, `--config` (default config path `dart_test_gen.yaml`).
- Progress vs logs: design keeps **progress on stdout**, **verbose / errors on stderr** where applicable (see `generate_pipeline` / `EmitGenerationUi`).

## Code style and engineering conventions

- **Naming**: Dart idioms — `snake_case` for libraries/files, `UpperCamelCase` for types, `lowerCamelCase` for members; generated tests follow `*_test.dart` next to mirrored `lib/` paths under `test/`.
- **Imports**: prefer `package:` for dependencies; `bin/generate.dart` uses relative import into `lib/` for the pipeline (acceptable for a single-package bin).
- **Privacy**: generator focuses on **public instance methods** of a chosen class (default: class with the most suitable methods in a file).
- **Types supported in snapshots** (evolving): primitives, `String`, `List<int>`, enums from the same file, registered patterns such as **`RgbColor`**, nullable / defaults / omitted named args, async (`Future`) / `Stream` (stream expected as list in snapshot). Unsupported or partial areas are listed in README **TODO** (statics, factories, extension types, getters/setters/operators, broader generics, etc.).
- **Determinism**: sampling strategies and `--seed` matter for reproducibility; snapshot behavior can still depend on **SDK / platform** (called out in README roadmap).

## How to verify changes

- `dart pub get`
- `dart analyze` (respects `analysis_options.yaml`)
- `dart test`

## OpenSpec / AI workflow (this repo)

Experimental OpenSpec assets live under **`openspec/`** (e.g. `config.yaml`). This **`project.md`** is the long-form **project context** for proposals and implementation; keep it updated when stack, CLI, or supported Dart surface changes materially.
