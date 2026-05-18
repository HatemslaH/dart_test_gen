import '../../domain/models/enums.dart';
import '../../domain/models/test_models.dart';

/// Descriptive `test('…')` titles include the expected value; cap length so runners stay readable.
const int kMaxDescriptiveTestTitleLength = 220;

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

/// Name in `test('…')`: escape `'` and `\` in argument labels (`'hello'`, etc.).
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

String _operatorTestExpression(String recv, String op, List<Param> params, List<String> argLiterals) {
  String nameAt(int i) {
    if (i >= argLiterals.length || argLiterals[i] == '__OMITTED__') {
      throw StateError('operator $op: missing arg at index $i');
    }
    return params[i].name;
  }

  switch (op) {
    case '[]':
      return '$recv[${nameAt(0)}]';
    case '[]=':
      return '$recv[${nameAt(0)}] = ${nameAt(1)}';
    case '~':
      return '~$recv';
    case '-':
      if (params.isEmpty) return '-$recv';
      return '$recv - ${nameAt(0)}';
    default:
      return '$recv $op ${nameAt(0)}';
  }
}

/// Synchronous invocation expression for the test (before `await` when async).
String _syncInvokeExpression(
  String className,
  MethodSpec spec,
  String callArgs,
  List<String> argLiterals,
) {
  final instance = className.toLowerCase();
  if (spec.isFactory) {
    if (spec.name.isEmpty) {
      return '$className($callArgs)';
    }
    return '$className.${spec.name}($callArgs)';
  }
  final recv = spec.isStatic ? className : instance;
  switch (spec.kind) {
    case MethodKind.getter:
      return '$recv.${spec.name}';
    case MethodKind.setter:
      return '$recv.${spec.name} = $callArgs';
    case MethodKind.operator_:
      return _operatorTestExpression(recv, spec.name, spec.params, argLiterals);
    case MethodKind.method:
      return '$recv.${spec.name}($callArgs)';
  }
}

/// Prefix for `group` and test titles: getter/setter with the same name and operators stay distinct.
String _testGroupName(MethodSpec spec) {
  switch (spec.kind) {
    case MethodKind.getter:
      return 'getter ${spec.name}';
    case MethodKind.setter:
      return 'setter ${spec.name}';
    case MethodKind.operator_:
      return 'operator ${spec.name}';
    case MethodKind.method:
      return spec.name;
  }
}

String _testCaseTitleArgs(MethodSpec spec, String label) {
  switch (spec.kind) {
    case MethodKind.getter:
      return 'getter ${spec.name}';
    case MethodKind.setter:
      return label.isEmpty ? 'setter ${spec.name}' : 'setter ${spec.name}($label)';
    case MethodKind.operator_:
      return label.isEmpty ? 'operator ${spec.name}' : 'operator ${spec.name}($label)';
    case MethodKind.method:
      return label.isEmpty ? spec.name : '${spec.name}($label)';
  }
}

String _expectedOutcomePhrase(String expectedLiteral, {required bool useClose}) {
  final e = expectedLiteral.trim();
  if (useClose) {
    return 'returns a value close to $e';
  }
  return 'returns $e';
}

/// Compact fragment is [_testCaseTitleArgs]; descriptive adds a `returns …` / `closeTo` phrase unless too long.
String _successTestTitle(MethodSpec spec, String label, String expectedLiteral, {required bool useClose}) {
  final invocationPart = _testCaseTitleArgs(spec, label);
  final outcome = _expectedOutcomePhrase(expectedLiteral, useClose: useClose);
  final descriptive = '$invocationPart $outcome';
  if (descriptive.length > kMaxDescriptiveTestTitleLength) {
    return invocationPart;
  }
  return descriptive;
}

/// Instance getter `hashCode`: do not compare to the snapshot literal (unstable across processes);
/// instead assert consistency between two identically constructed objects.
bool _isInstanceHashCodeGetter(MethodSpec spec) =>
    spec.kind == MethodKind.getter && spec.name == 'hashCode' && !spec.isStatic && !spec.isFactory;

String _renderHashCodePairEqualityTest(String className, MethodSpec spec, String receiverExpr) {
  final title = _escapeSingleQuoted(_testCaseTitleArgs(spec, ''));
  if (spec.isAsync || spec.isStream) {
    return '''
    test('$title', () async {
      final left = $receiverExpr;
      final right = $receiverExpr;
      expect(await left.hashCode, await right.hashCode);
    });''';
  }
  return '''
    test('$title', () {
      final left = $receiverExpr;
      final right = $receiverExpr;
      expect(left.hashCode, right.hashCode);
    });''';
}

/// Second argument to `expect(actual, …)` for bool/null literals, or null for `expected` binding.
String? _successExpectMatcherSecondArg(MethodSpec spec, String expectedLiteral) {
  if (!spec.useExpectMatchersBoolNull) return null;
  final trimmed = expectedLiteral.trim();
  if (trimmed == 'null') return 'isNull';
  final rt = spec.snapshotReturnType.trim();
  if (rt == 'bool' || rt == 'bool?') {
    if (trimmed == 'true') return 'isTrue';
    if (trimmed == 'false') return 'isFalse';
  }
  return null;
}

