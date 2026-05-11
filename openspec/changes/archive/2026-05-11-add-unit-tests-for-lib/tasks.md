## 1. sampling.dart

- [x] 1.1 Create `test/sampling_test.dart` with cases for `full` (truncation at `maxCases`), `random` (deterministic with seed; size = `maxCases`), `happy_path` (1 optional + all mandatory), and the mandatory/optional bucket split

## 2. gen_config.dart (load path)

- [x] 2.1 Create `test/gen_config_load_test.dart` covering: missing file → defaults; invalid YAML → defaults; explicit `configPath` arg; per-method override inheritance; `keep_runner: true` at the top level

## 3. generate_pipeline.dart (parseCliArgs)

- [x] 3.1 Create `test/cli_args_parser_test.dart` covering: all documented flags parsed into record fields with expected values; defaults when flags are absent. Do NOT call `parseCliArgs` with inputs that trigger `exit(64)` (those are covered by CLI smoke)

## 4. generate_pipeline.dart (path helpers)

- [x] 4.1 Create `test/generate_pipeline_paths_test.dart` covering: `testOutputPathForLib` mirrors `lib/` → `test/`; `shortLibLabel` falls back to basename for paths outside `lib/`; `dartFilesUnderDirectory` recurses and filters by `.dart`; `expandGenerationTargets` expands files + directories, deduplicates, and exits on non-`.dart` files (test only the success cases — exit-on-error is covered by CLI smoke)

## 5. snapshot.dart (literal builder)

- [x] 5.1 Create `test/snapshot_literals_test.dart` covering `dartLiteralFromJson` for: `int`, `double` (including integer-valued double → `'1.0'` style), `bool`, `String` (escaping `'` and `\`), `List<int>`, `List<String>`, `Set<int>` (sorted), `Set<String>` (sorted), `Iterable<int>`, `Map<String, int>`, enum payload (`_enumType` / `_enumName`), user `ClassInfo` constructor (positional + named), fallback `_value`. Plus `dartLiteralFromJsonLoose` for null/bool/int/double/String

## 6. snapshot.dart (invoke expression)

- [x] 6.1 Create `test/snapshot_invoke_expression_test.dart` covering each `MethodKind`: `method` (instance + static receiver prefix), `getter`, `setter`, `operator_` for binary (`+`), index get (`[]`), index set (`[]=`), bitwise not (`~`), unary `-`, binary `-`

## 7. source_parser.dart

- [x] 7.1 Create `test/source_parser_test.dart` that writes tiny Dart sources to `Directory.systemTemp.createTempSync(...)` and asserts:
  - default class selection picks the class with the most supported methods
  - `className` override respects the request
  - getter / setter / operator declarations are parsed with the correct `MethodKind`
  - factory constructor and static method are surfaced (`isFactory`, `isStatic` flags set)
  - cleans up the temp dir in `tearDown`

## 8. cli_help.dart

- [x] 8.1 Create `test/cli_help_test.dart` that:
  - asserts `handleEarlyExitFlags(['--help'])`, `['-h']`, and `['--version']` return `true`; other inputs return `false`. Capture stdout (via `IOOverrides` or by redirecting if simple) only to a level that does not break parallel test output — easiest is to skip capture and just assert the return value
  - asserts `resolveVersion()` matches the version in `pubspec.yaml` (read the file in the test for the expected literal)

## 9. Final verification

- [x] 9.1 Run `dart test` and confirm the full suite (existing + new) passes
- [x] 9.2 Run `dart analyze` and confirm no new warnings are introduced by the test files
