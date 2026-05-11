import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';

const _projectRoot = '.';

ProcessResult _runDart(List<String> args, {String? cwd}) {
  return Process.runSync(
    Platform.resolvedExecutable,
    args,
    workingDirectory: cwd ?? _projectRoot,
    runInShell: false,
  );
}

void main() {
  group('dart run dart_test_gen', () {
    test('--help prints program name and every documented flag', () {
      final r = _runDart(['run', 'dart_test_gen', '--help']);
      expect(r.exitCode, 0);
      final out = r.stdout as String;
      expect(out, contains('dart_test_gen'));
      for (final flag in const [
        '--class',
        '--verbose',
        '--strategy',
        '--max-cases',
        '--seed',
        '--use-close-for-double',
        '--double-epsilon',
        '--config',
        '--keep-runner',
        '--dry-run',
        '--check',
        '--help',
        '--version',
      ]) {
        expect(out, contains(flag), reason: 'help text must mention $flag');
      }
    });

    test('--version prints the version from pubspec.yaml', () {
      final pubspec = File(p.join(_projectRoot, 'pubspec.yaml')).readAsStringSync();
      final match = RegExp(r'^version:\s*(\S+)', multiLine: true).firstMatch(pubspec);
      expect(match, isNotNull, reason: 'pubspec.yaml must declare a version');
      final version = match!.group(1)!;

      final r = _runDart(['run', 'dart_test_gen', '--version']);
      expect(r.exitCode, 0);
      expect(r.stdout as String, contains(version));
    });
  });
}
