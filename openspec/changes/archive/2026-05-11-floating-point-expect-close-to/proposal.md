## Why

Generated tests compare `double` results with `expect(actual, expected)` using literals from the snapshot runner. Arithmetic and transcendentals can differ slightly across platforms and SDK versions, so tests may flake even when behavior is acceptable. README roadmap item 7 calls for optional `closeTo` / epsilon-style assertions.

## What Changes

- When comparing **snapshot** `double` (and optionally `Future<double>` / `Stream` of doubles) success cases, optionally emit `expect(actual, closeTo(expected, epsilon))` (or equivalent) instead of exact equality.
- **Configuration**: extend `dart_test_gen.yaml` and CLI (e.g. `--double-epsilon` or nested under `expect:` / `doubles:`) with sensible defaults; ability to disable and keep exact `expect` for backward compatibility.
- **Documentation**: README TODO item 7 marked done once implemented; brief note on when to tune epsilon.
- **Regression usecase**: new `lib/usecases/.../` showcase with methods whose results are intentionally sensitive to FP order (e.g. repeated additions, division) so generated tests exercise the new path.

## Capabilities

### New Capabilities

- `floating-point-expectations`: Requirements for detecting `double` snapshot outcomes, generating stable matchers, and YAML/CLI controls (default epsilon, per-method overrides if consistent with existing `methods:` overrides).
- `usecase-floating-point-stability`: Requirements for a dedicated showcase library under `lib/usecases/` and generated tests that validate the feature end-to-end.

### Modified Capabilities

- (none) — existing `openspec/specs/snapshot-type-extensions/spec.md` covers static/factory/extension types, not FP assertions; no delta required unless we later fold this into a broader “test emission” spec.

## Impact

- `lib/test_generator.dart` — success-test rendering for `double` (and async/stream unwrap where the compared value is `double`).
- `lib/generate_pipeline.dart` / config loading — new options merged with `dart_test_gen.yaml`.
- Possible small changes in `lib/snapshot.dart` only if metadata is needed to tag “this expected is double”; likely inferrable from `MethodSpec.snapshotReturnType`.
- New files under `lib/usecases/<showcase>/` and matching `test/usecases/...` after generation (tasks will name paths explicitly).
