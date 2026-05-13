## Requirements

### Requirement: Generator module abstraction

The codebase SHALL define a generator module abstraction (interface or sealed family of types) that describes how a code generator participates in the tool: identity, required inputs, execution, and structured outcomes. The existing snapshot-driven unit test path SHALL be expressible as one implementation of this abstraction.

#### Scenario: Built-in generator is a module implementation

- **WHEN** the default “generate unit tests from snapshots” flow runs
- **THEN** it is invoked through the generator module abstraction rather than ad hoc static calls scattered through CLI-only code
- **AND** the module has a stable programmatic identifier distinct from its user-visible label

### Requirement: Module registration

The composition root SHALL register every in-repo generator module in one place (for example a list or map populated at startup), so adding a new first-party generator is a localized change (new implementation class + registration entry) without editing unrelated orchestration internals.

#### Scenario: Adding a module is a bounded edit

- **WHEN** a contributor adds a hypothetical future generator module implementation in its own library unit
- **THEN** integrating it requires updating the registration site and any CLI flags that select among modules
- **AND** they do not need to fork the entire pipeline file to add a sibling module

### Requirement: Structured inputs and outputs

Each generator module SHALL accept structured inputs (for example resolved paths, package name, configuration object) rather than ad hoc primitive parameter lists duplicated at each call site, and SHALL return or surface structured results (success with artifacts, or typed failures) suitable for CLI rendering without leaking raw exceptions across layer boundaries as the primary control flow.

#### Scenario: CLI maps module results to user messages

- **WHEN** a module completes with a structured failure (for example snapshot runner failure)
- **THEN** the CLI or presentation layer maps that result to stderr/stdout messaging using existing user-facing formatters where applicable
- **AND** the module contract documents which fields are safe for user display versus internal diagnostics

### Requirement: Coexistence without new products

This change SHALL NOT ship additional end-user generator products (such as `bloc_gen` or `golden_gen`). The contract and registration mechanism MUST be validated by the existing built-in module and tests; optional test doubles MAY illustrate a second module in `test/` only if needed to prove extensibility, and MUST NOT change default CLI behavior.

#### Scenario: Default CLI unchanged

- **WHEN** a user runs the tool with the same arguments supported before this change
- **THEN** generated outputs and exit codes remain consistent with unchanged behavioral specs (for example `cli-entrypoint` and existing generation specs)
- **AND** no new generator product is exposed as a default or documented primary workflow in this change
