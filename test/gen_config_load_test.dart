import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:dart_test_gen/gen_config.dart';

void main() {
  late Directory tempDir;

  setUp(() {
    tempDir = Directory.systemTemp.createTempSync('dart_test_gen_config_test_');
  });

  tearDown(() {
    tempDir.deleteSync(recursive: true);
  });

  group('GeneratorConfig.load — missing file', () {
    test('returns defaults when no dart_test_gen.yaml exists', () {
      final config = GeneratorConfig.load(tempDir.path);
      expect(config.keepRunner, isFalse);
      expect(config.methods, isEmpty);
      expect(config.defaults.strategy, SamplingStrategy.full);
      expect(config.defaults.maxCases, 200);
    });
  });

  group('GeneratorConfig.load — invalid YAML', () {
    test('returns defaults on invalid YAML content', () {
      final yamlFile = File(p.join(tempDir.path, 'dart_test_gen.yaml'));
      yamlFile.writeAsStringSync(': invalid: : yaml:::');
      final config = GeneratorConfig.load(tempDir.path);
      expect(config.keepRunner, isFalse);
      expect(config.methods, isEmpty);
    });

    test('returns defaults when YAML is not a map', () {
      final yamlFile = File(p.join(tempDir.path, 'dart_test_gen.yaml'));
      yamlFile.writeAsStringSync('- just a list');
      final config = GeneratorConfig.load(tempDir.path);
      expect(config.defaults.maxCases, 200);
    });
  });

  group('GeneratorConfig.load — keep_runner', () {
    test('keep_runner: true sets keepRunner = true', () {
      final yamlFile = File(p.join(tempDir.path, 'dart_test_gen.yaml'));
      yamlFile.writeAsStringSync('keep_runner: true\n');
      final config = GeneratorConfig.load(tempDir.path);
      expect(config.keepRunner, isTrue);
    });

    test('keep_runner: false sets keepRunner = false', () {
      final yamlFile = File(p.join(tempDir.path, 'dart_test_gen.yaml'));
      yamlFile.writeAsStringSync('keep_runner: false\n');
      final config = GeneratorConfig.load(tempDir.path);
      expect(config.keepRunner, isFalse);
    });
  });

  group('GeneratorConfig.load — explicit configPath', () {
    test('uses provided configPath instead of default', () {
      final customPath = p.join(tempDir.path, 'custom_config.yaml');
      File(customPath).writeAsStringSync('keep_runner: true\nmax_cases: 42\n');
      final config = GeneratorConfig.load(tempDir.path, configPath: customPath);
      expect(config.keepRunner, isTrue);
      expect(config.defaults.maxCases, 42);
    });

    test('returns defaults when explicit configPath does not exist', () {
      final config = GeneratorConfig.load(
        tempDir.path,
        configPath: p.join(tempDir.path, 'nonexistent.yaml'),
      );
      expect(config.defaults.maxCases, 200);
    });
  });

  group('GeneratorConfig.load — per-method override inheritance', () {
    test('per-method strategy overrides with top-level maxCases inherited', () {
      final yamlFile = File(p.join(tempDir.path, 'dart_test_gen.yaml'));
      yamlFile.writeAsStringSync('''
max_cases: 30
methods:
  divide:
    strategy: happy_path
''');
      final config = GeneratorConfig.load(tempDir.path);
      expect(config.forMethod('divide').strategy, SamplingStrategy.happyPath);
      expect(config.forMethod('divide').maxCases, 30);
      expect(config.forMethod('other').maxCases, 30);
    });

    test('method with no overrides falls back to defaults', () {
      final yamlFile = File(p.join(tempDir.path, 'dart_test_gen.yaml'));
      yamlFile.writeAsStringSync('''
strategy: random
max_cases: 50
methods:
  add:
    max_cases: 10
''');
      final config = GeneratorConfig.load(tempDir.path);
      expect(config.forMethod('add').maxCases, 10);
      expect(config.forMethod('add').strategy, SamplingStrategy.random);
      expect(config.forMethod('subtract').maxCases, 50);
      expect(config.forMethod('subtract').strategy, SamplingStrategy.random);
    });
  });
}
