import 'package:dart_test_gen/dart_test_gen.dart';

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
}
