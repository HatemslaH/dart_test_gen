## Why

The current `README.md` is long and highly technical, but it’s not optimized for first-time users scanning the project to understand what it is, how to try it quickly, and how to use it in CI. A more “product-style” README (like `talker`) will improve adoption, reduce support questions, and make expectations around determinism/CI clearer.

## What Changes

- Rewrite `README.md` into a cleaner, scan-friendly structure inspired by `talker`’s formatting (header block, badges, quick pitch, table of contents, well-scoped sections).
- Add a “Get started” flow that is short and copy/pasteable (install → run on a file → run on `lib/`).
- Add a dedicated CI section that clearly documents determinism expectations and recommends using `--check` / `--dry-run`.
- Consolidate and de-duplicate existing content (features, CLI options, config) into sections that are easy to navigate.
- Standardize language and tone across the README (prefer concise English sections, keeping technical accuracy).

## Capabilities

### New Capabilities
- `readme-talker-format`: Requirements for the repository `README.md` structure and minimum content, aligned with the “talker-style” format (hero/header, badges, TOC, quickstart, features, CLI/config, CI, links).

### Modified Capabilities
<!-- None. This is documentation-only and does not change generator runtime behavior requirements. -->

## Impact

- `README.md` content and structure will change substantially.
- No runtime behavior changes are intended; no changes to CLI flags, snapshot behavior, or generation logic are required for this change.
