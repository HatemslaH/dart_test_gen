/// Result of running a child process (mirrors [ProcessResult] surface used by this package).
class ProcessRunResult {
  const ProcessRunResult({
    required this.exitCode,
    required this.stdout,
    required this.stderr,
  });

  final int exitCode;
  final String stdout;
  final String stderr;
}

/// Abstraction over subprocess execution for testability and layer boundaries.
abstract class ProcessRunner {
  ProcessRunResult runSync(
    String executable,
    List<String> arguments, {
    String? workingDirectory,
    Map<String, String>? environment,
    bool runInShell = false,
  });
}
