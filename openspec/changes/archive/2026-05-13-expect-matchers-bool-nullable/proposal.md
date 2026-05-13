## Why

Generated tests use `expect(actual, expected)` for every return type, including `bool` and nullable results. The Dart test package offers clearer, more idiomatic matchers (`isTrue`, `isFalse`, `isNull`) that read better in failures and match common community style. README-style examples in generated code should prefer these matchers when the expected value is a compile-time literal.

## What Changes

- When the snapshot expected value is **`true` or `false`**, emit `expect(actual, isTrue)` or `expect(actual, isFalse)` instead of introducing an `expected` local and `expect(actual, expected)`.
- When the expected value is **null** (nullable return type with null literal), emit `expect(actual, isNull)` instead of `expect(actual, expected)` with a null `expected` binding.
- **Configuration** (default **on**): `use_expect_matchers_bool_null` (bool) in `dart_test_gen.yaml` at file root and under `methods: <name>:` (same pattern as `use_close_for_double`). CLI: `--expect-matchers-bool-null` / `--no-expect-matchers-bool-null` to force on or off for the run. When disabled, generation SHALL match today’s style (`final expected = …;` and `expect(actual, expected)`) for bool and null literals. CLI overrides YAML when a flag is present (same precedence model as existing sampling / `double` options).
- No change to runtime semantics; generated tests remain equivalent. Not a breaking change for consumers of the tool output (only emitted source shape changes; default preserves the new matcher style).

## Capabilities

### New Capabilities

- `expect-matchers-bool-null`: Requirements for detecting bool and null literal expectations in generated success assertions and emitting the corresponding `matcher` forms from `package:test/test.dart`.

### Modified Capabilities

- (none) — no existing OpenSpec capability defines assertion emission for primitives vs matchers; this is new surface area.

## Impact

- Test emission / code generation (`lib/test_generator.dart` and success-path emission).
- `lib/gen_config.dart` — `MethodConfig` (or equivalent) default and YAML parsing; root and optional per-method `methods:` entries.
- `lib/generate_pipeline.dart` — `parseCliArgs`, merge with loaded `GeneratorConfig`, usage text.
- `lib/cli_help.dart` — English help lines for the new flags.
- Golden or snapshot expectations in `example/test/usecases/` after regeneration (e.g. `calculator_test.dart` groups like `isEven`).
- Unit tests for the generator that assert on emitted Dart source strings or integration fixtures.
