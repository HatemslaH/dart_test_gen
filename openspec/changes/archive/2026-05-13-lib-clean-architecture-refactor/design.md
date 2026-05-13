## Context

`dart_test_gen` today centers on `generate_pipeline.dart`, which mixes orchestration (CLI args, isolates, `--check`, progress callbacks) with mechanics (snapshot subprocesses, sampling, file writes) and pulls in `source_parser.dart`, `snapshot.dart`, `sampling.dart`, and `test_generator.dart` in a relatively flat graph. `test_generator.dart` also holds a large amount of domain-ish modeling (params, method specs, rows) alongside emission concerns. That worked for a single product (snapshot-based unit tests) but makes it harder to add orthogonal generator kinds (for example a future `bloc_gen` or `golden_gen`) without copy-pasting pipeline patterns or growing one mega-file.

Constraints: keep the package dependency footprint light; preserve existing CLI and generation behavior as the acceptance bar; prefer incremental extraction over a risky rewrite; Dart 3.3+.

## Goals / Non-Goals

**Goals:**

- Establish **clear layers** (names and dependency direction) so contributors know where code belongs.
- Introduce a **generator module contract** and **registration** so new first-party or experimental generators plug in at defined seams.
- **Separate orchestration from infrastructure** (I/O, isolates, analyzer file access) from pure decisions and string emission where practical.
- Maintain **backward-compatible** `package:dart_test_gen/...` imports unless an explicit **BREAKING** decision is recorded and semver-handled.

**Non-Goals:**

- Implementing `bloc_gen`, `golden_gen`, or any new generator product.
- Introducing a heavyweight DI framework or code generation for wiring.
- Changing user-visible flags or default output format except as required by bugfixes discovered during refactor (any such change would need spec alignment).

## Decisions

### 1. Layer model (recommended default)

Use a small, explicit four-layer model mapped to folders under `lib/` (exact folder names to be finalized during implementation, example below):

```
┌─────────────────────────────────────────────────────────────┐
│  entry / presentation (bin/, thin lib exports)             │
│       │                                                     │
│       ▼                                                     │
│  application (orchestration: “run pipeline”, use cases)     │
│       │                                                     │
│       ▼                                                     │
│  domain + ports (models, policies, abstract ports)           │
│       ▲                                                     │
│       │ implements                                         │
│  infrastructure (analyzer FS, Process/Isolate, path IO)    │
└─────────────────────────────────────────────────────────────┘
```

**Rationale:** Matches Clean Architecture dependency rule without over-abstracting. Alternatives considered: (a) only two folders `core/` and `io/`—rejected as too vague for new contributors; (b) feature-first folders (`test_gen/`, `bloc_gen/`)—premature until a second product exists, but **registration** can still group by feature later inside `application/`.

### 2. Generator module as a narrow interface

Define something akin to:

- **Identity**: stable `id` string or enum for dispatch.
- **Run contract**: single method accepting a **context object** (paths, `GeneratorConfig`, verbosity flags) returning a **result** (success with written paths / content handles, or typed failure).
- **CLI selection**: optional future `--generator <id>`; until needed, only the built-in id is registered.

**Rationale:** One interface beats N parallel top-level functions. Alternative: separate packages per generator—valid long term, but out of scope; in-repo registration still benefits from a shared contract.

### 3. Composition root

Centralize construction of concrete adapters (real filesystem, real isolate runner) in one place (for example `lib/src/wiring/` or next to `generateFromCli` after split) and pass interfaces into orchestration.

**Rationale:** Makes tests swap fakes without touching domain. Alternative: service locator singleton—rejected for testability and hidden coupling.

### 4. Incremental migration strategy

Move code in **vertical slices** (e.g. extract “snapshot runner” port + adapter first, then “emit tests” service) rather than renaming everything at once. Keep `bin/dart_test_gen.dart` stable; if `lib/` files move, provide **temporary** `export` shims in old paths if needed for compatibility.

**Rationale:** Reduces merge conflict pain and keeps CI green. Alternative: big-bang directory move—higher risk.

### 5. Public API surface

Prefer moving implementation to `lib/src/**` and exporting a narrow façade from `lib/*.dart` files that today are imported by consumers. If any type is clearly internal, stop exporting it in a later semver minor only after checking pub.dev dependents (if any).

**Rationale:** Clean layering should not surprise downstream importers.

## Risks / Trade-offs

- **[Risk] Over-abstraction** → Mitigation: introduce ports only at pain points (I/O, isolate, large pure functions worth testing); reject speculative interfaces.
- **[Risk] Merge conflicts during long moves** → Mitigation: small PR-sized slices; re-export shims during transition.
- **[Risk] Performance regression** → Mitigation: no extra isolates or allocations on hot paths without measurement; keep async boundaries identical unless profiling justifies change.
- **[Trade-off] “Clean” vs. speed of delivery** → Accept slightly imperfect layering in the first pass if specs are satisfied; capture follow-ups in tasks.

## Migration Plan

1. Land folder structure and **empty** or thin module interface + registration with only the current generator registered (behavior unchanged).
2. Extract infrastructure adapters one at a time behind ports; update tests to use fakes where valuable.
3. Remove dead code and temporary re-exports once no internal imports reference old paths.
4. If **BREAKING** exports are unavoidable: bump semver per `pubspec.yaml`, document in changelog, and update any in-repo imports.

Rollback: revert slice-by-slice via git; no data migrations.

## Open Questions

- Whether to introduce `--generator` in this change or defer until a second module exists (proposal leans **defer**; registration can be internal-only first).
- Whether any types in `test_generator.dart` should become a published mini-API for plugin authors or stay private in `src/`.

### Resolved (implementation)

- **Folder layout** under `lib/src/`: `domain/`, `ports/`, `application/`, `infrastructure/`, `generators/`, `wiring/`. Public `package:dart_test_gen/generate_pipeline.dart` remains the façade with `export` of selected `src/` APIs.
