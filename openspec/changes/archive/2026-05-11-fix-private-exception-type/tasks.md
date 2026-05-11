## 1. Name normalization in the generator

- [x] 1.1 Add a top-level helper `String publicExceptionName(String runtimeTypeName, {bool isError = false, bool isException = false})` to `lib/snapshot.dart` that implements the whitelist (`_Exception → Exception`, `_AssertionError → AssertionError`, `_TypeError → TypeError`, `_CastError → TypeError`) and the fallbacks described in the design (private `_…` name → `Error` / `Exception` / `Object` depending on the flags; non-private names pass through)
- [x] 1.2 Apply `publicExceptionName(row['exception'] as String)` inside `_mergeDecoded` before constructing `SnapshotRow(throwsExceptionType: …)`. The host call passes `isError = false, isException = false` (no runtime check available) — names that already look like `Error`/`Exception` whitelist entries are handled by the table; anything else with a leading `_` is left untouched at host level
- [x] 1.3 In the snapshot runner template (`lib/snapshot.dart`, the buffer that emits the runner Dart code), define a `String _publicExceptionName(Object e)` helper that mirrors the same table and uses `e is Error` / `e is Exception` to pick the fallback; emit it into the runner source
- [x] 1.4 Replace both occurrences of `e.runtimeType.toString()` inside `out.add({…, 'exception': …})` (around lines ~284 and ~302) with `_publicExceptionName(e)`

## 2. Regression usecase

- [x] 2.1 Create `lib/usecases/exception_throws_showcase.dart` with a class `ExceptionThrowsShowcase` exposing public instance methods:
  - `int needPositive(int x)` — throws `Exception('non-positive')` when `x <= 0`, else returns `x`
  - `int needNonZero(int x)` — throws `ArgumentError.value(x, 'x', 'must be non-zero')` when `x == 0`, else returns `x`
  - `String requireOpen(bool open)` — throws `StateError('closed')` when `!open`, else returns `'open'`
  - `int parseHex(String s)` — returns `int.parse(s, radix: 16)` (uncaught `FormatException` for non-hex input)
  - `int requireEven(int x)` — `if (x.isOdd) throw AssertionError('odd'); return x;` (explicit throw so the case is deterministic regardless of `--enable-asserts`)
- [x] 2.2 Run `dart run dart_test_gen lib/usecases/exception_throws_showcase.dart` and commit the generated `test/usecases/exception_throws_showcase_test.dart`
- [x] 2.3 Verify the generated test file contains at least one `throwsA(isA<Exception>())` matcher and no `_`-prefixed identifiers
- [x] 2.4 Run `dart test test/usecases/exception_throws_showcase_test.dart` and ensure it passes

## 3. Unit tests for the normalizer

- [x] 3.1 Create `test/exception_type_normalization_test.dart` with cases asserting:
  - `publicExceptionName('_Exception') == 'Exception'`
  - `publicExceptionName('_AssertionError') == 'AssertionError'`
  - `publicExceptionName('_TypeError') == 'TypeError'`
  - `publicExceptionName('_CastError') == 'TypeError'`
  - `publicExceptionName('ArgumentError') == 'ArgumentError'`
  - `publicExceptionName('StateError') == 'StateError'`
  - Idempotence: `publicExceptionName(publicExceptionName('_Exception')) == 'Exception'`
- [x] 3.2 Confirm full suite still passes: `dart test`

## 4. Documentation

- [x] 4.1 Remove the bullet "throw Exception генерируется в _Exception, а нужно чтобы было Exception." from the `## Известные баги` section of `README.md`. If the section becomes empty, remove the section header too
- [x] 4.2 (Optional, only if section is removed) Remove the now-empty `## Известные баги` heading
