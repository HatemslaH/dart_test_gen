## 1. Inventory and barrels

- [x] 1.1 Document barrel strategy and same-directory relative import exceptions in `lib/src/README.md` (align names with `lib_structure.md` if present).
- [x] 1.2 Add initial barrel libraries under `lib/src/` (layer- or feature-scoped) that `export` the existing implementation libraries needed for the snapshot facade and other hot import paths.
- [x] 1.3 Run `dart analyze` after barrel wiring to confirm there are no export cycles.

## 2. Internal import policy (`package:` URIs)

- [x] 2.1 Convert cross-directory imports across `lib/` and `lib/src/` to `package:dart_test_gen/...` (using barrels where they reduce churn), keeping same-directory relative imports only where documented.
- [x] 2.2 Update `bin/dart_test_gen.dart` (and any other package entry) to follow the same import policy where applicable.
- [x] 2.3 Re-run `dart analyze` and fix any missing exports surfaced by the import rewrite.

## 3. Thin `lib/snapshot.dart` and single-purpose `lib/src` files

- [x] 3.1 Move private helpers currently in `lib/snapshot.dart` (for example `_tailLines`, `_snapshotVerbose`) into a dedicated `lib/src/` helper module for the snapshot feature.
- [x] 3.2 Move `runSnapshots` orchestration (temp runner file, `ProcessRunner` invocation, stdout JSON handling, cleanup policy) into a dedicated `lib/src/` module per `design.md` (application vs infrastructure), keeping one primary concern per file.
- [x] 3.3 Leave `lib/snapshot.dart` as exports plus thin forwarders only; ensure all prior public symbols remain available through the same `package:dart_test_gen/snapshot.dart` import path.
- [x] 3.4 Scan other `lib/*.dart` facades for remaining private top-level bodies or orchestration; repeat the extract-and-forward pattern where specs apply.

## 4. Verification and spec alignment

- [x] 4.1 Run full `dart test` for the package and fix regressions.
- [x] 4.2 Manually verify requirements in `specs/lib-src-file-granularity/spec.md`, `specs/internal-barrel-imports/spec.md`, and the delta specs under `specs/internal-library-layers/spec.md` and `specs/god-file-decomposition/spec.md` against the final tree.
