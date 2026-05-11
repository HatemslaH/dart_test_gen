import 'dart:io';

import 'package:analyzer/dart/analysis/features.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:path/path.dart' as p;

import 'test_generator.dart';

/// Описание метода, извлечённого из исходника (до снимка).
class ParsedMethod {
  final String name;
  final List<Param> params;
  final String returnType;

  /// `true` если тело `async` / `async*` или объявленный тип — `Future<…>`.
  final bool isAsync;

  /// `true` если объявленный тип возврата — `Stream<…>`.
  final bool isStream;

  /// Развёрнутый тип для снимка и генерации: `Future<T>` → `T`, `Stream<T>` → `List<T>`.
  final String snapshotReturnType;

  final bool isStatic;
  final bool isFactory;

  const ParsedMethod({
    required this.name,
    required this.params,
    required this.returnType,
    required this.isAsync,
    required this.isStream,
    required this.snapshotReturnType,
    this.isStatic = false,
    this.isFactory = false,
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

/// Результат разбора одного файла: имя класса и его методы.
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

/// Собирает литералы `EnumName.variant` для всех публичных enum в файле.
Map<String, List<String>> collectEnumLiterals(CompilationUnit unit) {
  final map = <String, List<String>>{};
  for (final d in unit.declarations) {
    if (d is! EnumDeclaration) continue;
    final name = d.name.lexeme;
    if (name.startsWith('_')) continue;
    final values = <String>[];
    for (final ec in d.constants) {
      values.add('$name.${ec.name.lexeme}');
    }
    if (values.isEmpty) continue;
    map[name] = values;
  }
  return map;
}

List<ClassInfo> _collectAllClasses(CompilationUnit unit) {
  final out = <ClassInfo>[];
  for (final d in unit.declarations) {
    if (d is ClassDeclaration) {
      final fields = <String>[];
      final fieldTypes = <String, String>{};
      for (final member in d.members) {
        if (member is FieldDeclaration && !member.isStatic) {
          final typeSource = member.fields.type?.toSource() ?? 'dynamic';
          for (final v in member.fields.variables) {
            final name = v.name.lexeme;
            if (!name.startsWith('_')) {
              fields.add(name);
              fieldTypes[name] = typeSource;
            }
          }
        }
      }

      // Находим основной конструктор (неименованный или первый попавшийся)
      final positional = <String>[];
      final named = <String>[];
      ConstructorDeclaration? primary;
      for (final member in d.members) {
        if (member is ConstructorDeclaration && member.factoryKeyword == null) {
          if (member.name == null) {
            primary = member;
            break;
          }
          primary ??= member;
        }
      }

      if (primary != null) {
        for (final p in primary.parameters.parameters) {
          if (p.isNamed) {
            named.add(p.name!.lexeme);
          } else {
            positional.add(p.name!.lexeme);
          }
        }
      }

      out.add(ClassInfo(
        d.name.lexeme,
        fields,
        fieldTypes: fieldTypes,
        constructorPositionalParams: positional,
        constructorNamedParams: named,
      ));
    } else if (d is ExtensionTypeDeclaration) {
      final fields = <String>[];
      final fieldTypes = <String, String>{};
      
      final rep = d.representation;
      final repName = rep.fieldName.lexeme;
      fields.add(repName);
      fieldTypes[repName] = rep.fieldType.toSource();
      
      final positional = <String>[repName];
      final named = <String>[];
      
      out.add(ClassInfo(
        d.name.lexeme,
        fields,
        fieldTypes: fieldTypes,
        constructorPositionalParams: positional,
        constructorNamedParams: named,
        isExtensionType: true,
      ));
    }
  }
  return out;
}

List<String> _extractLiteralsFromNode(AstNode? node, String paramName) {
  if (node == null) return const [];
  final literals = <String>{};
  node.visitChildren(_LiteralVisitor(paramName, literals));
  return literals.toList();
}

class _LiteralVisitor extends RecursiveAstVisitor<void> {
  final String paramName;
  final Set<String> literals;

  _LiteralVisitor(this.paramName, this.literals);

  @override
  void visitBinaryExpression(BinaryExpression node) {
    if (node.operator.lexeme == '==' || node.operator.lexeme == '!=') {
      _check(node.leftOperand, node.rightOperand);
      _check(node.rightOperand, node.leftOperand);
    }
    super.visitBinaryExpression(node);
  }

  @override
  void visitSwitchCase(SwitchCase node) {
    // Если switch(paramName)
    final parent = node.parent;
    if (parent is SwitchStatement) {
      final target = parent.expression;
      if (target is SimpleIdentifier && target.name == paramName) {
        final expr = node.expression;
        if (expr is Literal) {
          literals.add(expr.toSource());
        }
      }
    }
    super.visitSwitchCase(node);
  }

  void _check(Expression a, Expression b) {
    if (a is SimpleIdentifier && a.name == paramName) {
      if (b is Literal) {
        literals.add(b.toSource());
      }
    }
  }
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

/// Вызов конструктора с примитивными литералами (позиционные, затем именованные) — для снимков и границ.
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
List<String>? _sampleLiteralsForCustomClass(ClassInfo cls) {
  if (cls.constructorPositionalParams.isEmpty && cls.constructorNamedParams.isEmpty) {
    return null;
  }
  return [
    instantiationExpressionForClass(cls, diagonalIdx: 0),
    instantiationExpressionForClass(cls, diagonalIdx: 1),
  ];
}

Param _paramFor(
  String paramName,
  TypeAnnotation? t,
  Map<String, List<String>> enumLiterals,
  List<ClassInfo> allFileClasses, {
  bool isNullable = false,
  bool isNamed = false,
  bool isOptionalPositional = false,
  String? defaultValueCode,
  List<String>? extraLiterals,
}) {
  Param create(ParamType type, {List<String>? literalValues}) {
    final combined = <String>{};
    if (literalValues != null) combined.addAll(literalValues);
    if (extraLiterals != null) combined.addAll(extraLiterals);

    // Для базовых типов мы хотим сохранить стандартные границы ПЛЮС найденные литералы.
    // Если мы вернем combined здесь, generateBoundaryCases проигнорирует стандарты.
    // Поэтому мы помечаем, нужно ли объединять со стандартами.
    // Но в Param сейчас нет такого поля.
    // Проще всего в Param.literalValues положить ВСЕ значения, если это не Enum.

    return Param(
      paramName,
      type,
      literalValues: combined.isEmpty ? null : combined.toList(),
      isNullable: isNullable,
      isNamed: isNamed,
      isOptionalPositional: isOptionalPositional,
      defaultValueCode: defaultValueCode,
    );
  }

  if (t == null) {
    return create(ParamType.dynamic_);
  }
  if (t is NamedType) {
    final base = t.name.lexeme;
    if (_isListOfIntNamedType(t)) {
      return create(ParamType.listInt_);
    }
    if (_isListOfStringNamedType(t)) {
      return create(ParamType.listString_);
    }
    if (_isSetOfIntNamedType(t)) {
      return create(ParamType.setInt_);
    }
    if (_isIterableOfIntNamedType(t)) {
      return create(ParamType.iterableInt_);
    }
    final enumCases = enumLiterals[base];
    if (enumCases != null) {
      return create(ParamType.enum_, literalValues: enumCases);
    }
    switch (base) {
      case 'int':
        return create(ParamType.int_);
      case 'double':
        return create(ParamType.double_);
      case 'bool':
        return create(ParamType.bool_);
      case 'String':
        return create(ParamType.string_);
      default:
        final cls = allFileClasses.where((c) => c.name == base).firstOrNull;
        final customLiterals = cls != null ? _sampleLiteralsForCustomClass(cls) : null;
        return create(ParamType.custom_, literalValues: customLiterals);
    }
  }
  return create(ParamType.dynamic_);
}

bool _isListOfIntNamedType(NamedType t) {
  if (t.name.lexeme != 'List') return false;
  final args = t.typeArguments?.arguments;
  if (args == null || args.length != 1) return false;
  final inner = args.single;
  return inner is NamedType && inner.name.lexeme == 'int';
}

bool _isListOfStringNamedType(NamedType t) {
  if (t.name.lexeme != 'List') return false;
  final args = t.typeArguments?.arguments;
  if (args == null || args.length != 1) return false;
  final inner = args.single;
  return inner is NamedType && inner.name.lexeme == 'String';
}

bool _isSetOfIntNamedType(NamedType t) {
  if (t.name.lexeme != 'Set') return false;
  final args = t.typeArguments?.arguments;
  if (args == null || args.length != 1) return false;
  final inner = args.single;
  return inner is NamedType && inner.name.lexeme == 'int';
}

bool _isIterableOfIntNamedType(NamedType t) {
  if (t.name.lexeme != 'Iterable') return false;
  final args = t.typeArguments?.arguments;
  if (args == null || args.length != 1) return false;
  final inner = args.single;
  return inner is NamedType && inner.name.lexeme == 'int';
}

String _returnTypeString(MethodDeclaration m) {
  final rt = m.returnType;
  if (rt == null) return 'dynamic';
  return rt.toSource();
}

String? _futureStreamInner(NamedType rt) {
  final base = rt.name.lexeme;
  if (base != 'Future' && base != 'Stream') return null;
  final args = rt.typeArguments?.arguments;
  if (args == null || args.isEmpty) return 'dynamic';
  if (args.length != 1) return null;
  return args.single.toSource();
}

String _snapshotReturnTypeForMethod(MethodDeclaration m) {
  final rt = m.returnType;
  if (rt is NamedType) {
    final base = rt.name.lexeme;
    if (base == 'Future') {
      return _futureStreamInner(rt) ?? 'dynamic';
    }
    if (base == 'Stream') {
      final inner = _futureStreamInner(rt) ?? 'dynamic';
      return 'List<$inner>';
    }
  }
  return _returnTypeString(m);
}

bool _methodIsStream(MethodDeclaration m) {
  final rt = m.returnType;
  return rt is NamedType && rt.name.lexeme == 'Stream';
}

bool _methodIsAsync(MethodDeclaration m) {
  if (m.body.isAsynchronous) return true;
  final rt = m.returnType;
  return rt is NamedType && rt.name.lexeme == 'Future';
}

bool _isSupportedMethod(MethodDeclaration m) {
  if (m.parent is! ClassDeclaration && m.parent is! ExtensionTypeDeclaration) return false;
  if (m.operatorKeyword != null) return false;
  if (m.isGetter || m.isSetter) return false;
  if (m.name.lexeme.startsWith('_')) return false;
  if (m.body is EmptyFunctionBody) return false;
  return true;
}

List<Param> _paramsFromFormalList(
  FormalParameterList? list,
  Map<String, List<String>> enumLiterals,
  List<ClassInfo> allFileClasses,
  AstNode? node,
) {
  if (list == null) return const [];
  final out = <Param>[];
  for (final fp in list.parameters) {
    final isNamed = fp.isNamed;
    final isOptionalPositional = fp.isOptionalPositional;
    String? defaultValueCode;

    final resolved = fp is DefaultFormalParameter ? fp.parameter : fp;
    if (fp is DefaultFormalParameter) {
      defaultValueCode = fp.defaultValue?.toSource();
    }

    if (resolved is SimpleFormalParameter) {
      final paramName = resolved.name;
      if (paramName == null) {
        return const [];
      }

      final type = resolved.type;
      bool isNullable = false;
      if (type == null) {
        isNullable = true;
      } else if (type is NamedType) {
        isNullable = type.question != null;
      } else if (type is GenericFunctionType) {
        isNullable = type.question != null;
      }

      final extraLiterals = _extractLiteralsFromNode(node, paramName.lexeme);

      out.add(_paramFor(
        paramName.lexeme,
        resolved.type,
        enumLiterals,
        allFileClasses,
        isNullable: isNullable,
        isNamed: isNamed,
        isOptionalPositional: isOptionalPositional,
        defaultValueCode: defaultValueCode,
        extraLiterals: extraLiterals,
      ));
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

/// Имя класса, для которого выполняется генерация (как при разборе без `--class`).
String? targetClassNameForGeneration(String absoluteLibPath, {String? className}) {
  final parsed = parseFile(path: absoluteLibPath, featureSet: FeatureSet.latestLanguageVersion()).unit;
  final cls = _findTargetClassOrExtensionType(parsed, className: className);
  return cls?.name.lexeme;
}

NamedCompilationUnitMember? _findTargetClassOrExtensionType(CompilationUnit unit, {String? className}) {
  final classesAndExtensions = unit.declarations
      .where((d) => d is ClassDeclaration || d is ExtensionTypeDeclaration)
      .cast<NamedCompilationUnitMember>()
      .toList();
  if (classesAndExtensions.isEmpty) return null;

  if (className != null) {
    for (final c in classesAndExtensions) {
      if (c.name.lexeme == className) return c;
    }
    return null;
  }

  NamedCompilationUnitMember? best;
  var bestScore = -1;
  for (final c in classesAndExtensions) {
    if (c.name.lexeme.startsWith('_')) continue;
    var score = 0;
    
    final members = c is ClassDeclaration ? c.members : (c as ExtensionTypeDeclaration).members;
    for (final member in members) {
      if (member is ConstructorDeclaration) {
        if (member.factoryKeyword != null && (member.name == null || !member.name!.lexeme.startsWith('_'))) score++;
      } else if (member is MethodDeclaration) {
        if (!_isSupportedMethod(member)) continue;
        if (_hasUnsupportedParameters(member.parameters)) continue;
        score++;
      }
    }
    if (score > bestScore) {
      bestScore = score;
      best = c;
    }
  }
  if (best != null) return best;

  for (final c in classesAndExtensions) {
    if (!c.name.lexeme.startsWith('_')) return c;
  }
  return classesAndExtensions.first;
}

/// Дополняет [enumLiterals] и [allClasses] объявлениями из указанных файлов [mergeLibAbsolutePaths].
void _mergeDeclarationsFromLibPaths(
  Map<String, List<String>> enumLiterals,
  List<ClassInfo> allClasses,
  List<String> mergeLibAbsolutePaths,
) {
  for (final rawPath in mergeLibAbsolutePaths) {
    final path = p.normalize(rawPath);
    try {
      final unit = parseFile(path: path, featureSet: FeatureSet.latestLanguageVersion()).unit;
      enumLiterals.addAll(collectEnumLiterals(unit));
      for (final info in _collectAllClasses(unit)) {
        final i = allClasses.indexWhere((c) => c.name == info.name);
        if (i < 0) {
          allClasses.add(info);
        } else {
          allClasses[i] = info;
        }
      }
    } catch (_) {}
  }
}

/// Разбирает [absoluteLibPath] (файл в `lib/`).
///
/// Возвращает `null`, если при [className] == `null` файл не подходит для генерации:
/// нет ни одного [ClassDeclaration] (например только enum без класса), либо у целевого класса
/// нет поддерживаемых методов экземпляра.
///
/// Если [className] задан и класс не найден или в нём нет поддерживаемых методов — бросает
/// [StateError].
ParsedClass? parseLibraryClassOptional(
  String absoluteLibPath, {
  String? className,
  List<String> mergeLibAbsolutePaths = const [],
}) {
  final parsed = parseFile(path: absoluteLibPath, featureSet: FeatureSet.latestLanguageVersion()).unit;
  final cls = _findTargetClassOrExtensionType(parsed, className: className);
  if (cls == null) {
    if (className != null) {
      throw StateError('Не найден класс $className в файле: $absoluteLibPath');
    }
    return null;
  }

  final enumLiterals = Map<String, List<String>>.from(collectEnumLiterals(parsed));
  final allClasses = List<ClassInfo>.from(_collectAllClasses(parsed));
  _mergeDeclarationsFromLibPaths(enumLiterals, allClasses, mergeLibAbsolutePaths);

  final methods = <ParsedMethod>[];
  final members = cls is ClassDeclaration ? cls.members : (cls as ExtensionTypeDeclaration).members;
  for (final member in members) {
    if (member is MethodDeclaration) {
      final m = member;
      if (!_isSupportedMethod(m)) continue;
      if (_hasUnsupportedParameters(m.parameters)) continue;

      final params = _paramsFromFormalList(m.parameters, enumLiterals, allClasses, m);
      methods.add(
        ParsedMethod(
          name: m.name.lexeme,
          params: params,
          returnType: _returnTypeString(m),
          isAsync: _methodIsAsync(m),
          isStream: _methodIsStream(m),
          snapshotReturnType: _snapshotReturnTypeForMethod(m),
          isStatic: m.isStatic,
        ),
      );
    } else if (member is ConstructorDeclaration) {
      if (member.factoryKeyword != null) {
        if (member.name?.lexeme.startsWith('_') == true) continue;
        if (_hasUnsupportedParameters(member.parameters)) continue;

        final params = _paramsFromFormalList(member.parameters, enumLiterals, allClasses, member);
        methods.add(
          ParsedMethod(
            name: member.name?.lexeme ?? '',
            params: params,
            returnType: cls.name.lexeme,
            isAsync: false,
            isStream: false,
            snapshotReturnType: cls.name.lexeme,
            isFactory: true,
          ),
        );
      }
    }
  }

  if (methods.isEmpty) {
    if (className != null) {
      throw StateError(
        'В классе ${cls.name.lexeme} нет поддерживаемых методов: $absoluteLibPath',
      );
    }
    return null;
  }

  return ParsedClass(
    className: cls.name.lexeme,
    methods: methods,
    allFileClasses: allClasses,
  );
}

/// Как [parseLibraryClassOptional], но не возвращает `null`: бросает [StateError], если
/// сгенерировать тесты не из чего.
ParsedClass parseLibraryClass(
  String absoluteLibPath, {
  String? className,
  List<String> mergeLibAbsolutePaths = const [],
}) {
  final r = parseLibraryClassOptional(
    absoluteLibPath,
    className: className,
    mergeLibAbsolutePaths: mergeLibAbsolutePaths,
  );
  if (r == null) {
    throw StateError('Нет класса с поддерживаемыми методами: $absoluteLibPath');
  }
  return r;
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
