# IEC — institutional cuts

**English** · [中文](README.zh-CN.md)

**When may an institution change its own history, rules or authority, and how can anyone check that the change was admissible?**

## Why

Institutions change themselves: a protocol forks, an organisation re-founds, a fleet of agents replaces its governance rules. Such a change is a *cut* of the institution's history, with a successor, possibly a new genesis, and a disposition of what came before. Done informally, a cut is where authority is silently rewritten and history quietly reinterpreted.

IEC makes a cut an object that can be admitted or refused:
- it is normalized directly against [MST-NF](https://github.com/residua-labs/MST-NF);
- its closure is computed by [RCC](https://github.com/residua-labs/RCC) relative to a supplied, cut-bound context;
- a cut that is not admissible returns a typed non-closure (`Await`, `Reepoch`, address refusal, …), never a silent acceptance.

Residua's own governance, in which rule changes go through logic and a non-proposer quorum rather than a person's signature, is the kind of institution IEC is meant to describe. IEC is also the second application of the formal-theory construction method that produced RCC: it tests whether that method generalizes.

## Status, stated exactly

- **Research mirror.** IEC is **not** part of Residua's release closure, and it is not being expanded until it is closed. `closure_claim = 0`.
- Only IEC-T003 (bounded-profile factorization) and the relative-complete-closure packet are discharged here. The other theorem targets (`IEC-T001` … `IEC-T038`) are fixed in `docs/` as targets, not results.

## Contents

Machine-checked Lean 4 modules for **IEC**, the institutional-cut layer of the
Residua project, extracted from Residua for public release.

IEC asks when an institution-level change — a *cut* of an institution's history,
with its successor, new-genesis and disposition relations — may be admitted. It is
normalized directly against [MST-NF](https://github.com/residua-labs/MST-NF) and is
checked by the [Relative Closure Calculus (RCC)](https://github.com/residua-labs/RCC):
a cut is closed only *relative to* a supplied, cut-bound context, and otherwise
returns a typed non-closure (`Await`, `Reepoch`, address refusal, …). The
research record in `docs/` fixes the vocabulary, the countermodels, the theorem
targets (`IEC-T001` … `IEC-T038`) and the explicit non-claims.

## What is included

| Module | Residua namespace | Content |
|---|---|---|
| `IEC.BoundedProfileFactorization` | `Residua.IEC.T003` | IEC-T003: fixed bounded-profile semantics factors admissibility, `sigma` and `rho` through the profile quotient `q` |
| `IEC.RelativeCompleteClosure` | `Residua.IEC.RelativeCompleteClosure` | product-level closedness: a cut-relative IEC context is closed exactly when one certificate packet is inhabited |
| `Conflux.IECAdapter` | `Residua.Conflux.IECAdapter` | IEC bounded disposition profile as a Conflux/MST-NF profile (outer preparation, seven disposition obligations, RCC interpretation) |
| `Conflux.IECCurrentCutBinding` | `Residua.Conflux.IECCurrentCutBinding` | binds the current IEC cut to a sealed RCC snapshot through its address registry |
| `Conflux.MSTNFComposition`, `Conflux.ProfileInstallationGate`, `Conflux.RCCCompositeSeam` | `Residua.Conflux.*` | supporting Conflux modules: MST-NF profile composition, profile installation gate, RCC composite seam |
| `IECTests.*` (4) | `…Tests` | concrete witnesses, refusal cases and load-bearing mutants; each ends with `#print axioms` |

Declarations keep their original `Residua.*` namespaces. Apart from import lines,
the Lean code is unchanged from the Residua source; module paths were renamed for
this release (see `docs/README.md` for the mapping).

## Headline theorems

Axiom footprints as printed by `scripts/PrintAxioms.lean`.

| Theorem | Module | Axioms |
|---|---|---|
| `Residua.IEC.T003.admissible_factors_through_q` | `IEC.BoundedProfileFactorization` | none |
| `Residua.IEC.T003.sigma_factors_through_q` | `IEC.BoundedProfileFactorization` | none |
| `Residua.IEC.T003.rho_factors_through_q` | `IEC.BoundedProfileFactorization` | none |
| `Residua.IEC.T003.result_factors_through_q` | `IEC.BoundedProfileFactorization` | none |
| `Residua.IEC.T003.same_q_different_outcome_impossible` | `IEC.BoundedProfileFactorization` | none |
| `Residua.IEC.T003.Tests.nontrivial_same_q_witness` / `mutant_same_q_different_outcome` | `IECTests.BoundedProfileFactorization` | none |
| `Residua.IEC.RelativeCompleteClosure.iec_closed_iff_packet` | `IEC.RelativeCompleteClosure` | none |
| `Residua.IEC.RelativeCompleteClosure.iec_closed_iff_certificates` | `IEC.RelativeCompleteClosure` | none |
| `Residua.IEC.RelativeCompleteClosure.adapter_obeys_t003` | `IEC.RelativeCompleteClosure` | none |
| `Residua.IEC.RelativeCompleteClosure.plan_total_does_not_imply_completeness` | `IEC.RelativeCompleteClosure` | none |
| `Residua.Conflux.IECAdapter.quotient_preserves_coordinates` | `Conflux.IECAdapter` | none |
| `Residua.Conflux.IECAdapter.green_without_exact_binding_is_refused` | `Conflux.IECAdapter` | `propext` |
| `Residua.Conflux.IECAdapter.supplied_totality_does_not_imply_completeness` | `Conflux.IECAdapter` | `propext` |
| `Residua.Conflux.IECCurrentCutBinding.policy_change_requires_entry_address_change` | `Conflux.IECCurrentCutBinding` | none |
| `Residua.Conflux.IECCurrentCutBinding.candidate_does_not_claim_live_current_cut_or_closure` | `Conflux.IECCurrentCutBinding` | none |

The `IECTests` modules also prove the anti-closure cases (stale basis, mixed
frontier or plan, truncated enumeration, missing relevant dependency, forged or
stale cut address, …) by concrete counterexample.

## What is *not* claimed

* IEC here is a **candidate formal layer**, not a frozen institution checker. The
  modules state explicitly that they do not manufacture a live institutional
  witness, a concrete address kernel, live frontier completeness, SCM
  correspondence, or a live closure claim; `closure_claim` stays `0`.
* Only IEC-T003 and the relative-complete-closure packet are discharged here; the
  other targets in `docs/iec/IEC_0_4_THEOREM_COUNTERMODEL_NONCLAIM_REGISTRY_V0_1.md`
  are tracked in the research record, not proved in this repository.
* Residua's machine receipts, SCM targets, Rust gate and verification scripts are
  not included.

## Trust base

* Lean 4 core only (`leanprover/lean4:v4.14.0`), plus
  [residua-labs/RCC](https://github.com/residua-labs/RCC) (itself Lean core only).
  No Mathlib.
* No `sorry`, no `axiom` declarations, no `native_decide` or `implemented_by`.
* `scripts/PrintAxioms.lean` checks every theorem in `IEC.*`, `Conflux.*` and
  `IECTests.*` (501 theorems): 426 use no axioms, 75 use only `propext`.

## Relation to MST-NF and RCC

* **MST-NF** supplies the structural normal form; `Conflux.MSTNFComposition`
  restates the MST-NF role profiles that the IEC adapter instantiates (it does not
  import the Mathlib-based MST-NF package).
* **RCC** supplies the closure verdicts and snapshots. This package requires RCC at
  commit `0f7f5f39ff36f8f21c13e649c35127c235ab3df6` and imports `RCC.FormalCore`, `RCC.StepExecModel`,
  `RCC.RC1DurableTrace` and, through it, `RCC.RelativeCompleteClosure` and
  `RCC.ClosurePrerequisites`.

## Build

```sh
# install elan: https://github.com/leanprover/elan
lake build                                    # fetches RCC, builds IEC and IECTests
lake env lean --run scripts/PrintAxioms.lean  # headline footprints + axiom summary
```

## Documentation

See `docs/README.md`: the IEC-0.0 … IEC-1.0 research record and the design specs and
plans for each stage.

## License

Apache-2.0. See `LICENSE` and `NOTICE`.
