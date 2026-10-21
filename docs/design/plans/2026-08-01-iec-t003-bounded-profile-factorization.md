# IEC-T003 Bounded-Profile Factorization Implementation Plan


**Goal:** Discharge IEC-T003 on one exact repository occurrence by proving that fixed bounded-profile semantics factors `a`, `sigma`, and `rho` through profile `q`, and by catching the IEC-CM008 raw-sensitive mutant.

**Architecture:** A Prelude-only Lean module is theorem authority. A separate Lean fixture module supplies a nontrivial same-q witness and a load-bearing mutant. A Python checker independently re-derives the finite fixture partition and validates exact artifact identities. A shell gate records axiom footprints. The canonical `residua-gate` consumes all three.

**Tech Stack:** Lean 4 pinned by `lean-toolchain`, Lake, Python 3.12 standard library, Bash, GitHub Actions.

## Global Constraints

- Scope is exactly `IEC-T003 / BoundedProfileFactorization` for the IEC-0.2 bounded disposition profile.
- Countermodel is exactly `IEC-CM008 / SameQDifferentOutcome`.
- No Mathlib, no `sorry`, no `sorryAx`, and no hash-injectivity assumption.
- `a`, `sigma`, and `rho` are functions of profile class, never raw identity.
- At least two distinct raw fixture values must share one profile q.
- The mutant must inspect raw identity after q and diverge on that same pair.
- IEC-T004/T005/T006/T024 and global RCC M1 remain explicit nonclaims.
- `closure_claim=0`.

---

### Task 1: Establish the RED Lean boundary

**Files:**
- Create: `IECTests/BoundedProfileFactorization.lean`
- Modify: `lakefile.lean`

**Interfaces:**
- Consumes: frozen claim in issue #2013.
- Produces: a test module importing `IEC.BoundedProfileFactorization`, and Lake target `IECBoundedProfileFactorization` rooted at the test module.

- [ ] **Step 1: Write the failing test module**

The module imports the not-yet-existing production module and states examples using these required production names:

```lean
import IEC.BoundedProfileFactorization

open Residua.IEC.T003

namespace Residua.IEC.T003.Tests

inductive Raw where | aliasA | aliasB | rejected
inductive Class where | admitted | rejected
inductive Rep where | settled
inductive Residue where | failed

def q : Raw -> Class
  | .aliasA | .aliasB => .admitted
  | .rejected => .rejected

-- The remaining fixture definitions and examples are added after the production
-- interface exists; this import is the intentional RED boundary.

end Residua.IEC.T003.Tests
```

- [ ] **Step 2: Add the Lake target rooted at the test module**

```lean
lean_lib «IECBoundedProfileFactorization» where
  srcDir := "lean"
  roots := #[`IECTests.BoundedProfileFactorization]
```

- [ ] **Step 3: Run the target and require RED**

Run:

```bash
lake build IECBoundedProfileFactorization
```

Expected: non-zero exit because `IEC.BoundedProfileFactorization` does not exist. Refuse a failure caused by malformed Lake syntax or a missing toolchain.

### Task 2: Implement the minimal fixed-semantics theorem surface

**Files:**
- Create: `IEC/BoundedProfileFactorization.lean`
- Modify: `IECTests/BoundedProfileFactorization.lean`

**Interfaces:**
- Produces:
  - `FixedProfileSemantics`
  - `ProfileResult`
  - `result`
  - `admissible_factors_through_q`
  - `sigma_factors_through_q`
  - `rho_factors_through_q`
  - `result_factors_through_q`
  - `SameQDifferentOutcome`
  - `same_q_different_outcome_impossible`

- [ ] **Step 1: Define the production types and projections**

```lean
structure FixedProfileSemantics (Raw Class Rep Residue : Type) where
  q : Raw -> Class
  admissible : Class -> Bool
  sigma : Class -> Option Rep
  rho : Class -> Option Residue

structure ProfileResult (Rep Residue : Type) where
  admissible : Bool
  sigma : Option Rep
  rho : Option Residue
  deriving DecidableEq

def result (P : FixedProfileSemantics Raw Class Rep Residue) (raw : Raw) :
    ProfileResult Rep Residue :=
  { admissible := P.admissible (P.q raw)
    sigma := P.sigma (P.q raw)
    rho := P.rho (P.q raw) }
```

- [ ] **Step 2: Prove pointwise and bundled factorization**

Each theorem takes `hq : P.q x = P.q y` and closes by substituting `hq`; no stronger axiom is introduced.

- [ ] **Step 3: Define and refute IEC-CM008**

```lean
def SameQDifferentOutcome (P : FixedProfileSemantics Raw Class Rep Residue) : Prop :=
  exists x y, P.q x = P.q y and result P x != result P y

