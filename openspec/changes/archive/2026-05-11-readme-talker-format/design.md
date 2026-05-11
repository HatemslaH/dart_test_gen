## Context

`dart_test_gen` already has a feature-complete README, but it is optimized for deep, linear reading and is written primarily in Russian. The README mixes user-facing onboarding, long-form technical explanation, roadmap notes, and detailed CLI/config reference.

The reference format (the `talker` README) uses a “product-style” layout:
- A centered header/hero block with a short pitch
- Badges for quick signals (pub, license, CI, etc.)
- A table of contents for fast navigation
- A “Get Started” section first, then feature and reference sections
- Repeated use of short paragraphs, images/gifs (optional), and clear section boundaries

For `dart_test_gen`, we want the same scanning ergonomics and clear onboarding, while keeping technical accuracy and preserving essential details (CLI flags, config, determinism/CI guidance).

Constraints:
- Documentation-only change; no CLI/API behavior changes are required.
- README content should remain correct for current package behavior and flags.
- The repository already documents CI determinism flags (`--check`, `--dry-run`) and timestamp handling; the new README must keep those in an easier-to-find place.

## Goals / Non-Goals

**Goals:**
- Restructure `README.md` into a talker-inspired format that is easy to scan.
- Provide a minimal “copy/paste” onboarding path (install → generate for a file → generate for a directory).
- Make CI usage and determinism requirements obvious and actionable.
- Provide a table of contents and section ordering that matches how new users evaluate tools.
- Keep the README concise at the top, with deeper reference content further down.

**Non-Goals:**
- Changing generator behavior, CLI flags, YAML schema, or snapshot logic.
- Translating every existing Russian paragraph verbatim; the intent is to produce a clean, cohesive README, not a literal translation.
- Adding heavy marketing content or large images that bloat the repository (images are optional and should be used sparingly).

## Decisions

- **Adopt a talker-style skeleton, adapted for a CLI tool**
  - Rationale: `dart_test_gen` is primarily a CLI. We will keep the talker ergonomics (hero, badges, TOC, quickstart), but the core sections will focus on CLI usage rather than package API usage.
  - Alternative: “Keep existing structure and only add TOC” — rejected because it doesn’t address onboarding and scanability.

- **Prefer short, structured English sections**
  - Rationale: Public OSS READMEs benefit from a consistent language and tone; it lowers friction for first-time users. We will keep technical correctness and may keep small Russian notes only when truly necessary.
  - Alternative: “Keep RU-first README” — rejected because the goal is to match the reference format and improve onboarding for a wider audience.

- **Separate “Quick Start” from “Reference”**
  - Rationale: New users should be able to try it in < 60 seconds; detailed CLI/config tables can live in later sections.
  - Alternative: “Inline all CLI options early” — rejected due to cognitive load.

- **CI section anchored on `--check` and `--dry-run`**
  - Rationale: These flags are the most important operational contract for keeping generated tests deterministic and up-to-date in CI.
  - Alternative: “Document CI as a footnote” — rejected; CI is a primary use case for generators.

## Risks / Trade-offs

- **Risk**: Removing or shortening existing details could lose important nuance.
  - **Mitigation**: Maintain a “Reference” section with links/anchors for advanced topics; ensure CI determinism, config keys, and the main flags remain present.

- **Risk**: Users who relied on the Russian README might find it less accessible.
  - **Mitigation**: Keep critical terms consistent with the CLI output; optionally include a short RU note near the top pointing to a “RU details” section if needed (only if the new README becomes unclear otherwise).

- **Risk**: The README could drift from actual behavior over time.
  - **Mitigation**: Tie the README sections directly to the current flags/config keys and keep examples minimal; prefer referencing `--help` output and existing tests that enforce behavior (e.g., `--check` ignoring timestamps).

