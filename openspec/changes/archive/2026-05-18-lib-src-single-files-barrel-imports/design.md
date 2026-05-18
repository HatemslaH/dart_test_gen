## Context

`dart_test_gen` already split many “god file” concerns into `lib/src/` with domain, application, and infrastructure folders. Some public `lib/*.dart` files still host sizeable top-level logic and private helpers (for example `runSnapshots` and friends in `lib/snapshot.dart`), and much of the tree uses relative imports into `src/...`. Contributors asked for **one file / one primary concern** under `lib/src/`, **moving global helpers out of facades**, and **barrels + `package:` imports** for consistency and navigation.

## Goals / Non-Goals

**Goals:**

- Relocate remaining substantive top-level implementation from `lib/*.dart` into appropriate `lib/src/` modules, split so each file has a clear primary responsibility.
- Introduce or extend **barrel** libraries under `lib/src/` to group exports and stabilize import targets.
- Standardize **in-package** imports on `package:dart_test_gen/...` (via barrels where helpful), minimizing long relative paths across layers.
- Keep the **external package API** stable: same entry libraries and symbols for normal consumers unless a change is explicitly marked **BREAKING** with migration steps.

**Non-Goals:**

- Rewriting algorithms, snapshot JSON format, or CLI UX.
- Renaming public types or moving symbols to new public entry files without a compatibility story.
- Enforcing package URIs inside `test/` or `example/` if those folders are out of scope for this change (optional follow-up).

## Decisions

1. **Where snapshot orchestration lives** — Move `runSnapshots` orchestration (temp runner path, `ProcessRunner`, progress hooks, failure mapping) into `lib/src/application/` (preferred if it composes ports) or `lib/src/infrastructure/` if classified purely as I/O orchestration. Rationale: satisfies “orchestration not in public facade” while reusing existing `ProcessRunner` port. Alternative considered: keep in `lib/snapshot.dart` as “coordination”; rejected because it conflicts with thin-facade requirements.

2. **Barrel granularity** — Start with **layer-scoped** barrels (for example `lib/src/application.dart` or `lib/src/application/snapshot_run.dart` naming per repo convention) plus narrow feature barrels where cycles would otherwise appear. Rationale: fewer barrels to maintain than per-class barrels; still removes `../../../` chains. Alternative: single mega-barrel for all `src`; rejected due to cycle and compile-time coupling risk.

3. **Relative import exception** — Allow same-directory `import 'foo.dart'` when a library is split for private parts only. Rationale: Dart style and analyzer friendliness; package URI for same folder is often noise. Document in `lib/src/README.md`.

4. **Order of work** — Land barrels and import policy for `lib/` + `lib/src/` first in a mechanical pass, then extract `snapshot.dart` (and any other stragglers) so tests stay green incrementally. Alternative: move code first then fix imports; higher conflict risk.

## Risks / Trade-offs

- **[Risk] Export cycles when adding barrels** → Mitigation: add barrels bottom-up from leaf modules; run `dart analyze` after each barrel; split barrels if a cycle appears.
- **[Risk] Analyzer performance from re-export churn** → Mitigation: keep barrels shallow; avoid wildcard re-exports of huge trees unless needed.
- **[Risk] Test imports of private implementation** → Mitigation: tests that need internals should import the concrete `lib/src/...` library via `package:` path that remains supported for testing, or use the same barrels as production.

## Migration Plan

1. Add barrel files and re-export existing public `lib/src` symbols without moving implementation.
2. Convert `lib/` and `lib/src/` imports to `package:dart_test_gen/...` per policy (same-dir exception documented).
3. Extract `lib/snapshot.dart` bodies into new `lib/src/` modules; leave facade as export + thin forwarders.
4. Run `dart analyze` and full `dart test`; fix any cyclic export or missing export.
5. On archive, merge delta specs into `openspec/specs/` per OpenSpec workflow.

## Open Questions

- Exact barrel file names and whether to mirror `package:flutter` style (`src.dart` vs folder `src/application.dart`) — resolve to match existing `lib_structure.md` / README conventions during `/opsx:apply`.
- Whether `bin/` must also use only `package:` imports for `lib` — default yes for consistency unless analyzer constraints differ for executables.
