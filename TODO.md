# TODO — Dart test generator (problems only)

This file lists **problems and gaps** as the author sees them today. It intentionally does **not** prescribe solutions.

---

## Vision and motivation

The goal is a **high-quality Dart test generator** that auto-generates tests and genuinely makes day-to-day work easier. Today the generator is judged **not good enough** on realistic code such as `StressShowcase`: generated suites miss important behaviors that a human would catch from reading the implementation or comments.

---

## Gap: no logic-aware test generation

**Problem:** Generation is driven mainly by **types and fixed boundary literals**, not by **what the method actually does** (which APIs it calls, which branches exist, which invariants hold).

**Description:** For example, if a method uses `toLowerCase()`, a reader infers that **case folding** should be verified. The current pipeline does not systematically derive inputs from callee patterns, so behaviors tied to `String` transforms, truncation rules, Unicode handling, custom operators, etc. are often **never exercised** even when they are obvious from the body.

---

## Gap: three intended levels of coverage are not represented

The following levels describe **desired richness** of generated tests. The generator today does **not** clearly separate or fully implement them.

### Level 1 — Logic-derived tests

**Problem:** There is no robust stage that **analyzes method logic** (control flow, calls to other methods, use of operators, hidden constants, order-dependent steps) and turns that into **targeted test cases**.

**Description:** Methods that combine deduplication, sort, filter, index-based transforms, recursion with memoization, or side effects on fields are under-specified by snapshots over a tiny fixed input set. **Cross-call** and **stateful** stories (e.g. cache hits after a larger call, call counts after a sequence) are not first-class.

### Level 2 — Boundary tests

**Problem:** “Boundary” today means **a fixed catalog per parameter type** (e.g. a small set of `int` and `string` literals), not boundaries that follow from the **method’s own** domain (exact length limits, sign combinations for truncating division, empty vs non-empty branches).

**Description:** Many real boundaries (e.g. “exactly at truncation length” vs “one past it”) never appear as inputs because they are not in the global list. **Asymmetric** or **combinatorial** grids can also be **truncated** by sampling limits, which can make coverage look arbitrary without documenting why.

### Level 3 — Sample / ordinary-value tests

**Problem:** There is no clear notion of **sampling ordinary inputs** to surface “typical but non-boundary” failures or to diversify expectations beyond the same small literals.

**Description:** Without this layer, suites can look exhaustive on the grid they use while still missing **representative** cases and **compound** cases (one input that exercises trim + case + spaces + length in one shot).

---

## Problem: `StressShowcase` exposes systematic blind spots

**Description (examples of symptoms, not fixes):**

- **Arithmetic:** Hidden offsets and divisor-specific behavior are not reflected in test names or inputs; divisors outside the fixed int set are never tried.
- **Strings:** Uppercase, internal spaces, exact length cutoffs, and long/compound strings are often absent when the fixed string set is minimal.
- **Collections:** Branches like “all filtered out but non-empty input,” duplicates, longer lists, and negative values after sort may be missing when list literals are fixed and few.
- **Recurrence / memoization:** Small `n` grids miss early post-base indices, large `n`, and sequences that exercise cache reuse on the same instance.
- **Encoding / Unicode:** Comments in source may call out rune vs code-unit traps; generated string inputs may never include grapheme clusters or emoji if they are not in the boundary set.
- **Getters and side effects:** Assertions on getters can depend on **how many times** earlier generated tests called mutating methods, and on **order** of groups sharing one fixture instance—coupling that is easy to break when generation changes.

---

## Problem: single shared fixture across groups

**Description:** One receiver instance for the whole file ties **order of execution**, **mutable state** (`callCount`, caches, histories), and **getter expectations** together. That makes some tests **integration-like** and **fragile** relative to reordering or adding cases.

---

## Problem: analysis quality is the first priority for the author

**Description:** The immediate direction is to **improve analysis** of what each method does so generated tests can reflect that information. Until analysis improves, expanding boundary lists or samples alone will not address “the method clearly does X but no test checks X.”

---

## Problem: “What I want now” is incomplete in the original note

**Description:** The working note ended at immediate next steps without a fully enumerated checklist. This entry marks that **short-term scope** still needs to be captured elsewhere when it is ready—again as problems or goals, not as designs here.
