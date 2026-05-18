import 'package:dart_test_gen/dart_test_gen.dart';

/// Composition root for CLI presentation (help, early exit, failure formatting).
final class CliDependencies {
  CliDependencies({
    required this.earlyExitHandler,
    required this.snapshotFailureFormatter,
  });

  final EarlyExitHandler earlyExitHandler;
  final SnapshotFailureFormatter snapshotFailureFormatter;

  factory CliDependencies.production() => CliDependencies(
        earlyExitHandler: EarlyExitHandler(
          helpText: cliHelpText,
          resolveVersion: resolveVersion,
        ),
        snapshotFailureFormatter: const SnapshotFailureFormatter(),
      );
}
