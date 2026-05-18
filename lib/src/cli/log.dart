import 'dart:io';

/// Logging via [Stdout]/[Stderr].[write], without [print].
abstract final class CliLog {
  static void out(String message) => stdout.write('$message\n');

  static void outRaw(String chunk) => stdout.write(chunk);

  static void err(String message) => stderr.write('$message\n');
}
