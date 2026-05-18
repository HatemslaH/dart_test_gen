import 'package:analyzer/dart/analysis/features.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_test_gen/dart_test_gen.dart';
import 'package:test/test.dart';

void main() {
  final analyzer = const MethodLogicAnalyzer();

  CompilationUnit parseSnippet(String snippet) {
    return parseString(
      content: snippet,
      featureSet: FeatureSet.latestLanguageVersion(),
    ).unit;
  }

  MethodDeclaration getFirstMethod(CompilationUnit unit) {
    final clazz = unit.declarations.first as ClassDeclaration;
    return clazz.members.first as MethodDeclaration;
  }

  group('MethodLogicAnalyzer', () {
    test('extracts integer literals from binary expressions', () {
      final unit = parseSnippet('''
class Foo {
  void check(int x) {
    if (x > 10) {}
    if (5 <= x) {}
    if (x == -1) {}
  }
}
''');
      final method = getFirstMethod(unit);
      final profile = analyzer.analyze(method.body, ['x']);

      expect(profile.parameterLiterals['x'], containsAll(['10', '5', '-1']));
    });

    test('extracts string literals from binary expressions and switch cases', () {
      final unit = parseSnippet('''
class Foo {
  void check(String s) {
    if (s == 'admin') {}
    switch (s) {
      case 'user': break;
      case 'guest': break;
    }
  }
}
''');
      final method = getFirstMethod(unit);
      final profile = analyzer.analyze(method.body, ['s']);

      expect(profile.parameterLiterals['s'], containsAll(["'admin'", "'user'", "'guest'"]));
    });

    test('detects API calls on parameters', () {
      final unit = parseSnippet('''
class Foo {
  void process(String input, List<int> list) {
    input.trim().toLowerCase();
    list.where((x) => x.isOdd).toList();
  }
}
''');
      final method = getFirstMethod(unit);
      final profile = analyzer.analyze(method.body, ['input', 'list']);

      expect(profile.parameterInferences['input'], containsAll(['trim', 'toLowerCase']));
      expect(profile.parameterInferences['list'], containsAll(['where', 'toList']));
    });

    test('handles parenthesized expressions and unary minus', () {
      final unit = parseSnippet('''
class Foo {
  void check(int x) {
    if ((x) == (-42)) {}
  }
}
''');
      final method = getFirstMethod(unit);
      final profile = analyzer.analyze(method.body, ['x']);

      expect(profile.parameterLiterals['x'], contains('-42'));
    });
  });
}
