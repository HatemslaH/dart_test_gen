## 1. CLI flag plumbing

- [x] 1.1 Extend `parseCliArgs` in `lib/generate_pipeline.dart` with `bool? dryRun` and `bool? check` fields; add `--dry-run` and `--check` to the parser branches
- [x] 1.2 Add `bool dryRun` and `bool check` (defaults `false`) to `GeneratorConfig` and pass them through the spawn message; CLI overrides update the config in `generateFromCli`
- [x] 1.3 In `generateFromCli`, reject the combination `--dry-run && --check` with `CliLog.err(...)` and `exit(64)` immediately after argument parsing
- [x] 1.4 Update `cliHelpText` in `lib/cli_help.dart` to document both new flags

## 2. `stripGeneratedTimestamp` helper

- [x] 2.1 Add `String stripGeneratedTimestamp(String content)` to `lib/test_generator.dart` that removes lines whose prefix matches either `// Generated:` or `// Сгенерировано:` (one line each, leaves the rest unchanged)
- [x] 2.2 In `generateTestFile`, switch the banner from `// Сгенерировано:` to `// Generated:` while keeping the same ISO-8601 timestamp format
- [x] 2.3 Add `test/test_generator_timestamp_test.dart` covering the three scenarios from the spec (strip Generated, strip legacy Russian, no-op)

## 3. Pipeline branching for dry-run / check

- [x] 3.1 In `generateSingleLibraryFile` (`lib/generate_pipeline.dart`), refactor the tail (after `content` is built) into a small dispatch that handles three modes:
  - default: call `writeTestFile(testOut, content)` as today
  - dry-run: call `CliLog.out(testOut)` and, when `verbose`, emit `content` via the existing verbose channel
  - check: read `testOut` if present; apply `stripGeneratedTimestamp` to both sides; if missing or differs, build the diff summary string and signal failure to the caller (e.g. return a `CheckMismatch` value or set a shared flag)
- [x] 3.2 In both call sites (`generateFromCli` single-file path AND the multi-isolate aggregator path), collect any check failures and exit with code `1` if at least one was reported; success path stays at `0`
- [x] 3.3 Diff summary format on stderr per failing target:
  - `[check] differs: <test path>`
  - `  expected: <abs path or <missing>>`
  - `  first diff at line <N>:`
  - `    -- existing: <line, truncated to ~160 chars>`
  - `    ++ generated: <line, truncated to ~160 chars>`
- [x] 3.4 Closing summary line on stderr: `[check] <N> file(s) differ` when N > 0

## 4. Tests for the new flags

- [x] 4.1 Add `test/dry_run_and_check_test.dart` with these process-based smoke scenarios (mirroring the style of `cli_smoke_test.dart`):
  - `--dry-run` on `example/lib/usecases/calculator.dart` prints the absolute test path on stdout, leaves the file unchanged on disk, exits 0
  - `--check` on the same target after a normal generation returns 0
  - `--check` after the test file is deleted exits 1 and stderr mentions `<missing>`
  - `--check` after the test file is mutated (a non-timestamp line edited) exits 1 and stderr contains `first diff at line`
  - `--check` after only the `// Generated:` timestamp is changed in the existing file returns 0 (timestamp-only diff is ignored)
  - `--dry-run --check` together exit with code 64 and stderr mentions the conflict
- [x] 4.2 Multi-file aggregation: `--check` against a directory with at least one matching and one differing target exits with code 1 and stderr contains the closing `[check] <N> file(s) differ` line
- [x] 4.3 Use `Directory.systemTemp.createTempSync(...)` for any mutate-and-restore scenarios so the canonical `example/lib/usecases/...` test files are not modified by the test run; assert restoration in `tearDown`

## 5. Ripple effects on existing tests

- [x] 5.1 Update `test/cli_smoke_test.dart`: extend the `for (final flag in const [...]) expect(out, contains(flag))` list to include `--dry-run` and `--check`, so the smoke test guards the help-text contract
- [x] 5.2 Search the repo for any test that asserts on the literal banner `// Сгенерировано:` (e.g. golden-style snapshots). If any are found, update them to expect `// Generated:` — but do NOT silently drop the legacy match in `stripGeneratedTimestamp`, since on-disk files in `example/...` may still carry the old banner until regenerated
- [x] 5.3 After the banner switch in `generateTestFile`, regenerate all `example/lib/usecases/.../*_test.dart` files via `dart run dart_test_gen example/lib/usecases` and commit the updated banners so `dart test` keeps passing

## 6. README documentation

- [x] 6.1 Add a new section `## CI и детерминизм` after the existing TODO/roadmap discussion (or just before it) covering:
  - Зависимость снимка от Dart SDK и платформы (имена приватных рантайм-типов уже нормализуются, IEEE-754 — рекомендуется `use_close_for_double`)
  - Команды `--dry-run` (smoke) и `--check` (CI-стейдж)
  - Пример CI-шага (GitHub Actions yaml block) с пином SDK и `dart run dart_test_gen lib --check`
- [x] 6.2 Update the `### Опции CLI` list to include `--dry-run` and `--check`
- [x] 6.3 Mark TODO item 9 as `[x]` and describe what shipped

## 7. Translate Russian comments in `lib/` to English

For each file below, translate only `//` and `///` comments. Do NOT alter string literals, identifiers, public API names, or log/CLI user-facing messages.

- [x] 7.1 `lib/cli_log.dart` (1 occurrence)
- [x] 7.2 `lib/cli_progress.dart` (2 occurrences)
- [x] 7.3 `lib/gen_config.dart` (3 occurrences)
- [x] 7.4 `lib/resolved_dependencies.dart` (4 occurrences)
- [x] 7.5 `lib/snapshot.dart` (12 occurrences)
- [x] 7.6 `lib/test_generator.dart` (19 occurrences)
- [x] 7.7 `lib/source_parser.dart` (34 occurrences)
- [x] 7.8 `lib/generate_pipeline.dart` (37 occurrences)
- [x] 7.9 After all files: `dart analyze` clean; `dart test` clean; `grep -P '[А-Яа-яЁё]' lib/**/*.dart` returns only string literals (no comment matches)

## 8. Final verification

- [x] 8.1 Run the full suite: `dart test` — must include the new unit test (`test_generator_timestamp_test.dart`), the new CLI smoke (`dry_run_and_check_test.dart`), and the updated existing tests
- [x] 8.2 Run `dart analyze` — no new warnings introduced
- [x] 8.3 Regenerate one showcase and verify both: the new `// Generated:` banner appears AND `dart run dart_test_gen <regenerated path> --check` returns 0
