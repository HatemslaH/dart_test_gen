import 'package:dart_test_gen/src/domain/models/snapshot_models.dart';

/// Structured, user-facing rendering of a [SnapshotRunnerFailure].
final class SnapshotFailureFormatter {
  const SnapshotFailureFormatter();

  String format(SnapshotRunnerFailure failure) {
    final ctx = StringBuffer('[${failure.absoluteLibPath}');
    if (failure.className != null) {
      ctx.write(' ${failure.className}');
      if (failure.methodName != null) ctx.write('.${failure.methodName}');
      ctx.write(']');
    } else {
      ctx.write(']');
    }
    final tail = failure.dartStderrTail.trimRight();
    final indentedTail =
        tail.isEmpty ? '    <empty>' : tail.split('\n').map((l) => '    $l').join('\n');
    return [
      'Snapshot runner failed (${failure.stage}) for $ctx',
      '  runner kept at: ${failure.runnerPath}',
      if (failure.exitCode != null) '  dart exit code: ${failure.exitCode}',
      '  dart stderr (tail):',
      indentedTail,
      '  hints:',
      '    - re-run with -v for the full log',
      '    - open the runner file to inspect the generated snapshot code',
      '    - if this looks like a generator bug, attach the runner file to the report',
      '',
    ].join('\n');
  }
}
