import 'package:dart_test_gen/src/domain/models/parsed_models.dart';
import 'package:dart_test_gen/src/domain/models/snapshot_models.dart';
import 'package:dart_test_gen/src/domain/services/boundary_case_generator.dart';

List<MethodSnapshot> mergeDecodedSnapshots(
  List<ParsedMethod> methods,
  List<ClassInfo> allFileClasses,
  List<dynamic> decoded,
) {
  var idx = 0;
  final snapshots = <MethodSnapshot>[];

  for (final m in methods) {
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
          final lit = dartLiteralFromJson(row['value'], m.snapshotReturnType, allFileClasses);
          rows.add(SnapshotRow(argLiterals: argLiterals, expectedDartLiteral: lit));
        }
      } else {
        final ex = publicExceptionName(row['exception'] as String);
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

String _escapeDartString(String s) {
  return s.replaceAll(r'\', r'\\').replaceAll("'", r"\'");
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

/// Dart literal from a JSON value (after snapshot).
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
