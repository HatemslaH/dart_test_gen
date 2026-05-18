## ADDED Requirements

### Requirement: Package URIs for cross-directory internal imports

Libraries under `lib/` and `lib/src/` SHALL import other libraries in this package using `package:dart_test_gen/...` URIs when crossing directory boundaries between implementation folders, preferring documented barrel exports where they reduce coupling. Same-directory relative imports MAY be used only for tightly coupled split parts of a single feature, and any broader exception MUST be documented in `lib/src/README.md` (or the successor architecture note).

#### Scenario: Imports are navigable from entrypoints

- **WHEN** a contributor traces an import from `lib/snapshot.dart` into implementation code
- **THEN** the import chain uses `package:dart_test_gen/...` targets (including barrels) rather than long `../` chains across `lib/src`
- **AND** layer rules from this specification continue to hold (domain does not gain forbidden infrastructure imports)

## MODIFIED Requirements

### Requirement: Public lib entrypoints contain no infrastructure implementation

Top-level `lib/*.dart` files (except documented temporary re-export shims) SHALL contain only exports and thin forwarding wrappers to `lib/src/`—no private helper implementations, no multi-step orchestration bodies, and no code paths that import `package:analyzer`, perform `dart:io` file access, or build generated Dart source strings except as delegation into `lib/src/`.

#### Scenario: test_generator and snapshot entrypoints are thin

- **WHEN** reviewing `lib/test_generator.dart` (or `lib/boundary_test_generator.dart`) and `lib/snapshot.dart` after refactor
- **THEN** neither file contains private top-level function bodies, substantive implementation, or non-trivial orchestration beyond re-exports and short coordination glue delegated to `lib/src/`
- **AND** codegen, filesystem I/O, subprocess orchestration, and JSON decoding implementation bodies live under `lib/src/infrastructure/` or other appropriate `lib/src/` modules
