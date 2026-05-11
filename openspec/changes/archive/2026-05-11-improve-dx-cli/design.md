## Context

`dart_test_gen` сейчас имеет две точки входа: `bin/generate.dart` (рабочая, тонкая обёртка над `generateFromCli`) и `bin/dart_test_gen.dart` (заглушка `print('Hello world!')`). В `pubspec.yaml` нет секции `executables`, поэтому утилита не запускается ни как `dart pub global run dart_test_gen`, ни как `dart run dart_test_gen:dart_test_gen` без явного указания файла. Это шероховатость DX: имя пакета и имя бинаря расходятся, а в README приходится писать длинный путь `dart run bin/generate.dart`.

Снимок поведения собирается во временном Dart-раннере (см. `lib/snapshot.dart` и оркестрацию в `lib/generate_pipeline.dart`). При двух категориях сбоев — (a) раннер не компилируется (`dart` процесс вернул ненулевой код до запуска), (b) stdout раннера не парсится как ожидаемый снимок — текущий путь в `generationIsolateMain` ловит исключение и шлёт `'ERROR\t$e\n$st\n'` через bridge как stderr. Для пользователя это выглядит как стектрейс без указания файла/класса/метода, что сильно тормозит диагностику. Временный раннер удаляется до того, как пользователь успевает его открыть.

## Goals / Non-Goals

**Goals:**
- Сделать `dart_test_gen` основным бинарём, доступным как `dart run dart_test_gen` и через `dart pub global activate`.
- Сохранить полную обратную совместимость со скриптами/CI, которые вызывают `dart run bin/generate.dart …` (через shim с deprecation warning в stderr).
- Превратить ошибки раннера снимка в структурированное сообщение с контекстом (файл, класс, метод), путём к сохранённому артефакту раннера и actionable-подсказками.
- Добавить `--help` и `--version` без внешних зависимостей (использовать уже подключённые `path`, `yaml`).

**Non-Goals:**
- Не менять алгоритм генерации, парсинга, сэмплинга или формата теста.
- Не вводить полноценный CLI-фреймворк (`args` package) в рамках этой итерации — парсер аргументов уже самописный и работоспособен.
- Не переписывать `lib/snapshot.dart` ради структурных ошибок — достаточно прокидывать stderr `dart`-процесса и путь к временному файлу через исключения с расширенным контекстом.
- Локализация сообщений: оставляем смешанный ru/en как в существующих логах.

## Decisions

### D1. Точка входа: `bin/dart_test_gen.dart` становится основным

`bin/dart_test_gen.dart` будет импортировать `lib/generate_pipeline.dart` и вызывать `generateFromCli(args)`. `bin/generate.dart` превращается в shim: печатает в stderr одну строку deprecation-warning и делегирует туда же.

Альтернатива: оставить `generate.dart` основным и зарегистрировать его в `executables: { dart_test_gen: generate }`. Отклонена: имя файла-входа должно совпадать с именем бинаря — это упрощает чтение трейсов и pub-инструментарий.

### D2. Регистрация в `pubspec.yaml`

```yaml
executables:
  dart_test_gen:
```

(без явного значения — pub возьмёт `bin/dart_test_gen.dart`). Это разблокирует `dart pub global activate` и `dart run dart_test_gen`.

### D3. `--version` через чтение `pubspec.yaml`

Уже подключён `yaml: ^3.1.2`. На старте CLI лениво читать `pubspec.yaml` относительно `Platform.script` (или через `Isolate.resolvePackageUri`) и доставать поле `version`. Если файл не найден (например, в скомпилированном AOT), печатать `unknown`. Альтернатива: hard-code константа версии в коде. Отклонена: расходится с реальной версией, нужна синхронизация.

### D4. `--help` собирается из встроенного блока документации

Хранить help-текст как `const String _helpText` в новом файле `lib/cli_help.dart` (или прямо в `bin/dart_test_gen.dart`). Источник правды — README раздел «Опции CLI», но дублирование допустимо: help короткий. Не используем `args` package, чтобы не плодить зависимости.

### D5. Структурированные ошибки раннера снимка

