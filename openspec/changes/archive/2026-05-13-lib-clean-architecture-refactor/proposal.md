## Why

The `lib/` package code grew as a single pipeline with parsing, snapshotting, sampling, CLI wiring, and test emission in one flat module graph. That layout makes it harder to reason about responsibilities, test boundaries in isolation, and add new kinds of code generation (for example future `bloc_gen`- or `golden_gen`-style modules) without entangling them with the existing snapshot-driven unit-test path. A deliberate internal architecture reduces coupling and gives contributors a clear place to plug in new generators **without** this change implementing those hypothetical tools.

## What Changes

- Introduce a **layered internal structure** (for example domain / application / infrastructure or ports-and-adapters) so dependencies point inward and each layer has a narrow, documented job.
- Apply **SOLID-oriented boundaries**: separate orchestration from I/O, from parsing, from string emission; prefer small interfaces over concrete cross-imports where it improves testability and swapability.
- Define **generator extensibility** as a first-class concept: a stable contract (interface + lifecycle + inputs/outputs) and a composition root that can register or select generator kinds; document how a future module would integrate. **No** implementation of `bloc_gen`, `golden_gen`, or similar products in this change—only the hooks and folder conventions.
- **Refactor in place** with tests and CLI behavior preserved unless explicitly called out; prefer incremental moves (extract types, introduce abstractions, move files) over a big-bang rewrite.
- **BREAKING** (only if unavoidable after design review): any change to the published `package:dart_test_gen/...` import paths or types that downstream packages rely on must be listed explicitly and versioned per semver; default plan is to keep the public library surface stable and confine churn to `lib/src/` or non-exported internals.

## Capabilities

### New Capabilities

- `internal-library-layers`: Requirements for internal layering, allowed dependency directions, and what each layer may know about (so the codebase stays navigable and lintable).
- `generator-module-contract`: Requirements for how an additional generator module participates in the tool (capabilities, inputs, outputs, errors, and how it coexists with the existing test generator) without mandating specific third-party generators.

### Modified Capabilities

- None for user-visible behavior: existing specs such as `cli-entrypoint` and generation behavior specs remain the acceptance bar; this change is primarily structural and contributor-facing. If a design decision later requires a behavior spec update, that will be added as a delta in the corresponding existing spec.

## Impact

- **Primary**: All files under `lib/` (`generate_pipeline.dart`, `test_generator.dart`, `source_parser.dart`, `snapshot.dart`, `sampling.dart`, `gen_config.dart`, CLI helpers, etc.) and any `bin/` imports of them.
- **Tests**: Package `test/` and `example/` may need import path updates if files move; golden or integration expectations should stay aligned with unchanged CLI contract.
- **Consumers**: Packages importing `package:dart_test_gen/...` directly should be treated as a compatibility surface; minimize churn or document **BREAKING** in changelog.
- **Dependencies**: Unlikely to add heavy frameworks; stay within Dart SDK and current `pubspec.yaml` dependencies unless design proves otherwise.
