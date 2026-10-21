# IEC-T003 Bounded-Profile Factorization Design

## Status and authority

This design consumes the frozen IEC target `IEC-T003 / BoundedProfileFactorization`, scoped only to the IEC-0.2 bounded disposition profile. Issue #2013 is the active work item. The predecessor J1 occurrence landed at `7edd8ac8e59da9bf9db9f2271bf79aa47b4c45d6`.

`closure_claim=0` throughout. This design does not widen IEC, discharge global RCC M1, or combine T003 with T004/T005/T006/T024.

## Claim

For one fixed profile semantics:

```text
q     : Raw -> Class
a     : Class -> Bool
sigma : Class -> Option Rep
rho   : Class -> Option Residue
```

raw evaluation is defined only by composition through `q`:

```text
result(raw) = (a(q(raw)), sigma(q(raw)), rho(q(raw)))
```

Therefore `q(x) = q(y)` entails equality of `a`, `sigma`, `rho`, and the bundled result. The forbidden IEC-CM008 shape is:

```text
exists x y, q(x) = q(y) and result(x) != result(y)
```

and must be uninhabited under fixed semantics.

## Architecture

### Lean authority

Create `IEC/BoundedProfileFactorization.lean` with:

- `FixedProfileSemantics`, containing only class-indexed `admissible`, `sigma`, and `rho`;
- `ProfileResult`, the bundled `a/sigma/rho` result;
- raw projections defined by composition with `q`;
- pointwise factorization theorems for each projection;
- bundled factorization;
- `SameQDifferentOutcome` and its impossibility theorem.

Create `IECTests/BoundedProfileFactorization.lean` with a finite nontrivial fixture. Two distinct raw constructors map to the same class. Their real results agree. A separate raw-sensitive mutant disagrees on that same pair, demonstrating that the negative tooth is load-bearing rather than a renamed positive case.

Both modules are Prelude-only. No Mathlib, `sorry`, classical choice, quotient axiom, or hash injectivity assumption is needed.

### Executable independent checker

Create `residua-internal verifier verify_iec_t003_factorization (not included)`. It independently reads the machine registry, groups fixture rows by `profile_q`, and re-derives:

- at least one distinct same-q pair exists;
- every real same-q group has one exact `(admissible, sigma, rho)` tuple;
- the registered mutant has the same q but a different result;
- the mutant is classified as caught;
- exact source blobs and target/countermodel identities match.

The checker does not infer the Lean theorem from source text. Its role is finite executable conformance and artifact/receipt integrity; Lean remains theorem authority.

### Axiom gate

Create `docker/lean-verifier/verify-iec-t003-axioms.sh`. It imports the production module, runs `#print axioms` for every discharged theorem, refuses missing output, and fails on `sorryAx`. The expected footprint is empty for each theorem.

### Machine and human authority

Create:

- `residua-internal iec conformance record IEC_1_0_T003_BOUNDED_PROFILE_FACTORIZATION_V0_1.json (not included)`;
- `docs/iec/IEC_1_0_T003_CURRENT_BASIS_V0_1.md`.

The JSON binds target ID, countermodel ID, exact basis, Lean/checker/test blobs, theorem names, empty axiom footprints, fixture rows, mutant row, and disposition. The document states the bounded result and all nonclaims.

### Permanent gate consumption

Add a Lake target `IECBoundedProfileFactorization`, include it in the canonical Lean build list, and add permanent Lean-job steps for the axiom gate and independent checker. No optional workflow or receipt cache may substitute for these checks.

## Error and refusal behavior

The implementation refuses rather than weakening the claim when:

- a theorem is missing from the axiom probe;
- any theorem depends on `sorryAx`;
- a source blob drifts from the registry;
- no nontrivial same-q fixture pair exists;
- a real same-q group has multiple outcomes;
- the mutant does not diverge;
- the target/countermodel/basis identity is stale.

## Verification boundary

Success discharges T003 only on the exact bound repository occurrence. It does not establish outcome exclusivity, typed residue totality, full profile exactness, lawful-plan non-vacuity, global RCC M1, or IEC-NF.
