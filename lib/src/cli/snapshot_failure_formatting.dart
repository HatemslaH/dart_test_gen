import 'package:dart_test_gen/snapshot.dart';

/// Structured, user-facing rendering of a [SnapshotRunnerFailure].
String formatSnapshotRunnerFailure(SnapshotRunnerFailure f) {
  final ctx = StringBuffer('[${f.absoluteLibPath}');
  if (f.className != null) {
    ctx.write(' ${f.className}');
    if (f.methodName != null) ctx.write('.${f.methodName}');
    ctx.write(']');
  } else {
    ctx.write(']');
  }
  final tail = f.dartStderrTail.trimRight();
  final indentedTail = tail.isEmpty ? '    <empty>' : tail.split('\n').map((l) => '    $l').join('\n');
  return [
    'Snapshot runner failed (${f.stage}) for $ctx',
    '  runner kept at: ${f.runnerPath}',
    if (f.exitCode != null) '  dart exit code: ${f.exitCode}',
    '  dart stderr (tail):',
    indentedTail,
    '  hints:',
    '    - re-run with -v for the full log',
    '    - open the runner file to inspect the generated snapshot code',
    '    - if this looks like a generator bug, attach the runner file to the report',
    '',
  ].join('\n');
}
