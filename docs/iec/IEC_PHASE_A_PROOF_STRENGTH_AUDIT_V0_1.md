# IEC Phase A — proof-strength audit (findings only)

`closure_claim=0`. Seat: `agent:grok-1`. Doorbell dispatch `5157552466`.

**This is a strength map, not a discharge.** Phase B (main theorems against a
frozen residua InstitutionalCut) waits on `ADR_RESIDUA_KERNEL_FREEZE`.

Shape matches the evalLF coverage table craft: **theorem × trust-class × what
it actually constrains**. Trust-class vocabulary follows the architect
ruling on #2010 / ProofGradeLowering §7c:

| class | meaning |
|-------|---------|
| **kernel-checked** | `#print axioms` empty; proof reduces in the kernel (`rfl` / `congrArg` / `cases` / `by decide` on closed `Decidable`) |
| **native_decide** | carries `Lean.ofReduceBool` — compiled-eval trust class; **must be named**, never silently graded as kernel |
| **axiom footprint** | nonempty `#print axioms` (incl. `sorryAx`) |
| **registry-only / no Lean** | IEC-0.x target named in registries with `proof_status=not_discharged` and no Lake module |
| **construction-by-encoding** | theorem is true of an encoding chosen so the property holds by definition (honest but thin) |

Exact heads audited:

| surface | ref |
|---------|-----|
| findings branch tip | `grok1/iec-phase-a-proof-strength` (this file) |
| base main at first audit | `55d79e2cae2575e200364bf929264af2b4cc12fa` |
| T003 Lean | `lean/algorithms/IECBoundedProfileFactorization{,Tests}.lean` (on main / this branch) |
| T004 Lean | PR #2016 (private development branch) @ `ed16e2733368ebe2895e3d0b55e333e09063de31` |
| target registry | `residua-internal iec conformance record IEC_THEOREM_TARGET_REGISTRY_V0_1.json (not included)` (38 targets, all `not_discharged`) |

### Live measurement receipt (re-runnable)

| step | result |
|------|--------|
| `lake build IECBoundedProfileFactorization` | **PASS** (exit 0) |
| `lake build IECDispositionOutcomePartition` (T004 tip worktree) | **PASS** (exit 0) |
| `#print axioms` × 7 gated T003 theorems | each: *does not depend on any axioms* → **kernel-checked** |
| `#print axioms` × 10 gated T004 theorems | each: *does not depend on any axioms* → **kernel-checked** |
| `Lean.ofReduceBool` / `sorryAx` in axiom dump | **absent** (no native_decide; no axiom footprint) |
| Phase B mains IEC-T026 / IEC-T029 Lean modules | **absent** |

Reproduce (portable — do **not** rely on GNU `mktemp --suffix`):

```bash
lake build IECBoundedProfileFactorization
# write probe with every name from docker/lean-verifier/verify-iec-t003-axioms.sh:
#   import IECTests.BoundedProfileFactorization
#   #print axioms Residua.IEC.T003.<name>
lake env lean t003_axioms.lean
# T004 tip worktree:
lake build IECDispositionOutcomePartition
# same pattern with verify-iec-t004-axioms.sh names
lake env lean t004_axioms.lean
```

### Gated theorem trust-class (1:1 with axiom scripts)

| theorem (fully qualified stem) | trust-class | axiom dump |
|--------------------------------|-------------|------------|
| `T003.admissible_factors_through_q` | kernel-checked | empty |
| `T003.sigma_factors_through_q` | kernel-checked | empty |
| `T003.rho_factors_through_q` | kernel-checked | empty |
| `T003.result_factors_through_q` | kernel-checked | empty |
| `T003.same_q_different_outcome_impossible` | kernel-checked | empty |
| `T003.Tests.nontrivial_same_q_witness` | kernel-checked | empty |
| `T003.Tests.mutant_same_q_different_outcome` | kernel-checked | empty |
| `T004.admit_not_residue` | kernel-checked | empty |
| `T004.residue_not_admit` | kernel-checked | empty |
| `T004.outcome_exactly_one` | kernel-checked | empty |
| `T004.evaluated_outcome_exactly_one` | kernel-checked | empty |
| `T004.sigma_rho_double_or_neither_impossible` | kernel-checked | empty |
| `T004.evaluated_double_or_neither_impossible` | kernel-checked | empty |
| `T004.Tests.admit_reachable` | kernel-checked | empty |
| `T004.Tests.residue_reachable` | kernel-checked | empty |
| `T004.Tests.double_mutant_not_encoded` | kernel-checked | empty |
| `T004.Tests.neither_mutant_not_encoded` | kernel-checked | empty |

