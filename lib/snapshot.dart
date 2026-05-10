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

/// Генерирует исходник раннера, выполняет его и возвращает снимки по методам.
List<MethodSnapshot> runSnapshots({
  required String packageRoot,
  required String packageName,
  required String absoluteLibPath,
  required ParsedClass parsed,
}) {
  final runnerPath = p.join(
    packageRoot,
    '.dart_tool',
    'dart_test_gen',
    'snapshot_runner_${DateTime.now().microsecondsSinceEpoch}.dart',
  );
  File(runnerPath).parent.createSync(recursive: true);

  final importUri = packageImportUri(packageRoot, packageName, absoluteLibPath);
  final buf = StringBuffer();
  buf.writeln("// ignore_for_file: unused_local_variable");
  buf.writeln("import 'dart:convert';");
  buf.writeln("import 'dart:io';");
  buf.writeln("import '$importUri';");
  buf.writeln();
  buf.writeln('void main() {');
  buf.writeln('  final out = <Map<String, Object?>>[];');
  buf.writeln('  final c = ${parsed.className}();');
  buf.writeln();

  for (final m in parsed.methods) {
    final cases = generateBoundaryCases(m.params);
    for (final args in cases) {
      final argList = args.join(', ');
      final argJson = jsonEncode(args);
      if (m.returnType == 'void') {
        buf.writeln('  {');
        buf.writeln("    const method = '${_escapeDartString(m.name)}';");
        buf.writeln('    final args = $argJson as List<dynamic>;');
        buf.writeln('    try {');
        buf.writeln('      c.${m.name}($argList);');
        buf.writeln("      out.add({'method': method, 'args': args, 'ok': true});");
        buf.writeln('    } catch (e) {');
        buf.writeln("      out.add({'method': method, 'args': args, 'ok': false, 'exception': e.runtimeType.toString()});");
        buf.writeln('    }');
        buf.writeln('  }');
      } else {
        buf.writeln('  {');
        buf.writeln("    const method = '${_escapeDartString(m.name)}';");
        buf.writeln('    final args = $argJson as List<dynamic>;');
        buf.writeln('    try {');
        buf.writeln('      final v = c.${m.name}($argList);');
        buf.writeln('      if (v is! num && v is! bool && v is! String && v != null) {');
        buf.writeln('        throw StateError("unsupported snapshot result type");');
        buf.writeln('      }');
        buf.writeln("      out.add({'method': method, 'args': args, 'ok': true, 'value': v});");
        buf.writeln('    } catch (e) {');
        buf.writeln("      out.add({'method': method, 'args': args, 'ok': false, 'exception': e.runtimeType.toString()});");
        buf.writeln('    }');
        buf.writeln('  }');
      }
    }
    buf.writeln();
  }

  buf.writeln("  stdout.write(jsonEncode(out));");
  buf.writeln('}');

  File(runnerPath).writeAsStringSync(buf.toString());

  try {
    final result = Process.runSync(
      Platform.resolvedExecutable,
      ['run', runnerPath],
      workingDirectory: packageRoot,
      runInShell: false,
    );
    if (result.exitCode != 0) {
      stderr.writeln(result.stderr);
      stderr.writeln(result.stdout);
      throw StateError('snapshot runner failed: exit ${result.exitCode}');
    }
    final raw = result.stdout as String;
    final decoded = jsonDecode(raw);
    if (decoded is! List) {
      throw StateError('snapshot: ожидался JSON-массив');
    }
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
        if (m.returnType == 'void') {
          rows.add(SnapshotRow(argLiterals: argLiterals));
        } else {
          final lit = dartLiteralFromJson(row['value'], m.returnType);
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

/// Литерал Dart из значения JSON (после снимка).
String dartLiteralFromJson(dynamic value, String returnType) {
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
  if (returnType == 'dynamic' || returnType.contains('?')) {
    return dartLiteralFromJsonLoose(value);
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
