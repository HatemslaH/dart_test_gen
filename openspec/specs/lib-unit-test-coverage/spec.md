## ADDED Requirements

### Requirement: Unit tests for `sampling.dart`

The repository SHALL contain a test file `test/sampling_test.dart` that exercises `sampleTestCases` for every `SamplingStrategy` value and the mandatory/optional bucket split.

#### Scenario: full strategy truncates to maxCases
- **WHEN** `sampleTestCases` is called with strategy `full`, `maxCases = 3`, and 10 successful rows
- **THEN** the result contains exactly the first 3 of the optional rows (plus any mandatory rows)

#### Scenario: random strategy is deterministic with a seed
- **WHEN** `sampleTestCases` is called twice with strategy `random`, the same `maxCases`, the same `seed`, and the same input rows
- **THEN** both calls return identical lists

#### Scenario: happy_path strategy keeps one optional + all mandatory
- **WHEN** input contains 5 optional rows and 2 mandatory (throwing) rows under strategy `happy_path`
- **THEN** the result contains all 2 mandatory rows and exactly 1 optional row

### Requirement: Unit tests for `GeneratorConfig.load`

The repository SHALL contain a test file `test/gen_config_load_test.dart` that exercises `GeneratorConfig.load` for missing files, invalid YAML, custom config paths, per-method overrides, and the top-level `keep_runner` flag.

#### Scenario: Missing config file yields defaults
- **WHEN** `GeneratorConfig.load` is called against a directory that has no `dart_test_gen.yaml`
- **THEN** the returned config equals `const GeneratorConfig()` (defaults, `keepRunner = false`, empty methods)

#### Scenario: `keep_runner: true` is honored
- **WHEN** the YAML file contains `keep_runner: true` at the top level
- **THEN** `GeneratorConfig.load` returns a config with `keepRunner == true`

#### Scenario: Per-method overrides inherit then replace
- **WHEN** the YAML has top-level `max_cases: 30` and `methods: { divide: { strategy: happy_path } }`
- **THEN** `config.forMethod('divide').strategy == SamplingStrategy.happyPath`
- **AND** `config.forMethod('divide').maxCases == 30`
- **AND** `config.forMethod('other').maxCases == 30`

### Requirement: Unit tests for `parseCliArgs`

The repository SHALL contain a test file `test/cli_args_parser_test.dart` that asserts every documented flag is parsed into the corresponding record field with the expected value or `null`.

#### Scenario: All boolean and value flags are recognized
- **WHEN** `parseCliArgs(['lib/foo.dart', '--class', 'Foo', '-v', '--strategy', 'random', '--max-cases', '5', '--seed', '7', '--use-close-for-double', '--double-epsilon', '1e-6', '--config', 'cfg.yaml', '--keep-runner'])` is called
- **THEN** the returned record has `inputs == ['lib/foo.dart']`, `className == 'Foo'`, `verbose == true`, `strategy == 'random'`, `maxCases == 5`, `seed == 7`, `useCloseForDouble == true`, `doubleEpsilon == 1e-6`, `configPath == 'cfg.yaml'`, `keepRunner == true`

#### Scenario: Defaults when no flags
- **WHEN** `parseCliArgs(['lib/foo.dart'])` is called
- **THEN** flags that were not passed are `null` or `false` as appropriate (`className == null`, `verbose == false`, `strategy == null`, `keepRunner == null`)

### Requirement: Unit tests for path helpers in `generate_pipeline.dart`

The repository SHALL contain a test file `test/generate_pipeline_paths_test.dart` that exercises `testOutputPathForLib`, `shortLibLabel`, `dartFilesUnderDirectory`, and `expandGenerationTargets` against a temporary package layout.

#### Scenario: testOutputPathForLib mirrors lib structure
- **WHEN** called with `packageRoot = /tmp/pkg` and `absoluteLibPath = /tmp/pkg/lib/a/b.dart`
- **THEN** the result is `/tmp/pkg/test/a/b_test.dart`

