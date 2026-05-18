## ADDED Requirements

### Requirement: `lib/src` files have a single primary responsibility

Each library file under `lib/src/` SHALL expose one primary concern (for example one service type, one code generator, one model cluster, or one port abstraction). Ancillary private top-level functions MAY exist in the same library only when they are narrowly scoped helpers for that primary concern and kept small enough that the file remains readable without unrelated imports.

#### Scenario: Snapshot orchestration is not embedded in a public facade

- **WHEN** a maintainer searches for snapshot runner orchestration (temp runner file, `ProcessRunner` invocation, JSON decode of stdout)
- **THEN** that logic resides under `lib/src/` in dedicated module(s), not in `lib/snapshot.dart`
- **AND** `lib/snapshot.dart` SHALL remain limited to exports and thin forwarding per the internal layers specification

#### Scenario: Helpers live with their feature

- **WHEN** a private helper exists solely to support one public operation (for example verbose logging for snapshot runs)
- **THEN** it SHALL live in the same `lib/src/` module as that operation or a clearly named adjacent helper library under the same feature folder
- **AND** it SHALL NOT accumulate in a public `lib/*.dart` facade file

### Requirement: Public `lib` facades delegate substantive work

Top-level `lib/*.dart` entrypoints SHALL NOT contain multi-step orchestration bodies or private implementation helpers; they SHALL delegate to `lib/src/` via `package:` imports (optionally via barrels).

#### Scenario: Facades are skim-readable

- **WHEN** a new contributor opens any `lib/*.dart` file intended as a package entrypoint
- **THEN** they can understand the exported surface without scrolling through orchestration or helper implementations
- **AND** any remaining top-level functions are forwarding wrappers of negligible line count
