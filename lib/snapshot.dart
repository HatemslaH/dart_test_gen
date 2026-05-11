import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;

import 'source_parser.dart';
import 'test_generator.dart';

/// Одна строка сценария: аргументы-литералы и либо ожидаемое значение, либо тип исключения.
class SnapshotRow {
  final List<String> argLiterals;
  final String? expectedDartLiteral;
  final String? throwsExceptionType;

  const SnapshotRow({
    required this.argLiterals,
    this.expectedDartLiteral,
    this.throwsExceptionType,
  });
}

/// Снимок по одному методу (порядок строк совпадает с порядком граничных комбинаций).
class MethodSnapshot {
  final String methodName;
  final List<SnapshotRow> rows;

  const MethodSnapshot({required this.methodName, required this.rows});
}

String _escapeDartString(String s) {
  return s.replaceAll(r'\', r'\\').replaceAll("'", r"\'");
}

void _snapshotVerbose(void Function(String line)? sink, String label, String step, String detail) {
  sink?.call('[$label]\tsnapshot/$step\t$detail\n');
}

/// Импорты раннера: целевой файл и [extraPackageImports] (доп. `package:` из разрешения API).
void _writeSnapshotRunnerImports(
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
    final p = params[i];
    final val = argLiterals[i];
    if (val == '__OMITTED__') continue;
    if (p.isNamed) {
      parts.add('${p.name}: $val');
    } else {
      parts.add(val);
    }
  }
  return parts.join(', ');
}

