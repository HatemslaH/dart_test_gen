import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';

final String _repoRoot = p.normalize(p.absolute('.'));

ProcessResult _runDart(List<String> args, {String? cwd}) {
  return Process.runSync(
    Platform.resolvedExecutable,
    args,
    workingDirectory: cwd ?? _repoRoot,
    runInShell: false,
  );
}

/// Copies [src] directory tree into [dst] (recursive, non-follow symlinks).
void _copyTree(Directory src, Directory dst) {
  dst.createSync(recursive: true);
  for (final entity in src.listSync(recursive: false, followLinks: false)) {
    final destPath = p.join(dst.path, p.basename(entity.path));
    if (entity is Directory) {
      _copyTree(Directory(entity.path), Directory(destPath));
    } else if (entity is File) {
      File(entity.path).copySync(destPath);
    }
  }
}

/// Fresh package under a temp dir (example layout). Runs `dart pub get`.
/// Deletes the temp dir in tearDown.
Directory _materializeTempPackage({required bool fullUsecases}) {
  final tmp = Directory.systemTemp.createTempSync('dart_test_gen_smoke_');
  addTearDown(() {
    if (tmp.existsSync()) {
      tmp.deleteSync(recursive: true);
    }
  });

  final root = tmp.path;
  File(p.join(_repoRoot, 'example', 'pubspec.yaml')).copySync(p.join(root, 'pubspec.yaml'));

  final libUsecases = Directory(p.join(root, 'lib', 'usecases'));
  if (fullUsecases) {
    _copyTree(
      Directory(p.join(_repoRoot, 'example', 'lib', 'usecases')),
      libUsecases,
    );
  } else {
    libUsecases.createSync(recursive: true);
    File(p.join(_repoRoot, 'example', 'lib', 'usecases', 'calculator.dart'))
        .copySync(p.join(libUsecases.path, 'calculator.dart'));
  }

  final pubGet = Process.runSync(
    Platform.resolvedExecutable,
    const ['pub', 'get'],
    workingDirectory: root,
    runInShell: false,
  );
  if (pubGet.exitCode != 0) {
    fail('pub get failed in temp package: ${pubGet.stderr}');
  }

  return tmp;
}

