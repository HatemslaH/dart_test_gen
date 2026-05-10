import 'dart:io';

/// Логирование через [Stdout]/[Stderr].[write], без [print].
abstract final class CliLog {
  static void out(String message) => stdout.write('$message\n');

  static void outRaw(String chunk) => stdout.write(chunk);

  static void err(String message) => stderr.write('$message\n');
}