**17/17 gated theorems = kernel-checked.** Zero `native_decide`. Zero axiom footprint.

---

## §1 Headline counts

| bucket | n | notes |
|--------|---|-------|
| IEC theorem **targets** in frozen registry | **38** | 5 families; every row still `proof_status: not_discharged` |
| Targets with a **Lean module on main** | **1** | IEC-T003 only |
| Targets with Lean on **open PR** (#2016) | **+1** | IEC-T004 (not on main at audit) |
| Targets with **zero Lean surface** | **36** | including Phase-B mains T026 / T029 |
| T003 gated theorems empty-axiom | **7/7** | kernel-checked |
| T004 gated theorems empty-axiom | **10/10** | kernel-checked |
| IEC Lean uses of `native_decide` | **0** | none in T003/T004 |
| IEC Lean `sorry` / declared `axiom` | **0** | none |
| IEC-0.x registries claiming `closure_claim=1` | **0** | all 0 or null |

**The hollow claim this audit exists to catch:** "T004 lake-builds / empty
axioms ⇒ IEC proof is solid." What is solid is a **bounded encoding model**.
What is still open is **36/38 targets**, the **runtime/history binding**, and
the **frozen InstitutionalCut object** Phase B needs.

---

## §2 T003 — Bounded Profile Factorization (on main)

Module: `Residua.IEC.T003` · Lake: `IECBoundedProfileFactorization` ·
`lake build` **PASS** · axiom probe **PASS (empty)**.

### 2.1 Coverage table

| theorem | trust-class | tactic shape | what it actually constrains | what it does **not** constrain |
|---------|-------------|--------------|-----------------------------|--------------------------------|
| `admissible_factors_through_q` | **kernel-checked** | `congrArg` | equal `q` ⇒ equal `admissible∘q` | injectivity of `q`; residua wire |
| `sigma_factors_through_q` | **kernel-checked** | `congrArg` | equal `q` ⇒ equal `sigma∘q` | exclusivity of sigma/rho (T004) |
| `rho_factors_through_q` | **kernel-checked** | `congrArg` | equal `q` ⇒ equal `rho∘q` | typed residue coverage (T005) |
| `result_factors_through_q` | **kernel-checked** | `congrArg` on record | equal `q` ⇒ equal full `ProfileResult` | that real disposition uses this `result` |
| `same_q_different_outcome_impossible` | **kernel-checked** | `cases` + prior | IEC-CM008 impossible **under** `FixedProfileSemantics` whose `result` is defined as compose-through-`q` | any evaluator that peeks raw identity **after** `q` (the mutant is outside the type) |
| `Tests.nontrivial_same_q_witness` | **kernel-checked** | `refine` + prior | fixture has two distinct raws, same q, same result | production corpus |
| `Tests.mutant_same_q_different_outcome` | **kernel-checked** (`decide` on ≠) | `constructor` / `rfl` / `decide` | a hand-written **non-factoring** `mutantResult` exhibits CM008 shape | that production forbids the mutant |
| `Tests.aliases_distinct` | **kernel-checked** via `decide` | `decide` | fixture enum inequality | — |
| `Tests.aliases_same_q` / `aliases_same_result` | **kernel-checked** | `rfl` / apply | fixture sanity | — |

**Trust-class note:** tests use `by decide`, **not** `native_decide`. Measured
`#print axioms` is empty (no `Lean.ofReduceBool`). Per #2010 ruling this is
still the kernel-checked class — closed-term decidable reduction in-kernel.
Named so the grade is not confused with compiled-eval.

### 2.2 Construction honesty (load-bearing)

```lean
def result P raw := { admissible := P.admissible (P.q raw),
                      sigma := P.sigma (P.q raw),
                      rho := P.rho (P.q raw) }
```

Factorization is **true by definition** of `result`. The theorems are
real and empty-axiom; they constrain the **model**, not an independently
specified disposition evaluator. The mutant that violates CM008 is a
different function (`mutantResult`) that is **not** of type
`FixedProfileSemantics.result` — so the theorem does not "catch" it as a
bad inhabitant of the type; it shows a countermodel shape that the type
excludes by encoding.

Registry receipt `IEC_1_0_T003_BOUNDED_PROFILE_FACTORIZATION_V0_1.json`:
`status=passed`, `closure_claim=0`, nonclaims explicitly hold T004/T005/T006/T024 open.
**Target index still lists T003 as `not_discharged`** — registry discharge
status is **not** re-derived from Lake; Phase A finding:
`[iec_target_registry_discharge_status_stale]`.

---

## §3 T004 — Disposition Outcome Partition (PR #2016 @ `ed16e2733`)

Module: `Residua.IEC.T004` · Lake: `IECDispositionOutcomePartition` ·
`lake build` **PASS** (worktree) · axiom probe **PASS (empty, 10/10 gated)**.

### 3.1 Coverage table

| theorem | trust-class | tactic shape | what it actually constrains | what it does **not** constrain |
|---------|-------------|--------------|-----------------------------|--------------------------------|
| `admit_not_residue` | **kernel-checked** | `rcases` + `cases` on `true=false` | `encode (.admit _)` is not a residue result | arbitrary `ProfileResult` not in image of `encode` |
| `residue_not_admit` | **kernel-checked** | dual | `encode (.residue _)` is not admit | same |
| `outcome_exactly_one` | **kernel-checked** | `cases outcome` | every **typed** `DispositionOutcome` encodes to ExactlyOne(Admit, Residue) | T003's free `sigma`/`rho` functions |
| `evaluated_outcome_exactly_one` | **kernel-checked** | apply prior | every eval under `PartitionedProfileSemantics` is ExactlyOne | eval under T003 `FixedProfileSemantics` (still allows double/neither) |
| `sigma_rho_double_or_neither_impossible` | **kernel-checked** | `cases` | IEC-CM009 impossible for **encode image** | that runtime disposition forbids double/neither |
| `evaluated_double_or_neither_impossible` | **kernel-checked** | apply prior | CM009 impossible for partitioned eval | global history / cut lineage |
| `Tests.admit_reachable` / `residue_reachable` | **kernel-checked** | `rfl` | fixture reaches both branches | production paths |
| `Tests.double_mutant_not_encoded` | **kernel-checked** | apply CM009 thm | double mutant ∉ image(`encode`) | mutant is not a runtime refusal proof |
| `Tests.neither_mutant_not_encoded` | **kernel-checked** | dual | neither mutant ∉ image(`encode`) | same |
| `Tests.double_mutant_is_countermodel` / `neither_…` | **kernel-checked** | `exact` | the free `ProfileResult` values inhabit CM009 | not gated in axiom script (extra) |
| `Tests.admit_fixture_partition` / `residue_…` | **kernel-checked** | apply | fixture partitions | not gated |

**No `native_decide` in the T004 surface.** Empty axiom footprints confirmed
live on the PR tip.

### 3.2 Construction honesty (the thin edge)

```lean
inductive DispositionOutcome | admit sigma | residue rho
def encode | .admit s => {adm=true, sigma=some s, rho=none}
           | .residue r => {adm=false, sigma=none, rho=some r}
structure PartitionedProfileSemantics where
  q : Raw → Class
  outcome : Class → DispositionOutcome   -- forces the partition at the type
def result P raw := encode (P.outcome (P.q raw))
```

Partition / CM009-impossibility hold **for the image of `encode`**. They do
**not** close the stronger statement "every `ProfileResult` produced by the
residua disposition stack is exclusive," because T003's
`FixedProfileSemantics` still admits free `sigma`/`rho` (double and neither
are well-typed there). T004 is a **re-encoding model** that proves: *if* you
adopt `DispositionOutcome` + `encode`, then exclusive partition follows.

That is real kernel work and real CM009 coverage **inside the model**. It is
not yet a bridge to live disposition receipts, cut lineage, or the
disposer-as-role instance.

Receipt on PR: `IEC_1_0_T004_DISPOSITION_OUTCOME_PARTITION_V0_1.json`
`status=passed`, `closure_claim=0`, nonclaims T005/T006/T024 + RCC M1 open.
Target index (main) still `not_discharged` for T004.

---

## §4 Full 38-target map (registry × Lean surface)

Legend: **K** = kernel Lean present · **K-PR** = kernel Lean on open PR only ·
**—** = no Lean · trust for Lean rows is always kernel-checked empty-axiom
when present; registry row remains `not_discharged` until an independent
discharge update (finding `[iec_target_registry_discharge_status_stale]`).

### 4.1 address_profile (6)

| id | name | Lean | trust / surface | actually constrains today |
|----|------|------|-----------------|---------------------------|
| IEC-T001 | InstitutionRefAddressKindSound | — | registry-only | *named obligation only* |
| IEC-T002 | InstitutionalCutIdentityBinding | — | registry-only | *named; Phase B object not frozen* |
| IEC-T003 | BoundedProfileFactorization | **K** main | kernel-checked | q-factorization of model `result` |
| IEC-T004 | DispositionOutcomePartition | **K-PR** #2016 | kernel-checked | encode-image exclusive partition |
| IEC-T005 | TypedDispositionResidueCoverage | — | registry-only | open (T003 nonclaim) |
| IEC-T006 | BoundedDispositionProfileExactness | — | registry-only | open (T003 nonclaim) |

### 4.2 evidence (6)

| id | name | Lean | notes |
|----|------|------|-------|
| IEC-T007 | EvidencePolicyExplicitAdmission | — | lean_plus_runtime declared; 0 Lean |
| IEC-T008 | GreenDoesNotSynthesizeBinding | — | CM001 targets; 0 Lean |
| IEC-T009 | ConditionalForeignFactorRequirement | — | runtime_conformance declared |
| IEC-T010 | EvidenceReferenceRequiresGrounding | — | |
| IEC-T011 | EvidencePolicyChangeRequiresRevalidation | — | |
| IEC-T035 | EvidencePolicyAcceptanceIsContextRelative | — | |

### 4.3 capability_effect (5)

| id | name | Lean |
|----|------|------|
| IEC-T012 … T016 | IdentityKnowledge… / NoAmbient… / CapEffectSep / Revocation… / DeclarationToEffect | — |

### 4.4 cut_lineage (12) — includes Phase B main

| id | name | Lean | Phase-B relevance |
|----|------|------|-------------------|
| IEC-T017 … T025 | CutRelation… / Composition / NewGenesis / Successor / DomainExact / Totality / Coupling / NonVacuity / Historical… | — | |
| **IEC-T026** | **StaleCutRequiresRevalidationOrReepoch** | **—** | **Phase B main; 0 Lean; needs frozen cut object** |
| IEC-T036 | SequentialDispositionCompositionIsExplicit | — | |
| IEC-T038 | DispositionOutcomeFamilyIsPolicyOpen | — | runtime_conformance |

### 4.5 frontier (9) — includes Phase B main

| id | name | Lean | Phase-B relevance |
|----|------|------|-------------------|
| IEC-T027 | SuppliedTotalityDoesNotImplyCompleteness | — | |
| IEC-T028 | FrontierExtractionSoundness | — | |
| **IEC-T029** | **RelativeLiveFrontierCompleteness** | **—** | **Phase B main (`LiveFrontierCompleteness`); 0 Lean** |
| IEC-T030 … T034, T037 | Determinism / Omission… / CapabilityRegister… / CouplingEdge… / FrontierItemKind… | — | |

**Scoreboard:** Lean-backed **2/38** (1 main + 1 PR) · **0/38** discharged in the target index · **0** `native_decide` · **0** sorry/axiom in the IEC Lean surface that exists.

---

## §5 IEC-0.x frozen registries — what "passed" means

| node | artifact class | status at audit | proof strength |
|------|----------------|-----------------|----------------|
| IEC-0.0 | pinned source window + claim matrix | docs/json | enumeration of upstream claims — **not theorems** |
| IEC-0.1 | operational countermodel registry | `passed`, `closure_claim=0` | **countermodels named**, not refuted in Lean |
| IEC-0.2 | nearest-object collision | `passed`, freeze-granted history | absorption analysis — **not discharge** |
| IEC-0.3 | minimal vocabulary + live frontier evidence | `passed` / candidate_for_freeze | vocabulary + evidence **rows**; LiveFrontierCompleteness marked `designated_domain_instance_not_implemented_in_iec_0_3` |
| IEC-0.4 | theorem/countermodel/nonclaim index | `passed` | **38 targets assigned IDs before discharge** (method-correct); all still open |
| IEC-0.5 | RCC dependency + closure disposition map | `candidate` / `candidate_for_freeze` | dependency map; Advanced disposition — **RCC ids open** |
| T003 receipt | factorization | `passed`, `closure_claim=0` | kernel Lean + empty axioms (main) |
| T004 receipt | partition | `passed` on PR, `closure_claim=0` | kernel Lean + empty axioms (PR) |
| disposer-as-role self-instance | candidate | **not** a frozen InstitutionalCut | Phase B object precursor only |

**Finding:** IEC-0.x "passed" means **registry completeness / freeze discipline**,
not **theorem discharge**. The product of Phase 0 is an enumerated open
frontier with nonclaims — which is the correct RCC/IEC method — and it is
exactly why `closure_claim` stays 0. Treating 0.x freeze as "IEC proved"
would be the self-measurement defect ADR_SELF_MEASUREMENT names.

---

## §6 Where `closure_claim=0` is load-bearing (honest residual)

1. **36/38 targets have no Lean module** — including both Phase B mains
   (T026 StaleCut…, T029 LiveFrontierCompleteness).
2. **T003/T004 are kernel-solid encoding models**, not runtime bridges:
   factorization/partition hold by construction of `result`/`encode`.
3. **Target registry discharge status is stale** relative to T003 (and T004
   PR): still `not_discharged` after empty-axiom Lean exists.
4. **No `native_decide` residue to name on IEC Lean** — good — but the
   absence is coverage thinness, not full strength.
5. **Phase B object missing:** frozen residua as `disposer-as-role-iec-instance`
   / first InstitutionalCut waits on `ADR_RESIDUA_KERNEL_FREEZE`. Without
   exact `root_q`, T026/T029 have nothing concrete to discharge against.
6. **macOS axiom script footgun:** `docker/lean-verifier/verify-iec-t00{3,4}-axioms.sh`
   use `mktemp --suffix=.lean` (GNU); fails on BSD mktemp before probing.
   Gate is sound in CI Linux; local macOS needs a portable probe. Named
   `[iec_axiom_script_mktemp_portability]`, not a proof defect.

---

## §7 Phase B readiness checklist (do not start early)

When architect rings `ADR_RESIDUA_KERNEL_FREEZE` dispose:

| step | object |
|------|--------|
| 1 | Pin exact `root_q` of frozen residua |
| 2 | Instantiate `InstitutionalCut` / disposer-as-role from that pin (`IEC_DISPOSER_ROLE_SELF_INSTANCE` upgrades from candidate) |
| 3 | Discharge **IEC-T029** RelativeLiveFrontierCompleteness against the cut's declared universe + relevance |
| 4 | Discharge **IEC-T026** StaleCutRequiresRevalidationOrReepoch (stale-input mutants → revalidation / Reepoch residue) |
| 5 | Re-run this table: every new theorem gets trust-class + axiom probe; `native_decide` if used must be named |

Until then: this Phase A map is the cold-start zero-delay foundation.

---

## §8 Named findings (machine ids)

| id | severity | summary |
|----|----------|---------|
| `[iec_2_of_38_lean_backed]` | structural | Only T003 (main) + T004 (PR) have Lean; 36 targets registry-only |
| `[iec_encoding_model_not_runtime_bridge]` | honesty | T003/T004 constrain encode/result models; not live disposition stack |
| `[iec_target_registry_discharge_status_stale]` | registry | Target index still `not_discharged` for Lean-backed T003 |
| `[iec_phase_b_object_absent]` | gate | No frozen InstitutionalCut / root_q; T026/T029 blocked |
| `[iec_0x_passed_is_registry_not_proof]` | grading | 0.x `passed` ≠ theorem discharge; closure_claim=0 is correct |
| `[iec_no_native_decide_on_surface]` | positive | T003/T004 empty axiom; no ofReduceBool — kernel class holds |
| `[iec_axiom_script_mktemp_portability]` | tooling | GNU `mktemp --suffix` breaks local macOS probe |

---

## §9 Nonclaims (this audit)

- Does **not** merge or re-grade PR #2016.
- Does **not** edit IEC-0.x freeze bytes or target `proof_status` fields
  (findings-only; discharge status update is a separate judgment act).
- Does **not** claim Phase B readiness beyond the checklist.
- Does **not** add Python (0-python iron law).
- `closure_claim=0`.

---

*Produced by agent:grok-1 Phase A pre-assignment. Independent of P6.
When P6 disposes, resume at §7.*
