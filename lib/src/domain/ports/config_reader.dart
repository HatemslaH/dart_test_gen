import 'package:dart_test_gen/gen_config.dart';

/// Loads [GeneratorConfig] from disk (YAML) without coupling the domain model to `dart:io`.
abstract class ConfigReader {
  GeneratorConfig loadConfig(String packageRoot, {String? configPath});
}
