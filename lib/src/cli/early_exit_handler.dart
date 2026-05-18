import 'dart:io';

import 'package:dart_test_gen/dart_test_gen.dart';

/// Returns `true` if an early-exit flag was handled (caller should return).
bool handleEarlyExitFlags(List<String> args) {
  for (final a in args) {
    if (a == '--help' || a == '-h') {
      stdout.write(cliHelpText);
      return true;
    }
    if (a == '--version') {
      stdout.writeln(resolveVersion());
      return true;
    }
  }
  return false;
}
