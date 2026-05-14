## Why

The current test generator relies on fixed, type-based boundary values (e.g., `0`, `1`, `""`) and does not inspect the actual logic of the methods it tests. This leads to systematic blind spots where critical behaviors—such as hidden constants, specific branch conditions (like `length > 10`), and domain-specific edge cases—are never exercised, resulting in incomplete and brittle test suites.

## What Changes

- **Method Body Parsing**: Introduce an analysis phase that inspects the AST/IR of method bodies to extract constants, branch conditions, and API calls.
- **Dynamic Boundary Inference**: Generate test inputs dynamically based on the extracted constants and conditions (e.g., if `length > 10` is found, generate strings of length 10 and 11).
- **Control Flow Path Generation**: Identify distinct execution paths (e.g., early returns, if/else branches) and ensure inputs are generated to cover each path.
- **Callee Analysis**: Infer required inputs based on standard library calls (e.g., `toLowerCase()`, `trim()`, `isOdd`).

## Capabilities

### New Capabilities
- `method-body-analyzer`: Parses Dart method bodies to extract constants, branch conditions, and API calls.
- `dynamic-input-generator`: Generates targeted test inputs based on the extracted logic and control flow paths.

### Modified Capabilities

## Impact

- **Test Quality**: Generated tests will have significantly higher branch and path coverage on realistic code.
- **Performance**: The analysis phase will add some overhead to the generation process.
- **Dependencies**: May require deeper integration with the Dart `analyzer` package to traverse method bodies and resolve types/constants.
