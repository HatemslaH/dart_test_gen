## 1. Method Body Analyzer

- [x] 1.1 Create `MethodLogicAnalyzer` class and define `LogicProfile` model.
- [x] 1.2 Implement AST visitor to extract integer literals from binary expressions (e.g., `>`, `<`, `==`).
- [x] 1.3 Implement AST visitor to extract string literals from binary expressions and switch cases.
- [x] 1.4 Implement AST visitor to detect common API calls (e.g., `toLowerCase`, `isOdd`) on parameters.
- [x] 1.5 Write unit tests for `MethodLogicAnalyzer` using sample method bodies.

## 2. Dynamic Input Generator

- [x] 2.1 Create `DynamicInputGenerator` class that consumes a `LogicProfile`.
- [x] 2.2 Implement generation of integer boundaries (value - 1, value, value + 1) for extracted integer literals.
- [x] 2.3 Implement generation of string boundaries (exact, empty, variations) for extracted string literals and API calls.
- [x] 2.4 Write unit tests for `DynamicInputGenerator` to ensure correct boundary generation.

## 3. Integration

- [x] 3.1 Update the existing `test-case-generator` flow to invoke `MethodLogicAnalyzer` on the target method.
- [x] 3.2 Update the test case generation logic to merge dynamic inputs with fixed boundaries, removing duplicates.
- [x] 3.3 Run the updated generator against `StressShowcase` to verify improved test coverage and dynamic input usage.
- [x] 3.4 Fix any failing tests or edge cases discovered during integration.
