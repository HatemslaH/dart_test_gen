## ADDED Requirements

### Requirement: Opt-in closeTo for scalar double expectations

When enabled by configuration, the generator SHALL emit floating-point assertions using `closeTo` from `package:test/test.dart` for successful test cases whose compared value type is a scalar `double` (including `Future<double>` after await), instead of `expect(actual, expected)` with strict equality.

#### Scenario: Sync method returning double

- **WHEN** configuration enables close-to mode for doubles
- **WHEN** a method has `snapshotReturnType` of `double` and a successful snapshot row
- **THEN** the generated test SHALL compare `actual` to the snapshot literal using `closeTo` with the configured epsilon

#### Scenario: Async method returning Future of double

- **WHEN** configuration enables close-to mode for doubles
- **WHEN** a method is async and the awaited snapshot value is `double`
- **THEN** the generated test SHALL use `closeTo` with the configured epsilon for that comparison

#### Scenario: Feature disabled preserves exact equality

- **WHEN** close-to mode for doubles is disabled (default)
- **WHEN** a method returns `double` in a successful case
- **THEN** the generator SHALL emit `expect(actual, expected)` as today

### Requirement: Epsilon configuration

The system SHALL allow defining a positive absolute epsilon at the global default level and optional per-method override, loaded from `dart_test_gen.yaml` and overridable via CLI for a generation run.

#### Scenario: Global epsilon in YAML

- **WHEN** the user sets a global double epsilon in the configuration file
- **WHEN** close-to mode is enabled
- **THEN** generated `closeTo` calls SHALL use that epsilon unless a method-specific value applies

#### Scenario: Per-method epsilon override

- **WHEN** the user sets a method-specific epsilon under the existing per-method configuration map
- **WHEN** close-to mode is enabled for that method
- **THEN** the generated test for that method SHALL use the method-specific epsilon

#### Scenario: CLI overrides file defaults

- **WHEN** the user passes CLI flags for epsilon and/or enablement
- **THEN** those values SHALL take precedence over file defaults for that invocation

### Requirement: Documentation

The README SHALL mark roadmap item 7 (floating-point stability) as done once the feature ships, and SHALL describe how to enable close-to expectations and tune epsilon.

#### Scenario: User discovers the option

- **WHEN** the user reads the README TODO / configuration section
- **THEN** they SHALL find the new flags or YAML keys and intended use for unstable `double` snapshots
