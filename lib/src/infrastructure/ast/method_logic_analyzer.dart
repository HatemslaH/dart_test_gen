import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';

import '../../domain/logic_profile.dart';

/// Analyzes a method body to extract logic-derived test hints.
class MethodLogicAnalyzer {
  const MethodLogicAnalyzer();

  LogicProfile analyze(AstNode? body, List<String> paramNames) {
    if (body == null) return LogicProfile.empty();

    final literals = <String, Set<String>>{};
    final inferences = <String, Set<String>>{};

    for (final name in paramNames) {
      literals[name] = {};
      inferences[name] = {};
      body.accept(_LogicVisitor(name, literals[name]!, inferences[name]!));
    }

    return LogicProfile(
      parameterLiterals: literals,
      parameterInferences: inferences,
    );
  }
}

class _LogicVisitor extends RecursiveAstVisitor<void> {
  final String paramName;
  final Set<String> literals;
  final Set<String> inferences;

  _LogicVisitor(this.paramName, this.literals, this.inferences);

  @override
  void visitBinaryExpression(BinaryExpression node) {
    final left = _unwrapParens(node.leftOperand);
    final right = _unwrapParens(node.rightOperand);

    if (_tracesToParam(left)) {
      _extractLiteral(right);
    } else if (_tracesToParam(right)) {
      _extractLiteral(left);
    }

    super.visitBinaryExpression(node);
  }

  @override
  void visitSwitchStatement(SwitchStatement node) {
    final target = _unwrapParens(node.expression);
    if (_isParam(target)) {
      for (final member in node.members) {
        if (member is SwitchCase) {
          _extractLiteral(member.expression);
        } else if (member is SwitchPatternCase) {
          final pattern = member.guardedPattern.pattern;
          if (pattern is ConstantPattern) {
            _extractLiteral(pattern.expression);
          }
        }
      }
    }
    super.visitSwitchStatement(node);
  }

  @override
  void visitMethodInvocation(MethodInvocation node) {
    final target = node.target;
    if (target != null && _tracesToParam(_unwrapParens(target))) {
      inferences.add(node.methodName.name);
    }
    super.visitMethodInvocation(node);
  }

  bool _isParam(Expression e) {
    return e is SimpleIdentifier && e.name == paramName;
  }

  bool _tracesToParam(Expression e) {
    var current = _unwrapParens(e);
    while (current is MethodInvocation || current is PropertyAccess || current is PrefixedIdentifier) {
      if (current is MethodInvocation) {
        final target = current.target;
        if (target == null) return false;
        current = _unwrapParens(target);
      } else if (current is PropertyAccess) {
        final target = current.target;
        if (target == null) return false;
        current = _unwrapParens(target);
      } else if (current is PrefixedIdentifier) {
        current = current.prefix;
      }
    }
    return _isParam(current);
  }

  void _extractLiteral(Expression e) {
    final u = _unwrapParens(e);
    if (u is Literal) {
      literals.add(u.toSource());
    } else if (u is PrefixExpression && u.operator.lexeme == '-') {
      final inner = _unwrapParens(u.operand);
      if (inner is Literal) {
        literals.add(u.toSource());
      }
    }
  }

  Expression _unwrapParens(Expression e) {
    var x = e;
    while (x is ParenthesizedExpression) {
      x = x.expression;
    }
    return x;
  }
}
