## 1. Reference and outline

- [x] 1.1 Capture the target README skeleton (hero/pitch, badges, TOC, sections) from `talker` and adapt headings for a CLI tool
- [x] 1.2 Audit current `README.md` content and map what MUST be kept (Quick Start, CLI flags, config, CI determinism)
- [x] 1.3 Decide which existing sections become “Reference” vs “Advanced” vs “Roadmap” and define the final section order

## 2. Rewrite `README.md` to match the spec

- [x] 2.1 Implement the new top section: short pitch + quick signals (badges) + minimal intro
- [x] 2.2 Add a table of contents with anchors to all main sections
- [x] 2.3 Write “Quick Start” with verified commands for single file and directory generation
- [x] 2.4 Write “Features” section with concise bullets (high-level capabilities only)
- [x] 2.5 Add a “CLI options” reference section covering the key supported flags listed in the spec
- [x] 2.6 Add a “Configuration” section describing `dart_test_gen.yaml` keys and a minimal example
- [x] 2.7 Add a “CI & determinism” section describing `--check` and `--dry-run` behavior and a sample CI snippet
- [x] 2.8 Add a short “Project structure / Internals” section (optional) and trim overly deep internals into links or brief notes

## 3. Verification

- [x] 3.1 Ensure README headings match the TOC anchors (no broken links)
- [x] 3.2 Confirm all documented flags and config keys reflect current behavior (cross-check with `--help` and existing tests)
- [x] 3.3 Run markdown preview sanity check (formatting, code fences, lists)
