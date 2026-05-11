## Context

Today `_renderSuccessTest` in `test_generator.dart` always emits `expect(actual, expected)` with a numeric literal for `double` outcomes. The snapshot isolate serializes `double` via JSON (`snapshot.dart`); small platform or ordering differences can change the least significant bits and break CI. README item 7 asks for optional `closeTo` / epsilon comparisons.

`GeneratorConfig` / `MethodConfig` in `gen_config.dart` already merge YAML defaults with per-method overrides; CLI merges overrides in `generate_pipeline.dart`. `MethodSpec.snapshotReturnType` is already the unwrapped type for async (`Future<double>` → `double`) and stream (`Stream<double>` → `List<double>`).

## Goals / Non-Goals

**Goals:**

- Emit `closeTo` from `package:test/test.dart` when comparing **scalar** `double` success results (sync and async), using a configurable absolute epsilon.
- Default **off** for backward compatibility; when enabled, use a documented default epsilon (e.g. `1e-9`) unless overridden in YAML/CLI or per-method.
- Document YAML keys and CLI flags; add showcase usecase under `lib/usecases/`.

**Non-Goals:**

- Generic deep matchers for nested `List<double>` / `Map` with doubles (can be a follow-up; showcase can avoid `Stream<double>` if needed).
- Relative error (`closeTo` is absolute in `matcher`); ULP-based comparison.
- Changing snapshot JSON encoding of doubles.

## Decisions

1. **Default on vs off**  
   **Chosen: default `off`** (`use_close_for_double: false` or absent) so existing generated tests and golden workflows do not change until the user opts in. README still satisfied because the capability exists and is documented.  
   **Alternative:** default `on` — better out-of-the-box stability but changes regenerated output for every `double` test.

2. **Where to branch**  
   In `_renderSuccessTest` (and any shared helper), when `spec.snapshotReturnType == 'double'` and config says use close-to, emit:
   `expect(actual, closeTo(expected, <epsilon-expr>));`  
   with `expected` still a `final` from the snapshot literal (same as today). No change to snapshot runner output format.

3. **Epsilon source**  
   Root YAML `double_epsilon: <num>` (or nested `double_expect: { enabled, epsilon }` — pick one style and use consistently in tasks). Per-method: extend `MethodConfig` with optional `doubleEpsilon` / inherit from defaults, mirroring `max_cases` pattern.

4. **CLI**  
   `--double-epsilon <num>` and `--use-close-for-double` (boolean flag) mirroring other sampling flags; merged into `GeneratorConfig` before isolate spawn. Invalid values → stderr + exit non-zero or fall back with warning (prefer strict parse for epsilon).

5. **Nullable `double?`**  
   If snapshot type is `double?` (if parser emits it), keep exact equality for `null` branches; only apply `closeTo` when the comparison is non-null double. If the generator does not support `double?` return today, note as non-issue until supported.

6. **Showcase**  
   New library e.g. `lib/usecases/floating_point_showcase/floating_point_showcase.dart` with a small class: methods like `sumMany(double x, int n)`, `divideChain` so regenerated tests demonstrate `closeTo` when config enabled.

## Risks / Trade-offs

- **[Risk] Epsilon too tight** → still flakes; **mitigation:** document tuning; per-method override.  
- **[Risk] Epsilon too loose** → hides real bugs; **mitigation:** keep default epsilon small; users choose opt-in.  
- **[Risk] `closeTo` with NaN/infinity** → matcher behavior; **mitigation:** if snapshot literals include non-finite values, keep exact `expect` or document limitation.

## Migration Plan

1. Ship code + docs with feature **disabled** by default.  
2. Users who hit flakes opt in via `dart_test_gen.yaml` and regenerate tests.  
3. No database or file migration.

## Open Questions

- Exact YAML shape (flat vs `double_expect:` block) — align with existing snake_case keys in `dart_test_gen.yaml`.  
- Whether to support `List<double>` from `Stream<double>` in the same change (recommend deferral unless trivial).
