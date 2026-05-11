## Why

В разделе «Известные баги» в `README.md` зафиксировано: когда генерируемый тест должен проверять `throwsA(isA<…>())` для метода, бросающего `Exception('msg')`, в файл попадает приватный тип `_Exception` из dart:core. Этот идентификатор недоступен извне dart:core, поэтому сгенерированный тест **не компилируется** (`Undefined name '_Exception'`). Корень проблемы — снимок сохраняет `e.runtimeType.toString()`, а у `Exception(...)` runtime-тип — внутренний приватный класс `_Exception`. Та же ловушка ждёт и другие core-исключения, у которых публичный тип/фабрика возвращает приватную реализацию (`_AssertionError` для `AssertionError`, `_TypeError` для `TypeError` и т. п.).

## What Changes

- В runtime-коде раннера снимка (`lib/snapshot.dart`) перед записью имени исключения нормализовать имя: если `runtimeType.toString()` начинается с `_`, маппить его на ближайший публичный тип через явный whitelist (`_Exception → Exception`, `_AssertionError → AssertionError`, `_TypeError → TypeError`, `_CastError → TypeError`). Если приватный тип не входит в whitelist — fallback на общий супертип (`Exception` для `e is Exception`, `Error` для `e is Error`, иначе `Object`).
- Дополнительно очищать имя на стороне `_mergeDecoded` (двойная защита для уже накопленных снимков): тот же whitelist + fallback по характеру строки.
- Добавить новый usecase **`lib/usecases/exception_throws_showcase.dart`** с публичными методами, гарантированно бросающими `Exception('…')`, `ArgumentError`, `StateError`, `FormatException`, и `AssertionError` (assert). Класс служит регрессией: после генерации все методы покрыты тестами вида `throwsA(isA<Exception>())` / `throwsA(isA<ArgumentError>())` и т. п., и сгенерированный файл должен **компилироваться и проходить** под `dart test`.
- Добавить юнит-тест на маппер (чтобы не зависеть только от интеграции через генерацию).
- В README удалить пункт из раздела «Известные баги».

## Capabilities

### New Capabilities
- `exception-type-normalization`: правила нормализации приватных runtime-типов исключений (`_Exception`, `_AssertionError`, `_TypeError`, `_CastError`) в публичные имена при формировании снимка и при пост-обработке.

### Modified Capabilities
<!-- none — раздел «throws»-кейсов уже покрыт неформально, отдельной спеки на него нет; вводим новую -->

## Impact

- Код: `lib/snapshot.dart` (генерация раннера: добавить helper `_publicExceptionName(e)` и использовать его в обоих местах захвата `'exception': …`; пост-обработка `_mergeDecoded` тоже нормализует имя).
- Новый файл: `lib/usecases/exception_throws_showcase.dart` с регрессионными методами.
- Сгенерированный файл `test/usecases/exception_throws_showcase_test.dart` — артефакт прогона генератора, добавляется в репозиторий (как и другие showcase-тесты).
- Юнит-тест: `test/exception_type_normalization_test.dart` для самого маппера (имя класса/функции экспортированы из `snapshot.dart`).
- `README.md`: убрать пункт «throw Exception генерируется в _Exception…» из раздела «Известные баги».
- Совместимость: имя в существующих сгенерированных тестах было невалидно, поэтому перегенерация безопасна; ранее «работавшие» тесты, опиравшиеся на конкретное `_…` имя, отсутствуют.
