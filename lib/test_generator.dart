import 'dart:io';

enum ParamType { int_, double_, bool_, string_, dynamic_, listInt_, enum_, custom_ }

class Param {
  final String name;
  final ParamType type;

  /// Если задано (например кейсы enum), подставляется вместо стандартных границ.
  final List<String>? literalValues;

  final bool isNullable;
  final bool isNamed;
  final bool isOptionalPositional;
  final String? defaultValueCode;

  const Param(
    this.name,
    this.type, {
    this.literalValues,
    this.isNullable = false,
    this.isNamed = false,
    this.isOptionalPositional = false,
    this.defaultValueCode,
  });
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

  /// Тип значения для `expect` / void-проверки (`Future<T>` → `T`, `Stream<T>` → `List<T>`).
  final String snapshotReturnType;

  final bool isAsync;
  final bool isStream;
  final List<TestCaseRow> testCases;

  const MethodSpec({
    required this.name,
    required this.params,
    required this.returnType,
    required this.snapshotReturnType,
    this.isAsync = false,
    this.isStream = false,
    required this.testCases,
  });
}

const Map<ParamType, List<String>> _boundaryValues = {
  ParamType.int_: ['0', '1', '-1', '2', '-2', '10', '-10'],
  ParamType.double_: ['0.0', '1.0', '-1.0', '0.5', '-0.5'],
  ParamType.bool_: ['true', 'false'],
  ParamType.string_: ["''", "'hello'", "'  '"],
  ParamType.dynamic_: ['0', "'str'"],
  ParamType.listInt_: ['<int>[]', '[0]', '[1, -1, 2]'],
  ParamType.enum_: const [], // только с literalValues
  ParamType.custom_: const [], // только с literalValues
};

List<List<String>> generateBoundaryCases(List<Param> params) {
  if (params.isEmpty) return [[]];

  List<List<String>> result = [[]];
  for (final param in params) {
    final values = <String>{};

    // Всегда добавляем стандартные границы для базовых типов
    final defaults = _boundaryValues[param.type];
    if (defaults != null && defaults.isNotEmpty) {
      values.addAll(defaults);
    }

    // Добавляем специфичные литералы (из AST или Enum)
    if (param.literalValues != null) {
      values.addAll(param.literalValues!);
    }

    if (param.isNullable) {
      values.add('null');
    }
    if (param.defaultValueCode != null) {
      values.add(param.defaultValueCode!);
    }
    if (param.isNamed || param.isOptionalPositional) {
      values.add('__OMITTED__');
    }

    final valuesList = values.toList();
    result = [
      for (final existing in result)
        for (final val in valuesList)
          if (_isValidCombination(existing, val, params)) [...existing, val],
    ];
  }
  return result;
}

bool _isValidCombination(List<String> existing, String newVal, List<Param> params) {
  final nextIdx = existing.length;
  final param = params[nextIdx];

  if (param.isOptionalPositional) {
    // Если текущий аргумент НЕ пропущен, но какой-то из предыдущих позиционных опциональных БЫЛ пропущен — это невалидно.
    if (newVal != '__OMITTED__') {
      for (var i = 0; i < existing.length; i++) {
        if (params[i].isOptionalPositional && existing[i] == '__OMITTED__') {
          return false;
        }
      }
    }
  }
  return true;
}

String _argLabel(List<Param> params, List<String> args) {
  final parts = <String>[];
  for (var i = 0; i < params.length; i++) {
    final p = params[i];
    final val = args[i];
    if (val == '__OMITTED__') continue;
    if (p.isNamed) {
      parts.add('${p.name}: $val');
    } else {
      parts.add(val);
    }
  }
  return parts.join(', ');
}

