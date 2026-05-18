import 'package:test/test.dart';
import 'package:dart_test_gen/test_generator.dart';
import 'package:dart_test_gen/src/domain/logic_profile.dart';
import 'package:dart_test_gen/src/domain/services/dynamic_input_generator.dart';

void main() {
  final generator = const DynamicInputGenerator();

  group('DynamicInputGenerator', () {
    test('generates integer triplets for integer literals', () {
      final profile = LogicProfile(
        parameterLiterals: {
          'x': {'10', '-5'},
        },
        parameterInferences: {},
      );
      final params = [
        const Param('x', ParamType.int_),
      ];

      final result = generator.generate(profile, params);

      expect(result['x'], containsAll(['9', '10', '11', '-6', '-5', '-4']));
    });

    test('generates string variations for string literals and API calls', () {
      final profile = LogicProfile(
        parameterLiterals: {
          's': {"'admin'"},
        },
        parameterInferences: {
          's': {'toLowerCase', 'trim'},
        },
      );
      final params = [
        const Param('s', ParamType.string_),
      ];

      final result = generator.generate(profile, params);

      expect(result['s'], containsAll(["'admin'", "''", "'MIXED_case'", "'  leading'"]));
    });

    test('generates inputs for isOdd/isEven inferences', () {
      final profile = LogicProfile(
        parameterLiterals: {},
        parameterInferences: {
          'x': {'isOdd'},
        },
      );
      final params = [
        const Param('x', ParamType.int_),
      ];

      final result = generator.generate(profile, params);

      expect(result['x'], containsAll(['1', '2']));
    });

    test('generates special values for double parameters', () {
      final profile = LogicProfile(
        parameterLiterals: {},
        parameterInferences: {
          'd': {'isNaN', 'isInfinite'},
        },
      );
      final params = [
        const Param('d', ParamType.double_),
      ];

      final result = generator.generate(profile, params);

      expect(result['d'], containsAll(['double.nan', 'double.infinity', 'double.negativeInfinity']));
    });

    test('generates length-dependent strings for integer literals in string params', () {
      final profile = LogicProfile(
        parameterLiterals: {
          's': {'5'},
        },
        parameterInferences: {},
      );
      final params = [
        const Param('s', ParamType.string_),
      ];

      final result = generator.generate(profile, params);

      expect(result['s'], containsAll(["'aaaa'", "'aaaaa'", "'aaaaaa'"]));
    });

    test('returns empty map if no logic-derived inputs are found', () {
      final profile = LogicProfile.empty();
      final params = [
        const Param('x', ParamType.int_),
      ];

      final result = generator.generate(profile, params);

      expect(result, isEmpty);
    });
  });
}
