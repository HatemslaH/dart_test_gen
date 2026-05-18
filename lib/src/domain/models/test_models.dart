import 'package:dart_test_gen/dart_test_gen.dart';

class Param {
  final String name;
  final ParamType type;

  /// When set (e.g. enum cases), these override the default boundary values.
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

/// One test-case row after snapshotting.
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

/// Descriptor for one method, used for test generation.
class MethodSpec {
  final String name;
  final List<Param> params;
  final String returnType;

  /// Value type for `expect` / void checks (`Future<T>` → `T`, `Stream<T>` → `List<T>`).
  final String snapshotReturnType;

  final bool isAsync;
  final bool isStream;
  final bool isStatic;
  final bool isFactory;
  final MethodKind kind;

  /// From config: when true and [snapshotReturnType] is `double`, emit `closeTo`.
  final bool useCloseForDouble;

  /// Absolute epsilon for generated `closeTo` when [useCloseForDouble] is true.
  final double doubleEpsilon;

  /// From config: when true, bool/null literals use `isTrue` / `isFalse` / `isNull`.
  final bool useExpectMatchersBoolNull;

  final List<TestCaseRow> testCases;

  const MethodSpec({
    required this.name,
    required this.params,
    required this.returnType,
    required this.snapshotReturnType,
    this.isAsync = false,
    this.isStream = false,
    this.isStatic = false,
    this.isFactory = false,
    this.kind = MethodKind.method,
    this.useCloseForDouble = false,
    this.doubleEpsilon = 1e-9,
    this.useExpectMatchersBoolNull = true,
    required this.testCases,
  });
}
