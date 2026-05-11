## Context

В dart:core фабрика `Exception(...)` возвращает экземпляр приватного класса `_Exception` (см. реализацию в SDK). Аналогично, ряд ошибок, которые принято писать как `AssertionError`/`TypeError`/`CastError`, в рантайме имеют приватные runtime-типы (`_AssertionError`, `_TypeError`). Снимок генератора захватывает имя исключения через `e.runtimeType.toString()` (см. `lib/snapshot.dart` строки ~284 и ~302), а затем `test_generator.dart` подставляет это имя в `throwsA(isA<$ex>())` (`lib/test_generator.dart:393, 398-399`). В результате сгенерированный тест содержит идентификатор, недоступный за пределами dart:core, и не компилируется. README уже фиксирует это в разделе «Известные баги».

## Goals / Non-Goals

**Goals:**
- Сгенерированные тесты, проверяющие исключения, должны компилироваться и проходить на CI.
- Семантика проверки сохраняется: для `Exception('x')` тест должен утверждать, что выброшенное значение является `Exception` (не `Object`/`Error`/конкретный приватный класс).
- Покрыть нормализацию регрессионным usecase (`exception_throws_showcase.dart`) + юнит-тестом маппера.

**Non-Goals:**
- Не вводим эвристики «угадай ближайший публичный супертип» через рефлексию (Dart её толком не предоставляет). Ограничиваемся коротким явным whitelist + двумя широкими fallback (`Exception`/`Error`).
- Не пытаемся восстановить точный subclass для приватных классов вне whitelist — это потребовало бы ведения большой таблицы и быстро устарело бы; общий супертип достаточен и стабилен.
- Не меняем формат снапшота на JSON-уровне — поле остаётся `'exception': '<name>'`.

## Decisions

### D1. Где нормализуем — на стороне раннера снимка

В сгенерированном раннере захватываем имя через локальный helper `String _publicExceptionName(Object e)`. Это делает снимки сразу «правильными», а старые форматы тестов остаются совместимыми.

Альтернатива: нормализовать только в `_mergeDecoded` (хосте). Отклонена как единственная точка фиксации — раннер сохранил бы «битое» имя в логах/диагностике. Решение: **делаем в обоих местах** — раннер пишет публичное имя, плюс `_mergeDecoded` дополнительно нормализует на случай старых/чужих снимков и для тестируемости (юнит-тест может звать функцию из хоста без запуска подпроцесса).

### D2. Whitelist приватных имён

Минимальный, документированный список:

| runtime-тип | публичное имя |
|---|---|
| `_Exception` | `Exception` |
| `_AssertionError` | `AssertionError` |
| `_TypeError` | `TypeError` |
| `_CastError` | `TypeError` |

Прочие имена с лидирующим `_`:
- если в раннере `e is Error` → `Error`;
- иначе если `e is Exception` → `Exception`;
- иначе → `Object`.

На стороне хоста (`_mergeDecoded`) нет доступа к рантайм-типу, только к строке. Поэтому fallback на хосте: для имени с ведущим `_` без явного маппинга оставляем как есть (раннер уже должен был очистить). Если когда-то прилетит «грязная» строка из устаревшего снимка — это будет видно как `_Foo` в тесте и упадёт на компиляции — это улучшение в обоих случаях, потому что в худшем случае ситуация не хуже сегодняшней.

### D3. Helper-функция: `publicExceptionName(String)` в хосте

Экспортируется из `lib/snapshot.dart` (top-level или static), принимает имя-строку и возвращает нормализованную. Используется и в `_mergeDecoded`, и в юнит-тесте.

Раннер инлайнит свой локальный helper в исходник (другая среда исполнения — нельзя импортировать наш `lib/`).

### D4. Регрессионный usecase

`lib/usecases/exception_throws_showcase.dart` с одним классом `ExceptionThrowsShowcase` и публичными методами:

- `int needPositive(int x)` — `throw Exception('non-positive')` при `x <= 0`, иначе возврат `x`.
- `int needNonZero(int x)` — `throw ArgumentError.value(x, 'x', 'must be non-zero')` при `x == 0`.
- `String requireOpen(bool open)` — `throw StateError('closed')` при `!open`, иначе строка.
- `int parseHex(String s)` — `int.parse(s, radix: 16)` без обработки → `FormatException` на «zz».
- `int requireEven(int x)` — `assert(x.isEven); return x;` → `AssertionError` в debug. (Если ассерты выключены в раннере — кейс не выстрелит, оставляем простой `throw AssertionError('odd')` чтобы регрессия была детерминированной независимо от `--enable-asserts`.)

После перегенерации `test/usecases/exception_throws_showcase_test.dart` должен содержать `throwsA(isA<Exception>())`, `throwsA(isA<ArgumentError>())`, `throwsA(isA<StateError>())`, `throwsA(isA<FormatException>())`, `throwsA(isA<AssertionError>())` и **проходить** `dart test`.

### D5. Юнит-тест маппера

`test/exception_type_normalization_test.dart` проверяет `publicExceptionName('_Exception') == 'Exception'`, `'_AssertionError' → 'AssertionError'`, etc., и что не-приватные имена (`'StateError'`, `'ArgumentError'`) проходят без изменений.

## Risks / Trade-offs

- **[R1] Появятся новые приватные типы в core SDK.** → Покрыты широким fallback на стороне раннера (`is Exception`/`is Error`). Whitelist расширяется по необходимости.
- **[R2] Слишком общий fallback («любой `_Foo` от Exception → `Exception`») потеряет специфичный subclass.** → Это компромисс корректности vs точности; точное имя нам всё равно недоступно из публичного API. Тест по `isA<Exception>` стабилен и информативен.
- **[R3] `AssertionError` в раннере без `--enable-asserts`.** → Решено в D4: бросаем `throw AssertionError(...)` явно, чтобы кейс не зависел от режима исполнения.

## Migration Plan

1. Добавить helper `publicExceptionName` в `lib/snapshot.dart` и инлайн-helper в раннер.
2. Подменить оба `e.runtimeType.toString()` в шаблоне раннера на helper.
3. Применить `publicExceptionName` в `_mergeDecoded`.
4. Создать `lib/usecases/exception_throws_showcase.dart`.
5. Сгенерировать `test/usecases/exception_throws_showcase_test.dart` через `dart run dart_test_gen lib/usecases/exception_throws_showcase.dart` и закоммитить результат.
6. Прогнать `dart test` — все тесты, включая новый сгенерированный, должны проходить.
7. Удалить пункт из «Известные баги» в README.

Rollback: точечный — отмена изменений в `lib/snapshot.dart`, удаление usecase и сгенерированного теста.

## Open Questions

- Стоит ли расширять whitelist `_CompileTimeError`, `_OutOfMemoryError` и т.п.? Предлагаю не вносить пока никто не наступил — добавим по факту.
