import 'dart:io';

import 'package:analyzer/dart/analysis/features.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:path/path.dart' as p;

import 'test_generator.dart';

/// Описание метода, извлечённого из исходника (до снимка).
class ParsedMethod {
  final String name;
  final List<Param> params;
  final String returnType;

  const ParsedMethod({
    required this.name,
    required this.params,
    required this.returnType,
  });
}

/// Результат разбора одного файла: имя класса и его методы.
class ParsedClass {
  final String className;
  final List<ParsedMethod> methods;

  const ParsedClass({required this.className, required this.methods});
}

ParamType _paramTypeFromAnnotation(TypeAnnotation? t) {
  if (t == null) return ParamType.dynamic_;
  final name = _namedTypeBaseName(t);
  if (name == null) return ParamType.dynamic_;
  switch (name) {
    case 'int':
      return ParamType.int_;
    case 'double':
      return ParamType.double_;
    case 'bool':
      return ParamType.bool_;
    case 'String':
      return ParamType.string_;
    default:
      return ParamType.dynamic_;
  }
}

String? _namedTypeBaseName(TypeAnnotation t) {
  if (t is NamedType) {
    return t.name2.lexeme;
  }
  return null;
}

String _returnTypeString(MethodDeclaration m) {
  final rt = m.returnType;
  if (rt == null) return 'dynamic';
  return rt.toSource();
}

bool _isAsyncOrFuture(MethodDeclaration m) {
  if (m.body.isAsynchronous) return true;
  final rt = m.returnType;
  if (rt is NamedType) {
    final base = rt.name2.lexeme;
    if (base == 'Future' || base == 'Stream') return true;
  }
  return false;
}

bool _isSupportedInstanceMethod(MethodDeclaration m) {
  if (m.parent is! ClassDeclaration) return false;
  if (m.isStatic) return false;
  if (m.operatorKeyword != null) return false;
  if (m.name.lexeme.startsWith('_')) return false;
  if (m.body is EmptyFunctionBody) return false;
  if (_isAsyncOrFuture(m)) return false;
  return true;
}

List<Param> _paramsFromFormalList(FormalParameterList? list) {
  if (list == null) return const [];
  final out = <Param>[];
  for (final fp in list.parameters) {
    final resolved = fp is DefaultFormalParameter ? fp.parameter : fp;
    if (resolved is SimpleFormalParameter) {
      final paramName = resolved.name;
      if (paramName == null) {
        return const [];
      }
      out.add(Param(paramName.lexeme, _paramTypeFromAnnotation(resolved.type)));
    } else {
      return const [];
    }
  }
  return out;
}

bool _hasUnsupportedParameters(FormalParameterList? list) {
  if (list == null) return false;
  for (final fp in list.parameters) {
    final resolved = fp is DefaultFormalParameter ? fp.parameter : fp;
    if (resolved is! SimpleFormalParameter) return true;
  }
  return false;
}

ClassDeclaration? _findTargetClass(CompilationUnit unit, {String? className}) {
  final classes = unit.declarations.whereType<ClassDeclaration>().toList();
  if (classes.isEmpty) return null;

  if (className != null) {
    for (final c in classes) {
      if (c.name.lexeme == className) return c;
    }
    return null;
  }

  for (final c in classes) {
    if (!c.name.lexeme.startsWith('_')) return c;
  }
  return classes.first;
}

/// Разбирает [absoluteLibPath] (файл в `lib/`) и возвращает публичный класс с методами.
ParsedClass parseLibraryClass(String absoluteLibPath, {String? className}) {
  final parsed = parseFile(path: absoluteLibPath, featureSet: FeatureSet.latestLanguageVersion()).unit;
  final cls = _findTargetClass(parsed, className: className);
  if (cls == null) {
    throw StateError('Не найден класс в файле: $absoluteLibPath');
  }

  final methods = <ParsedMethod>[];
  for (final member in cls.members) {
    if (member is! MethodDeclaration) continue;
    final m = member;
    if (!_isSupportedInstanceMethod(m)) continue;
    if (_hasUnsupportedParameters(m.parameters)) continue;

    final params = _paramsFromFormalList(m.parameters);
    methods.add(
      ParsedMethod(
        name: m.name.lexeme,
        params: params,
        returnType: _returnTypeString(m),
      ),
    );
  }

  return ParsedClass(className: cls.name.lexeme, methods: methods);
}

/// Корень пакета: каталог, содержащий `pubspec.yaml`, для пути к файлу.
String findPackageRootForFile(String absoluteFilePath) {
  var dir = p.dirname(p.normalize(absoluteFilePath));
  while (true) {
    if (File(p.join(dir, 'pubspec.yaml')).existsSync()) {
      return dir;
    }
    final parent = p.dirname(dir);
    if (parent == dir) {
      throw StateError('pubspec.yaml не найден выше по дереву от $absoluteFilePath');
    }
    dir = parent;
  }
}

/// `lib/foo.dart` → `package:<name>/foo.dart`
String packageImportUri(String packageRoot, String packageName, String absoluteLibPath) {
  final libRoot = p.join(packageRoot, 'lib');
  final rel = p.relative(absoluteLibPath, from: libRoot);
  if (rel.startsWith('..')) {
    throw StateError('Файл должен находиться в $libRoot, получено: $absoluteLibPath');
  }
  final posix = rel.replaceAll(r'\', '/');
  return 'package:$packageName/$posix';
}

String readPackageName(String packageRoot) {
  final pubspec = p.join(packageRoot, 'pubspec.yaml');
  final text = File(pubspec).readAsStringSync();
  for (final line in text.split('\n')) {
    final trimmed = line.trimLeft();
    if (trimmed.startsWith('name:')) {
      return trimmed.substring('name:'.length).trim();
    }
  }
  throw StateError('Имя пакета не найдено в $pubspec');
}
