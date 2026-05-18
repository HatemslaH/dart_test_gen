import 'package:dart_test_gen/dart_test_gen.dart';
import 'package:test/test.dart';

ParsedMethod _method(
  String name, {
  MethodKind kind = MethodKind.method,
  bool isStatic = false,
  List<Param> params = const [],
}) =>
    ParsedMethod(
      name: name,
      params: params,
      returnType: 'int',
      isAsync: false,
      isStream: false,
      snapshotReturnType: 'int',
      kind: kind,
      isStatic: isStatic,
    );

void main() {
  group('snapshotInvokeExpression — method', () {
    test('instance method with args', () {
      final m = _method('foo');
      expect(
        snapshotInvokeExpression(className: 'C', m: m, argList: '1, 2', args: ['1', '2']),
        'c.foo(1, 2)',
      );
    });

    test('static method uses ClassName receiver', () {
      final m = _method('bar', isStatic: true);
      expect(
        snapshotInvokeExpression(className: 'C', m: m, argList: '3', args: ['3']),
        'C.bar(3)',
      );
    });

    test('method with no args', () {
      final m = _method('baz');
      expect(
        snapshotInvokeExpression(className: 'C', m: m, argList: '', args: []),
        'c.baz()',
      );
    });
  });

  group('snapshotInvokeExpression — getter', () {
    test('instance getter', () {
      final m = _method('length', kind: MethodKind.getter);
      expect(
        snapshotInvokeExpression(className: 'C', m: m, argList: '', args: []),
        'c.length',
      );
    });

    test('static getter uses ClassName receiver', () {
      final m = _method('instance', kind: MethodKind.getter, isStatic: true);
      expect(
        snapshotInvokeExpression(className: 'MyClass', m: m, argList: '', args: []),
        'MyClass.instance',
      );
    });
  });

  group('snapshotInvokeExpression — setter', () {
    test('instance setter', () {
      final m = _method('value', kind: MethodKind.setter);
      expect(
        snapshotInvokeExpression(className: 'C', m: m, argList: '7', args: ['7']),
        'c.value = 7',
      );
    });
  });

  group('snapshotInvokeExpression — operator_', () {
    test('binary + operator', () {
      final m = _method('+', kind: MethodKind.operator_);
      expect(
        snapshotInvokeExpression(className: 'C', m: m, argList: '3', args: ['3']),
        'c + 3',
      );
    });

    test('binary - operator', () {
      final m = _method('-', kind: MethodKind.operator_);
      expect(
        snapshotInvokeExpression(className: 'C', m: m, argList: '2', args: ['2']),
        'c - 2',
      );
    });

    test('unary - operator (no args)', () {
      final m = _method('-', kind: MethodKind.operator_);
      expect(
        snapshotInvokeExpression(className: 'C', m: m, argList: '', args: []),
        '-c',
      );
    });

    test('index get operator []', () {
      final m = _method('[]', kind: MethodKind.operator_);
      expect(
        snapshotInvokeExpression(className: 'C', m: m, argList: '0', args: ['0']),
        'c[0]',
      );
    });

    test('index set operator []=', () {
      final m = _method('[]=', kind: MethodKind.operator_);
      expect(
        snapshotInvokeExpression(className: 'C', m: m, argList: '0, 9', args: ['0', '9']),
        'c[0] = 9',
      );
    });

    test('bitwise not operator ~', () {
      final m = _method('~', kind: MethodKind.operator_);
      expect(
        snapshotInvokeExpression(className: 'C', m: m, argList: '', args: []),
        '~c',
      );
    });
  });

  group('formatArgsForSnapshot', () {
    test('positional args joined with comma', () {
      final params = [
        const Param('a', ParamType.int_),
        const Param('b', ParamType.int_),
      ];
      expect(formatArgsForSnapshot(params, ['1', '2']), '1, 2');
    });

    test('named args include name: prefix', () {
      final params = [
        const Param('x', ParamType.int_, isNamed: true),
        const Param('y', ParamType.int_, isNamed: true),
      ];
      expect(formatArgsForSnapshot(params, ['10', '20']), 'x: 10, y: 20');
    });

    test('__OMITTED__ args are skipped', () {
      final params = [
        const Param('a', ParamType.int_),
        const Param('b', ParamType.int_, isNamed: true, isOptionalPositional: false),
      ];
      expect(formatArgsForSnapshot(params, ['1', '__OMITTED__']), '1');
    });
  });
}