void main() {
  group('--dry-run', () {
    test('prints the would-be output path to stdout and writes nothing', () {
      final pkg = _materializeTempPackage(fullUsecases: false);
      final calcLib = p.join(pkg.path, 'lib', 'usecases', 'calculator.dart');
      final calcTest = p.join(pkg.path, 'test', 'usecases', 'calculator_test.dart');

      expect(File(calcTest).existsSync(), isFalse);

      final r = _runDart([
        'run',
        'dart_test_gen',
        '--dry-run',
        calcLib,
      ]);
      expect(r.exitCode, 0);
      expect((r.stdout as String).trim(), contains('calculator_test.dart'));
      expect(File(calcTest).existsSync(), isFalse, reason: '--dry-run must not write any files');
    });

    test('preserves an existing test file unchanged when --dry-run is used', () {
      final pkg = _materializeTempPackage(fullUsecases: false);
      final calcLib = p.join(pkg.path, 'lib', 'usecases', 'calculator.dart');
      final calcTest = p.join(pkg.path, 'test', 'usecases', 'calculator_test.dart');

      final gen = _runDart(['run', 'dart_test_gen', calcLib]);
      expect(gen.exitCode, 0);

      final mtimeBefore = File(calcTest).lastModifiedSync();
      sleep(const Duration(milliseconds: 50));

      final r = _runDart([
        'run',
        'dart_test_gen',
        '--dry-run',
        calcLib,
      ]);
      expect(r.exitCode, 0);
      expect(
        File(calcTest).lastModifiedSync(),
        equals(mtimeBefore),
        reason: '--dry-run must not modify the existing test file',
      );
    });
  });

  group('--check', () {
    test('returns 0 when generated content matches the existing file', () {
      final pkg = _materializeTempPackage(fullUsecases: false);
      final calcLib = p.join(pkg.path, 'lib', 'usecases', 'calculator.dart');

      final genResult = _runDart(['run', 'dart_test_gen', calcLib]);
      expect(genResult.exitCode, 0);

      final r = _runDart([
        'run',
        'dart_test_gen',
        '--check',
        calcLib,
      ]);
      expect(r.exitCode, 0);
      expect((r.stderr as String), isNot(contains('[check] differs:')));
    });

    test('returns 1 and mentions <missing> when the test file does not exist', () {
      final pkg = _materializeTempPackage(fullUsecases: false);
      final calcLib = p.join(pkg.path, 'lib', 'usecases', 'calculator.dart');
      final calcTest = p.join(pkg.path, 'test', 'usecases', 'calculator_test.dart');

      if (File(calcTest).existsSync()) File(calcTest).deleteSync();

      final r = _runDart([
        'run',
        'dart_test_gen',
        '--check',
        calcLib,
      ]);
      expect(r.exitCode, 1);
      expect((r.stderr as String), contains('<missing>'));
    });

    test('returns 1 and shows first diff when a non-timestamp line differs', () {
      final pkg = _materializeTempPackage(fullUsecases: false);
      final calcLib = p.join(pkg.path, 'lib', 'usecases', 'calculator.dart');
      final calcTest = p.join(pkg.path, 'test', 'usecases', 'calculator_test.dart');

      _runDart(['run', 'dart_test_gen', calcLib]);
      final original = File(calcTest).readAsStringSync();

      final modified = original.replaceFirst('void main()', 'void mainMODIFIED()');
      File(calcTest).writeAsStringSync(modified);

      final r = _runDart([
        'run',
        'dart_test_gen',
        '--check',
        calcLib,
      ]);
      expect(r.exitCode, 1);
      expect((r.stderr as String), contains('[check] differs:'));
      expect((r.stderr as String), contains('first diff at line'));

      File(calcTest).writeAsStringSync(original);
    });

    test('returns 0 when only the timestamp line differs', () {
      final pkg = _materializeTempPackage(fullUsecases: false);
      final calcLib = p.join(pkg.path, 'lib', 'usecases', 'calculator.dart');
      final calcTest = p.join(pkg.path, 'test', 'usecases', 'calculator_test.dart');

      _runDart(['run', 'dart_test_gen', calcLib]);
      final original = File(calcTest).readAsStringSync();

      final modified = original.replaceAll(
        RegExp(r'// Generated: .+'),
        '// Generated: 1970-01-01T00:00:00.000000',
      );
      File(calcTest).writeAsStringSync(modified);

      final r = _runDart([
        'run',
        'dart_test_gen',
        '--check',
        calcLib,
      ]);
      expect(
        r.exitCode,
        0,
        reason: 'timestamp-only diff must be ignored by --check',
      );

      File(calcTest).writeAsStringSync(original);
    });
  });

  group('--dry-run --check together', () {
    test('exits 64 and mentions the conflict in stderr', () {
      final r = _runDart([
        'run',
        'dart_test_gen',
        '--dry-run',
        '--check',
        p.join(_repoRoot, 'example', 'lib', 'usecases', 'calculator.dart'),
      ]);
      expect(r.exitCode, 64);
      expect((r.stderr as String), contains('--dry-run'));
      expect((r.stderr as String), contains('--check'));
    });
  });

  group('--check multi-file aggregation', () {
    test('exits 1 and stderr contains closing summary when at least one file differs', () {
      final pkg = _materializeTempPackage(fullUsecases: true);
      final usecasesDir = p.join(pkg.path, 'lib', 'usecases');

      final genAll = _runDart(['run', 'dart_test_gen', usecasesDir]);
      expect(genAll.exitCode, 0);

      final calcTest = p.join(pkg.path, 'test', 'usecases', 'calculator_test.dart');
      final original = File(calcTest).readAsStringSync();
      final modified = original.replaceFirst('void main()', 'void mainMUTATED()');
      File(calcTest).writeAsStringSync(modified);

      final r = _runDart([
        'run',
        'dart_test_gen',
        '--check',
        usecasesDir,
      ]);
      expect(r.exitCode, 1);
      expect((r.stderr as String), contains('file(s) differ'));

      File(calcTest).writeAsStringSync(original);
    });
  });
}