/// Имя в `test('…')` — экранируем `'` и `\` в подписи аргументов (`'hello'` и т.д.).
String _escapeSingleQuoted(String s) => s.replaceAll(r'\', r'\\').replaceAll("'", r"\'");

String _inputDeclarations(List<Param> params, List<String> argLiterals) {
  final buf = StringBuffer();
  for (var i = 0; i < params.length; i++) {
    final val = argLiterals[i];
    if (val == '__OMITTED__') continue;
    buf.writeln('      final ${params[i].name} = $val;');
  }
  return buf.toString().trimRight();
}

String _callArgs(List<Param> params, List<String> argLiterals) {
  final parts = <String>[];
  for (var i = 0; i < params.length; i++) {
    final p = params[i];
    final val = argLiterals[i];
    if (val == '__OMITTED__') continue;
    if (p.isNamed) {
      parts.add('${p.name}: ${p.name}');
    } else {
      parts.add(p.name);
    }
  }
  return parts.join(', ');
}

String _renderSuccessTest(String className, MethodSpec spec, TestCaseRow row) {
  final instance = className.toLowerCase();
  final label = _argLabel(spec.params, row.argLiterals);
  final inputs = _inputDeclarations(spec.params, row.argLiterals);
  final callArgs = _callArgs(spec.params, row.argLiterals);
  final syncCall = '$instance.${spec.name}($callArgs)';
  final async = spec.isAsync || spec.isStream;
  final awaitedCall = spec.isStream ? 'await $syncCall.toList()' : 'await $syncCall';

  final titleOk = _escapeSingleQuoted('${spec.name}($label)');
  if (spec.snapshotReturnType == 'void') {
    final title = _escapeSingleQuoted('${spec.name}($label) runs without error');
    if (async) {
      return '''
    test('$title', () async {
$inputs
      $awaitedCall;
    });''';
    }
    return '''
    test('$title', () {
$inputs
      expect(() => $syncCall, returnsNormally);
    });''';
  }

  final expected = row.expectedLiteral;
  if (expected == null) {
    throw StateError('expectedLiteral is null for ${spec.name}');
  }

  if (async) {
    return '''
    test('$titleOk', () async {
$inputs
      final expected = $expected;
      final actual = $awaitedCall;
      expect(actual, expected);
    });''';
  }

  return '''
    test('$titleOk', () {
$inputs
      final expected = $expected;
      final actual = $syncCall;
      expect(actual, expected);
    });''';
}

String _renderThrowsTest(String className, MethodSpec spec, TestCaseRow row) {
  final instance = className.toLowerCase();
  final label = _argLabel(spec.params, row.argLiterals);
  final inputs = _inputDeclarations(spec.params, row.argLiterals);
  final callArgs = _callArgs(spec.params, row.argLiterals);
  final call = '$instance.${spec.name}($callArgs)';
  final ex = row.throwsType ?? 'Object';
  final title = _escapeSingleQuoted('${spec.name}($label) throws $ex');
  final async = spec.isAsync || spec.isStream;
  final thrown = spec.isStream ? '$call.toList()' : call;

  if (async) {
    return '''
    test('$title', () async {
$inputs
      await expectLater($thrown, throwsA(isA<$ex>()));
    });''';
  }

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
  List<String> extraImports = const [],
  /// Вызов конструктора получателя (например `Foo(a: 1)` при обязательных именованных параметрах).
  String? receiverInstantiation,
}) {
  final buf = StringBuffer();

  buf.writeln("import 'package:test/test.dart';");
  buf.writeln("import '$importPath';");
  for (final imp in extraImports) {
    buf.writeln("import '$imp';");
  }
  buf.writeln();
  buf.writeln('// AUTO-GENERATED — не редактировать вручную');
  buf.writeln('// Сгенерировано: ${DateTime.now().toIso8601String()}');
  buf.writeln();
  buf.writeln('void main() {');
  final recv = receiverInstantiation ?? '$className()';
  buf.writeln('  final ${className.toLowerCase()} = $recv;');
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
  File(path).parent.createSync(recursive: true);
  File(path).writeAsStringSync(content);
}
