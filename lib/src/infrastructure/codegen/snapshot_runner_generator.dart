import 'dart:convert';

import 'package:dart_test_gen/dart_test_gen.dart';
import 'package:path/path.dart' as p;

String _escapeDartString(String s) {
  return s.replaceAll(r'\', r'\\').replaceAll("'", r"\'");
}

/// Runner imports: the target file and [extraPackageImports] (extra `package:` URIs from API resolution).
void writeSnapshotRunnerImports(
  StringBuffer buf,
  String packageRoot,
  String packageName,
  String absoluteLibPath,
  List<String> extraPackageImports,
) {
  final primaryNorm = p.normalize(absoluteLibPath);
  buf.writeln("import '${packageImportUri(packageRoot, packageName, primaryNorm)}';");
  for (final uri in extraPackageImports) {
    buf.writeln("import '$uri';");
  }
}

String formatArgsForSnapshot(List<Param> params, List<String> argLiterals) {
  final parts = <String>[];
  for (var i = 0; i < params.length; i++) {
    final param = params[i];
    final val = argLiterals[i];
    if (val == '__OMITTED__') continue;
    if (param.isNamed) {
      parts.add('${param.name}: $val');
    } else {
      parts.add(val);
    }
  }
  return parts.join(', ');
}

String _snapshotReceiverPrefix(String className, ParsedMethod m) {
  if (m.isStatic) return className;
  return 'c';
}

String _snapshotOperatorExpression(String recv, String op, List<String> argLiterals) {
  switch (op) {
    case '[]':
      return '$recv[${argLiterals[0]}]';
    case '[]=':
      return '$recv[${argLiterals[0]}] = ${argLiterals[1]}';
    case '~':
      return '~$recv';
    case '-':
      if (argLiterals.isEmpty) return '-$recv';
      return '$recv - ${argLiterals[0]}';
    default:
      if (argLiterals.length != 1) {
        throw StateError('operator $op: expected 1 arg, got ${argLiterals.length}');
      }
      return '$recv $op ${argLiterals[0]}';
  }
}

/// Invocation expression for the snapshot runner (getter / setter / operator / method).
String snapshotInvokeExpression({
  required String className,
  required ParsedMethod m,
  required String argList,
  required List<String> args,
}) {
  final recv = _snapshotReceiverPrefix(className, m);
  switch (m.kind) {
    case MethodKind.getter:
      return '$recv.${m.name}';
    case MethodKind.setter:
      return '$recv.${m.name} = $argList';
    case MethodKind.operator_:
      return _snapshotOperatorExpression(recv, m.name, args);
    case MethodKind.method:
      return '$recv.${m.name}($argList)';
  }
}

/// Full temporary snapshot runner Dart source.
String buildSnapshotRunnerSource({
  required String packageRoot,
  required String packageName,
  required String absoluteLibPath,
  required List<String> extraPackageImports,
  required String className,
  required List<ParsedMethod> methods,
  required List<ClassInfo> allFileClasses,
}) {
  final buf = StringBuffer();
  buf.writeln("// ignore_for_file: unused_local_variable");
  buf.writeln("import 'dart:convert';");
  buf.writeln("import 'dart:io';");
  writeSnapshotRunnerImports(buf, packageRoot, packageName, absoluteLibPath, extraPackageImports);
  buf.writeln();
  buf.writeln('String _publicExceptionName(Object e) {');
  buf.writeln('  final n = e.runtimeType.toString();');
  buf.writeln('  switch (n) {');
  buf.writeln("    case '_Exception': return 'Exception';");
  buf.writeln("    case '_AssertionError': return 'AssertionError';");
  buf.writeln("    case '_TypeError': return 'TypeError';");
  buf.writeln("    case '_CastError': return 'TypeError';");
  buf.writeln('  }');
  buf.writeln("  if (n.startsWith('_')) {");
  buf.writeln("    if (e is Error) return 'Error';");
  buf.writeln("    if (e is Exception) return 'Exception';");
  buf.writeln("    return 'Object';");
  buf.writeln('  }');
  buf.writeln('  return n;');
  buf.writeln('}');
  buf.writeln();
  buf.writeln('Object? snapshotValue(Object? v) {');
  buf.writeln('  if (v == null || v is num || v is bool || v is String) {');
  buf.writeln('    return v;');
  buf.writeln('  }');
  buf.writeln('  if (v is List) {');
  buf.writeln('    return v.map(snapshotValue).toList();');
  buf.writeln('  }');
  buf.writeln('  if (v is Set) {');
  buf.writeln('    return v.map(snapshotValue).toList();');
  buf.writeln('  }');
  buf.writeln('  if (v is Iterable && v is! List && v is! Map && v is! String) {');
  buf.writeln('    return v.map(snapshotValue).toList();');
  buf.writeln('  }');
  buf.writeln('  if (v is Map) {');
  buf.writeln('    final out = <String, Object?>{};');
  buf.writeln('    for (final e in v.entries) {');
  buf.writeln("      out['\${e.key}'] = snapshotValue(e.value);");
  buf.writeln('    }');
  buf.writeln('    return out;');
  buf.writeln('  }');
  buf.writeln('  if (v is Enum) {');
  buf.writeln('    return <String, Object?>{');
  buf.writeln("      '_enumType': v.runtimeType.toString(),");
  buf.writeln("      '_enumName': v.name,");
  buf.writeln('    };');
  buf.writeln('  }');

  for (final cls in allFileClasses) {
    buf.writeln("  if (v.runtimeType.toString() == '${cls.name}') {");
    buf.writeln("    final dynamic d = v;");
    buf.writeln("    return <String, Object?>{");
    buf.writeln("      '_type': '${cls.name}',");
    for (final field in cls.fields) {
      buf.writeln("      '$field': snapshotValue(d.$field),");
    }
    buf.writeln("    };");
    buf.writeln("  }");
  }

  buf.writeln('  try {');
  buf.writeln('    final dynamic d = v;');
  buf.writeln('    final json = d.toJson();');
  buf.writeln('    if (json is Map<String, dynamic>) {');
  buf.writeln('      return <String, Object?>{');
  buf.writeln("        '_type': v.runtimeType.toString(),");
  buf.writeln('        ...json.map((k, v) => MapEntry(k, snapshotValue(v))),');
  buf.writeln('      };');
  buf.writeln('    }');
  buf.writeln('  } catch (_) {}');

  buf.writeln('  return <String, Object?>{');
  buf.writeln("    '_type': v.runtimeType.toString(),");
  buf.writeln("    '_value': v.toString(),");
  buf.writeln('  };');
  buf.writeln('}');
  buf.writeln();
  buf.writeln('Future<void> main() async {');
  buf.writeln('  final out = <Map<String, Object?>>[];');
  final receiverInfo = allFileClasses.where((c) => c.name == className).firstOrNull;
  final receiverExpr = receiverInfo != null ? instantiationExpressionForClass(receiverInfo) : '$className()';
  buf.writeln('  final c = $receiverExpr;');
  buf.writeln();

  for (final m in methods) {
    final cases = generateBoundaryCases(m.params);
    for (final args in cases) {
      final argList = formatArgsForSnapshot(m.params, args);
      final argJson = jsonEncode(args);

      String invokeExpr;
      if (m.isFactory) {
        if (m.name.isEmpty) {
          invokeExpr = '$className($argList)';
        } else {
          invokeExpr = '$className.${m.name}($argList)';
        }
      } else {
        invokeExpr = snapshotInvokeExpression(
          className: className,
          m: m,
          argList: argList,
          args: args,
        );
      }

      if (m.snapshotReturnType == 'void') {
        buf.writeln('  {');
        buf.writeln("    const method = '${_escapeDartString(m.name)}';");
        buf.writeln('    final args = $argJson as List<dynamic>;');
        buf.writeln('    try {');
        if (m.isStream) {
          buf.writeln('      await $invokeExpr.toList();');
        } else if (m.isAsync) {
          buf.writeln('      await $invokeExpr;');
        } else {
          buf.writeln('      $invokeExpr;');
        }
        buf.writeln("      out.add({'method': method, 'args': args, 'ok': true});");
        buf.writeln('    } catch (e) {');
        buf.writeln(
            "      out.add({'method': method, 'args': args, 'ok': false, 'exception': _publicExceptionName(e)});");
        buf.writeln('    }');
        buf.writeln('  }');
      } else {
        buf.writeln('  {');
        buf.writeln("    const method = '${_escapeDartString(m.name)}';");
        buf.writeln('    final args = $argJson as List<dynamic>;');
        buf.writeln('    try {');
        if (m.isStream) {
          buf.writeln('      final v = await $invokeExpr.toList();');
        } else if (m.isAsync) {
          buf.writeln('      final v = await $invokeExpr;');
        } else {
          buf.writeln('      final v = $invokeExpr;');
        }
        buf.writeln("      out.add({'method': method, 'args': args, 'ok': true, 'value': snapshotValue(v)});");
        buf.writeln('    } catch (e) {');
        buf.writeln(
            "      out.add({'method': method, 'args': args, 'ok': false, 'exception': _publicExceptionName(e)});");
        buf.writeln('    }');
        buf.writeln('  }');
      }
    }
    buf.writeln();
  }

  buf.writeln("  stdout.write(jsonEncode(out));");
  buf.writeln('}');
  return buf.toString();
}
