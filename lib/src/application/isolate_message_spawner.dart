import 'dart:isolate';

import 'package:dart_test_gen/dart_test_gen.dart';

final class IsolateMessageSpawner {
  IsolateMessageSpawner(
    SingleLibraryGenerator singleLibraryGenerator,
    SnapshotFailureFormatter snapshotFailureFormatter,
  )   : _singleLibraryGenerator = singleLibraryGenerator,
        _snapshotFailureFormatter = snapshotFailureFormatter;

  final SingleLibraryGenerator _singleLibraryGenerator;
  final SnapshotFailureFormatter _snapshotFailureFormatter;

  Map<String, Object?> spawnMessage({
    required String absoluteLibPath,
    required String packageRoot,
    required String packageName,
    required String? className,
    required String displayLabel,
    required bool verbose,
    required GeneratorConfig config,
    required SendPort logPort,
  }) =>
      <String, Object?>{
        'absoluteLibPath': absoluteLibPath,
        'packageRoot': packageRoot,
        'packageName': packageName,
        'className': className,
        'displayLabel': displayLabel,
        'verbose': verbose,
        'config': config,
        'logPort': logPort,
      };

  @pragma('vm:entry-point')
  Future<void> generationIsolateMain(Map<String, Object?> message) async {
    final path = message['absoluteLibPath']! as String;
    final root = message['packageRoot']! as String;
    final pkg = message['packageName']! as String;
    final className = message['className'] as String?;
    final displayLabel = message['displayLabel']! as String;
    final verbose = message['verbose']! as bool;
    final config = message['config']! as GeneratorConfig;
    final port = message['logPort']! as SendPort;

    void bridge({double? progress, String? line, bool? error}) {
      final isErr = error == true;
      if (progress != null) {
        port.send(<String, Object?>{
          't': GenerationIsolateProtocol.msgProgress,
          'l': displayLabel,
          'pct': progress,
        });
      }
      if (line != null && (verbose || isErr)) {
        port.send(<String, Object?>{
          't': isErr ? GenerationIsolateProtocol.msgError : GenerationIsolateProtocol.msgVerbose,
          'm': line,
        });
      }
    }

    var ok = false;
    try {
      final result = await _singleLibraryGenerator.generateSingleLibraryFile(
        filesystem: IoGenerationFilesystem(),
        generator: const SnapshotUnitTestGeneratorModule(),
        absoluteLibPath: path,
        packageRoot: root,
        packageName: pkg,
        className: className,
        displayLabel: displayLabel,
        verbose: verbose,
        config: config,
        emit: bridge,
      );
      if (result.checkFailure != null) {
        port.send(<String, Object?>{'t': GenerationIsolateProtocol.msgCheckFail, 's': result.checkFailure!.summary});
      }
      final outLine = result.stdoutLine;
      if (outLine != null) {
        port.send(<String, Object?>{'t': GenerationIsolateProtocol.msgStdout, 'm': outLine});
      }
      ok = true;
    } on SnapshotRunnerFailure catch (f) {
      bridge(line: _snapshotFailureFormatter.format(f), error: true);
    } catch (e, st) {
      bridge(
        line: 'ERROR\t$e\n$st\n',
        error: true,
      );
    }
    port.send('${GenerationIsolateProtocol.isolateResultPrefix}:${ok ? "ok" : "fail"}');
    port.send(GenerationIsolateProtocol.isolateDoneSentinel);
  }
}
