## ADDED Requirements

### Requirement: Barrel files group related `lib/src` exports

The package SHALL provide documented barrel libraries under `lib/src/` (for example per layer or feature area) that re-export cohesive sets of types and functions so callers can import stable `package:dart_test_gen/src/...` URIs instead of deep file paths.

#### Scenario: Barrels avoid export cycles

- **WHEN** maintainers add or adjust barrel exports
- **THEN** the dependency graph among barrel and implementation libraries remains acyclic (no circular `export` chains that prevent compilation)
- **AND** any cycle risk is resolved by splitting barrels or importing concrete implementation libraries directly from leaves

### Requirement: Internal code uses `package:` imports

Libraries under `lib/` and `lib/src/` SHALL import other in-package libraries using `package:dart_test_gen/...` URIs, including imports satisfied through barrel files, rather than relative paths that traverse multiple parent directories (for example `../../..`).

#### Scenario: Cross-layer imports use package URIs

- **WHEN** code under `lib/src/application/` imports infrastructure or domain types from another subdirectory of `lib/src/`
- **THEN** the import URI begins with `package:dart_test_gen/`
- **AND** relative imports are limited to same-directory or nearest-neighbor cases only where a package URI would be redundant and the design document explicitly allows it

#### Scenario: Public entrypoints re-export through stable paths

- **WHEN** a consumer imports a supported public library such as `package:dart_test_gen/snapshot.dart`
- **THEN** the same public symbols remain available as before the change (no **BREAKING** removals without migration notes)
- **AND** internal refactors do not require consumers to switch to new deep `lib/src/...` paths unless a new supported export path is documented
