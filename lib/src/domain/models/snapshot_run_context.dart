import 'package:dart_test_gen/src/domain/ports/process_runner.dart';

import 'parsed_models.dart';

/// Optional callbacks and flags for [runSnapshots].
final class SnapshotRunContext {
  const SnapshotRunContext({
    required this.packageRoot,
    required this.packageName,
    required this.absoluteLibPath,
    required this.parsed,
    required this.processRunner,
    this.extraPackageImports = const [],
    this.logLabel = '',
    this.onSnapshotFraction,
    this.onVerboseLine,
    this.onRunnerFailed,
    this.keepRunner = false,
  });

  final String packageRoot;
  final String packageName;
  final String absoluteLibPath;
  final ParsedClass parsed;
  final ProcessRunner processRunner;

  final List<String> extraPackageImports;
  final String logLabel;
  final void Function(double fraction01)? onSnapshotFraction;
  final void Function(String line)? onVerboseLine;
  final void Function(String stderrText, String stdoutText)? onRunnerFailed;
  final bool keepRunner;
}
