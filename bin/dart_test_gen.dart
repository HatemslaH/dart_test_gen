import 'package:dart_test_gen/dart_test_gen.dart';

Future<void> main(List<String> args) async {
  final dependencies = AppDependencies.production();
  if (dependencies.cli.earlyExitHandler.handle(args)) return;
  await GeneratePipeline.generateFromCli(args, dependencies: dependencies);
}
