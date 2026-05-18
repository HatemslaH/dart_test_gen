## 1. Split `test_generator.dart` (god-file 1.1)

- [x] 1.1 Create `lib/src/domain/models/enums.dart` with `MethodKind`, `ParamType`
- [x] 1.2 Create `lib/src/domain/models/test_models.dart` with `Param`, `TestCaseRow`, `MethodSpec`
- [x] 1.3 Create `lib/src/domain/services/boundary_case_generator.dart`; move `generateBoundaryCases` and `_boundaryValues` (pure logic only)
- [x] 1.4 Create `lib/src/infrastructure/codegen/test_file_renderer.dart`; move all `_render*` helpers and `generateTestFile`
- [x] 1.5 Replace `lib/test_generator.dart` with re-exports / thin facade; update all imports; run `dart test`

## 2. Split `snapshot.dart` (god-file 1.2)

- [x] 2.1 Create `lib/src/domain/models/snapshot_models.dart` with `SnapshotRow`, `MethodSnapshot`, `SnapshotRunnerFailure`
- [x] 2.2 Create `lib/src/infrastructure/serialization/json_decoder.dart`; move `dartLiteralFromJson`, `dartLiteralFromJsonLoose`, `_mergeDecoded`
- [x] 2.3 Create `lib/src/infrastructure/codegen/snapshot_runner_generator.dart`; move runner `StringBuffer` codegen from `runSnapshots`
- [x] 2.4 Slim `lib/snapshot.dart` to I/O + coordination only; update imports; run `dart test`

## 3. Split `source_parser.dart` (god-file 1.3)

- [x] 3.1 Create `lib/src/domain/models/parsed_models.dart` with `ParsedMethod`, `ClassInfo`, `ParsedClass`
- [x] 3.2 Create `lib/src/infrastructure/ast/dart_ast_parser.dart`; move `parseLibraryClassOptional`, `_collectAllClasses`, `collectEnumLiterals`
- [x] 3.3 Create `lib/src/infrastructure/io/package_path_resolver.dart`; move `findPackageRootForFile`, `packageImportUri`, `readPackageName`
- [x] 3.4 Replace `lib/source_parser.dart` with re-exports; update imports; run `dart test`

## 4. Fix layer violations (2.1–2.3)

- [x] 4.1 In `snapshot_unit_test_generation.dart`, remove `cli_log` import; return dry-run text; print from CLI orchestrator
- [x] 4.2 In `cli_args.dart`, remove `exit(64)`; throw `InvalidCliArgumentsException`; catch in CLI and exit there
- [x] 4.3 Make `GeneratorConfig` a plain data class; add `ConfigReader` port + `config_loader.dart`; wire in `AppDependencies`; run `dart test`

## 5. Abstract process execution (issue 3)

- [x] 5.1 Add `lib/src/domain/ports/process_runner.dart` and `lib/src/infrastructure/io/io_process_runner.dart`
- [x] 5.2 Inject `ProcessRunner` into snapshot flow; replace `Process.runSync` in `lib/snapshot.dart`
- [x] 5.3 Register `IoProcessRunner` in composition root (`AppDependencies` / orchestrator); run `dart test`

## 6. Move files to correct layers (4.1–4.2)

- [x] 6.1 Move `dynamic_input_generator.dart` to `lib/src/domain/services/`; move `method_logic_analyzer.dart` to `lib/src/infrastructure/ast/` (analyzer dependency); fix imports; run `dart test`
- [x] 6.2 Move `snapshot_failure_formatting.dart` to `lib/src/cli/`; fix imports; run `dart test`

## 7. Clean public API (issue 5)

- [x] 7.1 Move `resolved_dependencies.dart` → `lib/src/infrastructure/analyzer/library_path_resolver.dart`; update imports; delete or re-export shim
- [x] 7.2 Verify `lib/snapshot.dart` and test generator facade contain no infrastructure implementation; run `dart test`

## 8. Simplify `generate_pipeline.dart` (issue 6)

- [x] 8.1 Relocate `dartFilesUnderDirectory`, `expandGenerationTargets`, `testOutputPathForLib`, `shortLibLabel` to owning module (`snapshot_unit_test_generation.dart`); `GeneratePipeline` static methods delegate to that module + default I/O
- [x] 8.2 Remove re-exports of internal types from `generate_pipeline.dart`; fix consumer imports; run `dart test`

## 9. Naming and CLI cleanup (issues 7, 10, 11)

- [x] 9.1 Rename CLI files: `cli_log` → `log`, `cli_progress` → `progress`, `cli_help` → `help` (under `lib/src/cli/`); update imports and any `package:` shims
- [x] 9.2 Add `version_resolver.dart` and `early_exit_handler.dart`; slim `help.dart` to help text only
- [x] 9.3 Rename `lib/test_generator.dart` → `lib/boundary_test_generator.dart` with backward-compatible export if needed
- [x] 9.4 Delete `lib/src/cli/cli.dart` barrel; fix imports (no barrel existed)
- [x] 9.5 Evaluate `SnapshotUnitTestGeneratorModule`—inline if pure delegate or document retention; run `dart test`

## 10. `SnapshotRunContext` and explicit `allFileClasses` (issues 8–9)

- [x] 10.1 Add `SnapshotRunContext`; change `runSnapshots` to accept context; update call sites
- [x] 10.2 Pass `List<ClassInfo> allFileClasses` to runner codegen and JSON decoder; stop passing full `ParsedClass` where unnecessary; run `dart test`

## 11. Final validation

- [x] 11.1 Run full `dart test`; fix any failures before proceeding
- [x] 11.2 Grep `lib/src/domain` and `lib/src/application` for `dart:io` and `package:analyzer` (must be clean)
- [x] 11.3 Manual CLI spot-check on `example/` (`--dry-run`, normal run, `--check`) and confirm output matches pre-refactor behavior (covered by `test/dry_run_and_check_test.dart` and CLI smoke tests)
- [x] 11.4 Update `lib/src/README.md` if paths changed; document moved files in commit message
