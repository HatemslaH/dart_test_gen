import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:path/path.dart' as p;

import 'cli_log.dart';
import 'cli_progress.dart';
import 'snapshot.dart';
import 'source_parser.dart';
import 'test_generator.dart';

/// UI-колбэк: прогресс 0–100, подробная строка; [error]==true — в stderr всегда.
typedef EmitGenerationUi = void Function({double? progress, String? line, bool? error});

/// Сообщения из изолята (только sendable-типы).
const _msgProgress = 'p';
const _msgVerbose = 'v';
const _msgError = 'e';

/// После [isolateResultPrefix] идёт [isolateDoneSentinel].
const isolateResultPrefix = '__dart_test_gen_result__';
const isolateDoneSentinel = '__dart_test_gen_isolate_done__';

Map<String, Object?> generationIsolateSpawnMessage({
  required String absoluteLibPath,
  required String packageRoot,
  required String packageName,
  required String? className,
  required String displayLabel,
  required bool verbose,
  required SendPort logPort,
}) =>
    <String, Object?>{
      'absoluteLibPath': absoluteLibPath,
      'packageRoot': packageRoot,
      'packageName': packageName,
      'className': className,
      'displayLabel': displayLabel,
      'verbose': verbose,
      'logPort': logPort,
    };

@pragma('vm:entry-point')
void generationIsolateMain(Map<String, Object?> message) {
  final path = message['absoluteLibPath']! as String;
  final root = message['packageRoot']! as String;
  final pkg = message['packageName']! as String;
  final className = message['className'] as String?;
  final displayLabel = message['displayLabel']! as String;
  final verbose = message['verbose']! as bool;
  final port = message['logPort']! as SendPort;

  void bridge({double? progress, String? line, bool? error}) {
    final isErr = error == true;
    if (progress != null) {
      port.send(<String, Object?>{'t': _msgProgress, 'l': displayLabel, 'pct': progress});
    }
    if (line != null && (verbose || isErr)) {
      port.send(<String, Object?>{
        't': isErr ? _msgError : _msgVerbose,
        'm': line,
      });
    }
  }

  var ok = false;
  try {
    generateSingleLibraryFile(
      absoluteLibPath: path,
      packageRoot: root,
      packageName: pkg,
      className: className,
      displayLabel: displayLabel,
      verbose: verbose,
      emit: bridge,
    );
    ok = true;
  } catch (e, st) {
    bridge(
      line: 'ERROR\t$e\n$st\n',
      error: true,
    );
  }
  port.send('$isolateResultPrefix:${ok ? "ok" : "fail"}');
  port.send(isolateDoneSentinel);
}

/// Разбор аргументов: пути, `--class`, `-v` / `--verbose`.
({List<String> inputs, String? className, bool verbose}) parseCliArgs(List<String> args) {
  String? className;
  var verbose = false;
  final rest = <String>[];
  for (var i = 0; i < args.length; i++) {
    final a = args[i];
    if (a == '--class' && i + 1 < args.length) {
      className = args[++i];
    } else if (a == '-v' || a == '--verbose') {
      verbose = true;
    } else {
      rest.add(a);
    }
  }
  if (rest.isEmpty) {
    CliLog.err(
      'Использование: dart run bin/generate.dart <путь> [путь …] [--class ClassName] [-v|--verbose]\n'
      '  путь — файл .dart внутри lib/ или каталог (рекурсивно).\n'
      '  --class — только при одном целевом .dart после фильтра.\n'
      '  -v — подробный лог (stderr), прогресс остаётся на stdout.',
    );
    exit(64);
  }
  return (inputs: rest, className: className, verbose: verbose);
}

String _absolute(String cwd, String userPath) {
  final normalized = p.normalize(userPath);
  if (p.isAbsolute(normalized)) return normalized;
  return p.normalize(p.join(cwd, normalized));
}

/// Все `.dart` файлы под каталогом [dirAbs] (рекурсивно).
List<String> dartFilesUnderDirectory(String dirAbs) {
  final root = Directory(dirAbs);
  final out = <String>[];
  if (!root.existsSync()) return out;
  for (final entity in root.listSync(recursive: true, followLinks: false)) {
    if (entity is! File) continue;
    if (!p.basename(entity.path).endsWith('.dart')) continue;
    out.add(p.normalize(entity.path));
  }
  out.sort();
  return out;
}

/// Раскрывает файлы и каталоги в упорядоченный список `.dart` абсолютных путей.
List<String> expandGenerationTargets(String cwd, List<String> inputs) {
  final seen = <String>{};
  final out = <String>[];
  for (final raw in inputs) {
    final abs = _absolute(cwd, raw);
    final type = FileSystemEntity.typeSync(abs);
    if (type == FileSystemEntityType.notFound) {
      CliLog.err('Не найден путь: $abs');
      exit(1);
    }
    if (type == FileSystemEntityType.file) {
      if (!abs.endsWith('.dart')) {
        CliLog.err('Укажите файл .dart: $abs');
        exit(1);
      }
      if (seen.add(abs)) out.add(abs);
      continue;
    }
    if (type == FileSystemEntityType.directory) {
      for (final f in dartFilesUnderDirectory(abs)) {
        if (seen.add(f)) out.add(f);
      }
      continue;
    }
    CliLog.err('Неподдерживаемый тип пути: $abs');
    exit(1);
  }
  return out;
}

