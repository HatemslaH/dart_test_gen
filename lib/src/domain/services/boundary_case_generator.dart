import '../models/enums.dart';
import '../models/test_models.dart';

const Map<ParamType, List<String>> kBoundaryValues = {
  ParamType.int_: ['0', '1', '-1', '2', '-2', '10', '-10'],
  ParamType.double_: ['0.0', '1.0', '-1.0', '0.5', '-0.5'],
  ParamType.bool_: ['true', 'false'],
  ParamType.string_: ["''", "'hello'", "'  '"],
  ParamType.dynamic_: ['0', "'str'"],
  ParamType.listInt_: ['<int>[]', '[0]', '[1, -1, 2]'],
  // Compact sets: same semantic boundaries as listInt_/string_, without extra combinatorics.
  ParamType.listString_: ['<String>[]', "['']", "['hello']"],
  ParamType.setInt_: ['<int>{}', '{0}', '{-1, 1}'],
  ParamType.iterableInt_: ['<int>[]', '[0]', '[1, -1, 2]'],
  ParamType.enum_: const [], // only with literalValues
  ParamType.custom_: const [], // only with literalValues
};

List<List<String>> generateBoundaryCases(List<Param> params) {
  if (params.isEmpty) return [[]];

  List<List<String>> result = [[]];
  for (final param in params) {
    final values = <String>{};

    // Always add standard boundaries for primitive types
    final defaults = kBoundaryValues[param.type];
    if (defaults != null && defaults.isNotEmpty) {
      values.addAll(defaults);
    }

    // Add literals specific to the parameter (from AST or enum)
    if (param.literalValues != null) {
      values.addAll(param.literalValues!);
    }

    if (param.isNullable) {
      values.add('null');
    }
    if (param.defaultValueCode != null) {
      values.add(param.defaultValueCode!);
    }
    if (param.isNamed || param.isOptionalPositional) {
      values.add('__OMITTED__');
    }

    final valuesList = values.toList();
    result = [
      for (final existing in result)
        for (final val in valuesList)
          if (_isValidCombination(existing, val, params)) [...existing, val],
    ];
  }
  return result;
}

bool _isValidCombination(List<String> existing, String newVal, List<Param> params) {
  final nextIdx = existing.length;
  final param = params[nextIdx];

  if (param.isOptionalPositional) {
    // If the current arg is not omitted but a previous optional positional was omitted — invalid.
    if (newVal != '__OMITTED__') {
      for (var i = 0; i < existing.length; i++) {
        if (params[i].isOptionalPositional && existing[i] == '__OMITTED__') {
          return false;
        }
      }
    }
  }
  return true;
}
