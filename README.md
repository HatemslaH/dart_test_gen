# dart_test_gen

<p align="center">
  Snapshot-based unit test generator for Dart.
  <br>
  Generate `test/**/_test.dart` files by executing your code in a sandbox runner and snapshotting results into expectations.
</p>

<p align="center">
  <img alt="Dart" src="https://img.shields.io/badge/Dart-%3E%3D3.3-0175C2?logo=dart&logoColor=white">
  <img alt="Type" src="https://img.shields.io/badge/type-CLI-informational">
  <img alt="Snapshots" src="https://img.shields.io/badge/tests-snapshot--based-blue">
</p>

## Table of contents

- [Quick start](#quick-start)
- [What it generates](#what-it-generates)
- [Features](#features)
- [CLI options](#cli-options)
- [Configuration (`dart_test_gen.yaml`)](#configuration-dart_test_genyaml)
- [CI & determinism](#ci--determinism)
- [Project structure](#project-structure)
- [Limitations](#limitations)

## Quick start

From the package root (where `pubspec.yaml` is located):

```bash
dart pub get
dart run dart_test_gen lib/usecases/calculator.dart
```

Generate tests for a directory under `lib/`:

```bash
dart run dart_test_gen lib/usecases
```

## What it generates

- **Mirrored paths**: inputs under `lib/` map to tests under `test/` with `*_test.dart` names.
- **Real execution + snapshot**: the generator runs your code in a helper runner process and writes the observed results into test expectations.
- **Exceptions become tests**: if a call throws during the snapshot stage, the generated test uses `throwsA(isA<...>())`.

## Features

- **API parsing via `analyzer`**: discovers public instance methods and their parameter/return types.
- **Edge-case inputs**: builds boundary-value sets for supported primitives and common collections.
- **Sampling strategies**: keep generation size reasonable with `--strategy` and `--max-cases`.
- **Floating point stability**: optional `closeTo` assertions for scalar `double` via `--use-close-for-double` / `use_close_for_double`.
- **CI-friendly modes**: `--dry-run` (no writes) and `--check` (fail if committed tests differ).

## CLI options

```
dart_test_gen — snapshot-based unit test generator for Dart.

Usage:
  dart run dart_test_gen <path> [path ...] [options]

Arguments:
  <path>                       .dart file under lib/ or a directory under lib/.

Options:
  --class <Name>               pick a specific class (only when targets reduce to 1 file).
  -v, --verbose                verbose log to stderr; progress stays on stdout.
  --strategy <type>            case sampling strategy: full | random | happy_path.
  --max-cases <N>              max successful cases per method (default 200).
  --seed <N>                   seed for the random strategy.
  --use-close-for-double       use expect(actual, closeTo(expected, eps)) for scalar double.
  --double-epsilon <x>         absolute epsilon for closeTo (positive finite number).
  --config <path>              path to config file (default: dart_test_gen.yaml).
  --keep-runner                keep the temporary snapshot runner file on success.
  --dry-run                    run the full pipeline but do not write any test files;
                               prints the would-be output paths to stdout.
  --check                      run the full pipeline but compare generated content to
                               existing files instead of writing; exits 1 if any differ.
  -h, --help                   show this help and exit.
  --version                    print the package version and exit.
```

## Configuration (`dart_test_gen.yaml`)

Create `dart_test_gen.yaml` in the project root to set defaults:

```yaml
strategy: random
max_cases: 30
seed: 42
use_close_for_double: false
double_epsilon: 1e-9
methods:
  clamp:
    strategy: full
    max_cases: 50
  divide:
    strategy: happy_path
```

Notes:
- `use_close_for_double` and `double_epsilon` only affect **scalar** `double` assertions.
- `double_epsilon` MUST be a positive finite number.

## CI & determinism

Snapshot tests are **real execution**, so results depend on the environment. To keep CI stable:

- **Pin the Dart SDK version** in CI (runtime behavior and `double` math can differ across versions).
- If you see flaky floating-point assertions across platforms, enable:
  - `use_close_for_double: true` (or pass `--use-close-for-double`)

### Check that generated tests are up-to-date (`--check`)

`--check` runs the full pipeline and compares generated output with committed files instead of writing.

- Exits with **code 1** if any file differs.
- Ignores the `// Generated: <timestamp>` line during comparison.

Example (GitHub Actions step):

```yaml
- name: Check generated tests are up-to-date
  run: dart run dart_test_gen lib --check
```

### Smoke-check without writing (`--dry-run`)

`--dry-run` runs the full pipeline but does not write any test files. It prints the would-be output paths to stdout:

```bash
dart run dart_test_gen lib --dry-run
```

## Project structure

- `bin/generate.dart`: CLI entry point (shim).
- `lib/`: implementation:
  - `source_parser.dart`: API parsing via analyzer
  - `snapshot.dart`: snapshot runner + result normalization
  - `test_generator.dart`: Dart test output generation
  - `generate_pipeline.dart`: orchestration

## Limitations

- Not all Dart language constructs/types are supported yet (especially complex generics and certain advanced signatures).
- Methods with many parameters can produce a large combinatorial set of cases; use sampling (`--strategy`, `--max-cases`) to control size.
