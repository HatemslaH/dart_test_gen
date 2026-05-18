## ADDED Requirements

### Requirement: Concrete path conventions for decomposed modules

After god-file decomposition, source files SHALL follow these primary layer assignments: domain models under `lib/src/domain/models/`; domain services (pure logic) under `lib/src/domain/services/`; port interfaces under `lib/src/domain/ports/`; codegen and serialization under `lib/src/infrastructure/codegen/` and `lib/src/infrastructure/serialization/`; AST and analyzer adapters under `lib/src/infrastructure/ast/` and `lib/src/infrastructure/analyzer/`; filesystem and process adapters under `lib/src/infrastructure/io/`; config loading under `lib/src/infrastructure/config/`.

#### Scenario: New contributor finds code by concern

- **WHEN** a contributor needs to change JSON literal decoding for snapshots
- **THEN** they open `lib/src/infrastructure/serialization/json_decoder.dart` (or the documented equivalent)
- **AND** they do not search a monolithic `lib/snapshot.dart` for decoding logic

### Requirement: Public lib entrypoints contain no infrastructure implementation

Top-level `lib/*.dart` files (except documented temporary re-export shims) SHALL contain only exports, thin facades, or stable entry functions—no bodies that import `package:analyzer`, perform `dart:io` file access, or build generated Dart source strings.

#### Scenario: test_generator and snapshot entrypoints are thin

- **WHEN** reviewing `lib/test_generator.dart` (or `lib/boundary_test_generator.dart`) and `lib/snapshot.dart` after refactor
- **THEN** neither file contains substantial implementation beyond exports and coordination glue delegated to `lib/src/`
- **AND** codegen and I/O implementations live under `lib/src/infrastructure/`

## MODIFIED Requirements

### Requirement: Orchestration separated from mechanisms

Application-layer orchestration (what steps run, in what order, and how errors aggregate) SHALL NOT contain low-level string formatting for generated Dart tests, direct subprocess/isolate spawn code, or CLI presentation formatting; those mechanisms SHALL live in infrastructure codegen adapters, `ProcessRunner` implementations, or CLI modules callable from orchestration.

#### Scenario: Pipeline orchestration reads as a sequence of use-case steps

- **WHEN** a maintainer reads the primary “generate from CLI” orchestration entry
- **THEN** it is expressed as coordination of named operations (parse, snapshot, sample, emit, check) rather than inlined low-level I/O and string building for the entire flow
- **AND** snapshot runner string generation and subprocess execution are delegated to infrastructure types or ports

#### Scenario: Snapshot unit-test generation has no embedded codegen blocks

- **WHEN** reading `snapshot_unit_test_generation.dart` (or successor application module)
- **THEN** it does not contain large `StringBuffer` blocks that emit snapshot runner Dart source
- **AND** such blocks reside in `snapshot_runner_generator.dart` or equivalent infrastructure module
