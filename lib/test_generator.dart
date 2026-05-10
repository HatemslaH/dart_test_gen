import 'dart:io';

enum ParamType { int_, double_, bool_, string_, dynamic_ }

class Param {
  final String name;
  final ParamType type;
  const Param(this.name, this.type);
}

/// Одна строка теста после снимка.
class TestCaseRow {
  final List<String> argLiterals;
  final String? expectedLiteral;
  final String? throwsType;

  const TestCaseRow({
    required this.argLiterals,
    this.expectedLiteral,
    this.throwsType,
  });
}

/// Описание одного метода для генерации тестов.
class MethodSpec {
  final String name;
  final List<Param> params;
  final String returnType;
  final List<TestCaseRow> testCases;

  const MethodSpec({
    required this.name,
    required this.params,
    required this.returnType,
    required this.testCases,
  });
}

const Map<ParamType, List<String>> _boundaryValues = {
  ParamType.int_: ['0', '1', '-1', '2', '-2', '10', '-10'],
  ParamType.double_: ['0.0', '1.0', '-1.0', '0.5', '-0.5'],
  ParamType.bool_: ['true', 'false'],
  ParamType.string_: ["''", "'hello'", "'  '"],
  ParamType.dynamic_: ['null', '0', "'str'"],
};

List<List<String>> generateBoundaryCases(List<Param> params) {
  if (params.isEmpty) return [[]];

  List<List<String>> result = [[]];
  for (final param in params) {
    final values = _boundaryValues[param.type] ?? ['null'];
    result = [
      for (final existing in result)
        for (final val in values) [...existing, val],
    ];
  }
  return result;
}

String _argLabel(List<String> args) => args.join(', ');

String _inputDeclarations(List<Param> params, List<String> argLiterals) {
  final buf = StringBuffer();
  for (var i = 0; i < params.length; i++) {
    buf.writeln('      final ${params[i].name} = ${argLiterals[i]};');
  }
  return buf.toString().trimRight();
}

String _callArgs(List<Param> params) => params.map((p) => p.name).join(', ');

String _renderSuccessTest(String className, MethodSpec spec, TestCaseRow row) {
  final instance = className.toLowerCase();
  final label = _argLabel(row.argLiterals);
  final inputs = _inputDeclarations(spec.params, row.argLiterals);
  final callArgs = _callArgs(spec.params);
  final call = '$instance.${spec.name}($callArgs)';

  if (spec.returnType == 'void') {
    return '''
    test('${spec.name}($label) runs without error', () {
$inputs
      expect(() => $call, returnsNormally);
    });''';
  }

  final expected = row.expectedLiteral;
  if (expected == null) {
    throw StateError('expectedLiteral is null for ${spec.name}');
  }

  return '''
    test('${spec.name}($label)', () {
$inputs
      final expected = $expected;
      final actual = $call;
      expect(actual, expected);
    });''';
}

String _renderThrowsTest(String className, MethodSpec spec, TestCaseRow row) {
  final instance = className.toLowerCase();
  final label = _argLabel(row.argLiterals);
  final inputs = _inputDeclarations(spec.params, row.argLiterals);
  final callArgs = _callArgs(spec.params);
  final call = '$instance.${spec.name}($callArgs)';
  final ex = row.throwsType ?? 'Object';

  return '''
    test('${spec.name}($label) throws $ex', () {
$inputs
      expect(() => $call, throwsA(isA<$ex>()));
    });''';
}

String generateTestFile({
  required String className,
  required String importPath,
  required List<MethodSpec> methods,
}) {
  final buf = StringBuffer();

  buf.writeln("import 'package:test/test.dart';");
  buf.writeln("import '$importPath';");
  buf.writeln();
  buf.writeln('// AUTO-GENERATED — не редактировать вручную');
  buf.writeln('// Сгенерировано: ${DateTime.now().toIso8601String()}');
  buf.writeln();
  buf.writeln('void main() {');
  buf.writeln('  final ${className.toLowerCase()} = $className();');
  buf.writeln();

  for (final spec in methods) {
    buf.writeln("  group('${spec.name}', () {");

    for (final row in spec.testCases) {
      if (row.throwsType != null) {
        buf.writeln(_renderThrowsTest(className, spec, row));
      } else {
        buf.writeln(_renderSuccessTest(className, spec, row));
      }
    }

    buf.writeln('  });');
    buf.writeln();
  }

  buf.writeln('}');
  return buf.toString();
}

void writeTestFile(String path, String content) {
  File(path).writeAsStringSync(content);
  stdout.writeln('✅ Тест-файл записан: $path');
}