/// `lib/a/b.dart` → `test/a/b_test.dart`
String testOutputPathForLib(String packageRoot, String absoluteLibPath) {
  final libRoot = p.join(packageRoot, 'lib');
  final rel = p.relative(absoluteLibPath, from: libRoot);
  if (rel.startsWith('..')) {
    throw StateError('Файл должен находиться внутри $libRoot, получено: $absoluteLibPath');
  }
  final dir = p.dirname(rel);
  final base = p.basenameWithoutExtension(rel);
  final testTail = dir == '.' ? '${base}_test.dart' : p.join(dir, '${base}_test.dart');
  return p.join(packageRoot, 'test', testTail);
}

String importPathForTestFile(String testFileAbs, String libFileAbs) {
  final rel = p.relative(libFileAbs, from: p.dirname(testFileAbs));
  return rel.replaceAll(r'\', '/');
}

String shortLibLabel(String absoluteLibPath, String packageRoot) {
  final libRoot = p.join(packageRoot, 'lib');
  try {
    return p.relative(absoluteLibPath, from: libRoot).replaceAll(r'\', '/');
  } catch (_) {
    return p.basename(absoluteLibPath);
  }
}

EmitGenerationUi _mainThreadEmit({
  required GenerationProgressUi progressUi,
  required String displayLabel,
  required bool verbose,
}) {
  return ({double? progress, String? line, bool? error}) {
    final isErr = error == true;
    if (progress != null) {
      progressUi.setPercent(displayLabel, progress);
    }
    if (line != null && line.isNotEmpty) {
      if (isErr) {
        CliLog.err(line.endsWith('\n') ? line : '$line\n');
      } else if (verbose) {
        CliLog.err(line.endsWith('\n') ? line : '$line\n');
      }
    }
  };
}

/// Одна генерация.
void generateSingleLibraryFile({
  required String absoluteLibPath,
  required String packageRoot,
  required String packageName,
  required String? className,
  required String displayLabel,
  required bool verbose,
  required EmitGenerationUi emit,
}) {
  void v(String phase, String detail) {
    if (!verbose) return;
    emit(line: '[$displayLabel]\t$phase\t$detail\n');
  }

  emit(progress: 5);
  v('init', absoluteLibPath);

  final parsed = parseLibraryClass(absoluteLibPath, className: className);
  emit(progress: 14);
  v('parse', 'class=${parsed.className}, methods=${parsed.methods.length}');

  const snapStart = 14.0;
  const snapWidth = 54.0;

  final snapshots = runSnapshots(
    packageRoot: packageRoot,
    packageName: packageName,
    absoluteLibPath: absoluteLibPath,
    parsed: parsed,
    logLabel: displayLabel,
    onSnapshotFraction: (f) => emit(progress: snapStart + snapWidth * f),
    onVerboseLine: verbose
        ? (ln) {
            emit(line: ln);
          }
        : null,
    onRunnerFailed: (se, so) {
      emit(
        line: 'snapshot runner stderr:\n$se\nsnapshot runner stdout:\n$so\n',
        error: true,
      );
    },
  );

  emit(progress: 72);
  v('snapshot', 'decode OK');

  if (snapshots.length != parsed.methods.length) {
    throw StateError('несогласованность снимков и методов');
  }

  final methods = <MethodSpec>[];
  for (var i = 0; i < parsed.methods.length; i++) {
    final m = parsed.methods[i];
    final snap = snapshots[i];
    if (snap.methodName != m.name) {
      throw StateError('несогласованность имён методов');
    }
    final rows = <TestCaseRow>[];
    for (final r in snap.rows) {
      if (r.throwsExceptionType != null) {
        rows.add(
          TestCaseRow(
            argLiterals: r.argLiterals,
            throwsType: r.throwsExceptionType,
          ),
        );
      } else if (m.returnType == 'void') {
        rows.add(TestCaseRow(argLiterals: r.argLiterals));
      } else {
        final lit = r.expectedDartLiteral;
        if (lit == null) {
          throw StateError('ожидался expectedDartLiteral для ${m.name}');
        }
        rows.add(TestCaseRow(argLiterals: r.argLiterals, expectedLiteral: lit));
      }
    }
    methods.add(
      MethodSpec(
        name: m.name,
        params: m.params,
        returnType: m.returnType,
        testCases: rows,
      ),
    );
  }

  emit(progress: 78);
  final testOut = testOutputPathForLib(packageRoot, absoluteLibPath);
  final importPath = importPathForTestFile(testOut, absoluteLibPath);
  v('render', importPath);

  final content = generateTestFile(
    className: parsed.className,
    importPath: importPath,
    methods: methods,
  );

  emit(progress: 90);
  writeTestFile(testOut, content);
  emit(progress: 100);
  v('done', testOut);
}

bool _isDartUnderLib(String absoluteFile, String packageRoot) {
  final libRoot = p.normalize(p.join(packageRoot, 'lib'));
  final file = p.normalize(absoluteFile);
  return p.isWithin(libRoot, file);
}

/// CLI.
Future<void> generateFromCli(List<String> args) async {
  final parsedArgs = parseCliArgs(args);
  final cwd = Directory.current.path;
  var targets = expandGenerationTargets(cwd, parsedArgs.inputs);

  if (targets.isEmpty) {
    CliLog.err('Не найдено ни одного .dart файла.');
    exit(1);
  }

  final packageRoots = targets.map(findPackageRootForFile).toSet();
  if (packageRoots.length != 1) {
    CliLog.err(
      'Все пути должны относиться к одному пакету (один pubspec рядом).\n'
      'Найдено корней: ${packageRoots.join(", ")}',
    );
    exit(1);
  }
  final packageRoot = packageRoots.first;

  final before = targets.length;
  targets = targets.where((t) => _isDartUnderLib(t, packageRoot)).toList();
  if (targets.isEmpty) {
    CliLog.err(
      'После фильтрации не осталось файлов в $packageRoot${p.separator}lib '
      '(было кандидатов: $before).',
    );
    exit(1);
  }

  if (parsedArgs.className != null && targets.length != 1) {
    CliLog.err(
      '--class задаёт один класс: укажите ровно один .dart под lib или одну цель без лишних файлов.\n'
      'Сейчас целей после фильтра: ${targets.length}.',
    );
    exit(64);
  }

  final packageName = readPackageName(packageRoot);
  final labels = targets.map((t) => shortLibLabel(t, packageRoot)).toList();
  final ui = GenerationProgressUi.create(labels);

  if (parsedArgs.verbose) {
    CliLog.err('[cli]\tverbose\tpkg=$packageRoot\tfiles=${targets.length}\n');
  }

  if (targets.length == 1) {
    final label = labels.first;
    try {
      generateSingleLibraryFile(
        absoluteLibPath: targets.first,
        packageRoot: packageRoot,
        packageName: packageName,
        className: parsedArgs.className,
        displayLabel: label,
        verbose: parsedArgs.verbose,
        emit: _mainThreadEmit(progressUi: ui, displayLabel: label, verbose: parsedArgs.verbose),
      );
    } catch (e, st) {
      ui.finish();
      CliLog.err('Ошибка: $e\n$st');
      exit(1);
    }
    ui.finish();
    return;
  }

  final futures = <Future<void>>[];

  for (final libAbs in targets) {
    final receivePort = ReceivePort();
    final displayLabel = shortLibLabel(libAbs, packageRoot);

    final done = Completer<void>();
    var doneSent = false;
    var success = false;
    var sawResult = false;

    StreamSubscription<Object?>? sub;
    sub = receivePort.listen((message) {
      if (message is Map) {
        final t = message['t'] as String?;
        if (t == _msgProgress) {
          final lab = message['l']! as String;
          final pct = (message['pct'] as num).toDouble();
          ui.setPercent(lab, pct);
          return;
        }
        if (t == _msgVerbose && parsedArgs.verbose) {
          final m = message['m'] as String? ?? '';
          CliLog.err(m.endsWith('\n') ? m : '$m\n');
          return;
        }
        if (t == _msgError) {
          final m = message['m'] as String? ?? '';
          CliLog.err(m.endsWith('\n') ? m : '$m\n');
          return;
        }
        return;
      }
      if (message is String && message.startsWith(isolateResultPrefix)) {
        success = message.endsWith(':ok');
        sawResult = true;
        return;
      }
      if (message == isolateDoneSentinel) {
        if (!doneSent) {
          doneSent = true;
          if (!sawResult) {
            done.completeError(StateError('изолят без результата: $libAbs'));
          } else if (success) {
            done.complete();
          } else {
            done.completeError(StateError('сбой генерации: $libAbs'));
          }
        }
        return;
      }
    });

    futures.add(done.future.then((_) async {
      await sub?.cancel();
      receivePort.close();
    }));

    final isolateMessage = generationIsolateSpawnMessage(
      absoluteLibPath: libAbs,
      packageRoot: packageRoot,
      packageName: packageName,
      className: null,
      displayLabel: displayLabel,
      verbose: parsedArgs.verbose,
      logPort: receivePort.sendPort,
    );

    await Isolate.spawn(
      generationIsolateMain,
      isolateMessage,
      errorsAreFatal: false,
      debugName: p.basename(libAbs),
    );
  }

  Object? aggregateError;
  for (final f in futures) {
    try {
      await f;
    } catch (e, st) {
      aggregateError ??= e;
      CliLog.err('Пакет: $e\n$st');
    }
  }

  ui.finish();

  if (aggregateError != null) {
    exit(1);
  }
}
