## 1. Configuration

- [x] 1.1 Add `useExpectMatchersBoolNull` to `MethodConfig` in `lib/gen_config.dart` with default **`true`**; parse YAML key `use_expect_matchers_bool_null` at root and under `methods:` (via existing `fromYaml` / merge); add `copyWith`.
- [x] 1.2 Extend `parseCliArgs` / return record in `lib/generate_pipeline.dart` with `bool? useExpectMatchersBoolNull`; support `--expect-matchers-bool-null` and `--no-expect-matchers-bool-null` (document in Russian usage block; if both appear, pick a deterministic rule e.g. last wins or reject — note in code comment).
- [x] 1.3 Merge CLI override into `GeneratorConfig` in `generateFromCli` when either flag is set (same pattern as `useCloseForDouble` / sampling).
- [x] 1.4 Document flags in `lib/cli_help.dart` (English help text).

## 2. Generator logic

- [x] 2.1 Pass effective `useExpectMatchersBoolNull` into `MethodSpec` (or equivalent) from `generate_pipeline.dart` when building `MethodSpec` from `MethodConfig`.
- [x] 2.2 Extend `_renderSuccessTest` in `lib/test_generator.dart`: when the flag is **false**, keep current `expected` + `expect(actual, expected)` for all literals including bool/null. When **true**, apply trimmed-literal detection for `null` / `true` / `false` with bool type gate as in design; omit `expected` only on matcher paths.
- [x] 2.3 Keep `closeTo` double branch and default `expect(actual, expected)` for other types; support sync and async bodies.

## 3. Verification

- [x] 3.1 Unit tests: matcher shape when flag true (default); legacy `final expected` shape when false (YAML-simulated or `MethodConfig` in test harness).
- [x] 3.2 Regenerate affected example tests (e.g. `example/test/usecases/calculator_test.dart` bool/null groups) via the project’s normal generate command so checked-in output matches **default-on** behavior.

## 4. Quality gate

- [x] 4.1 Run `dart analyze` / project test suite and fix any issues introduced by the change.
