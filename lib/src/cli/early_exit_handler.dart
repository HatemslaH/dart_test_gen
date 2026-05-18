import 'dart:io';

/// Handles `--help`, `-h`, and `--version` before the main pipeline runs.
final class EarlyExitHandler {
  EarlyExitHandler({
    required this.helpText,
    required this.resolveVersion,
    IOSink? stdoutSink,
  }) : _stdout = stdoutSink ?? stdout;

  final String helpText;
  final String Function() resolveVersion;
  final IOSink _stdout;

  /// Returns `true` if an early-exit flag was handled (caller should return).
  bool handle(List<String> args) {
    for (final a in args) {
      if (a == '--help' || a == '-h') {
        _stdout.write(helpText);
        return true;
      }
      if (a == '--version') {
        _stdout.writeln(resolveVersion());
        return true;
      }
    }
    return false;
  }
}
