import 'package:dart_test_gen/gen_config.dart';
import 'package:test/test.dart';
import 'package:yaml/yaml.dart';

void main() {
  group('MethodConfig double expectations from YAML', () {
    test('parses root use_close_for_double and double_epsilon', () {
      final yaml = loadYaml('''
use_close_for_double: true
double_epsilon: 1e-6
''') as YamlMap;

      final c = MethodConfig.fromYaml(yaml, const MethodConfig());
      expect(c.useCloseForDouble, true);
      expect(c.doubleEpsilon, closeTo(1e-6, 1e-15));
    });

    test('invalid double_epsilon falls back to default', () {
      final yaml = loadYaml('''
use_close_for_double: true
double_epsilon: -1
''') as YamlMap;

      final c = MethodConfig.fromYaml(yaml, const MethodConfig());
      expect(c.useCloseForDouble, true);
      expect(c.doubleEpsilon, 1e-9);
    });

    test('per-method overrides inherit then replace', () {
      final yaml = loadYaml('''
use_close_for_double: true
double_epsilon: 1e-8
methods:
  asyncSum:
    use_close_for_double: false
''') as YamlMap;

      final defaults = MethodConfig.fromYaml(yaml, const MethodConfig());
      final methodsYaml = yaml['methods'] as YamlMap;
      final methods = <String, MethodConfig>{
        for (final e in methodsYaml.entries)
          e.key as String: MethodConfig.fromYaml(e.value as YamlMap?, defaults),
      };
      final cfg = GeneratorConfig(defaults: defaults, methods: methods);

      expect(cfg.forMethod('sumTenths').useCloseForDouble, true);
      expect(cfg.forMethod('asyncSum').useCloseForDouble, false);
    });
  });

  group('yamlScalarToPositiveDouble', () {
    test('accepts int and string', () {
      expect(yamlScalarToPositiveDouble(3), 3.0);
      expect(yamlScalarToPositiveDouble('2.5'), 2.5);
      expect(yamlScalarToPositiveDouble(0), isNull);
    });
  });
}
