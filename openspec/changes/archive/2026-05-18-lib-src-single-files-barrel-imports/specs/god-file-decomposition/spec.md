## MODIFIED Requirements

### Requirement: Snapshot module split into models, serialization, and codegen

The snapshot implementation SHALL move DTOs (`SnapshotRow`, `MethodSnapshot`, `SnapshotRunnerFailure`) to `lib/src/domain/models/snapshot_models.dart`; JSON-to-Dart literal decoding (`dartLiteralFromJson`, `dartLiteralFromJsonLoose`, merge helpers) to `lib/src/infrastructure/serialization/json_decoder.dart`; snapshot runner source generation (the `StringBuffer` block inside `runSnapshots`) to `lib/src/infrastructure/codegen/snapshot_runner_generator.dart`; and SHALL move snapshot runner execution orchestration (temporary runner file lifecycle, invoking the configured `ProcessRunner`, decoding stdout into snapshots, progress reporting hooks, failure translation) into dedicated libraries under `lib/src/` so that `lib/snapshot.dart` remains a thin export facade.

#### Scenario: Snapshot public entrypoint stays thin

- **WHEN** a maintainer reads the public `lib/snapshot.dart` (or its renamed facade) after decomposition
- **THEN** it SHALL contain only exports and at most thin forwarding wrappers to `lib/src/` APIs
- **AND** it SHALL NOT contain inline runner codegen string building, JSON decoding implementation bodies, private helper implementations, or substantive orchestration for `runSnapshots`

#### Scenario: Snapshot behavior unchanged for consumers

- **WHEN** a consumer imports `package:dart_test_gen/snapshot.dart` and uses the supported snapshot APIs
- **THEN** externally observable behavior remains equivalent to the pre-change implementation except for internal module layout
