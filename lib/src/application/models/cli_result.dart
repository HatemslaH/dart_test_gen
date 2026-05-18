final class CliResult {
  const CliResult({
    required this.inputs,
    this.className,
    this.verbose = false,
    this.strategy,
    this.maxCases,
    this.seed,
    this.configPath,
    this.useCloseForDouble,
    this.doubleEpsilon,
    this.useExpectMatchersBoolNull,
    this.keepRunner,
    this.dryRun,
    this.check,
  });

  final List<String> inputs;
  final String? className;
  final bool verbose;
  final String? strategy;
  final int? maxCases;
  final int? seed;
  final String? configPath;
  final bool? useCloseForDouble;
  final double? doubleEpsilon;
  final bool? useExpectMatchersBoolNull;
  final bool? keepRunner;
  final bool? dryRun;
  final bool? check;
}
