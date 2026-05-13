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

Application-layer orchestration (what steps run, in what order, and how errors aggregate) SHALL NOT contain low-level string formatting for generated Dart tests or direct subprocess/isolate spawn code; those mechanisms SHALL live behind dedicated components or port implementations callable from orchestration.

#### Scenario: Pipeline orchestration reads as a sequence of use-case steps

- **WHEN** a maintainer reads the primary “generate from CLI” orchestration entry
- **THEN** it is expressed as coordination of named operations (parse, snapshot, sample, emit, check) rather than inlined low-level I/O and string building for the entire flow
- **AND** at least one mechanism type previously inlined is relocated behind a port or cohesive service type

### Requirement: Composition root clarity

The package SHALL have a clearly identified composition root (for example `bin/dart_test_gen.dart` plus a small wiring type) that constructs concrete infrastructure adapters and injects them into application-level APIs, rather than constructing adapters scattered across domain types.

#### Scenario: Wiring is localized

- **WHEN** a contributor needs to swap a fake filesystem or runner for tests
- **THEN** they can construct alternate adapter instances at the composition root or test harness without modifying domain types
- **AND** production wiring is concentrated in one or a small number of factory/builder types
