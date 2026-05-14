import '../../test_generator.dart';
import '../domain/logic_profile.dart';

enum StringHint {
  caseSensitive,
  whitespace,
  delimiter,
  emptyString,
  lengthDependent,
  substringMatch,
  replacement,
  padding,
}

enum NumericHint {
  parity,
  signDependent,
  rounding,
  specialValues,
  arithmetic,
  bitManipulation,
  formatting,
}

const _stringHints = {
  'toLowerCase': StringHint.caseSensitive,
  'toUpperCase': StringHint.caseSensitive,
  'trim': StringHint.whitespace,
  'trimLeft': StringHint.whitespace,
  'trimRight': StringHint.whitespace,
  'split': StringHint.delimiter,
  'splitMapJoin': StringHint.delimiter,
  'isEmpty': StringHint.emptyString,
  'isNotEmpty': StringHint.emptyString,
  'substring': StringHint.lengthDependent,
  'length': StringHint.lengthDependent,
  'codeUnitAt': StringHint.lengthDependent,
  'startsWith': StringHint.substringMatch,
  'endsWith': StringHint.substringMatch,
  'contains': StringHint.substringMatch,
  'indexOf': StringHint.substringMatch,
  'lastIndexOf': StringHint.substringMatch,
  'replaceFirst': StringHint.replacement,
  'replaceAll': StringHint.replacement,
  'replaceRange': StringHint.replacement,
  'padLeft': StringHint.padding,
  'padRight': StringHint.padding,
};

const _numericHints = {
  'isOdd': NumericHint.parity,
  'isEven': NumericHint.parity,
  'abs': NumericHint.signDependent,
  'sign': NumericHint.signDependent,
  'isNegative': NumericHint.signDependent,
  'round': NumericHint.rounding,
  'floor': NumericHint.rounding,
  'ceil': NumericHint.rounding,
  'truncate': NumericHint.rounding,
  'toInt': NumericHint.rounding,
  'toDouble': NumericHint.rounding,
  'roundToDouble': NumericHint.rounding,
  'floorToDouble': NumericHint.rounding,
  'ceilToDouble': NumericHint.rounding,
  'truncateToDouble': NumericHint.rounding,
  'isNaN': NumericHint.specialValues,
  'isFinite': NumericHint.specialValues,
  'isInfinite': NumericHint.specialValues,
  'gcd': NumericHint.arithmetic,
  'modPow': NumericHint.arithmetic,
  'modInverse': NumericHint.arithmetic,
  'bitLength': NumericHint.bitManipulation,
  'toUnsigned': NumericHint.bitManipulation,
  'toSigned': NumericHint.bitManipulation,
  'toStringAsFixed': NumericHint.formatting,
  'toStringAsExponential': NumericHint.formatting,
  'toStringAsPrecision': NumericHint.formatting,
};

/// Generates targeted test inputs based on a [LogicProfile].
class DynamicInputGenerator {
  const DynamicInputGenerator();

  /// Returns a map of parameter name to a set of logic-derived literals.
  Map<String, Set<String>> generate(LogicProfile profile, List<Param> params) {
    final result = <String, Set<String>>{};

    for (final param in params) {
      final literals = profile.parameterLiterals[param.name] ?? {};
      final inferences = profile.parameterInferences[param.name] ?? {};
      final dynamicBoundaries = <String>{};

      for (final lit in literals) {
        dynamicBoundaries.add(lit);

        // Integer boundaries (value - 1, value, value + 1)
        if (param.type == ParamType.int_) {
          final val = int.tryParse(lit);
          if (val != null) {
            dynamicBoundaries.add('${val - 1}');
            dynamicBoundaries.add('${val + 1}');
          }
        }

        // String variations
        if (param.type == ParamType.string_) {
          dynamicBoundaries.add("''");

          // If we found an integer literal for a string parameter (e.g. from .length),
          // generate strings of that length.
          final val = int.tryParse(lit);
          if (val != null && val >= 0) {
            if (val > 0) dynamicBoundaries.add("'${'a' * (val - 1)}'");
            dynamicBoundaries.add("'${'a' * val}'");
            dynamicBoundaries.add("'${'a' * (val + 1)}'");
          }
        }
      }

      // API-based inferences
      for (final inf in inferences) {
        if (param.type == ParamType.string_) {
          final hint = _stringHints[inf];
          if (hint != null) {
            _addStringHintBoundaries(dynamicBoundaries, hint);
          }
        }
        if (param.type == ParamType.int_ || param.type == ParamType.double_ || param.type == ParamType.listInt_) {
          final hint = _numericHints[inf];
          if (hint != null) {
            _addNumericHintBoundaries(dynamicBoundaries, hint, param.type);
          }
        }
      }

      if (dynamicBoundaries.isNotEmpty) {
        result[param.name] = dynamicBoundaries;
      }
    }

    return result;
  }

  void _addStringHintBoundaries(Set<String> boundaries, StringHint hint) {
    switch (hint) {
      case StringHint.caseSensitive:
        boundaries.addAll(["'MIXED_case'", "'UPPERCASE'", "'lowercase'"]);
      case StringHint.whitespace:
        boundaries.addAll(["'  leading'", "'trailing  '", "'  both  '", r"'\t tab \n'"]);
      case StringHint.delimiter:
        boundaries.addAll(["','", "' '", "'|'", "';'"]);
      case StringHint.emptyString:
        boundaries.addAll(["''", "' '"]);
      case StringHint.lengthDependent:
        boundaries.addAll(["'a'", "'long string' * 10"]);
      case StringHint.substringMatch:
        boundaries.addAll(["'prefix'", "'suffix'", "'middle'"]);
      case StringHint.replacement:
        boundaries.addAll(["'old'", "'new'"]);
      case StringHint.padding:
        boundaries.addAll(["'x'", "'0'"]);
    }
  }

  void _addNumericHintBoundaries(Set<String> boundaries, NumericHint hint, ParamType type) {
    switch (hint) {
      case NumericHint.parity:
        boundaries.addAll(['1', '2']);
      case NumericHint.signDependent:
        boundaries.addAll(['-1', '0', '1']);
      case NumericHint.rounding:
        if (type == ParamType.double_) {
          boundaries.addAll(['0.1', '0.5', '0.9', '-0.5']);
        }
      case NumericHint.specialValues:
        if (type == ParamType.double_) {
          boundaries.addAll(['double.nan', 'double.infinity', 'double.negativeInfinity']);
        }
      case NumericHint.arithmetic:
        boundaries.addAll(['2', '3', '5', '7']);
      case NumericHint.bitManipulation:
        boundaries.addAll(['0', '1', '255', '-1']);
      case NumericHint.formatting:
        boundaries.addAll(['1.2345', '123456.789']);
    }
  }
}