#### Scenario: dartFilesUnderDirectory finds only `.dart` files recursively
- **WHEN** a temp directory contains `a.dart`, `sub/b.dart`, and `c.txt`
- **THEN** `dartFilesUnderDirectory(dir)` returns `[…/a.dart, …/sub/b.dart]` (sorted)

### Requirement: Unit tests for snapshot literals

The repository SHALL contain a test file `test/snapshot_literals_test.dart` that exercises `dartLiteralFromJson` and `dartLiteralFromJsonLoose` for every supported return type.

#### Scenario: Primitive literals
- **WHEN** `dartLiteralFromJson(42, 'int', [])` is called
- **THEN** it returns the string `'42'`
- **WHEN** `dartLiteralFromJson(1.5, 'double', [])` is called
- **THEN** it returns `'1.5'`
- **WHEN** `dartLiteralFromJson('a\'b', 'String', [])` is called
- **THEN** it returns `"'a\\'b'"`

#### Scenario: `Set<int>` is sorted
- **WHEN** `dartLiteralFromJson([3, 1, 2], 'Set<int>', [])` is called
- **THEN** the result equals `'{1, 2, 3}'`

#### Scenario: Enum payload
- **WHEN** the value is `{'_enumType': 'LogLevel', '_enumName': 'warn'}`
- **THEN** `dartLiteralFromJson(value, 'LogLevel', [])` returns `'LogLevel.warn'`

#### Scenario: User class via ClassInfo
- **WHEN** a `ClassInfo` for `Point` with positional params `['x', 'y']` is provided
- **AND** the value is `{'_type': 'Point', 'x': 1, 'y': 2}`
- **THEN** `dartLiteralFromJson(value, 'Point', [classInfo])` returns `'Point(1, 2)'`

### Requirement: Unit tests for `snapshotInvokeExpression`

The repository SHALL contain a test file `test/snapshot_invoke_expression_test.dart` covering every `MethodKind` variant.

#### Scenario: Method, getter, setter, and operator emission
- **WHEN** invoked with kinds `method`, `getter`, `setter`, and `operator_` (`+`, `[]`, `[]=`, `~`, unary `-`, binary `-`)
- **THEN** each returns the expected Dart expression (e.g. `c.foo(1, 2)`, `c.bar`, `c.baz = 7`, `c + 3`, `c[0]`, `c[0] = 9`, `~c`, `-c`)

### Requirement: Unit tests for `parseLibraryClassOptional`

The repository SHALL contain a test file `test/source_parser_test.dart` that exercises `parseLibraryClassOptional` on tiny inline Dart fixtures written to a temp directory.

#### Scenario: Picks the class with the most supported methods
- **WHEN** the source has class `Small { int a() => 0; }` and `Big { int a() => 0; int b() => 0; int c() => 0; }`
- **THEN** without `--class` the parsed class name is `Big`
- **AND** when `--class: 'Small'` is passed, the parsed class name is `Small`

#### Scenario: Detects getter/setter/operator kinds
- **WHEN** the source declares `int get foo => 0;`, `set foo(int v) {}`, and `int operator +(int o) => 0;`
- **THEN** the parsed methods include three entries whose `kind` values are `getter`, `setter`, and `operator_` respectively

### Requirement: Unit tests for `cli_help.dart` helpers

The repository SHALL contain a test file `test/cli_help_test.dart` that exercises `handleEarlyExitFlags` and `resolveVersion`.

#### Scenario: `handleEarlyExitFlags` recognizes `--help`, `-h`, and `--version`
- **WHEN** `handleEarlyExitFlags(['--help'])`, `handleEarlyExitFlags(['-h'])`, or `handleEarlyExitFlags(['--version'])` is called
- **THEN** each returns `true`
- **WHEN** `handleEarlyExitFlags(['lib/foo.dart'])` is called
- **THEN** it returns `false`

#### Scenario: `resolveVersion` returns the pubspec version
- **WHEN** `resolveVersion()` is called with cwd at the repository root
- **THEN** the result equals the `version:` field of `pubspec.yaml`
