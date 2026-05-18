import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:yaml/yaml.dart';

enum SamplingStrategy {
  full, // all possible combinations
  random, // random selection of several combinations
  happyPath; // happy paths only (no exceptions)

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

  /// When true, bool/null snapshot literals emit `isTrue` / `isFalse` / `isNull` instead of `expected` locals.
  final bool useExpectMatchersBoolNull;

  const MethodConfig({
    this.strategy = SamplingStrategy.full,
    this.maxCases = 200,
    this.seed,
    this.useCloseForDouble = false,
    this.doubleEpsilon = 1e-9,
    this.useExpectMatchersBoolNull = true,
  });

  factory MethodConfig.fromYaml(YamlMap? yaml, MethodConfig defaults) {
    if (yaml == null) return defaults;

    final useClose = yaml.containsKey('use_close_for_double')
        ? (yaml['use_close_for_double'] as bool? ?? defaults.useCloseForDouble)
        : defaults.useCloseForDouble;

    final epsFromYaml = yaml.containsKey('double_epsilon')
        ? (yamlScalarToPositiveDouble(yaml['double_epsilon']) ?? defaults.doubleEpsilon)
        : defaults.doubleEpsilon;

    final useMatchers = yaml.containsKey('use_expect_matchers_bool_null')
        ? (yaml['use_expect_matchers_bool_null'] as bool? ?? defaults.useExpectMatchersBoolNull)
        : defaults.useExpectMatchersBoolNull;

    return MethodConfig(
      strategy:
          yaml.containsKey('strategy') ? SamplingStrategy.fromString(yaml['strategy'] as String?) : defaults.strategy,
      maxCases: yaml['max_cases'] as int? ?? defaults.maxCases,
      seed: yaml['seed'] as int? ?? defaults.seed,
      useCloseForDouble: useClose,
      doubleEpsilon: epsFromYaml,
      useExpectMatchersBoolNull: useMatchers,
    );
  }

  /// Parses a finite positive `double` from YAML values (`num`, `String`, etc.).
  static double? yamlScalarToPositiveDouble(Object? value) {
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

  MethodConfig copyWith({
    SamplingStrategy? strategy,
    int? maxCases,
    int? seed,
    bool? useCloseForDouble,
    double? doubleEpsilon,
    bool? useExpectMatchersBoolNull,
  }) {
    return MethodConfig(
      strategy: strategy ?? this.strategy,
      maxCases: maxCases ?? this.maxCases,
      seed: seed ?? this.seed,
      useCloseForDouble: useCloseForDouble ?? this.useCloseForDouble,
      doubleEpsilon: doubleEpsilon ?? this.doubleEpsilon,
      useExpectMatchersBoolNull: useExpectMatchersBoolNull ?? this.useExpectMatchersBoolNull,
    );
  }
}

class GeneratorConfig {
  final MethodConfig defaults;
  final Map<String, MethodConfig> methods;
  final bool keepRunner;

  /// When true, generation runs but no test files are written; output paths are printed to stdout.
  final bool dryRun;

  /// When true, generated content is compared to the existing file instead of written.
  /// Exits with code 1 if any target differs.
  final bool check;

  const GeneratorConfig({
    this.defaults = const MethodConfig(),
    this.methods = const {},
    this.keepRunner = false,
    this.dryRun = false,
    this.check = false,
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
