## 1. Inventory and target layout

- [x] 1.1 Map current `lib/` import graph (who imports whom) and list public `package:dart_test_gen/...` entry points used from `bin/` and tests.
- [x] 1.2 Decide final folder names under `lib/src/` (layers vs hybrid) and document them in `design.md` or a short `lib/src/README.md` per Open Questions resolution.

## 2. Generator module contract

- [x] 2.1 Add the generator module abstraction (identity, context input type, structured result type) in a domain-facing library unit with no `dart:io` / `dart:isolate` imports.
- [x] 2.2 Implement the existing snapshot-based unit test flow as the sole registered module behind that abstraction without changing CLI defaults.
- [x] 2.3 Add a composition-root factory that registers built-in module(s) and constructs infrastructure adapters used by orchestration.

## 3. Layering and orchestration split

- [x] 3.1 Extract at least one infrastructure concern behind a port (for example filesystem or isolate/snapshot runner) and inject it from the composition root.
- [x] 3.2 Refactor CLI-facing orchestration (`generateFromCli` and related) so it reads as coordinated steps delegating to services, not inlined low-level I/O for the full flow.
- [x] 3.3 Relocate domain models and policies (e.g. method/param/test row types vs string emitters) so domain-layer files do not import `dart:io` or `dart:isolate` per `internal-library-layers` spec.

## 4. Compatibility and cleanup

- [x] 4.1 If files move, add temporary `export` shims in old `lib/*.dart` paths as needed to preserve `package:dart_test_gen/...` imports; list any intentional **BREAKING** removals in `proposal.md` / changelog.
- [x] 4.2 Remove dead code and shims once all in-repo imports use new paths; ensure `bin/` entrypoints remain thin.

## 5. Verification

- [x] 5.1 Run full package tests and fix any regressions; confirm `cli-entrypoint` scenarios still pass (manual or automated as today).
- [x] 5.2 Run `dart analyze` / CI-equivalent checks on `lib/` and `bin/` with no new errors.
- [x] 5.3 Self-review against `specs/internal-library-layers/spec.md` and `specs/generator-module-contract/spec.md` (layer imports, registration locality, default behavior unchanged).
