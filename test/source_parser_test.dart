import 'dart:io';

import 'package:dart_test_gen/dart_test_gen.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

String _writeTempDart(Directory dir, String name, String content) {
  final file = File(p.join(dir.path, name));
  file.writeAsStringSync(content);
  return file.path;
}

void main() {
  late Directory tempDir;

  setUp(() {
    tempDir = Directory.systemTemp.createTempSync('dart_test_gen_parser_');
  });

  tearDown(() {
    tempDir.deleteSync(recursive: true);
  });

  group('parseLibraryClassOptional — class selection', () {
    test('picks class with most supported methods when className is null', () {
      final path = _writeTempDart(tempDir, 'multi.dart', '''
class Small {
  int a() => 0;
}
class Big {
  int a() => 0;
  int b() => 0;
  int c() => 0;
}
''');
      final result = parseLibraryClassOptional(path);
      expect(result, isNotNull);
      expect(result!.className, 'Big');
    });

    test('respects className override to pick specific class', () {
      final path = _writeTempDart(tempDir, 'multi2.dart', '''
class Small {
  int a() => 0;
}
class Big {
  int a() => 0;
  int b() => 0;
  int c() => 0;
}
''');
      final result = parseLibraryClassOptional(path, className: 'Small');
      expect(result, isNotNull);
      expect(result!.className, 'Small');
    });

    test('throws StateError if className is specified but not found', () {
      final path = _writeTempDart(tempDir, 'missing.dart', '''
class Foo {
  int x() => 0;
}
''');
      expect(
        () => parseLibraryClassOptional(path, className: 'Bar'),
        throwsStateError,
      );
    });

    test('returns null for file with no supported methods and no className', () {
      final path = _writeTempDart(tempDir, 'empty.dart', '''
class NoMethods {}
''');
      expect(parseLibraryClassOptional(path), isNull);
    });
  });

  group('parseLibraryClassOptional — method kinds', () {
    test('detects getter kind', () {
      final path = _writeTempDart(tempDir, 'getter.dart', '''
class Foo {
  int get value => 42;
}
''');
      final result = parseLibraryClassOptional(path);
      expect(result, isNotNull);
      final getter = result!.methods.where((m) => m.name == 'value').firstOrNull;
      expect(getter, isNotNull);
      expect(getter!.kind, MethodKind.getter);
    });

    test('detects setter kind', () {
      final path = _writeTempDart(tempDir, 'setter.dart', '''
class Foo {
  int _v = 0;
  set value(int v) { _v = v; }
  int get value => _v;
}
''');
      final result = parseLibraryClassOptional(path);
      expect(result, isNotNull);
      final setter = result!.methods.where((m) => m.kind == MethodKind.setter).firstOrNull;
      expect(setter, isNotNull);
      expect(setter!.name, 'value');
    });

    test('detects operator_ kind', () {
      final path = _writeTempDart(tempDir, 'operator.dart', '''
class Vec {
  final int x;
  Vec(this.x);
  Vec operator +(Vec other) => Vec(x + other.x);
}
''');
      final result = parseLibraryClassOptional(path);
      expect(result, isNotNull);
      final op = result!.methods.where((m) => m.kind == MethodKind.operator_).firstOrNull;
      expect(op, isNotNull);
      expect(op!.name, '+');
    });
  });

  group('parseLibraryClassOptional — factory and static', () {
    test('factory constructor is surfaced with isFactory = true', () {
      final path = _writeTempDart(tempDir, 'factory.dart', '''
class Box {
  final int value;
  Box(this.value);
  factory Box.fromInt(int v) => Box(v);
}
''');
      final result = parseLibraryClassOptional(path);
      expect(result, isNotNull);
      final factory = result!.methods.where((m) => m.isFactory).firstOrNull;
      expect(factory, isNotNull);
      expect(factory!.name, 'fromInt');
    });

    test('static method has isStatic = true', () {
      final path = _writeTempDart(tempDir, 'static.dart', '''
class MathHelper {
  static int double_(int x) => x * 2;
  int id(int x) => x;
}
''');
      final result = parseLibraryClassOptional(path);
      expect(result, isNotNull);
      final staticMethod = result!.methods.where((m) => m.isStatic).firstOrNull;
      expect(staticMethod, isNotNull);
      expect(staticMethod!.name, 'double_');
    });
  });
}
