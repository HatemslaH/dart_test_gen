## Context

В `lib/` десять файлов, из которых прямые юнит-тесты есть для четырёх частей: `MethodConfig.fromYaml`, `formatSnapshotRunnerFailure`, `publicExceptionName`, и CLI смоук-тест через `Process.run`. Остальное тестируется только косвенно — генератор регенерирует showcase-тесты в `example/lib/usecases/`, и если итоговые тест-файлы компилируются и проходят, считается, что код жив. Это маскирует регрессии: при поломке, скажем, `_collectionSingleTypeArg` или `_randomSample` тяжело локализовать причину; кроме того, любой рефакторинг требует прогона тяжёлой интеграции через `Process.run('dart', ...)`.

Цель — добавить набор быстрых, изолированных юнит-тестов на публичные чистые функции `lib/`, не дублируя то, что уже покрыто smoke- и snapshot-failure тестами.

## Goals / Non-Goals

**Goals:**
- Покрыть юнит-тестами все чистые публичные функции из `sampling.dart`, `gen_config.dart` (часть `load`), `generate_pipeline.dart` (parseCliArgs, path helpers), `snapshot.dart` (литералы, выражения вызова), `source_parser.dart` (parseLibraryClassOptional на inline-фикстурах), `cli_help.dart` (handleEarlyExitFlags, resolveVersion).
- Тесты должны выполняться за секунды, без `Process.run` и без `Isolate.spawn`.
- Тесты не должны зависеть от точного содержимого generated-фикстур в `example/lib/usecases/`.

**Non-Goals:**
- `cli_log.dart` / `cli_progress.dart`: тонкие обёртки над `stdout`/`stderr` и состоянием UI. Тестировать их через захват вывода — больше шума, чем пользы; оставляем покрытыми косвенно.
- `resolved_dependencies.dart`: работает с реальным `package_config.json`. Корректно тестируется только через сценарии showcase, что мы уже имеем.
- Интеграционные сценарии (полный CLI запуск, snapshot-runner поведение) — уже покрыты существующими `cli_smoke_test.dart` и `snapshot_runner_failure_test.dart`.
- Не добиваемся 100% line coverage; цель — функциональное покрытие ключевого API.

## Decisions

### D1. Один test-файл на смысловой блок, имена по модулю

Файлы создаются один к одному с интуитивными именами (`sampling_test.dart`, `cli_args_parser_test.dart`, …). Не группируем «всё про `snapshot.dart`» в один файл — разделяем по теме (литералы vs выражения вызова), чтобы при росте кода легче было читать и параллелить.

Альтернатива: один большой `lib_units_test.dart`. Отклонена: при добавлении нового кейса будет постоянно расти один файл, плюс хуже навигация.

### D2. Inline-фикстуры для парсера

`parseLibraryClassOptional` принимает абсолютный путь — в тестах кладём временный `.dart` файл через `Directory.systemTemp.createTempSync()` и подаём его. Это держит фикстуры рядом с проверяемой логикой и не требует поддерживать отдельный каталог `test/fixtures/`.

### D3. `parseCliArgs` тестируем напрямую

Функция возвращает record-тип; тестируем именно поля record'а. Случаи с `exit(64)` (например, неверное `--double-epsilon`) проверяем через `expect(() => parseCliArgs(...), throwsA(anything))` либо через изоляцию с `runZonedGuarded` — в текущем коде `exit` обрывает процесс. Лучше: добавить тест **только на валидные комбинации** и явно отметить в комментарии, что валидация выхода (`exit(64)`) покрыта CLI smoke-тестами. Это compromise: не вызываем `Process` и не падаем в `dart test`.

### D4. `resolveVersion` и `handleEarlyExitFlags`

`resolveVersion()` — детерминирована из cwd / `Platform.script` ; в тесте cwd = корень репозитория, поэтому `resolveVersion()` должен вернуть строку из `pubspec.yaml`. Утверждаем `expect(resolveVersion(), matches(RegExp(r'^\d+\.\d+\.\d+')))` и `expect(resolveVersion(), readPubspecVersion())`, где `readPubspecVersion()` — локальный helper в тесте.

`handleEarlyExitFlags` пишет в `stdout` через `stdout.write`. Захватываем через `IOOverrides.runZoned` или `runZoned` с заменой `print`. Проще: тестировать только возвращаемое значение `bool` (true/false) на разных аргументах, а проверку самого вывода оставить за `cli_smoke_test.dart`.

### D5. Снимок-литералы: входы как чистый JSON

`dartLiteralFromJson` принимает `dynamic value, String returnType, List<ClassInfo>`. В тестах подаём JSON-эквивалент (Map / List / num / String / bool / null) — без необходимости запускать раннер. Это резко упрощает тестирование всех веток (`List<int>`, `Set<int>` отсортированный, `Iterable<int>`, `Map<String, int>`, enum-формат `_enumType`/`_enumName`, пользовательский класс, fallback с `_value`).

### D6. Sampling: фиксируем порядок и детерминизм

Для `random` стратегии проверяем: (а) что результат содержит ровно `maxCases` элементов; (б) что при одинаковом `seed` результат стабилен; (в) что при `seed = null` — не проверяем порядок, только размер. Mandatory rows (`throwsType != null`) всегда сохраняются в начале (порядок документирован в коде).

## Risks / Trade-offs

- **[R1] Inline-фикстуры для `parseLibraryClassOptional` дублируют логику showcase.** → Согласовываем: тесты *проверяют API парсера на минимальных входах*, showcase *проверяет интеграцию*. Это разные роли.
- **[R2] Захват `stdout` в тестах на `handleEarlyExitFlags` хрупкий.** → Уже учтено в D4: тестируем только возвращаемое значение.
- **[R3] `parseCliArgs` падает в `exit(64)` на невалидных входах.** → Согласовано в D3: тестируем только валидные входы; невалидные ловит CLI smoke.
- **[R4] Растёт время `dart test`.** → Все новые тесты — чистые, оценочно <1 с на файл. Текущее время `dart test` ~10 с (доминируют `Process.run`-тесты). Прирост незначителен.

## Migration Plan

1. Добавить тесты по одному файлу, начиная с самых изолированных (sampling → gen_config_load → snapshot_literals → snapshot_invoke_expression → cli_args_parser → generate_pipeline_paths → cli_help → source_parser).
2. После каждого файла прогонять `dart test` и убеждаться, что весь набор зелёный.
3. По завершении упомянуть в README в разделе «Как верифицировать» (если такой есть) или оставить как есть.

Rollback: тривиально — тесты независимы, можно удалять любые без влияния на код.

## Open Questions

- Стоит ли вводить общий хелпер `test/_helpers/temp_dart_file.dart` для создания tmp-файлов с Dart-кодом? Решение: вводим только если три и более теста потребуют этой логики; иначе оставляем inline.
