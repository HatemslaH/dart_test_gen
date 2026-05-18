import 'package:dart_test_gen/dart_test_gen.dart';

Future<void> main(List<String> args) async {
  if (handleEarlyExitFlags(args)) return;
  await GeneratePipeline.generateFromCli(args);
}
