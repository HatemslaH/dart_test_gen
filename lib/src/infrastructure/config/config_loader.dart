import 'dart:io';

import 'package:dart_test_gen/dart_test_gen.dart';
import 'package:path/path.dart' as p;
import 'package:yaml/yaml.dart';

/// YAML-backed [ConfigReader] using `dart:io`.
final class IoConfigReader implements ConfigReader {
  const IoConfigReader();

  @override
  GeneratorConfig loadConfig(String packageRoot, {String? configPath}) {
    final path = configPath ?? p.join(packageRoot, 'dart_test_gen.yaml');
    final file = File(path);

    if (!file.existsSync()) {
      return const GeneratorConfig();
    }

    try {
      final yamlString = file.readAsStringSync();
      final yaml = loadYaml(yamlString);

      if (yaml is! YamlMap) {
        return const GeneratorConfig();
      }

      final defaults = MethodConfig.fromYaml(yaml, const MethodConfig());
      final methods = <String, MethodConfig>{};

      if (yaml.containsKey('methods') && yaml['methods'] is YamlMap) {
        final methodsYaml = yaml['methods'] as YamlMap;
        for (final entry in methodsYaml.entries) {
          final methodName = entry.key as String;
          final methodYaml = entry.value as YamlMap?;
          methods[methodName] = MethodConfig.fromYaml(methodYaml, defaults);
        }
      }

      final keepRunner = yaml['keep_runner'] as bool? ?? false;

      return GeneratorConfig(defaults: defaults, methods: methods, keepRunner: keepRunner);
    } catch (_) {
      return const GeneratorConfig();
    }
  }
}
