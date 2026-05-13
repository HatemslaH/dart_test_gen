## Why

Generated success tests use minimal titles such as `isEven(0)`, which mirror the call site but do not state the intended outcome. That makes large generated files harder to scan in test runners and diffs. Richer, sentence-style titles (for example describing the expected value or behavior) improve readability without changing assertions.

## What Changes

- Extend generated `test('…')` titles for **non-void** success paths so the name reflects inputs **and** the expected result (or a clear natural-language outcome), while staying safe for single-quoted strings (existing escaping rules).
- Keep **void** and **throws** title patterns consistent with today unless the design explicitly unifies wording (void already uses `runs without error`; throws uses `throws <Type>`).
- Add configuration if multiple title styles are desirable (e.g. compact vs descriptive); default should favor readability for the common case.
- Update golden / snapshot example tests and unit tests that assert on generated output.

## Capabilities

### New Capabilities

- `readable-test-titles`: Requirements for how generated `test` descriptions read for success cases (wording, inclusion of expected value, edge cases for matchers like `isTrue` vs literal `expected`).

### Modified Capabilities

- (none — no existing spec defines generated test title wording today.)

## Impact

- `lib/test_generator.dart` (title construction for `_renderSuccessTest`, possibly helpers shared with operators/getters/setters).
- `lib/gen_config.dart` and CLI if a style flag is introduced.
- Regenerated example tests under `example/test/usecases/` and generator tests under `test/`.
