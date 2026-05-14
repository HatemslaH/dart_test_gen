/// Profile of the logic extracted from a method body.
class LogicProfile {
  /// Literals found in the method body, grouped by parameter name.
  final Map<String, Set<String>> parameterLiterals;

  /// Inferred characteristics of parameters based on API calls.
  /// E.g., 'input' -> {'toLowerCase', 'trim'}
  final Map<String, Set<String>> parameterInferences;

  const LogicProfile({
    required this.parameterLiterals,
    required this.parameterInferences,
  });

  factory LogicProfile.empty() => const LogicProfile(
        parameterLiterals: {},
        parameterInferences: {},
      );
}
