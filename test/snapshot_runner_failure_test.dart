import 'dart:io';

import 'package:dart_test_gen/dart_test_gen.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

void main() {
  group('formatSnapshotRunnerFailure', () {
    test('compile stage message includes header, runner path, tail, and three hints', () {
      final f = SnapshotRunnerFailure(
        stage: 'compile',
        absoluteLibPath: r'C:\pkg\lib\foo.dart',
        className: 'Foo',
        methodName: 'bar',
        runnerPath: r'C:\Users\u\AppData\Local\Temp\dart_test_gen\snapshot_runner_Foo_1.dart',
        dartStderrTail: "lib/foo.dart:1:1: Error: boom",
        exitCode: 254,
      );

      final s = formatSnapshotRunnerFailure(f);

      expect(s, contains('Snapshot runner failed (compile)'));
      expect(s, contains(r'lib\foo.dart'));
      expect(s, contains('Foo.bar'));
      expect(s, contains('runner kept at: '));
      expect(s, contains('snapshot_runner_Foo_1.dart'));
      expect(s, contains('dart stderr (tail):'));
      expect(s, contains('boom'));
      expect(s, contains('hints:'));
      expect(s, contains('-v'));
      expect(s, contains('open the runner file'));
      expect(s, contains('attach the runner file'));
    });

    test('parse stage works without method name', () {
      final f = SnapshotRunnerFailure(
        stage: 'parse',
        absoluteLibPath: '/pkg/lib/x.dart',
        className: 'X',
        runnerPath: '/tmp/dart_test_gen/snapshot_runner_X_2.dart',
        dartStderrTail: 'expected JSON array, got: <html>',
      );

      final s = formatSnapshotRunnerFailure(f);

      expect(s, contains('Snapshot runner failed (parse)'));
      expect(s, contains('X]'));
      expect(s, isNot(contains('X.')));
      expect(s, contains('expected JSON array'));
    });
  });

  group('runSnapshots integration', () {
    late Directory tempPkg;

    setUpAll(() async {
      tempPkg = Directory.systemTemp.createTempSync('dart_test_gen_fixture_');
      File(p.join(tempPkg.path, 'pubspec.yaml')).writeAsStringSync('''
name: broken_pkg
environment:
  sdk: ">=3.3.0 <4.0.0"
''');
      Directory(p.join(tempPkg.path, 'lib')).createSync();
      File(p.join(tempPkg.path, 'lib', 'broken.dart')).writeAsStringSync('''
class Broken {
  int frob(int x) {
    // Intentionally unresolved identifier — runner will fail to compile.
    return _UndefinedSymbol.value + x;
  }
}
''');
      final r = Process.runSync(
        Platform.resolvedExecutable,
        ['pub', 'get'],
        workingDirectory: tempPkg.path,
        runInShell: false,
      );
      if (r.exitCode != 0) {
        fail('pub get failed in fixture: ${r.stderr}');
      }
    });

    tearDownAll(() {
      try {
        tempPkg.deleteSync(recursive: true);
      } catch (_) {}
    });

    test('broken target lib triggers structured error and preserves runner', () {
      final beforeRunners = _listRunners();

      final result = Process.runSync(
        Platform.resolvedExecutable,
        ['run', 'dart_test_gen', p.join(tempPkg.path, 'lib', 'broken.dart')],
        workingDirectory: Directory.current.path,
        runInShell: false,
      );

      expect(result.exitCode, isNot(0));
      final err = result.stderr as String;
      expect(err, contains('Snapshot runner failed (compile)'));
      expect(err, contains('runner kept at:'));
      expect(err, contains('hints:'));
      expect(err, contains('-v'));
      expect(err, contains('open the runner file'));
      expect(err, contains('attach the runner file'));

      // Extract the preserved runner path and assert it still exists on disk.
      final match = RegExp(r'runner kept at: (.+)').firstMatch(err);
      expect(match, isNotNull);
      final runnerPath = match!.group(1)!.trim();
      expect(File(runnerPath).existsSync(), isTrue, reason: 'preserved runner must remain on disk: $runnerPath');

      // The new runner appears in the temp dir and was not in the before-set.
      final afterRunners = _listRunners();
      expect(afterRunners.containsAll(beforeRunners), isTrue);
      expect(afterRunners.length, greaterThan(beforeRunners.length));
    });

    test('successful run leaves no new files in temp runner dir', () {
      final before = _listRunners();
      final r = Process.runSync(
        Platform.resolvedExecutable,
        ['run', 'dart_test_gen', 'example/lib/usecases/calculator.dart'],
        workingDirectory: Directory.current.path,
        runInShell: false,
      );
      expect(r.exitCode, 0, reason: 'calculator run should succeed: ${r.stderr}');
      final after = _listRunners();
      final created = after.difference(before);
      expect(created, isEmpty, reason: 'temp runner files must be cleaned up on success: $created');
    });
  });
}

Set<String> _listRunners() {
  final dir = Directory(p.join(Directory.systemTemp.path, 'dart_test_gen'));
  if (!dir.existsSync()) return <String>{};
  return dir.listSync(followLinks: false).whereType<File>().map((f) => f.path).toSet();
}
