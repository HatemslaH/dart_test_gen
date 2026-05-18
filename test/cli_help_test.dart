import 'dart:io';

import 'package:dart_test_gen/cli/cli_help.dart';
import 'package:test/test.dart';

String _readPubspecVersion() {
  final f = File('pubspec.yaml');
  for (final line in f.readAsLinesSync()) {
    if (line.startsWith('version:')) {
      return line.substring('version:'.length).trim();
    }
  }
  throw StateError('version not found in pubspec.yaml');
}

void main() {
  group('handleEarlyExitFlags — recognized flags return true', () {
    test('--help returns true', () {
      expect(handleEarlyExitFlags(['--help']), isTrue);
    });

    test('-h returns true', () {
      expect(handleEarlyExitFlags(['-h']), isTrue);
    });

    test('--version returns true', () {
      expect(handleEarlyExitFlags(['--version']), isTrue);
    });
  });

  group('handleEarlyExitFlags — non-early-exit returns false', () {
    test('lib/foo.dart returns false', () {
      expect(handleEarlyExitFlags(['lib/foo.dart']), isFalse);
    });

    test('empty args returns false', () {
      expect(handleEarlyExitFlags([]), isFalse);
    });

    test('--strategy flag returns false', () {
      expect(handleEarlyExitFlags(['--strategy', 'full']), isFalse);
    });
  });

  group('resolveVersion', () {
    test('returns version matching pubspec.yaml', () {
      final expected = _readPubspecVersion();
      expect(resolveVersion(), expected);
    });

    test('result matches semver pattern', () {
      expect(resolveVersion(), matches(RegExp(r'^\d+\.\d+\.\d+')));
    });
  });
}
