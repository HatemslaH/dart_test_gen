import 'package:test/test.dart';
import 'package:dart_test_gen/snapshot.dart';

void main() {
  group('publicExceptionName — whitelist', () {
    test('_Exception → Exception', () {
      expect(publicExceptionName('_Exception'), 'Exception');
    });
    test('_AssertionError → AssertionError', () {
      expect(publicExceptionName('_AssertionError'), 'AssertionError');
    });
    test('_TypeError → TypeError', () {
      expect(publicExceptionName('_TypeError'), 'TypeError');
    });
    test('_CastError → TypeError', () {
      expect(publicExceptionName('_CastError'), 'TypeError');
    });
  });

  group('publicExceptionName — public names pass through', () {
    test('ArgumentError unchanged', () {
      expect(publicExceptionName('ArgumentError'), 'ArgumentError');
    });
    test('StateError unchanged', () {
      expect(publicExceptionName('StateError'), 'StateError');
    });
    test('FormatException unchanged', () {
      expect(publicExceptionName('FormatException'), 'FormatException');
    });
  });

  group('publicExceptionName — unknown private fallback', () {
    test('unknown _Foo with isError → Error', () {
      expect(publicExceptionName('_FooError', isError: true), 'Error');
    });
    test('unknown _Foo with isException → Exception', () {
      expect(publicExceptionName('_FooException', isException: true), 'Exception');
    });
    test('unknown _Foo with neither → Object', () {
      expect(publicExceptionName('_Unknown'), 'Object');
    });
  });

  group('publicExceptionName — idempotence', () {
    test('applying twice yields same result as once', () {
      expect(publicExceptionName(publicExceptionName('_Exception')), 'Exception');
    });
    test('already-public name is stable', () {
      expect(publicExceptionName(publicExceptionName('ArgumentError')), 'ArgumentError');
    });
  });
}
