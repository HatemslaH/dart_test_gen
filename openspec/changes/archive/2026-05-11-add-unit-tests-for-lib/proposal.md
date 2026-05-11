## Why

Сейчас юнит-покрытие кода в `lib/` фрагментарное: прямых тестов всего четыре файла (`gen_config_double_expect_test.dart`, `cli_smoke_test.dart`, `snapshot_runner_failure_test.dart`, `exception_type_normalization_test.dart`). Большая часть чистых функций (парсинг CLI, sampling-стратегии, мап-литералы из снимка, нормализация путей, разбор YAML-конфига, расширение целей генерации) проверяется только косвенно — через перегенерацию showcase-тестов в `example/lib/usecases/`. Этого достаточно, чтобы поймать регрессию «поломали всё», но недостаточно, чтобы локализовать поломку конкретной функции, и неудобно для рефакторинга: любое изменение требует прогона тяжёлой интеграции. Цель — покрыть точечными юнит-тестами **публичные чистые функции** ключевых файлов в `lib/`, не дублируя то, что уже проверяет интеграция.

## What Changes

- Добавить новый test-файл на каждый недопокрытый модуль `lib/`:
  - `test/sampling_test.dart` — стратегии `full` / `random` / `happy_path`, лимит `maxCases`, mandatory-bucket для строк с `throwsType`, детерминизм при `seed`.
  - `test/gen_config_load_test.dart` — `GeneratorConfig.load`: отсутствующий файл → defaults; невалидный YAML → defaults; путь `--config`; per-method overrides; `keep_runner` на верхнем уровне.
  - `test/cli_args_parser_test.dart` — `parseCliArgs` из `lib/generate_pipeline.dart`: распознавание всех флагов, парсинг чисел, дефолты, обработка `--double-epsilon` с невалидным значением, корректная агрегация `--config` / `--keep-runner` / `--strategy`.
  - `test/generate_pipeline_paths_test.dart` — `testOutputPathForLib`, `shortLibLabel`, `dartFilesUnderDirectory`, `expandGenerationTargets` (через `tempDir` со структурой `lib/...`).
  - `test/snapshot_literals_test.dart` — `dartLiteralFromJson` / `dartLiteralFromJsonLoose` для всех поддерживаемых типов (`int`, `double`, `bool`, `String`, `List<T>`, `Set<int>` сортированный, `Set<String>`, `Iterable<T>`, `Map<String, int>`, enum-record `_enumType`/`_enumName`, пользовательский класс через `ClassInfo`, fallback `_value`).
  - `test/snapshot_invoke_expression_test.dart` — `snapshotInvokeExpression` и `formatArgsForSnapshot` для всех `MethodKind` и операторов (`[]`, `[]=`, `~`, унарный `-`, бинарные).
  - `test/source_parser_test.dart` — `parseLibraryClassOptional` на маленьких inline-фикстурах: класс с публичным методом и `int`-параметром; класс с getter/setter/operator; класс с factory и static; выбор класса с наибольшим числом методов; respect `--class`.
  - `test/cli_help_test.dart` — `handleEarlyExitFlags(['--help'])` / `['--version']` (через перехват `stdout` без spawn'а процесса — функция вызывается напрямую), `resolveVersion()` возвращает версию из `pubspec.yaml` репозитория.
- Структура: каждый test-файл независим, использует только публичные API из `package:dart_test_gen/...`. Никаких глобальных setUp / tearDown, никаких spawn-процессов в этих файлах (CLI-spawn уже покрыт в `cli_smoke_test.dart`).
- Не покрываем: `cli_log.dart` / `cli_progress.dart` — это I/O-обёртки без чистых функций; `resolved_dependencies.dart` — интеграция с реальным `package_config.json`, проще тестировать через showcase. Перечисляем явно в design как Non-Goals.

## Capabilities

### New Capabilities
- `lib-unit-test-coverage`: набор юнит-тестов на чистые публичные функции `lib/` (sampling, gen_config.load, parseCliArgs, path helpers, dartLiteralFromJson, snapshotInvokeExpression, source-parser на inline-фикстурах, cli_help helpers). Требования формулируются как «для каждого перечисленного модуля существует test-файл, который покрывает указанные сценарии».

### Modified Capabilities
<!-- none — это чисто инфраструктурное добавление тестов, требования к коду не меняются -->

## Impact

- Новые файлы: 8 тестовых модулей в `test/`. Прироста времени `dart test` ожидается умеренный: все добавляемые тесты — чистые, без `Process.run` и без `Isolate.spawn`, в отличие от существующих smoke/snapshot-тестов.
- Никаких изменений в `lib/` не предполагается. Если по ходу написания тестов обнаружится баг или плохо тестируемый API — поднимем отдельный change.
- Зависимости: используем уже подключённые `package:test`, `package:path`, `package:yaml`. Ничего нового добавлять не нужно.
- CI / документация: упомянуть в README раздел «Как верифицировать изменения» (если он есть) или просто оставить статус-кво — `dart test` уже стандартная команда.