String _renderSuccessTest(String className, MethodSpec spec, TestCaseRow row) {
  final label = _argLabel(spec.params, row.argLiterals);
  final inputs = _inputDeclarations(spec.params, row.argLiterals);
  final callArgs = _callArgs(spec.params, row.argLiterals);
  final syncCall = _syncInvokeExpression(className, spec, callArgs, row.argLiterals);

  final async = spec.isAsync || spec.isStream;
  final awaitedCall = spec.isStream ? 'await $syncCall.toList()' : 'await $syncCall';

  final titlePart = _testCaseTitleArgs(spec, label);
  if (spec.snapshotReturnType == 'void') {
    final title = _escapeSingleQuoted('$titlePart runs without error');
    if (async) {
      return '''
    test('$title', () async {
$inputs
      $awaitedCall;
    });''';
    }
    final voidBody = spec.kind == MethodKind.setter
        ? 'expect(() { $syncCall; }, returnsNormally);'
        : 'expect(() => $syncCall, returnsNormally);';
    return '''
    test('$title', () {
$inputs
      $voidBody
    });''';
  }

  final expected = row.expectedLiteral;
  if (expected == null) {
    throw StateError('expectedLiteral is null for ${spec.name}');
  }

  final useClose = spec.useCloseForDouble && spec.snapshotReturnType == 'double';
  final matcherSecond = useClose ? null : _successExpectMatcherSecondArg(spec, expected);
  final expectLine = useClose
      ? 'expect(actual, closeTo(expected, ${_doubleLiteralForGenerated(spec.doubleEpsilon)}));'
      : matcherSecond != null
      ? 'expect(actual, $matcherSecond);'
      : 'expect(actual, expected);';

  final expectedDecl = (useClose || matcherSecond == null) ? '      final expected = $expected;\n' : '';

  final titleOk = _escapeSingleQuoted(
    _successTestTitle(spec, label, expected, useClose: useClose),
  );

  if (async) {
    return '''
    test('$titleOk', () async {
$inputs
${expectedDecl}      final actual = $awaitedCall;
      $expectLine
    });''';
  }

  return '''
    test('$titleOk', () {
$inputs
${expectedDecl}      final actual = $syncCall;
      $expectLine
    });''';
}

String _doubleLiteralForGenerated(double d) {
  if (d.isNaN || d.isInfinite) return d.toString();
  return d.toString();
}

String _renderThrowsTest(String className, MethodSpec spec, TestCaseRow row) {
  final label = _argLabel(spec.params, row.argLiterals);
  final inputs = _inputDeclarations(spec.params, row.argLiterals);
  final callArgs = _callArgs(spec.params, row.argLiterals);
  final call = _syncInvokeExpression(className, spec, callArgs, row.argLiterals);

  final ex = row.throwsType ?? 'Object';
  final titlePart = _testCaseTitleArgs(spec, label);
  final title = _escapeSingleQuoted('$titlePart throws $ex');
  final async = spec.isAsync || spec.isStream;
  final thrown = spec.isStream ? '$call.toList()' : call;

  if (async) {
    return '''
    test('$title', () async {
$inputs
      await expectLater($thrown, throwsA(isA<$ex>()));
    });''';
  }

  final throwsBody = spec.kind == MethodKind.setter
      ? 'expect(() { $call; }, throwsA(isA<$ex>()));'
      : 'expect(() => $call, throwsA(isA<$ex>()));';

  return '''
    test('$title', () {
$inputs
      $throwsBody
    });''';
}

String generateTestFile({
  required String className,
  required String importPath,
  required List<MethodSpec> methods,
  List<String> extraImports = const [],
  /// Receiver constructor call (e.g. `Foo(a: 1)` when named parameters are required).
  String? receiverInstantiation,
}) {
  final buf = StringBuffer();

  buf.writeln("import 'package:test/test.dart';");
  buf.writeln("import '$importPath';");
  for (final imp in extraImports) {
    buf.writeln("import '$imp';");
  }
  buf.writeln();
  buf.writeln('// Auto-generated — do not edit manually');
  buf.writeln('// Generated: ${DateTime.now().toIso8601String()}');
  buf.writeln();
  buf.writeln('void main() {');
  final receiverExpr = receiverInstantiation ?? '$className()';
  bool needsInstance = methods.any((m) => !m.isStatic && !m.isFactory);
  if (needsInstance) {
    buf.writeln('  final ${className.toLowerCase()} = $receiverExpr;');
    buf.writeln();
  }

  for (final spec in methods) {
    buf.writeln("  group('${_escapeSingleQuoted(_testGroupName(spec))}', () {");

    if (_isInstanceHashCodeGetter(spec)) {
      buf.writeln(_renderHashCodePairEqualityTest(className, spec, receiverExpr));
    } else {
      for (final row in spec.testCases) {
        if (row.throwsType != null) {
          buf.writeln(_renderThrowsTest(className, spec, row));
        } else {
          buf.writeln(_renderSuccessTest(className, spec, row));
        }
      }
    }

    buf.writeln('  });');
    buf.writeln();
  }

  buf.writeln('}');
  return buf.toString();
}

/// Removes the generated timestamp banner line (English or legacy Cyrillic prefix).
/// All other lines are left unchanged. Idempotent.
String stripGeneratedTimestamp(String content) {
  return content
      .split('\n')
      .where((line) => !line.startsWith('// Generated:') && !line.startsWith('// Сгенерировано:'))
      .join('\n');
}
