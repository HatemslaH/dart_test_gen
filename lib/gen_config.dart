import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:yaml/yaml.dart';

enum SamplingStrategy {
  full, // все возможные комбинации
  random, // случайный выбор нескольких комбинаций
  happyPath; // только успешные пути (без исключений)

  static SamplingStrategy fromString(String? value) {
    return switch (value?.toLowerCase()) {
      'full' => SamplingStrategy.full,
      'random' => SamplingStrategy.random,
      'happy_path' || 'happypath' => SamplingStrategy.happyPath,
      _ => SamplingStrategy.full,
    };
  }
}

class MethodConfig {
  final SamplingStrategy strategy;
  final int maxCases;
  final int? seed;

  const MethodConfig({
    this.strategy = SamplingStrategy.full,
    this.maxCases = 200,
    this.seed,
  });

  factory MethodConfig.fromYaml(YamlMap? yaml, MethodConfig defaults) {
    if (yaml == null) return defaults;

    return MethodConfig(
      strategy:
          yaml.containsKey('strategy') ? SamplingStrategy.fromString(yaml['strategy'] as String?) : defaults.strategy,
      maxCases: yaml['max_cases'] as int? ?? defaults.maxCases,
      seed: yaml['seed'] as int? ?? defaults.seed,
    );
  }

  MethodConfig copyWith({
    SamplingStrategy? strategy,
    int? maxCases,
    int? seed,
  }) {
    return MethodConfig(
      strategy: strategy ?? this.strategy,
      maxCases: maxCases ?? this.maxCases,
      seed: seed ?? this.seed,
    );
  }
}

class GeneratorConfig {
  final MethodConfig defaults;
  final Map<String, MethodConfig> methods;

  const GeneratorConfig({
    this.defaults = const MethodConfig(),
    this.methods = const {},
  });

  MethodConfig forMethod(String name) => methods[name] ?? defaults;

  static GeneratorConfig load(String packageRoot, {String? configPath}) {
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

      return GeneratorConfig(defaults: defaults, methods: methods);
    } catch (e) {
      // Fallback to defaults on error
      return const GeneratorConfig();
    }
  }
}
