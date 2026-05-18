## Why

Several public `lib/*.dart` facades still embed substantial top-level logic (for example snapshot runner orchestration, helpers, and private utilities in one file). That makes layers harder to navigate, duplicates patterns already used under `lib/src/`, and encourages deep relative imports instead of a consistent internal import story. Tightening file granularity and standardizing barrels with `package:` imports keeps the package easier to maintain and aligns facades with the documented “thin entrypoint” goal.

## What Changes

- Move remaining top-level public and private functions that are not thin coordination from `lib/*.dart` into dedicated units under `lib/src/`, **one primary module per file** where practical (helpers, orchestration steps, and types split rather than stacked in a single facade file).
- Introduce or extend **barrel** files under `lib/src/` (per layer or concern) so implementation files re-export related symbols and callers use **`package:dart_test_gen/...`** URIs instead of long relative `../../` paths across the tree.
- Keep **public API** on existing `lib/*.dart` entrypoints via exports and small facades; behavior and exported names for package consumers stay stable unless explicitly marked otherwise.

## Capabilities

### New Capabilities

- `lib-src-file-granularity`: Rules for how `lib/src/` files are scoped—avoid multi-concern “kitchen sink” files; where top-level helpers belong; how public `lib/` facades delegate.
- `internal-barrel-imports`: Barrel layout and mandatory `package:dart_test_gen/...` import style for code under `lib/` and `lib/src/`, with exceptions only where the toolchain forbids it.

### Modified Capabilities

- `internal-library-layers`: Clarify that facades stay thin and that internal import/barrel conventions supplement the existing layer path rules.
- `god-file-decomposition`: Update the snapshot (and related) decomposition scenarios so orchestration and private helpers live under `lib/src/` per the new granularity rules, not in the public snapshot entry file.

## Impact

- `lib/snapshot.dart` and any other `lib/*.dart` files that still hold large top-level bodies or private helpers.
- New or moved files under `lib/src/` (application vs infrastructure placement per existing layer rules).
- Barrel files (new `lib/src/**/...dart` export hubs) and widespread import rewrites across `lib/`, `lib/src/`, `bin/`, and tests that import internals.
- No intentional change to CLI flags or external package API unless a re-export path is adjusted in a **BREAKING** way (not planned; if a symbol moves only between export paths, document migration in tasks).