Ввести в `lib/snapshot.dart` исключение `SnapshotRunnerFailure` с полями:
- `String stage` — `'compile'` или `'parse'` (compile = `dart` вернул ненулевой код; parse = stdout не распознан);
- `String? className`, `String? methodName`, `String absoluteLibPath`;
- `String runnerPath` — путь к временному файлу (НЕ удаляется при ошибке);
- `String dartStderrTail` — последние ~40 строк stderr процесса `dart`;
- `int? exitCode`.

`generationIsolateMain` ловит это исключение и форматирует многострочное сообщение:

```
Snapshot runner failed (compile) for lib/usecases/foo.dart [Foo.bar]
  runner kept at: /tmp/dart_test_gen_runner_xxx.dart
  dart stderr (tail):
    foo.dart:42:7: Error: ...
  hints:
    - re-run with -v for full log
    - open the runner file to inspect the generated snapshot code
    - if this looks like a generator bug, attach the runner file to the report
```

Альтернатива: оставить текущий `'ERROR\t$e\n$st'`. Отклонена — это и есть тот UX, который нужно починить.

### D6. Сохранение временного раннера при ошибке

По умолчанию: удалять при успехе, оставлять при ошибке. Флаг `--keep-runner` (и поле `keep_runner` в YAML) форсирует сохранение всегда. Путь печатается в обоих случаях, когда файл сохранён.

### D7. Обратная совместимость через shim

```dart
// bin/generate.dart
import 'dart:io';
import '../lib/generate_pipeline.dart';

Future<void> main(List<String> args) async {
  stderr.writeln(
    "[deprecated] 'bin/generate.dart' is kept for compatibility; "
    "use 'dart run dart_test_gen' instead.",
  );
  await generateFromCli(args);
}
```

Альтернатива: удалить `bin/generate.dart`. Отклонена — README и сторонние скрипты уже ссылаются на этот путь.

## Risks / Trade-offs

- **[R1] Чтение `pubspec.yaml` в рантайме хрупко при AOT-компиляции / `dart pub global activate`.** → Версия становится `unknown`, никаких падений; покрыть тестом fallback-ветки.
- **[R2] Накопление временных раннеров при многократных ошибках.** → Класть файлы в подкаталог `Directory.systemTemp/dart_test_gen/`, печатать путь, документировать ручную очистку. Не делаем auto-GC, чтобы не удалять артефакты, которые пользователь анализирует.
- **[R3] Расхождение README ↔ `--help`.** → Help сознательно держим лаконичным («see README for full docs»), полная справка остаётся в README. Делаем тест-смок, что `--help` содержит каждый ключевой флаг.
- **[R4] Deprecation-warning в stderr может ломать чьи-то grep-пайплайны.** → Это stderr, а не stdout; ассерты на stdout не страдают. Warning одной строкой, легко отфильтровать.
- **[R5] Snapshot runner может падать по причинам вне нашего контекста (нет SDK, нет прав).** → Структурированное сообщение в любом случае печатает stderr `dart`, так что причина видна. Не пытаемся классифицировать каждый случай.

## Migration Plan

1. Перенести содержимое `bin/generate.dart` (вызов `generateFromCli`) в `bin/dart_test_gen.dart` и добавить `--help`/`--version`.
2. Заменить `bin/generate.dart` на shim с deprecation-warning.
3. Добавить `executables:` в `pubspec.yaml`.
4. Расширить `lib/snapshot.dart` (исключение `SnapshotRunnerFailure`, сохранение runner-файла, сбор stderr).
5. Адаптировать `lib/generate_pipeline.dart` (форматирование ошибки в `generationIsolateMain`, прокидывание `className`/`methodName`).
6. Обновить `README.md`: примеры `dart run dart_test_gen ...`, описание `--help` / `--version` / `--keep-runner`, в TODO пункт 8 пометить `[x]`.
7. Тесты: smoke-тесты `--help`, `--version`, deprecation-warning, искусственный кейс с битым снимком (через usecase, который ломает компиляцию раннера) проверяет формат сообщения.

Rollback: тривиальный — все изменения локальны, обратной зависимости от внешних систем нет. Достаточно вернуть `bin/generate.dart` к старому содержимому и убрать секцию `executables`.

## Open Questions

- Нужен ли отдельный CLI-флаг `--no-deprecation-warning` для CI? Предлагаю не вводить, пока никто не жаловался.
- Стоит ли уже сейчас перейти на `package:args`? Откладываем — текущий парсер закрывает потребности, миграция на `args` достойна отдельного change.
