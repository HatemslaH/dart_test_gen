## 1. Configuration model

- [x] 1.1 Extend `GeneratorConfig` / `MethodConfig` in `lib/gen_config.dart` with fields for `useCloseForDouble` (bool, default false) and `doubleEpsilon` (double, e.g. default `1e-9` when enabled), including YAML parsing and `copyWith` / `forMethod` behavior
- [x] 1.2 Add CLI flags in `lib/generate_pipeline.dart` (`parseCliArgs`, help text) to toggle close-to mode and set epsilon; merge into loaded `GeneratorConfig` before calling `generateSingleLibraryFile`
- [x] 1.3 Document YAML keys in README configuration example (alongside existing `strategy` / `methods` examples)

## 2. Test emission

- [x] 2.1 Thread the resolved per-method double-expect settings from `generate_pipeline.dart` into `generateTestFile` (new parameters or a small options object)
- [x] 2.2 Update `lib/test_generator.dart` so `_renderSuccessTest` emits `expect(actual, closeTo(expected, <epsilon>))` when enabled and `spec.snapshotReturnType == 'double'`, otherwise keep `expect(actual, expected)`; cover sync and async paths
- [x] 2.3 Add unit-level coverage if the repo has tests for the generator (or rely on integration via showcase + `dart test`)

## 3. Showcase usecase

- [x] 3.1 Add `lib/usecases/floating_point_showcase/floating_point_showcase.dart` with a public class and methods returning `double` / `Future<double>` that exercise non-trivial FP arithmetic
- [x] 3.2 Run the generator on that file with close-to enabled and commit the resulting `test/usecases/floating_point_showcase/floating_point_showcase_test.dart` (or document regeneration step if policy is not to commit generated files — follow existing repo convention for other showcases)

## 4. README and closure

- [x] 4.1 Mark README roadmap item **7** (floating-point stability) as completed and summarize the feature in the capabilities or configuration section
- [x] 4.2 Run `dart analyze` and `dart test` for the package root to confirm nothing regresses
