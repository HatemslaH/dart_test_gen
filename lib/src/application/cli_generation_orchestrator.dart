import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:dart_test_gen/dart_test_gen.dart';
import 'package:path/path.dart' as p;

/// CLI orchestration: resolve targets, config, then single-thread or isolate fan-out.
final class CliGenerationOrchestrator {
  CliGenerationOrchestrator(AppDependencies deps) : _deps = deps;

  final AppDependencies _deps;

  Future<void> run(List<String> args) async {
    final CliResult parsedArgs;
    try {
      parsedArgs = CliArgs.parseCliArgs(args);
    } on InvalidCliArgumentsException catch (e) {
      CliLog.err('${e.message}\n');
      exit(64);
    }

    final cwd = _deps.filesystem.currentWorkingDirectory;
    List<String> targets;
    try {
      targets = expandGenerationTargetsWithFs(_deps.filesystem, cwd, parsedArgs.inputs);
    } on GenerationTargetError catch (e) {
      CliLog.err('${e.message}\n');
      exit(e.exitCode);
    }

    if (targets.isEmpty) {
      CliLog.err('No .dart files found.');
      exit(1);
    }

    final packageRoots = targets.map(findPackageRootForFile).toSet();
    if (packageRoots.length != 1) {
      CliLog.err(
        'All paths must belong to the same package (one pubspec).\n'
        'Found package roots: ${packageRoots.join(", ")}',
      );
      exit(1);
    }
    final packageRoot = packageRoots.first;

    final before = targets.length;
    targets = targets.where((t) => _isDartUnderLib(t, packageRoot)).toList();
    if (targets.isEmpty) {
      CliLog.err(
        'After filtering, no files remain under $packageRoot${p.separator}lib '
        '(candidates before filter: $before).',
      );
      exit(1);
    }

    if (parsedArgs.className != null && targets.length != 1) {
      CliLog.err(
        '--class selects one class: pass exactly one .dart under lib or a single target.\n'
        'Targets after filter: ${targets.length}.',
      );
      exit(64);
    }

    final packageName = readPackageName(packageRoot);

    if ((parsedArgs.dryRun ?? false) && (parsedArgs.check ?? false)) {
      CliLog.err('--dry-run and --check are mutually exclusive: pick one.');
      exit(64);
    }

    var config = _deps.configReader.loadConfig(packageRoot, configPath: parsedArgs.configPath);
    if (parsedArgs.strategy != null ||
        parsedArgs.maxCases != null ||
        parsedArgs.seed != null ||
        parsedArgs.useCloseForDouble != null ||
        parsedArgs.doubleEpsilon != null ||
        parsedArgs.useExpectMatchersBoolNull != null ||
        parsedArgs.keepRunner != null ||
        parsedArgs.dryRun != null ||
        parsedArgs.check != null) {
      config = GeneratorConfig(
        defaults: config.defaults.copyWith(
          strategy: parsedArgs.strategy != null ? SamplingStrategy.fromString(parsedArgs.strategy) : null,
          maxCases: parsedArgs.maxCases,
          seed: parsedArgs.seed,
          useCloseForDouble: parsedArgs.useCloseForDouble,
          doubleEpsilon: parsedArgs.doubleEpsilon,
          useExpectMatchersBoolNull: parsedArgs.useExpectMatchersBoolNull,
        ),
        methods: config.methods,
        keepRunner: parsedArgs.keepRunner ?? config.keepRunner,
        dryRun: parsedArgs.dryRun ?? config.dryRun,
        check: parsedArgs.check ?? config.check,
      );
    }

    final labels = targets.map((t) => shortLibLabel(t, packageRoot)).toList();
    final ui = GenerationProgressUi.create(labels);

    if (parsedArgs.verbose) {
      CliLog.err('[cli]\tverbose\tpkg=$packageRoot\tfiles=${targets.length}\n');
    }

    if (targets.length == 1) {
      final label = labels.first;
      late final SingleLibraryGenerationResult genResult;
      try {
        genResult = await _deps.singleLibraryGenerator.generateSingleLibraryFile(
          filesystem: _deps.filesystem,
          generator: _deps.defaultGenerator,
          absoluteLibPath: targets.first,
          packageRoot: packageRoot,
          packageName: packageName,
          className: parsedArgs.className,
          displayLabel: label,
          verbose: parsedArgs.verbose,
          config: config,
          emit: _mainThreadEmit(progressUi: ui, displayLabel: label, verbose: parsedArgs.verbose),
        );
      } on SnapshotRunnerFailure catch (f) {
        ui.finish();
        CliLog.err(_deps.cli.snapshotFailureFormatter.format(f));
        exit(1);
      } catch (e, st) {
        ui.finish();
        CliLog.err('Error: $e\n$st');
        exit(1);
      }
      ui.finish();
      final outLine = genResult.stdoutLine;
      if (outLine != null) {
        CliLog.out(outLine);
      }
      final checkFailure = genResult.checkFailure;
      if (checkFailure != null) {
        CliLog.err(checkFailure.summary);
        CliLog.err('[check] 1 file(s) differ');
        exit(1);
      }
      return;
    }

    final futures = <Future<void>>[];
    final checkFailureSummaries = <String>[];

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
          if (t == GenerationIsolateProtocol.msgProgress) {
            final lab = message['l']! as String;
            final pct = (message['pct'] as num).toDouble();
            ui.setPercent(lab, pct);
            return;
          }
          if (t == GenerationIsolateProtocol.msgVerbose && parsedArgs.verbose) {
            final m = message['m'] as String? ?? '';
            CliLog.err(m.endsWith('\n') ? m : '$m\n');
            return;
          }
          if (t == GenerationIsolateProtocol.msgError) {
            final m = message['m'] as String? ?? '';
            CliLog.err(m.endsWith('\n') ? m : '$m\n');
            return;
          }
          if (t == GenerationIsolateProtocol.msgCheckFail) {
            final s = message['s'] as String? ?? '';
            checkFailureSummaries.add(s);
            return;
          }
          if (t == GenerationIsolateProtocol.msgStdout) {
            final m = message['m'] as String? ?? '';
            if (m.isNotEmpty) {
              CliLog.out(m);
            }
            return;
          }
          return;
        }
        if (message is String && message.startsWith(GenerationIsolateProtocol.isolateResultPrefix)) {
          success = message.endsWith(':ok');
          sawResult = true;
          return;
        }
        if (message == GenerationIsolateProtocol.isolateDoneSentinel) {
          if (!doneSent) {
            doneSent = true;
            if (!sawResult) {
              done.completeError(StateError('isolate finished without result: $libAbs'));
            } else if (success) {
              done.complete();
            } else {
              done.completeError(StateError('generation failed: $libAbs'));
            }
          }
          return;
        }
      });

      futures.add(done.future.then((_) async {
        await sub?.cancel();
        receivePort.close();
      }));

      final isolateMessage = _deps.isolateMessageSpawner.spawnMessage(
        absoluteLibPath: libAbs,
        packageRoot: packageRoot,
        packageName: packageName,
        className: parsedArgs.className,
        displayLabel: displayLabel,
        verbose: parsedArgs.verbose,
        config: config,
        logPort: receivePort.sendPort,
      );

      await Isolate.spawn(
        _deps.isolateMessageSpawner.generationIsolateMain,
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
        CliLog.err('Error: $e\n$st');
      }
    }

    ui.finish();

    if (aggregateError != null) {
      exit(1);
    }

    if (checkFailureSummaries.isNotEmpty) {
      for (final s in checkFailureSummaries) {
        CliLog.err(s);
      }
      CliLog.err('[check] ${checkFailureSummaries.length} file(s) differ');
      exit(1);
    }
  }

  EmitGenerationUi _mainThreadEmit({
    required GenerationProgressUi progressUi,
    required String displayLabel,
    required bool verbose,
  }) =>
      ({double? progress, String? line, bool? error}) {
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

  bool _isDartUnderLib(String absoluteFile, String packageRoot) {
    final libRoot = p.normalize(p.join(packageRoot, 'lib'));
    final file = p.normalize(absoluteFile);
    return p.isWithin(libRoot, file);
  }
}
