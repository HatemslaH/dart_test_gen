import 'dart:convert';
import 'dart:io';

import 'package:dart_test_gen/dart_test_gen.dart';
import 'package:path/path.dart' as p;

/// Generates the runner source, executes it, and returns snapshots per method.
///
/// [onSnapshotFraction] — sub-progress for the snapshot stage only, 0 to 1.
/// [onVerboseLine] — verbose lines (typically only with `-v`).
/// [onRunnerFailed] — output when the `dart run` runner process fails (stderr/stdout).
List<MethodSnapshot> runSnapshots(SnapshotRunContext ctx) {
  final parsed = ctx.parsed;
  final packageRoot = ctx.packageRoot;
  final packageName = ctx.packageName;
  final absoluteLibPath = ctx.absoluteLibPath;
  final extraPackageImports = ctx.extraPackageImports;
  final logLabel = ctx.logLabel;
  final onSnapshotFraction = ctx.onSnapshotFraction;
  final onVerboseLine = ctx.onVerboseLine;
  final onRunnerFailed = ctx.onRunnerFailed;
  final keepRunner = ctx.keepRunner;
  final processRunner = ctx.processRunner;

  void sl(String step, String detail) => SnapshotRunHelpers.snapshotVerboseLine(onVerboseLine, logLabel, step, detail);

  void frac(double v) => onSnapshotFraction?.call(v.clamp(0.0, 1.0));

  frac(0);

  final runnerDir = Directory(p.join(Directory.systemTemp.path, 'dart_test_gen'));
  runnerDir.createSync(recursive: true);
  final runnerPath = p.join(
    runnerDir.path,
    'snapshot_runner_${parsed.className}_${DateTime.now().microsecondsSinceEpoch}.dart',
  );

  sl('runner', 'writing temporary script…');
  frac(0.08);

  final source = buildSnapshotRunnerSource(
    packageRoot: packageRoot,
    packageName: packageName,
    absoluteLibPath: absoluteLibPath,
    extraPackageImports: extraPackageImports,
    className: parsed.className,
    methods: parsed.methods,
    allFileClasses: parsed.allFileClasses,
  );

  File(runnerPath).writeAsStringSync(source);
  sl('runner', runnerPath);
  frac(0.22);

  var success = false;
  try {
    sl('process', 'dart run snapshot runner…');
    frac(0.38);
    final packageConfig = p.join(packageRoot, '.dart_tool', 'package_config.json');
    final result = processRunner.runSync(
      Platform.resolvedExecutable,
      ['run', '--packages=$packageConfig', runnerPath],
      workingDirectory: packageRoot,
      runInShell: false,
    );
    if (result.exitCode != 0) {
      final se = result.stderr;
      final so = result.stdout;
      onRunnerFailed?.call(se, so);
      throw SnapshotRunnerFailure(
        stage: 'compile',
        absoluteLibPath: absoluteLibPath,
        className: parsed.className,
        runnerPath: runnerPath,
        dartStderrTail: SnapshotRunHelpers.tailLinesForLog(se.isNotEmpty ? se : so, 40),
        exitCode: result.exitCode,
      );
    }
    sl('process', 'exit 0, decoding JSON…');
    frac(0.92);
    final raw = result.stdout;
    dynamic decoded;
    try {
      decoded = jsonDecode(raw);
    } catch (e) {
      onRunnerFailed?.call(result.stderr, raw);
      throw SnapshotRunnerFailure(
        stage: 'parse',
        absoluteLibPath: absoluteLibPath,
        className: parsed.className,
        runnerPath: runnerPath,
        dartStderrTail: SnapshotRunHelpers.tailLinesForLog(
          'jsonDecode failed: $e\nstdout (head):\n${raw.length > 4000 ? raw.substring(0, 4000) : raw}',
          40,
        ),
      );
    }
    if (decoded is! List) {
      onRunnerFailed?.call(result.stderr, raw);
      throw SnapshotRunnerFailure(
        stage: 'parse',
        absoluteLibPath: absoluteLibPath,
        className: parsed.className,
        runnerPath: runnerPath,
        dartStderrTail: SnapshotRunHelpers.tailLinesForLog('expected JSON array, got: $decoded', 40),
      );
    }
    frac(1.0);
    final merged = mergeDecodedSnapshots(parsed.methods, parsed.allFileClasses, decoded);
    success = true;
    return merged;
  } finally {
    if (success && !keepRunner) {
      try {
        File(runnerPath).deleteSync();
      } catch (_) {}
    }
  }
}
