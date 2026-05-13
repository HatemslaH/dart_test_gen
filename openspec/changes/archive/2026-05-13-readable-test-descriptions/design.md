## Context

Today, `_renderSuccessTest` in `lib/test_generator.dart` names non-void success tests using `_testCaseTitleArgs`, which yields compact labels such as `isEven(0)` for methods. Void paths already append `runs without error`; throw paths append `throws <Type>`. The user wants outcome-oriented phrasing so failures read like specifications (for example knowing that the case expected `true` without opening the body).

## Goals / Non-Goals

**Goals:**

- Produce **human-readable** `test('…')` titles for success cases that combine **invocation context** (method/operator/getter/setter + arguments where applicable) with **expected outcome** in plain language.
- Preserve **correct escaping** for single-quoted titles (`_escapeSingleQuoted`).
- Stay consistent across **sync/async**, **streams**, **doubles** (`closeTo`), and **bool/null matcher** modes (`isTrue` / `isFalse` / `isNull` vs `expected` binding).

**Non-Goals:**

- Changing assertion semantics, snapshot data, or grouping structure.
- Localizing titles to multiple natural languages.
- Rewriting historical archived specs outside this change.

## Decisions

1. **Default sentence pattern (recommended)**  
   Use **`<call> returns <expected>`** for ordinary value expectations, where `<call>` is the same logical fragment as today’s `_testCaseTitleArgs` (e.g. `isEven(0)`, `getter foo`, `operator +(a, b)`).  
   **Rationale:** Reads as a spec (“returns” states the contract), avoids subjective “should”, and works for non-bool types (`returns 42`, `returns 'hello'`).  
   **Alternatives considered:**  
   - `isEven(0) should be true` — friendly but slightly more verbose and subjective.  
   - `isEven(0) → true` — compact but less natural in prose-oriented test UIs.  
   - `isEven(0) is true` — aligns with `isTrue` matcher wording; good secondary **style** option if a flag is added later.

2. **Expected fragment in the title**  
   Use the **same literal text** as `expected` in generated code (trimmed), so the title matches the assertion surface (e.g. `true`, `null`, `3.14`, `'hello'`). For `closeTo`, use phrasing like **`returns a value close to <expected>`** or keep **`returns <expected>`** if the literal is enough; pick one and apply consistently in implementation tasks.

3. **Configuration (optional, single decision point)**  
   Prefer **one good default** in v1; if product needs both “compact” (`isEven(0)`) and “descriptive” (`isEven(0) returns true`), add an enum-style option on `GenConfig` (e.g. `testTitleStyle: compact | descriptive`) defaulting to **descriptive**. CLI wiring only if other generator options are already exposed the same way.

4. **Length guard**  
   If the composed title exceeds a reasonable length (e.g. 200–240 characters), **fall back** to the current compact title (call only) to avoid unreadable one-liners and UI truncation. Document the threshold in code comments.

## Risks / Trade-offs

- **[Risk] Title verbosity** — Large argument lists inflate titles. **Mitigation:** length guard + compact fallback.  
- **[Risk] Duplicate information** — Body already shows `expected`; title repeats it. **Mitigation:** accepted trade-off for runner UX; compact style remains available via config if added.  
- **[Risk] Matcher vs literal wording** — `isTrue` in code vs word `true` in title. **Mitigation:** title uses **value literals**, not matcher names, unless a future style explicitly chooses matcher-aligned wording.

## Migration Plan

- Regenerate affected example tests; any hand-maintained assertions on exact title strings in unit tests must be updated in the same change.

## Open Questions

- **Resolved for v1:** Ship **only** descriptive titles by default (no `GenConfig` / CLI toggle). Compact titles appear only when the length guard fires; a future change may add `testTitleStyle` if users request stable compact output.
