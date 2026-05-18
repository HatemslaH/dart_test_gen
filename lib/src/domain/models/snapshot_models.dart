/// Structured failure of the snapshot subprocess: compile error or unparsable stdout.
class SnapshotRunnerFailure implements Exception {
  /// `'compile'` — the `dart` subprocess exited with a non-zero code.
  /// `'parse'` — the subprocess succeeded but its stdout did not match the expected payload.
  final String stage;
  final String absoluteLibPath;
  final String? className;
  final String? methodName;
  final String runnerPath;
  final String dartStderrTail;
  final int? exitCode;

  SnapshotRunnerFailure({
    required this.stage,
    required this.absoluteLibPath,
    required this.runnerPath,
    required this.dartStderrTail,
    this.className,
    this.methodName,
    this.exitCode,
  });

  @override
  String toString() =>
      'SnapshotRunnerFailure(stage=$stage, lib=$absoluteLibPath, class=$className, method=$methodName, runner=$runnerPath, exit=$exitCode)';
}

/// One scenario row: argument literals and either the expected return value or the exception type.
class SnapshotRow {
  final List<String> argLiterals;
  final String? expectedDartLiteral;
  final String? throwsExceptionType;

  const SnapshotRow({
    required this.argLiterals,
    this.expectedDartLiteral,
    this.throwsExceptionType,
  });
}

/// Snapshot for one method (row order matches the boundary-combination order).
class MethodSnapshot {
  final String methodName;
  final List<SnapshotRow> rows;

  const MethodSnapshot({required this.methodName, required this.rows});
}

/// Normalizes a runtime exception type name to a public Dart identifier.
///
/// Maps known private dart:core names (`_Exception`, `_AssertionError`, etc.)
/// to their public counterparts. For other `_`-prefixed names, falls back to
/// `Error`, `Exception`, or `Object` based on the runtime flags.
String publicExceptionName(
  String runtimeTypeName, {
  bool isError = false,
  bool isException = false,
}) {
  switch (runtimeTypeName) {
    case '_Exception':
      return 'Exception';
    case '_AssertionError':
      return 'AssertionError';
    case '_TypeError':
      return 'TypeError';
    case '_CastError':
      return 'TypeError';
  }
  if (runtimeTypeName.startsWith('_')) {
    if (isError) return 'Error';
    if (isException) return 'Exception';
    return 'Object';
  }
  return runtimeTypeName;
}
