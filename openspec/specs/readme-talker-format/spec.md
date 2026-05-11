## Requirements

### Requirement: README is scan-friendly and talker-inspired

The repository `README.md` MUST follow a scan-friendly structure inspired by the `talker` README, with a short pitch at the top and progressively deeper sections below.

#### Scenario: New user landing experience

- **WHEN** a user opens the repository root `README.md`
- **THEN** the first screen MUST communicate what the tool does in 1–2 sentences and how to try it quickly

### Requirement: README contains a minimal Quick Start

The `README.md` MUST include a “Quick Start” section with copy/paste commands that work from a package root containing `pubspec.yaml`.

#### Scenario: Generate tests for a single file

- **WHEN** the user follows the Quick Start “single file” command
- **THEN** the example MUST use `dart pub get` and `dart run dart_test_gen <path>` and reference a plausible `lib/...` input file

#### Scenario: Generate tests for a directory

- **WHEN** the user follows the Quick Start “directory” command
- **THEN** the example MUST show running the generator on a directory under `lib/`

### Requirement: README documents CI usage and determinism flags

The `README.md` MUST include a “CI” (or “CI & determinism”) section that documents how to use `--check` and `--dry-run` and what they guarantee.

#### Scenario: CI check for generated tests

- **WHEN** a user wants to ensure generated tests are up-to-date in CI
- **THEN** the README MUST describe `--check` as a mode that compares generated output with committed tests and fails non-zero on mismatch

#### Scenario: Smoke-check without writing files

- **WHEN** a user wants to validate generation without modifying the working tree
- **THEN** the README MUST describe `--dry-run` as a mode that performs the pipeline but does not write test files

### Requirement: README provides a navigable table of contents

The `README.md` MUST include a table of contents that links to the main sections.

#### Scenario: Navigating to reference sections

- **WHEN** a user uses the table of contents links
- **THEN** each link MUST scroll to a matching section heading in the README

### Requirement: README retains a CLI options reference

The `README.md` MUST include a section that lists key CLI flags and their purpose.

#### Scenario: Finding CLI options

- **WHEN** a user searches for CLI options in the README
- **THEN** the README MUST list the primary flags currently supported (including `--class`, `--strategy`, `--max-cases`, `--seed`, `--config`, `--keep-runner`, `--dry-run`, `--check`, `--use-close-for-double`, `--double-epsilon`)
