## ADDED Requirements

### Requirement: Showcase library for floating-point generation

The repository SHALL include a new usecase package path under `lib/usecases/` dedicated to floating-point-heavy APIs that benefit from `closeTo` when the generator option is enabled.

#### Scenario: Library layout

- **WHEN** the change is complete
- **THEN** there SHALL be at least one Dart library file under `lib/usecases/<showcase-folder>/` exporting a public class with one or more public methods returning `double` or `Future<double>`
- **THEN** methods SHALL use arithmetic patterns that are realistic regression targets (e.g. repeated addition, chained division), not only trivial constants

### Requirement: Generated tests for the showcase

Running the generator against the showcase entry file with close-to mode enabled SHALL produce a test file that compiles and passes under `dart test`.

#### Scenario: End-to-end generation

- **WHEN** the developer runs the generator on the showcase `lib` entry with appropriate configuration to enable `closeTo` for doubles
- **THEN** a mirror `test/usecases/<showcase-folder>/…_test.dart` SHALL be produced or updatable
- **THEN** `dart test` on that test file SHALL succeed
