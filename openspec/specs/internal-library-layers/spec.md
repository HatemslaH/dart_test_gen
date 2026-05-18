# internal-library-layers Specification

## Purpose

Document how `dart_test_gen` splits `lib/` into layers (CLI, application, domain, infrastructure) and dependency rules so refactors stay consistent.
## Requirements
### Requirement: Documented internal layers

The `lib/` implementation SHALL be organized into documented internal layers (for example entry/CLI, application orchestration, domain/core models and policies, and infrastructure adapters) such that each source file has an obvious primary layer.

#### Scenario: Layer assignment is discoverable

- **WHEN** a contributor opens a new or moved source file under `lib/`
- **THEN** they can determine the file’s layer from path and/or adjacent `README` or architecture note referenced from the change tasks
- **AND** the change’s design document names the layers and their responsibilities

### Requirement: Inward dependency rule

Domain-layer and port-interface types SHALL NOT depend on infrastructure concerns, specifically: no imports of `dart:io` (except where a port’s signature is intentionally platform-agnostic and implemented elsewhere—prefer avoiding `dart:io` in domain entirely), no `dart:isolate`, and no direct `package:analyzer` plugin/driver setup tied to the filesystem from domain-layer code.

#### Scenario: Domain code stays free of I/O imports

- **WHEN** static analysis or code review inspects domain-layer and port interface files
- **THEN** those files do not import `dart:io`, `dart:isolate`, or filesystem-bound analyzer driver types
- **AND** filesystem and process execution live in infrastructure adapters or CLI layers

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

### Requirement: Composition root clarity

The package SHALL have a clearly identified composition root (for example `bin/dart_test_gen.dart` plus a small wiring type) that constructs concrete infrastructure adapters and injects them into application-level APIs, rather than constructing adapters scattered across domain types.

#### Scenario: Wiring is localized

- **WHEN** a contributor needs to swap a fake filesystem or runner for tests
- **THEN** they can construct alternate adapter instances at the composition root or test harness without modifying domain types
- **AND** production wiring is concentrated in one or a small number of factory/builder types

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

