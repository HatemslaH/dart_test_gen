## 1. Title builder

- [x] 1.1 Add a helper (or extend `_testCaseTitleArgs` usage) that composes the **descriptive** success title: invocation fragment + expected outcome phrase per `design.md` (default `returns <literal>`; define `closeTo` wording in one place).
- [x] 1.2 Implement **length guard** with compact fallback to invocation-only titles when over the chosen threshold.
- [x] 1.3 Wire descriptive titles into `_renderSuccessTest` for sync/async/stream paths without changing assertion lines.

## 2. Configuration (optional)

- [x] 2.1 Decide in code whether v1 ships **only** descriptive titles or adds `GenConfig` / CLI for `compact` vs `descriptive`; implement per `design.md` Open Questions resolution. **Resolution:** descriptive-only in v1; compact is only the length-guard fallback (no new config/CLI).
- [x] 2.2 If a flag is added, document it in `cli_help.dart` and parser tests. **N/A** — no flag added.

## 3. Verification

- [x] 3.1 Update or add unit tests in `test/` that assert generated `test('…')` strings for representative cases (bool with matcher, int, string, nullable, double `closeTo` if applicable).
- [x] 3.2 Regenerate or update `example/test/usecases/` outputs so titles match the new rules.
- [x] 3.3 Run `dart test` for the package and example as applicable.
