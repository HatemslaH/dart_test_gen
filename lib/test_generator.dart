import 'dart:io';

enum ParamType { int_, double_, bool_, string_, dynamic_, listInt_, enum_ }

class Param {
  final String name;
  final ParamType type;

  /// Если задано (например кейсы enum), подставляется вместо стандартных границ.
  final List<String>? literalValues;

  const Param(this.name, this.type, {this.literalValues});
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
  ParamType.listInt_: ['<int>[]', '[0]', '[1, -1, 2]'],
  ParamType.enum_: const [], // только с literalValues
};

List<List<String>> generateBoundaryCases(List<Param> params) {
  if (params.isEmpty) return [[]];

  List<List<String>> result = [[]];
  for (final param in params) {
    final values = param.literalValues ?? _boundaryValues[param.type] ?? ['null'];
    result = [
      for (final existing in result)
        for (final val in values) [...existing, val],
    ];
  }
  return result;
}

String _argLabel(List<String> args) => args.join(', ');

/// Имя в `test('…')` — экранируем `'` и `\` в подписи аргументов (`'hello'` и т.д.).
String _escapeSingleQuoted(String s) =>
    s.replaceAll(r'\', r'\\').replaceAll("'", r"\'");

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

  final titleOk = _escapeSingleQuoted('${spec.name}($label)');
  if (spec.returnType == 'void') {
    final title = _escapeSingleQuoted('${spec.name}($label) runs without error');
    return '''
    test('$title', () {
$inputs
      expect(() => $call, returnsNormally);
    });''';
  }

  final expected = row.expectedLiteral;
  if (expected == null) {
    throw StateError('expectedLiteral is null for ${spec.name}');
  }

  return '''
    test('$titleOk', () {
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
  final title = _escapeSingleQuoted('${spec.name}($label) throws $ex');

  return '''
    test('$title', () {
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
