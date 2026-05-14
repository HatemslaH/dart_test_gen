## Context

The current test generator uses fixed boundary values (like `0`, `1`, `""`) for testing, which leads to incomplete coverage because it ignores the specific logic inside methods. For example, a method checking `if (length > 10)` will not be tested with a string of length 11 unless it happens to be in the fixed boundaries. We need a way to analyze the method body (AST) to extract constants, branch conditions, and API calls, and use this information to dynamically generate test inputs.

## Goals / Non-Goals

**Goals:**
- Parse method bodies using the Dart `analyzer` package to extract literals (integers, strings, etc.) used in conditions.
- Identify common API calls (e.g., `toLowerCase`, `isOdd`) that imply specific input requirements.
- Generate dynamic test inputs based on the extracted values and logic.
- Integrate the dynamic inputs with the existing test case generation pipeline.

**Non-Goals:**
- Full symbolic execution or constraint solving (too complex and slow for this stage).
- Analyzing deep call chains across multiple files (we will focus on the immediate method body and its direct standard library calls).
- Changing the existing snapshot-driven unit test flow (this is an additive feature to improve input generation).

## Decisions

**1. AST Traversal for Literal Extraction**
- *Decision*: Use the `analyzer` package's AST visitor to traverse method bodies and extract literals used in `BinaryExpression` (e.g., `==`, `>`, `<`), `SwitchCase`, and `IfStatement`.
- *Rationale*: The `analyzer` package is already used in the project and provides a robust way to inspect method logic.
- *Alternatives*: Regular expressions (too brittle, misses context).

**2. Dynamic Boundary Generation**
- *Decision*: For extracted integer literals in comparisons (e.g., `x > 10`), generate inputs for the exact value, value - 1, and value + 1. For string literals, generate the exact string, empty string, and variations (e.g., different case if `toLowerCase` is called).
- *Rationale*: This covers the most common off-by-one errors and branch conditions without requiring a full constraint solver.
- *Alternatives*: Constraint solving (too heavy).

**3. Integration with Existing Generator**
- *Decision*: Create a new abstraction `MethodLogicAnalyzer` that takes a `MethodElement` and `MethodDeclaration` and returns a `LogicProfile` containing extracted constants and inferred boundaries. The `test-case-generator` will merge these dynamic boundaries with the existing fixed boundaries before generating snapshots.
- *Rationale*: Keeps the analysis decoupled from the generation logic, adhering to the generator module contract.

## Risks / Trade-offs

- **Risk: Performance Overhead** → *Mitigation*: The AST traversal is relatively fast, but we should cache the `LogicProfile` for each method to avoid re-analyzing if the method is called multiple times during generation.
- **Risk: State Explosion** → *Mitigation*: Limit the number of dynamically generated inputs per method (e.g., max 5 dynamic boundaries per parameter) to prevent combinatorial explosion in test cases.
- **Risk: Unhandled Complex Logic** → *Mitigation*: Fall back to fixed boundaries if the method logic is too complex to analyze (e.g., complex bitwise operations or external native calls).
