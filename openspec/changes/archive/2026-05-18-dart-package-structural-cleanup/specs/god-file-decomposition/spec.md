## ADDED Requirements

### Requirement: Test generator split into domain and infrastructure

The boundary test generation implementation SHALL be decomposed from `lib/test_generator.dart` into: enum types in `lib/src/domain/models/enums.dart`; data classes (`Param`, `TestCaseRow`, `MethodSpec`) in `lib/src/domain/models/test_models.dart`; pure boundary-case logic (`generateBoundaryCases`, boundary value helpers) in `lib/src/domain/services/boundary_case_generator.dart`; and all rendering helpers plus `generateTestFile` in `lib/src/infrastructure/codegen/test_file_renderer.dart`.

#### Scenario: Public test generator entry is a facade

- **WHEN** a consumer imports the package test generator library entrypoint
- **THEN** they receive the same public types and functions as before the refactor
- **AND** the entrypoint file contains no rendering or boundary-algorithm implementation bodies (only exports and optional thin wrappers)

#### Scenario: Boundary logic has no I/O

- **WHEN** static analysis inspects `boundary_case_generator.dart`
- **THEN** that file does not import `dart:io`, `dart:isolate`, or `package:analyzer`
- **AND** it depends only on domain models and other pure domain code

### Requirement: Snapshot module split into models, serialization, and codegen

The snapshot implementation SHALL move DTOs (`SnapshotRow`, `MethodSnapshot`, `SnapshotRunnerFailure`) to `lib/src/domain/models/snapshot_models.dart`; JSON-to-Dart literal decoding (`dartLiteralFromJson`, `dartLiteralFromJsonLoose`, merge helpers) to `lib/src/infrastructure/serialization/json_decoder.dart`; and snapshot runner source generation (the `StringBuffer` block inside `runSnapshots`) to `lib/src/infrastructure/codegen/snapshot_runner_generator.dart`.

#### Scenario: Snapshot facade coordinates only

- **WHEN** a maintainer reads the public `lib/snapshot.dart` (or its renamed facade) after decomposition
- **THEN** it contains I/O and process coordination for `runSnapshots`
- **AND** it does not contain inline runner codegen string building or JSON decoding implementation bodies

### Requirement: Source parser split into models, AST, and path utilities

The source parsing implementation SHALL move domain models (`ParsedMethod`, `ClassInfo`, `ParsedClass`) to `lib/src/domain/models/parsed_models.dart`; pure AST helpers (`parseLibraryClassOptional`, class collection, `collectEnumLiterals`) to `lib/src/infrastructure/ast/dart_ast_parser.dart`; and package/path utilities (`findPackageRootForFile`, `packageImportUri`, `readPackageName`) to `lib/src/infrastructure/io/package_path_resolver.dart`.

#### Scenario: Source parser public API preserved

- **WHEN** package tests or internal modules import the source parser entrypoint
- **THEN** required parsing functions and model types remain available without behavior change
- **AND** the entrypoint does not embed AST-walking implementation bodies
