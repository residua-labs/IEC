import Lean
import Std.Data.HashMap
import IEC
import IECTests
open Lean

/-- Headline theorems whose exact axiom footprint is printed individually. -/
def headlines : List Name := [
  `Residua.IEC.T003.admissible_factors_through_q,
  `Residua.IEC.T003.sigma_factors_through_q,
  `Residua.IEC.T003.rho_factors_through_q,
  `Residua.IEC.T003.result_factors_through_q,
  `Residua.IEC.T003.same_q_different_outcome_impossible,
  `Residua.IEC.T003.Tests.nontrivial_same_q_witness,
  `Residua.IEC.T003.Tests.mutant_same_q_different_outcome,
  `Residua.IEC.RelativeCompleteClosure.iec_closed_iff_packet,
  `Residua.IEC.RelativeCompleteClosure.iec_closed_iff_certificates,
  `Residua.IEC.RelativeCompleteClosure.adapter_obeys_t003,
  `Residua.IEC.RelativeCompleteClosure.plan_total_does_not_imply_completeness,
  `Residua.Conflux.IECAdapter.quotient_preserves_coordinates,
  `Residua.Conflux.IECAdapter.green_without_exact_binding_is_refused,
  `Residua.Conflux.IECAdapter.supplied_totality_does_not_imply_completeness,
  `Residua.Conflux.IECCurrentCutBinding.policy_change_requires_entry_address_change,
  `Residua.Conflux.IECCurrentCutBinding.candidate_does_not_claim_live_current_cut_or_closure ]

/-- Prints the axiom footprint of each headline theorem, then a count per axiom set
for every theorem declared in an `IEC.*`, `Conflux.*` or `IECTests.*` module, plus
any theorem that depends on an axiom outside `propext`, `Quot.sound`,
`Classical.choice`. -/
def main : IO Unit := do
  initSearchPath (← findSysroot)
  let env ← importModules #[{ module := `IEC }, { module := `IECTests }] {} 0
  let axiomsOf (n : Name) : List String :=
    let (_, s) := ((CollectAxioms.collect n).run env).run {}
    (s.axioms.toList.map toString).toArray.qsort (· < ·) |>.toList
  IO.println "headline theorems:"
  for n in headlines do
    if env.contains n then
      IO.println s!"  {n}: [{", ".intercalate (axiomsOf n)}]"
    else
      IO.println s!"  {n}: MISSING"
  let mut counts : Std.HashMap String Nat := {}
  let mut odd : Array String := #[]
  let mut total := 0
  for (n, ci) in env.constants.toList do
    let some idx := env.getModuleIdxFor? n | continue
    let modName := env.header.moduleNames[idx.toNat]!
    unless (`IEC).isPrefixOf modName || (`Conflux).isPrefixOf modName ||
        (`IECTests).isPrefixOf modName do continue
    unless ci matches .thmInfo _ do continue
    if n.isInternal then continue
    total := total + 1
    let axs := axiomsOf n
    let key := if axs.isEmpty then "(none)" else ", ".intercalate axs
    counts := counts.insert key (counts.getD key 0 + 1)
    for a in axs do
      unless a == "propext" || a == "Quot.sound" || a == "Classical.choice" do
        odd := odd.push s!"{n}: {a}"
  IO.println s!"theorems in IEC.*, Conflux.*, IECTests.*: {total}"
  for (k, v) in counts.toList do
    IO.println s!"{v}\t{k}"
  IO.println s!"non-standard axiom uses: {odd.size}"
  for o in odd do IO.println o