theorem same_q_different_outcome_impossible
    (P : FixedProfileSemantics Raw Class Rep Residue) :
    not (SameQDifferentOutcome P) := by
  intro h
  rcases h with ⟨x, y, hq, hne⟩
  exact hne (result_factors_through_q P hq)
```

- [ ] **Step 4: Complete the fixture and mutant tests**

Define the real class-indexed semantics, prove `aliasA != aliasB`, prove equal q and equal real result, then define `mutantResult : Raw -> ProfileResult Rep Residue` that returns a different representative or residue for `aliasB`. Prove the mutant results differ on `aliasA/aliasB` while q remains equal.

- [ ] **Step 5: Run GREEN**

Run:

```bash
lake build IECBoundedProfileFactorization
```

Expected: success with zero warnings about `sorry`.

### Task 3: Add executable conformance and exact artifact authority

**Files:**
- Create: `residua-internal iec conformance record IEC_1_0_T003_BOUNDED_PROFILE_FACTORIZATION_V0_1.json (not included)`
- Create: `residua-internal verifier verify_iec_t003_factorization (not included)`
- Create: `docs/iec/IEC_1_0_T003_CURRENT_BASIS_V0_1.md`

**Interfaces:**
- Checker consumes the JSON registry and exact repository files.
- Checker emits one terminal line beginning `IEC-T003: PASS`.

- [ ] **Step 1: Write the registry with a nontrivial fixture**

Include raw rows `alias_a`, `alias_b`, and `rejected`; `alias_a` and `alias_b` share one profile q and identical real results. Include a separate mutant row for `alias_b` with the same q and a different result. Bind exact target/countermodel IDs, basis SHA, source paths, theorem names, and blobs.

- [ ] **Step 2: Write the independent checker**

The checker must group real rows by `profile_q`, require exactly one result tuple per group, require a distinct same-q pair, and require the mutant tuple to differ. It must compute Git blob SHA-1 values using `blob <len>\0<bytes>` and compare them with the registry.

- [ ] **Step 3: Verify checker RED against an uncaught mutant**

Temporarily make the mutant result equal to the real result and run:

```bash
python3 residua-internal verifier verify_iec_t003_factorization (not included)
```

Expected: failure `[iec_t003_mutant_does_not_bite]`.

- [ ] **Step 4: Restore the divergent mutant and run GREEN**

Expected: `IEC-T003: PASS`.

### Task 4: Gate theorem axioms and canonical consumption

**Files:**
- Create: `docker/lean-verifier/verify-iec-t003-axioms.sh`
- Modify: `.github/workflows/residua-gate.yml`

**Interfaces:**
- Axiom script imports `IEC.BoundedProfileFactorization` and prints/checks all five theorem names.
- Canonical Lean job builds the target, runs the axiom script, and runs the independent checker.

- [ ] **Step 1: Implement the axiom gate**

Generate a temporary Lean file containing `#print axioms` for each theorem. Fail separately when output is missing and when an existing footprint names `sorryAx`.

- [ ] **Step 2: Add the Lake target to the canonical build list**

Append `IECBoundedProfileFactorization` to the existing `lake build` command without removing any current target.

- [ ] **Step 3: Add permanent gate steps**

```yaml
- name: IEC-T003 axiom footprint
  run: bash docker/lean-verifier/verify-iec-t003-axioms.sh "$GITHUB_WORKSPACE"
- name: IEC-T003 independent bounded-profile factorization check
  run: python3 residua-internal verifier verify_iec_t003_factorization (not included)
```

- [ ] **Step 4: Run targeted verification**

```bash
lake build IECBoundedProfileFactorization
bash docker/lean-verifier/verify-iec-t003-axioms.sh "$PWD"
python3 residua-internal verifier verify_iec_t003_factorization (not included)
python3 -m py_compile residua-internal verifier verify_iec_t003_factorization (not included)
git diff --check
```

Expected: all pass.

### Task 5: Exact-basis receipt and closure bookkeeping

**Files:**
- Temporary: `.github/workflows/iec-t003-exact-receipt.yml`
- Update only if basis changes: registry and disposition document basis fields.

**Interfaces:**
- Produces final head, bound basis, source blobs, successful targeted recheck, and self-deleted workflow.

- [ ] **Step 1: Capture the current base and refuse semantic-input drift**

The temporary workflow must pin the base and refuse any movement in the T003 semantic read surface during derivation.

- [ ] **Step 2: Rebuild and recheck on the exact occurrence**

Run the full targeted verification battery after resetting to the pushed final head.

- [ ] **Step 3: Self-delete and emit exact receipts**

Print final head, base head, Lean source/test/checker/registry/doc blobs, and axiom result.

- [ ] **Step 4: Update issue #2013 and close only after evidence**

Record `SatisfiedCurrentBasis`, exact identities, and explicit nonclaims. Keep `closure_claim=0`.
