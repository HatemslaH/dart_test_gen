import 'enums.dart';
import 'test_models.dart';

/// Description of a method extracted from source (before snapshotting).
class ParsedMethod {
  final String name;
  final List<Param> params;
  final String returnType;

  /// `true` when the body is `async` / `async*` or the declared type is `Future<…>`.
  final bool isAsync;

  /// `true` when the declared return type is `Stream<…>`.
  final bool isStream;

  /// Unwrapped type for snapshotting and codegen: `Future<T>` → `T`, `Stream<T>` → `List<T>`.
  final String snapshotReturnType;

  final bool isStatic;
  final bool isFactory;
  final MethodKind kind;

  const ParsedMethod({
    required this.name,
    required this.params,
    required this.returnType,
    required this.isAsync,
    required this.isStream,
    required this.snapshotReturnType,
    this.isStatic = false,
    this.isFactory = false,
    this.kind = MethodKind.method,
  });
}

class ClassInfo {
  final String name;
  final List<String> fields;

  /// Field name → type as written in source (e.g. `int`, `int?`).
  final Map<String, String> fieldTypes;
  final List<String> constructorPositionalParams;
  final List<String> constructorNamedParams;
  final bool isExtensionType;

  const ClassInfo(
    this.name,
    this.fields, {
    this.fieldTypes = const {},
    this.constructorPositionalParams = const [],
    this.constructorNamedParams = const [],
    this.isExtensionType = false,
  });
}

/// Result of parsing a single file: class name and its methods.
class ParsedClass {
  final String className;
  final List<ParsedMethod> methods;
  final List<ClassInfo> allFileClasses;

  const ParsedClass({
    required this.className,
    required this.methods,
    required this.allFileClasses,
  });
}

String _sampleLiteralForConstructorField(String typeSource, int diagonalIdx) {
  final t = typeSource.replaceAll(' ', '');
  final base = t.endsWith('?') ? t.substring(0, t.length - 1) : t;
  switch (base) {
    case 'int':
      return diagonalIdx == 0 ? '0' : '255';
    case 'double':
      return diagonalIdx == 0 ? '0.0' : '1.0';
    case 'bool':
      return diagonalIdx == 0 ? 'false' : 'true';
    case 'String':
      return diagonalIdx == 0 ? "''" : "'test'";
    default:
      return '0';
  }
}

/// Constructor call with primitive literals (positional, then named) — for snapshots and boundaries.
String instantiationExpressionForClass(ClassInfo cls, {int diagonalIdx = 0}) {
  final parts = <String>[];
  for (final name in cls.constructorPositionalParams) {
    final typeSrc = cls.fieldTypes[name] ?? 'dynamic';
    parts.add(_sampleLiteralForConstructorField(typeSrc, diagonalIdx));
  }
  for (final name in cls.constructorNamedParams) {
    final typeSrc = cls.fieldTypes[name] ?? 'dynamic';
    parts.add('$name: ${_sampleLiteralForConstructorField(typeSrc, diagonalIdx)}');
  }
  return '${cls.name}(${parts.join(', ')})';
}

/// Two diagonal constructor-call literals using boundary primitives per field type.
List<String>? sampleLiteralsForCustomClass(ClassInfo cls) {
  if (cls.constructorPositionalParams.isEmpty && cls.constructorNamedParams.isEmpty) {
    return null;
  }
  return [
    instantiationExpressionForClass(cls, diagonalIdx: 0),
    instantiationExpressionForClass(cls, diagonalIdx: 1),
  ];
}
