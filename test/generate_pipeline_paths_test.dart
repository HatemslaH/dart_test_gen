import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:dart_test_gen/generate_pipeline.dart';

void main() {
  group('testOutputPathForLib', () {
    test('mirrors lib/ to test/ with _test suffix', () {
      final root = p.normalize('/tmp/pkg');
      final libPath = p.normalize('/tmp/pkg/lib/a/b.dart');
      final expected = p.normalize('/tmp/pkg/test/a/b_test.dart');
      expect(testOutputPathForLib(root, libPath), expected);
    });

    test('top-level lib file maps to top-level test/', () {
      final root = p.normalize('/tmp/pkg');
      final libPath = p.normalize('/tmp/pkg/lib/foo.dart');
      final expected = p.normalize('/tmp/pkg/test/foo_test.dart');
      expect(testOutputPathForLib(root, libPath), expected);
    });

    test('throws StateError for path outside lib/', () {
      final root = p.normalize('/tmp/pkg');
      final outside = p.normalize('/tmp/pkg/bin/tool.dart');
      expect(() => testOutputPathForLib(root, outside), throwsStateError);
    });
  });

  group('shortLibLabel', () {
    test('returns forward-slash path relative to lib/', () {
      final root = p.normalize('/tmp/pkg');
      final libPath = p.normalize('/tmp/pkg/lib/foo/bar.dart');
      expect(shortLibLabel(libPath, root), 'foo/bar.dart');
    });

    test('does not include lib/ root in result for path under lib/', () {
      // Result should only contain the path fragment after lib/, not the full path
      final root = p.normalize('/tmp/pkg');
      final libPath = p.normalize('/tmp/pkg/lib/util.dart');
      final label = shortLibLabel(libPath, root);
      expect(label, isNot(contains('/tmp/')));
      expect(label, isNot(contains('lib/')));
    });
  });

  group('dartFilesUnderDirectory', () {
    late Directory tempDir;

    setUp(() {
      tempDir = Directory.systemTemp.createTempSync('dart_test_gen_paths_');
    });

    tearDown(() {
      tempDir.deleteSync(recursive: true);
    });

    test('finds .dart files recursively and filters non-.dart files', () {
      File(p.join(tempDir.path, 'a.dart')).writeAsStringSync('');
      Directory(p.join(tempDir.path, 'sub')).createSync();
      File(p.join(tempDir.path, 'sub', 'b.dart')).writeAsStringSync('');
      File(p.join(tempDir.path, 'c.txt')).writeAsStringSync('');

      final result = dartFilesUnderDirectory(tempDir.path);
      expect(result, hasLength(2));
      expect(result.any((f) => f.endsWith('a.dart')), isTrue);
      expect(result.any((f) => f.endsWith('b.dart')), isTrue);
      expect(result.any((f) => f.endsWith('c.txt')), isFalse);
    });

    test('returns empty list for non-existent directory', () {
      expect(dartFilesUnderDirectory(p.join(tempDir.path, 'nonexistent')), isEmpty);
    });

    test('result is sorted', () {
      File(p.join(tempDir.path, 'z.dart')).writeAsStringSync('');
      File(p.join(tempDir.path, 'a.dart')).writeAsStringSync('');
      final result = dartFilesUnderDirectory(tempDir.path);
      final sorted = List<String>.from(result)..sort();
      expect(result, sorted);
    });
  });

  group('expandGenerationTargets', () {
    late Directory tempDir;

    setUp(() {
      tempDir = Directory.systemTemp.createTempSync('dart_test_gen_expand_');
    });

    tearDown(() {
      tempDir.deleteSync(recursive: true);
    });

    test('expands a single .dart file to absolute path', () {
      final file = File(p.join(tempDir.path, 'foo.dart'))..writeAsStringSync('');
      final result = expandGenerationTargets(tempDir.path, ['foo.dart']);
      expect(result, [p.normalize(file.path)]);
    });

    test('expands a directory to all .dart files inside', () {
      File(p.join(tempDir.path, 'a.dart')).writeAsStringSync('');
      File(p.join(tempDir.path, 'b.dart')).writeAsStringSync('');
      final result = expandGenerationTargets(tempDir.path, ['.']);
      expect(result, hasLength(2));
    });

    test('deduplicates paths', () {
      final file = File(p.join(tempDir.path, 'foo.dart'))..writeAsStringSync('');
      final abs = p.normalize(file.path);
      final result = expandGenerationTargets(tempDir.path, ['foo.dart', abs]);
      expect(result, hasLength(1));
    });
  });
}
