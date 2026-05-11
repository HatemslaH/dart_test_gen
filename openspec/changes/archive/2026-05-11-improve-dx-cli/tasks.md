## 1. Entrypoint and packaging

- [x] 1.1 Replace the stub in `bin/dart_test_gen.dart` with a `Future<void> main(List<String> args)` that imports `../lib/generate_pipeline.dart` and calls `generateFromCli(args)`
- [x] 1.2 Add an `executables:` section to `pubspec.yaml` declaring `dart_test_gen:` (so `dart run dart_test_gen` resolves to `bin/dart_test_gen.dart`)
- [x] 1.3 Convert `bin/generate.dart` into a shim: print exactly one deprecation warning line on stderr ("[deprecated] 'bin/generate.dart' is kept for compatibility; use 'dart run dart_test_gen' instead.") and then delegate to `generateFromCli(args)`
- [x] 1.4 Verify `dart run dart_test_gen lib/usecases/calculator.dart` produces the same `test/usecases/calculator_test.dart` as the legacy invocation

## 2. `--help` and `--version`

- [x] 2.1 Extend the CLI argument parser in `lib/generate_pipeline.dart` (or a new helper) to recognize `--help` / `-h` and `--version` BEFORE any path validation
- [x] 2.2 Add `const String cliHelpText` containing the program name, usage line, and a one-line description for every documented flag (`--class`, `-v`/`--verbose`, `--strategy`, `--max-cases`, `--seed`, `--use-close-for-double`, `--double-epsilon`, `--config`, `--keep-runner`, `--help`, `--version`)
- [x] 2.3 Implement version lookup: resolve `pubspec.yaml` relative to `Platform.script` / `Isolate.resolvePackageUri`, parse with `package:yaml`, return the `version` field; fall back to the string `unknown` on any failure
- [x] 2.4 `--help` prints `cliHelpText` to stdout and exits with code 0 without invoking the generator; `--version` prints the resolved version to stdout and exits with code 0

## 3. Structured snapshot runner diagnostics

- [x] 3.1 In `lib/snapshot.dart` introduce `class SnapshotRunnerFailure implements Exception` with fields: `String stage` (`'compile' | 'parse'`), `String absoluteLibPath`, `String? className`, `String? methodName`, `String runnerPath`, `String dartStderrTail`, `int? exitCode`
- [x] 3.2 When the `dart` subprocess for the snapshot runner exits with a non-zero code OR its stdout cannot be parsed into the expected snapshot payload, throw `SnapshotRunnerFailure` with the appropriate `stage`, the captured tail (~40 last lines) of the subprocess stderr, and the absolute path of the temporary runner file
- [x] 3.3 On `SnapshotRunnerFailure`, do NOT delete the temporary runner file
- [x] 3.4 On successful snapshot generation, delete the temporary runner file unless `--keep-runner` is set
- [x] 3.5 Place temporary runner files under `Directory.systemTemp/dart_test_gen/` (create on demand) so they are easy to locate and clean up manually
- [x] 3.6 Propagate the current class name and (when known) method name into the snapshot runner call sites so `SnapshotRunnerFailure` can be populated with that context

## 4. Error formatting in the isolate

- [x] 4.1 In `lib/generate_pipeline.dart::generationIsolateMain`, catch `SnapshotRunnerFailure` separately from generic `Exception` and format a multi-line message containing: header `Snapshot runner failed (<stage>) for <absoluteLibPath> [<Class>.<method>]`, `runner kept at: <runnerPath>`, an indented `dart stderr (tail):` block, and a `hints:` section listing the three required hints (re-run with `-v`, open the runner file, attach it to a bug report)
- [x] 4.2 Send the formatted message through the existing `bridge(line: ..., error: true)` channel so it reaches stderr regardless of verbose mode
- [x] 4.3 Keep the existing generic `Exception` branch as a fallback for non-snapshot errors (no behavior change for those)

## 5. `--keep-runner` flag

- [x] 5.1 Add `--keep-runner` to the CLI argument parser and to the `cliHelpText`
- [x] 5.2 Thread the flag through `GeneratorConfig` (new bool field `keepRunner`, default `false`) and into the spawn message for `generationIsolateMain`
- [x] 5.3 Also accept `keep_runner: true` in `dart_test_gen.yaml` at the top level (mirroring other options); CLI flag wins over YAML
- [x] 5.4 When `keepRunner` is `true` and generation succeeds, log the runner file path through the verbose bridge so users can find it

## 6. Documentation

- [x] 6.1 Update the `## Запуск` section of `README.md` to use `dart run dart_test_gen ...` in all examples; add a note that `dart run bin/generate.dart ...` still works but is deprecated
- [x] 6.2 Update `### Опции CLI` to document `--help`, `--version`, `--keep-runner`
- [x] 6.3 Mark TODO item 8 in `README.md` as `[x]` and briefly describe what shipped (unified binary + structured runner errors)

## 7. Tests

- [x] 7.1 Add a smoke test that runs `dart run dart_test_gen --help` and asserts stdout contains the program name and the names of all documented flags
- [x] 7.2 Add a smoke test for `dart run dart_test_gen --version` that asserts stdout contains the version literal from `pubspec.yaml`
- [x] 7.3 Add a smoke test that runs `dart run bin/generate.dart --help` and asserts stderr contains a single deprecation warning line AND stdout still contains the help text
- [x] 7.4 Add a negative test: a fixture usecase whose generated runner intentionally fails to compile, and assert that stderr contains the structured error header (`Snapshot runner failed (compile)`), the `runner kept at:` line, and the `hints:` section, and that the runner file referenced by that path exists on disk after the run
- [x] 7.5 Add a test that on a successful run with no `--keep-runner`, no files remain in `Directory.systemTemp/dart_test_gen/` that were created during the run
