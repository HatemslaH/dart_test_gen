## Context

Success-case tests are built in `_renderSuccessTest` in `lib/test_generator.dart`. Today every non-void, non–`closeTo` double path declares `final expected = <literal>;` and uses `expect(actual, expected)`. Snapshot rows already carry `expectedLiteral` as Dart source, and `MethodSpec.snapshotReturnType` describes the unwrapped value type (after stripping `Future` / `Stream`).

## Goals / Non-Goals

**Goals:**

- Emit `expect(actual, isTrue)` or `expect(actual, isFalse)` when the compared value is `bool` (including nullable `bool?`) and the snapshot literal is `true` or `false`.
- Emit `expect(actual, isNull)` when the snapshot literal is `null`.
- Omit the `expected` local when the assertion uses a matcher alone (clearer generated tests, smaller diffs).
- Preserve existing `closeTo` behavior for `double` and all other types unchanged.
- Expose a **default-on** switch so teams can revert to legacy `expected` + `expect(actual, expected)` for bool/null literals via YAML and/or CLI.

**Non-Goals:**

- Broader matcher refactors (`equals`, `same`, `isA`, string matchers, etc.).
- Changing snapshot JSON or runner semantics.

## Decisions

1. **Detection** — Parse `expectedLiteral` as trimmed Dart token: `true`, `false`, `null`. For bool matchers, additionally require `snapshotReturnType` to be `bool` or `bool?` (after normalization) so we never emit `isTrue`/`isFalse` for unrelated types that might stringify to those tokens.
2. **Null** — If `expectedLiteral` is `null`, emit `expect(actual, isNull)` without requiring a specific `snapshotReturnType` (null is unambiguous for the success path).
3. **Ordering with `closeTo`** — Keep current precedence: if `useCloseForDouble && snapshotReturnType == 'double'`, keep `closeTo`; do not apply bool/null branches for doubles.
4. **Async/sync** — Same shape for sync and async bodies: only the `actual` assignment and `await` on the call differ; matcher lines stay one `expect(actual, …)`.
5. **Configuration** — Add `useExpectMatchersBoolNull` (Dart name) to `MethodConfig` with default **`true`**. YAML key **`use_expect_matchers_bool_null`** at file root and under `methods: <methodName>:` (same merge pattern as `use_close_for_double`). CLI: **`--expect-matchers-bool-null`** forces on, **`--no-expect-matchers-bool-null`** forces off; when either CLI flag is parsed, it overrides the merged YAML value for the run (mirror how `useCloseForDouble` / sampling overrides are applied in `generateFromCli`). Update English `cli_help.dart` and the Russian usage block in `parseCliArgs` for discoverability.
6. **Tests** — Cover matcher emission when the flag is true (default), and legacy emission when false (YAML or CLI). Regenerate example tests when the repo expects checked-in generated output to match defaults.

## Risks / Trade-offs

- **[Risk] Over-broad bool detection** — Mitigation: gate on `snapshotReturnType` for `bool` / `bool?` only.
- **[Risk] Literal formatting** — Snapshot might emit `true ` with spaces; Mitigation: trim when comparing token strings.
- **[Trade-off] Readability vs symmetry** — Some users prefer always binding `expected`; disabling the flag restores that style for bool/null.
- **[Risk] Conflicting CLI flags** — If both `--expect-matchers-bool-null` and `--no-expect-matchers-bool-null` appear, document and implement one rule (e.g. last wins) or reject with exit code 64.

## Migration Plan

- Ship generator change; users re-run `dart run dart_test_gen` (or project CLI) to refresh tests. No runtime migration for published packages beyond regenerating tests.

## Open Questions

- None blocking; if `true`/`false` appear as enum values with the same token shape, the bool gate on `snapshotReturnType` avoids misclassification.
