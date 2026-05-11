import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:yaml/yaml.dart';

/// Parses a finite positive `double` from YAML values (`num`, `String`, etc.).
double? yamlScalarToPositiveDouble(Object? value) {
  if (value == null) return null;
  if (value is double) {
    if (!value.isFinite || value <= 0) return null;
    return value;
  }
  if (value is int) {
    if (value <= 0) return null;
    return value.toDouble();
  }
  if (value is String) {
    final d = double.tryParse(value.trim());
    if (d == null || !d.isFinite || d <= 0) return null;
    return d;
  }
  return null;
}

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

  /// When true, successful `double` expectations use `closeTo` with [doubleEpsilon].
  final bool useCloseForDouble;

  /// Absolute epsilon for `closeTo` (only used when [useCloseForDouble] is true).
  final double doubleEpsilon;

  const MethodConfig({
    this.strategy = SamplingStrategy.full,
    this.maxCases = 200,
    this.seed,
    this.useCloseForDouble = false,
    this.doubleEpsilon = 1e-9,
  });

  factory MethodConfig.fromYaml(YamlMap? yaml, MethodConfig defaults) {
    if (yaml == null) return defaults;

    final useClose = yaml.containsKey('use_close_for_double')
        ? (yaml['use_close_for_double'] as bool? ?? defaults.useCloseForDouble)
        : defaults.useCloseForDouble;

    final epsFromYaml = yaml.containsKey('double_epsilon')
        ? (yamlScalarToPositiveDouble(yaml['double_epsilon']) ?? defaults.doubleEpsilon)
        : defaults.doubleEpsilon;

    return MethodConfig(
      strategy:
          yaml.containsKey('strategy') ? SamplingStrategy.fromString(yaml['strategy'] as String?) : defaults.strategy,
      maxCases: yaml['max_cases'] as int? ?? defaults.maxCases,
      seed: yaml['seed'] as int? ?? defaults.seed,
      useCloseForDouble: useClose,
      doubleEpsilon: epsFromYaml,
    );
  }

  MethodConfig copyWith({
    SamplingStrategy? strategy,
    int? maxCases,
    int? seed,
    bool? useCloseForDouble,
    double? doubleEpsilon,
  }) {
    return MethodConfig(
      strategy: strategy ?? this.strategy,
      maxCases: maxCases ?? this.maxCases,
      seed: seed ?? this.seed,
      useCloseForDouble: useCloseForDouble ?? this.useCloseForDouble,
      doubleEpsilon: doubleEpsilon ?? this.doubleEpsilon,
    );
  }
}

class GeneratorConfig {
  final MethodConfig defaults;
  final Map<String, MethodConfig> methods;
  final bool keepRunner;

  const GeneratorConfig({
    this.defaults = const MethodConfig(),
    this.methods = const {},
    this.keepRunner = false,
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

      final keepRunner = yaml['keep_runner'] as bool? ?? false;

      return GeneratorConfig(defaults: defaults, methods: methods, keepRunner: keepRunner);
    } catch (e) {
      // Fallback to defaults on error
      return const GeneratorConfig();
    }
  }
}
