/// Messages from the isolate (sendable types only).
abstract final class GenerationIsolateProtocol {
  static const msgProgress = 'p';
  static const msgVerbose = 'v';
  static const msgError = 'e';
  static const msgCheckFail = 'cf';
  static const msgStdout = 'so';

  /// [isolateDoneSentinel] follows [isolateResultPrefix].
  static const isolateResultPrefix = '__dart_test_gen_result__';
  static const isolateDoneSentinel = '__dart_test_gen_isolate_done__';
}
