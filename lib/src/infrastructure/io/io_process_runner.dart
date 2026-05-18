import 'dart:io';

import '../../domain/ports/process_runner.dart';

/// [ProcessRunner] backed by [Process.runSync].
final class IoProcessRunner implements ProcessRunner {
  const IoProcessRunner();

  @override
  ProcessRunResult runSync(
    String executable,
    List<String> arguments, {
    String? workingDirectory,
    Map<String, String>? environment,
    bool runInShell = false,
  }) {
    final r = Process.runSync(
      executable,
      arguments,
      workingDirectory: workingDirectory,
      environment: environment,
      runInShell: runInShell,
    );
    return ProcessRunResult(
      exitCode: r.exitCode,
      stdout: r.stdout is String ? r.stdout as String : String.fromCharCodes(r.stdout as List<int>),
      stderr: r.stderr is String ? r.stderr as String : String.fromCharCodes(r.stderr as List<int>),
    );
  }
}
