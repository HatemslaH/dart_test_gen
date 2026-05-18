import 'package:analyzer/dart/analysis/features.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_test_gen/dart_test_gen.dart';
import 'package:path/path.dart' as p;

/// Collects `EnumName.variant` literals for every public enum in the file.
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

List<ClassInfo> collectAllClasses(CompilationUnit unit) {
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

      // Find the primary constructor (unnamed or first suitable).
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

    // For primitive types we want default boundaries PLUS literals found in source.
    // If we return combined here, generateBoundaryCases skips the defaults.
    // So we track whether to merge with defaults — Param has no dedicated flag for that.
    // Easiest fix: put ALL values in Param.literalValues when it's not an enum.

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
      // `operator ==(Object other)` and `Object`/`Object?` — literals behave like dynamic.
      case 'Object':
        return create(ParamType.dynamic_);
      default:
        final cls = allFileClasses.where((c) => c.name == base).firstOrNull;
        final customLiterals = cls != null ? sampleLiteralsForCustomClass(cls) : null;
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

/// For setters the AST often omits return type — semantically this is `void`.
String _returnTypeStringForMember(MethodDeclaration m, MethodKind kind) {
  if (kind == MethodKind.setter) {
    final rt = m.returnType;
    if (rt == null) return 'void';
    return rt.toSource();
  }
  return _returnTypeString(m);
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

bool _isSupportedOperator(String op, FormalParameterList? parameters) {
  final n = parameters?.parameters.length ?? 0;
  switch (op) {
    case '-':
      return n == 0 || n == 1;
    case '~':
      return n == 0;
    case '[]':
      return n == 1;
    case '[]=':
      return n == 2;
    case '+':
    case '*':
    case '/':
    case '%':
    case '~/':
    case '&':
    case '|':
    case '^':
    case '<<':
    case '>>':
    case '>>>':
    case '<':
    case '>':
    case '<=':
    case '>=':
    case '==':
      return n == 1;
    default:
      return false;
  }
}

/// Returns the member kind when supported by the generator; otherwise `null`.
MethodKind? _supportedMemberKind(MethodDeclaration m) {
  if (m.parent is! ClassDeclaration && m.parent is! ExtensionTypeDeclaration) return null;
  if (m.name.lexeme.startsWith('_')) return null;
  if (m.body is EmptyFunctionBody) return null;

  if (m.isGetter) {
    if (m.parameters != null && m.parameters!.parameters.isNotEmpty) return null;
    if (_hasUnsupportedParameters(m.parameters)) return null;
    return MethodKind.getter;
  }
  if (m.isSetter) {
    if (m.parameters == null || m.parameters!.parameters.length != 1) return null;
    if (_hasUnsupportedParameters(m.parameters)) return null;
    return MethodKind.setter;
  }
  if (m.isOperator) {
    final op = m.name.lexeme;
    if (!_isSupportedOperator(op, m.parameters)) return null;
    if (_hasUnsupportedParameters(m.parameters)) return null;
    return MethodKind.operator_;
  }

  if (m.operatorKeyword != null) return null;
  return MethodKind.method;
}

List<Param> _paramsFromFormalList(
  FormalParameterList? list,
  Map<String, List<String>> enumLiterals,
  List<ClassInfo> allFileClasses,
  AstNode? node,
) {
  if (list == null) return const [];

  final paramNames = <String>[];
  for (final fp in list.parameters) {
    final resolved = fp is DefaultFormalParameter ? fp.parameter : fp;
    if (resolved is SimpleFormalParameter && resolved.name != null) {
      paramNames.add(resolved.name!.lexeme);
    }
  }

  final body = node is MethodDeclaration ? node.body : (node is ConstructorDeclaration ? node.body : null);
  final profile = const MethodLogicAnalyzer().analyze(body, paramNames);

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

      final initialParam = _paramFor(
        paramName.lexeme,
        resolved.type,
        enumLiterals,
        allFileClasses,
        isNullable: isNullable,
        isNamed: isNamed,
        isOptionalPositional: isOptionalPositional,
        defaultValueCode: defaultValueCode,
      );

      // Generate dynamic inputs and merge with Param.literalValues
      final dynamicInputs = const DynamicInputGenerator().generate(profile, [initialParam]);
      final extraLiterals = dynamicInputs[paramName.lexeme];

      out.add(_paramFor(
        paramName.lexeme,
        resolved.type,
        enumLiterals,
        allFileClasses,
        isNullable: isNullable,
        isNamed: isNamed,
        isOptionalPositional: isOptionalPositional,
        defaultValueCode: defaultValueCode,
        extraLiterals: extraLiterals?.toList(),
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

/// Class name selected for generation (same heuristic as parsing without `--class`).
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
        if (_supportedMemberKind(member) == null) continue;
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

/// Extends [enumLiterals] and [allClasses] with declarations from [mergeLibAbsolutePaths].
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
      for (final info in collectAllClasses(unit)) {
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

/// Parses [absoluteLibPath] (a file under `lib/`).
///
/// Returns `null` when [className] is `null` and the file is not suitable:
/// no [ClassDeclaration] (e.g. enum-only file), or the target class has no supported instance methods.
///
/// When [className] is set but the class is missing or has no supported methods — throws [StateError].
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
  final allClasses = List<ClassInfo>.from(collectAllClasses(parsed));
  _mergeDeclarationsFromLibPaths(enumLiterals, allClasses, mergeLibAbsolutePaths);

  final methods = <ParsedMethod>[];
  final members = cls is ClassDeclaration ? cls.members : (cls as ExtensionTypeDeclaration).members;
  for (final member in members) {
    if (member is MethodDeclaration) {
      final m = member;
      final kind = _supportedMemberKind(m);
      if (kind == null) continue;

      final params = _paramsFromFormalList(m.parameters, enumLiterals, allClasses, m);
      final returnType = _returnTypeStringForMember(m, kind);
      final snapshotRt = kind == MethodKind.setter ? 'void' : _snapshotReturnTypeForMethod(m);
      methods.add(
        ParsedMethod(
          name: m.name.lexeme,
          params: params,
          returnType: returnType,
          isAsync: _methodIsAsync(m),
          isStream: _methodIsStream(m),
          snapshotReturnType: snapshotRt,
          isStatic: m.isStatic,
          kind: kind,
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
            kind: MethodKind.method,
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

/// Like [parseLibraryClassOptional], but never returns `null`: throws [StateError] if there is nothing to generate.
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