/// Генерирует исходник раннера, выполняет его и возвращает снимки по методам.
///
/// [onSnapshotFraction] — подпрогресс только этапа снимка, от 0 до 1.
/// [onVerboseLine] — подробные строки (обычно только при `-v`).
/// [onRunnerFailed] — вывод при падении `dart run` раннера (stderr/stdout).
List<MethodSnapshot> runSnapshots({
  required String packageRoot,
  required String packageName,
  required String absoluteLibPath,
  required ParsedClass parsed,
  List<String> extraPackageImports = const [],
  String logLabel = '',
  void Function(double fraction01)? onSnapshotFraction,
  void Function(String line)? onVerboseLine,
  void Function(String stderrText, String stdoutText)? onRunnerFailed,
}) {
  void sl(String step, String detail) => _snapshotVerbose(onVerboseLine, logLabel, step, detail);

  void frac(double v) => onSnapshotFraction?.call(v.clamp(0.0, 1.0));

  frac(0);

  final runnerPath = p.join(
    packageRoot,
    '.dart_tool',
    'dart_test_gen',
    'snapshot_runner_${parsed.className}_${DateTime.now().microsecondsSinceEpoch}.dart',
  );
  File(runnerPath).parent.createSync(recursive: true);

  sl('runner', 'writing temporary script…');
  frac(0.08);
  final buf = StringBuffer();
  buf.writeln("// ignore_for_file: unused_local_variable");
  buf.writeln("import 'dart:convert';");
  buf.writeln("import 'dart:io';");
  _writeSnapshotRunnerImports(buf, packageRoot, packageName, absoluteLibPath, extraPackageImports);
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

  for (final cls in parsed.allFileClasses) {
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
  final receiverInfo = parsed.allFileClasses.where((c) => c.name == parsed.className).firstOrNull;
  final receiverExpr =
      receiverInfo != null ? instantiationExpressionForClass(receiverInfo) : '${parsed.className}()';
  buf.writeln('  final c = $receiverExpr;');
  buf.writeln();

  for (final m in parsed.methods) {
    final cases = generateBoundaryCases(m.params);
    for (final args in cases) {
      final argList = formatArgsForSnapshot(m.params, args);
      final argJson = jsonEncode(args);
      if (m.snapshotReturnType == 'void') {
        buf.writeln('  {');
        buf.writeln("    const method = '${_escapeDartString(m.name)}';");
        buf.writeln('    final args = $argJson as List<dynamic>;');
        buf.writeln('    try {');
        if (m.isStream) {
          buf.writeln('      await c.${m.name}($argList).toList();');
        } else if (m.isAsync) {
          buf.writeln('      await c.${m.name}($argList);');
        } else {
          buf.writeln('      c.${m.name}($argList);');
        }
        buf.writeln("      out.add({'method': method, 'args': args, 'ok': true});");
        buf.writeln('    } catch (e) {');
        buf.writeln(
            "      out.add({'method': method, 'args': args, 'ok': false, 'exception': e.runtimeType.toString()});");
        buf.writeln('    }');
        buf.writeln('  }');
      } else {
        buf.writeln('  {');
        buf.writeln("    const method = '${_escapeDartString(m.name)}';");
        buf.writeln('    final args = $argJson as List<dynamic>;');
        buf.writeln('    try {');
        if (m.isStream) {
          buf.writeln('      final v = await c.${m.name}($argList).toList();');
        } else if (m.isAsync) {
          buf.writeln('      final v = await c.${m.name}($argList);');
        } else {
          buf.writeln('      final v = c.${m.name}($argList);');
        }
        buf.writeln("      out.add({'method': method, 'args': args, 'ok': true, 'value': snapshotValue(v)});");
        buf.writeln('    } catch (e) {');
        buf.writeln(
            "      out.add({'method': method, 'args': args, 'ok': false, 'exception': e.runtimeType.toString()});");
        buf.writeln('    }');
        buf.writeln('  }');
      }
    }
    buf.writeln();
  }

  buf.writeln("  stdout.write(jsonEncode(out));");
  buf.writeln('}');

  File(runnerPath).writeAsStringSync(buf.toString());
  sl('runner', runnerPath);
  frac(0.22);

  try {
    sl('process', 'dart run snapshot runner…');
    frac(0.38);
    final result = Process.runSync(
      Platform.resolvedExecutable,
      ['run', runnerPath],
      workingDirectory: packageRoot,
      runInShell: false,
    );
    if (result.exitCode != 0) {
      final se = result.stderr.toString();
      final so = result.stdout.toString();
      onRunnerFailed?.call(se, so);
      stderr.write('$se\n$so\n');
      throw StateError('snapshot runner failed: exit ${result.exitCode}');
    }
    sl('process', 'exit 0, decoding JSON…');
    frac(0.92);
    final raw = result.stdout as String;
    final decoded = jsonDecode(raw);
    if (decoded is! List) {
      throw StateError('snapshot: ожидался JSON-массив');
    }
    frac(1.0);
    return _mergeDecoded(parsed, decoded);
  } finally {
    try {
      File(runnerPath).deleteSync();
    } catch (_) {}
  }
}

List<MethodSnapshot> _mergeDecoded(ParsedClass parsed, List<dynamic> decoded) {
  var idx = 0;
  final snapshots = <MethodSnapshot>[];

  for (final m in parsed.methods) {
    final cases = generateBoundaryCases(m.params);
    final rows = <SnapshotRow>[];
    for (var i = 0; i < cases.length; i++) {
      if (idx >= decoded.length) {
        throw StateError('snapshot: не хватает записей (метод ${m.name})');
      }
      final row = decoded[idx++] as Map<String, dynamic>;
      final name = row['method'] as String;
      if (name != m.name) {
        throw StateError('snapshot: ожидался метод ${m.name}, получено $name');
      }
      final argLiterals = List<String>.from(cases[i]);
      final ok = row['ok'] as bool;
      if (ok) {
        if (m.snapshotReturnType == 'void') {
          rows.add(SnapshotRow(argLiterals: argLiterals));
        } else {
          final lit = dartLiteralFromJson(row['value'], m.snapshotReturnType, parsed.allFileClasses);
          rows.add(SnapshotRow(argLiterals: argLiterals, expectedDartLiteral: lit));
        }
      } else {
        final ex = row['exception'] as String;
        rows.add(SnapshotRow(argLiterals: argLiterals, throwsExceptionType: ex));
      }
    }
    snapshots.add(MethodSnapshot(methodName: m.name, rows: rows));
  }

  if (idx != decoded.length) {
    throw StateError('snapshot: лишние записи в JSON');
  }

  return snapshots;
}

/// `List<T>` / `Set<T>` / `Iterable<T>` with a single simple type token `T` (no nested `<` or `,`).
String? _collectionSingleTypeArg(String returnType, String collectionKeyword) {
  var n = returnType.replaceAll(' ', '');
  if (n.endsWith('?')) n = n.substring(0, n.length - 1);
  final prefix = '$collectionKeyword<';
  if (!n.startsWith(prefix) || !n.endsWith('>')) return null;
  final inner = n.substring(prefix.length, n.length - 1);
  if (inner.isEmpty || inner.contains('<') || inner.contains('>') || inner.contains(',')) {
    return null;
  }
  return inner;
}

/// `Map<String, T>` with a single simple value type token `T`.
String? _mapStringValueInnerType(String returnType) {
  var n = returnType.replaceAll(' ', '');
  if (n.endsWith('?')) n = n.substring(0, n.length - 1);
  const prefix = 'Map<String,';
  if (!n.startsWith(prefix) || !n.endsWith('>')) return null;
  final inner = n.substring(prefix.length, n.length - 1);
  if (inner.isEmpty || inner.contains(',') || inner.contains('<') || inner.contains('>')) {
    return null;
  }
  return inner;
}

/// Литерал Dart из значения JSON (после снимка).
String dartLiteralFromJson(dynamic value, String returnType, List<ClassInfo> allClasses) {
  if (value is Map) {
    final m = Map<Object?, Object?>.from(value);
    if (m.containsKey('_type')) {
      final type = m['_type'] as String;
      if (m.containsKey('_value')) {
        // Fallback for objects we couldn't decompose
        return m['_value'].toString();
      }

      final cls = allClasses.where((c) => c.name == type).firstOrNull;
      if (cls != null) {
        final args = <String>[];
        for (final p in cls.constructorPositionalParams) {
          args.add(dartLiteralFromJsonLoose(m[p]));
        }
        for (final p in cls.constructorNamedParams) {
          args.add('$p: ${dartLiteralFromJsonLoose(m[p])}');
        }
        return '$type(${args.join(', ')})';
      }

      // Fallback if class info not found (e.g. imported class)
      final fields = <String>[];
      for (final entry in m.entries) {
        final k = entry.key as String;
        if (k == '_type') continue;
        final v = dartLiteralFromJsonLoose(entry.value);
        fields.add('$k: $v');
      }
      return '$type(${fields.join(', ')})';
    }
    if (m['_enumType'] != null && m['_enumName'] != null) {
      return '${m['_enumType']}.${m['_enumName']}';
    }

    final mapInner = _mapStringValueInnerType(returnType);
    if (mapInner != null) {
      final parts = <String>[];
      for (final entry in m.entries) {
        final k = '${entry.key}';
        final vLit = dartLiteralFromJson(entry.value, mapInner, allClasses);
        parts.add("'${_escapeDartString(k)}': $vLit");
      }
      return '{${parts.join(', ')}}';
    }
  }

  final listInner = _collectionSingleTypeArg(returnType, 'List');
  if (listInner != null && value is List) {
    final parts = value.map((dynamic e) => dartLiteralFromJson(e, listInner, allClasses)).toList();
    return '[${parts.join(', ')}]';
  }

  final setInner = _collectionSingleTypeArg(returnType, 'Set');
  if (setInner != null && value is List) {
    if (value.isEmpty) {
      return '<$setInner>{}';
    }
    if (setInner == 'int') {
      final lits = <String>[];
      final nums = <int>[];
      for (final e in value) {
        nums.add((e as num).toInt());
        lits.add(dartLiteralFromJson(e, 'int', allClasses));
      }
      final order = List<int>.generate(value.length, (i) => i);
      order.sort((a, b) => nums[a].compareTo(nums[b]));
      return '{${order.map((i) => lits[i]).join(', ')}}';
    }
    final literals = value.map((dynamic e) => dartLiteralFromJson(e, setInner, allClasses)).toList()..sort();
    return '{${literals.join(', ')}}';
  }

  final iterInner = _collectionSingleTypeArg(returnType, 'Iterable');
  if (iterInner != null && value is List) {
    final parts = value.map((dynamic e) => dartLiteralFromJson(e, iterInner, allClasses)).join(', ');
    return '[$parts]';
  }

  if (returnType == 'bool') {
    if (value is! bool) throw StateError('bool expected, got $value');
    return value ? 'true' : 'false';
  }
  if (returnType == 'int') {
    if (value is int) return '$value';
    if (value is num) return value.toInt().toString();
    throw StateError('int expected, got $value');
  }
  if (returnType == 'double') {
    if (value is! num) throw StateError('double expected, got $value');
    final d = value.toDouble();
    if (d.isNaN || d.isInfinite) return d.toString();
    if (d == d.roundToDouble()) return '${d.toInt()}.0';
    return d.toString();
  }
  if (returnType == 'String') {
    if (value is! String) throw StateError('String expected, got $value');
    return "'${_escapeDartString(value)}'";
  }
  return dartLiteralFromJsonLoose(value);
}

String dartLiteralFromJsonLoose(dynamic value) {
  if (value == null) return 'null';
  if (value is bool) return value ? 'true' : 'false';
  if (value is int) return '$value';
  if (value is double) {
    final d = value;
    if (d.isNaN || d.isInfinite) return d.toString();
    return d.toString();
  }
  if (value is String) return "'${_escapeDartString(value)}'";
  throw StateError('unsupported json value $value');
}
