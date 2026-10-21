import IEC.RelativeCompleteClosure

/-!
# IEC relative complete closure tests

These theorems pin the product packet: a missing relevant fact or
dependency, mixed frontier/plan/enumeration identity, unbound cut,
inexact evidence, empty plan, empty frontier, ghost plan edge, stale
current observation, dangling coupling, or unsatisfied coupling cannot
manufacture IEC closure.  Plan totality is not completeness.  Adapter
admission is not closedness.  There is no inhabitant of
`IECClosedPacket` here — that would be an instance, not a law.
-/

namespace Residua.IEC.RelativeCompleteClosure.Tests

open Residua.Conflux.IECAdapter
open Residua.IEC.RelativeCompleteClosure

def preimage : CutPreimage where
  sourceInstitutionQ := "institution-q"
  sourceEpochQ := "epoch-q"
  sourceHistoryHeadQ := "history-head-q"
  cutEventQ := "cut-event-q"
  targetRelationMapQ := "target-relation-map-q"

def algorithms : Algorithms where
  cutQ := fun cut =>
    cut.sourceInstitutionQ ++ ":" ++ cut.sourceEpochQ ++ ":" ++
      cut.sourceHistoryHeadQ ++ ":" ++ cut.cutEventQ ++ ":" ++
      cut.targetRelationMapQ

def cut : InstitutionalCut where
  preimage := preimage
  cutQ := algorithms.cutQ preimage
  institutionPolicyQ := "institution-policy-q"
  assumptionRootQ := "conflux-assumption-root-q"

def evidencePolicy : EvidencePolicy where
  evidencePolicyQ := "evidence-policy-q"
  institutionPolicyQ := cut.institutionPolicyQ
  expectedEvidenceQ := "evidence-q"
  expectedItemQ := "kept-item"
  expectedOutcomeQ := "outcome-q"
  expectedTargetInstitutionQ := "target-institution-q"
  requireForeign := true

def evidence : EvidenceEdge where
  evidenceQ := evidencePolicy.expectedEvidenceQ
  itemQ := evidencePolicy.expectedItemQ
  outcomeQ := evidencePolicy.expectedOutcomeQ
  targetInstitutionQ := evidencePolicy.expectedTargetInstitutionQ
  sourceInstitutionQ := cut.preimage.sourceInstitutionQ
  sourceEpochQ := cut.preimage.sourceEpochQ
  sourceHistoryHeadQ := cut.preimage.sourceHistoryHeadQ
  cutEventQ := cut.preimage.cutEventQ
  targetRelationMapQ := cut.preimage.targetRelationMapQ
  authorQ := "author-q"
  foreignQ := "independent-foreign-q"

def grounding : EvidenceGrounding where
  verifierQ := "verifier-q"
  receiptChainQ := "receipt-chain-q"

def kept : FrontierItem := ⟨"kept-item"⟩
def omitted : SourceFact := ⟨"live-omitted", "omitted-item"⟩
def keptFact : SourceFact := ⟨"live-kept", "kept-item"⟩
def omittedDep : SourceDependency :=
  ⟨"dep-omitted", "kept-item", "omitted-item", "constraint-q"⟩

def frontier : LiveFrontier where
  items := [kept]
  edges := []

def keptEdge : DispositionEdge where
  itemQ := "kept-item"
  outcomeQ := "outcome-q"
  targetInstitutionQ := "target-institution-q"
  evidenceQ := "evidence-q"

def plan : DispositionPlan where
  edges := [keptEdge]

def artifacts : ArtifactKernel where
  frontierQ := fun f =>
    f.items.foldl (fun acc i => acc ++ ":" ++ i.itemQ) "F" ++
      f.edges.foldl
        (fun acc e => acc ++ ":" ++ e.leftQ ++ ":" ++ e.rightQ) ""
  planQ := fun p =>
    p.edges.foldl
      (fun acc e => acc ++ ":" ++ e.itemQ ++ ":" ++ e.outcomeQ) "P"

def enumeration : EnumerationKernel where
  universeQ := fun source deps =>
    source.foldl (fun acc f => acc ++ ":" ++ f.factQ ++ ":" ++ f.itemQ) "U" ++
      deps.foldl
        (fun acc d => acc ++ ":" ++ d.factQ ++ ":" ++ d.leftQ ++ ":" ++ d.rightQ)
        ""

def extract : ExtractionContext where
  sourceUniverseQ := enumeration.universeQ [omitted, keptFact] []
  relevancePredicateQ := "relevance-q"
  extractorQ := "extractor-q"

def attempt : AttemptClass where
  cut := cut
  frontierQ := artifacts.frontierQ frontier
  planQ := artifacts.planQ plan
  evidencePolicy := evidencePolicy
  evidence := evidence
  grounding := grounding
  targetProjectionQ := "target-projection-q"
  checks :=
    { cutBound := true
      frontierForm := true
      planDomain := true
      total := true
      exclusive := true
      couplingCompatible := true }
  outer :=
    { liveFrontierComplete := true
      basisCurrent := true }

def current : CurrentObservation where
  historyHeadQ := cut.preimage.sourceHistoryHeadQ
  epochQ := cut.preimage.sourceEpochQ
  policyQ := cut.institutionPolicyQ
  frontierQ := attempt.frontierQ
  planQ := attempt.planQ

def sys : FrontierSystem where
  relevant := fun fact _cut _ctx =>
    fact.factQ == "live-omitted" || fact.factQ == "live-kept"
  relevantDep := fun dep _cut _ctx =>
    dep.factQ == "dep-omitted"

def coupling : CouplingPolicy where
  satisfied := fun _edge _left _right => true

/-- Constructive T027 world: adapter Bools and green admit are true, one
relevant source fact is omitted from the frontier. -/
def ctx : IECContext where
  algorithms := algorithms
  artifacts := artifacts
  enumeration := enumeration
  attempt := attempt
  frontier := frontier
  plan := plan
  extract := extract
  source := [omitted, keptFact]
  sourceDeps := []
  sys := sys
  coupling := coupling
  current := current

theorem plan_covers_the_supplied_item :
    PlanTotal ctx.plan ctx.frontier := by
  intro item mem
  change item ∈ [kept] at mem
  cases mem with
  | head =>
    exact ⟨keptEdge, List.Mem.head [], rfl⟩
  | tail _ empty =>
    cases empty

theorem omitted_relevant_fact_is_missing :
    ∃ fact,
      fact ∈ ctx.source ∧
        ctx.sys.relevant fact ctx.attempt.cut ctx.extract = true ∧
          ¬ ∃ item, item ∈ ctx.frontier.items ∧ item.itemQ = fact.itemQ := by
  refine ⟨omitted, List.Mem.head [keptFact], rfl, ?_⟩
  intro h
  rcases h with ⟨item, mem, hq⟩
  change item ∈ [kept] at mem
  cases mem with
  | head =>
    have hne : kept.itemQ ≠ omitted.itemQ := by decide
    exact hne hq
  | tail _ empty =>
    cases empty

theorem adapter_admits_the_open_context :
    admissible ctx.algorithms ctx.attempt = true := by
  decide

theorem totality_is_not_completeness :
    PlanTotal ctx.plan ctx.frontier ∧ ¬ IECClosed ctx :=
  ⟨plan_covers_the_supplied_item,
    missing_relevant_fact_excludes_closed omitted_relevant_fact_is_missing⟩

theorem adapter_admit_is_not_closedness :
    admissible ctx.algorithms ctx.attempt = true ∧ ¬ IECClosed ctx :=
  ⟨adapter_admits_the_open_context,
    adapter_admissible_does_not_imply_closed
      adapter_admits_the_open_context omitted_relevant_fact_is_missing⟩

theorem completeness_bit_is_not_closedness :
    ctx.attempt.outer.liveFrontierComplete = true ∧ ¬ IECClosed ctx :=
  ⟨rfl,
    completeness_bool_does_not_imply_closed rfl
      omitted_relevant_fact_is_missing⟩

def ctxDepOmitted : IECContext :=
  { ctx with
    source := [keptFact]
    sourceDeps := [omittedDep]
    extract :=
      { extract with
        sourceUniverseQ := enumeration.universeQ [keptFact] [omittedDep] } }

theorem omitted_relevant_dependency_is_missing :
    ∃ dep,
      dep ∈ ctxDepOmitted.sourceDeps ∧
        ctxDepOmitted.sys.relevantDep
            dep ctxDepOmitted.attempt.cut ctxDepOmitted.extract = true ∧
          ¬ ∃ edge,
            edge ∈ ctxDepOmitted.frontier.edges ∧
              MatchesDep edge dep := by
  refine ⟨omittedDep, List.Mem.head [], rfl, ?_⟩
  intro h
  rcases h with ⟨edge, mem, _⟩
  change edge ∈ ([] : List CouplingEdge) at mem
  cases mem

theorem missing_relevant_dependency_is_a_constructive_anti_closure :
    ¬ IECClosed ctxDepOmitted :=
  missing_relevant_dependency_excludes_closed
    omitted_relevant_dependency_is_missing

def ghostFrontier : LiveFrontier :=
  { items := [kept, ⟨"ghost-item"⟩], edges := [] }

def ghostPlan : DispositionPlan :=
  ⟨[keptEdge,
    { itemQ := "ghost-item"
      outcomeQ := "outcome-q"
      targetInstitutionQ := "target-institution-q"
      evidenceQ := "evidence-q" }]⟩

theorem frontier_q_orig : artifacts.frontierQ frontier = "F:kept-item" :=
  rfl

theorem frontier_q_ghost : artifacts.frontierQ ghostFrontier = "F:kept-item:ghost-item" :=
  rfl

theorem plan_q_orig : artifacts.planQ plan = "P:kept-item:outcome-q" :=
  rfl

theorem plan_q_ghost :
    artifacts.planQ ghostPlan = "P:kept-item:outcome-q:ghost-item:outcome-q" :=
  rfl

theorem universe_q_full :
    enumeration.universeQ [omitted, keptFact] [] =
      "U:live-omitted:omitted-item:live-kept:kept-item" :=
  rfl

theorem universe_q_truncated :
    enumeration.universeQ [keptFact] [] = "U:live-kept:kept-item" :=
  rfl

def detachedFrontier : IECContext :=
  { ctx with frontier := ghostFrontier }

theorem mixed_frontier_is_a_constructive_anti_closure :
    ¬ IECClosed detachedFrontier :=
  mixed_frontier_excludes_closed (by
    intro bound
    have h := bound.2
    change artifacts.frontierQ frontier = artifacts.frontierQ ghostFrontier at h
    rw [frontier_q_orig, frontier_q_ghost] at h
    have hne : "F:kept-item" ≠ "F:kept-item:ghost-item" := by decide
    exact hne h)

def detachedPlan : IECContext :=
  { ctx with plan := ghostPlan }

theorem mixed_plan_is_a_constructive_anti_closure :
    ¬ IECClosed detachedPlan :=
  mixed_plan_excludes_closed (by
    intro bound
    have h := bound.2
    change artifacts.planQ plan = artifacts.planQ ghostPlan at h
    rw [plan_q_orig, plan_q_ghost] at h
    have hne :
        "P:kept-item:outcome-q" ≠
          "P:kept-item:outcome-q:ghost-item:outcome-q" := by decide
    exact hne h)

def truncated : IECContext :=
  { ctx with source := [keptFact] }

theorem truncated_enumeration_is_a_constructive_anti_closure :
    ¬ IECClosed truncated :=
  truncated_enumeration_excludes_closed (by
    intro bound
    have h := bound.2
    change
        enumeration.universeQ [omitted, keptFact] [] =
          enumeration.universeQ [keptFact] [] at h
    rw [universe_q_full, universe_q_truncated] at h
    have hne :
        "U:live-omitted:omitted-item:live-kept:kept-item" ≠
          "U:live-kept:kept-item" := by decide
    exact hne h)

def stale : IECContext :=
  { ctx with current := { current with historyHeadQ := "other-head" } }

theorem stale_basis_is_a_constructive_anti_closure :
    ¬ IECClosed stale :=
  stale_basis_excludes_closed (by
    intro current
    have hne : "history-head-q" ≠ "other-head" := by decide
    exact hne current.2.1)

theorem missing_relevant_dependency_is_a_parametric_anti_closure
    {C : IECContext}
    (missing :
      ∃ dep,
        dep ∈ C.sourceDeps ∧
          C.sys.relevantDep dep C.attempt.cut C.extract = true ∧
            ¬ ∃ edge, edge ∈ C.frontier.edges ∧ MatchesDep edge dep) :
    ¬ IECClosed C :=
  missing_relevant_dependency_excludes_closed missing

theorem invented_coupling_edge_is_a_constructive_anti_closure
    {C : IECContext}
    (invented :
      ∃ edge,
        edge ∈ C.frontier.edges ∧
          ¬ ∃ dep,
            dep ∈ C.sourceDeps ∧
              C.sys.relevantDep dep C.attempt.cut C.extract = true ∧
                MatchesDep edge dep) :
    ¬ IECClosed C :=
  invented_coupling_edge_excludes_closed invented

theorem unbound_cut_is_a_constructive_anti_closure
    {C : IECContext}
    (unbound : ¬ CutAddressBound C.algorithms C.attempt) :
    ¬ IECClosed C :=
  unbound_cut_excludes_closed unbound

theorem inexact_evidence_is_a_constructive_anti_closure
    {C : IECContext}
    (inexact : ¬ ExactEvidence C.attempt) :
    ¬ IECClosed C :=
  inexact_evidence_excludes_closed inexact

theorem empty_plan_is_a_constructive_anti_closure
    {C : IECContext}
    (empty : ¬ PlanNonempty C.plan) :
    ¬ IECClosed C :=
  empty_plan_excludes_closed empty

theorem empty_frontier_is_a_constructive_anti_closure
    {C : IECContext}
    (empty : ¬ FrontierNonempty C.frontier) :
    ¬ IECClosed C :=
  empty_frontier_excludes_closed empty

theorem ghost_plan_edge_is_a_constructive_anti_closure
    {C : IECContext}
    (ghost : ¬ PlanDomain C.plan C.frontier) :
    ¬ IECClosed C :=
  ghost_plan_edge_excludes_closed ghost

theorem plan_not_exclusive_is_a_constructive_anti_closure
    {C : IECContext}
    (double : ¬ PlanExclusive C.plan C.frontier) :
    ¬ IECClosed C :=
  plan_not_exclusive_excludes_closed double

theorem dangling_coupling_is_a_constructive_anti_closure
    {C : IECContext}
    (dangling : ¬ CouplingExact C.frontier) :
    ¬ IECClosed C :=
  dangling_coupling_excludes_closed dangling

theorem unsatisfied_coupling_is_a_constructive_anti_closure
    {C : IECContext}
    (unsat : ¬ CouplingCompatible C.coupling C.frontier C.plan) :
    ¬ IECClosed C :=
  unsatisfied_coupling_excludes_closed unsat

theorem closed_is_exactly_the_packet
    (C : IECContext) :
    IECClosed C ↔ Nonempty (IECClosedPacket C) :=
  iec_closed_iff_packet C

theorem closed_is_exactly_the_certificates
    (C : IECContext) :
    IECClosed C ↔
      CutAddressBound C.algorithms C.attempt ∧
        ExactEvidence C.attempt ∧
          FrontierBound C ∧
            PlanBound C ∧
              EnumerationBound C ∧
                Nonempty
                    (RelativeCompletenessCertificate
                      C.sys C.attempt.cut C.extract C.frontier
                        C.source C.sourceDeps) ∧
                  FrontierNonempty C.frontier ∧
                    FrontierWellFormed C.frontier ∧
                      PlanNonempty C.plan ∧
                        PlanTotal C.plan C.frontier ∧
                          PlanExclusive C.plan C.frontier ∧
                            PlanDomain C.plan C.frontier ∧
                              CouplingExact C.frontier ∧
                                CouplingCompatible C.coupling C.frontier C.plan ∧
                                  CurrentBasis C :=
  iec_closed_iff_certificates C

theorem adapter_still_factors_through_q
    (algs : Algorithms) :
    ¬ Residua.IEC.T003.SameQDifferentOutcome (adapterSemantics algs) :=
  adapter_obeys_t003 algs

theorem coupling_is_not_an_implicit_closure
    (frontier : LiveFrontier) :
    CouplingExact frontier ↔
      ∀ edge, edge ∈ frontier.edges →
        edge.constraintQ ≠ "" ∧
          (∃ left, left ∈ frontier.items ∧ left.itemQ = edge.leftQ) ∧
            ∃ right, right ∈ frontier.items ∧ right.itemQ = edge.rightQ :=
  coupling_exact_is_supplied_edges_only frontier

#print axioms iec_closed_iff_packet
#print axioms iec_closed_iff_certificates
#print axioms plan_total_does_not_imply_completeness
#print axioms missing_relevant_fact_excludes_closed
#print axioms missing_relevant_dependency_excludes_closed
#print axioms mixed_frontier_excludes_closed
#print axioms mixed_plan_excludes_closed
#print axioms truncated_enumeration_excludes_closed
#print axioms unbound_cut_excludes_closed
#print axioms inexact_evidence_excludes_closed
#print axioms empty_plan_excludes_closed
#print axioms empty_frontier_excludes_closed
#print axioms ghost_plan_edge_excludes_closed
#print axioms stale_basis_excludes_closed
#print axioms dangling_coupling_excludes_closed
#print axioms unsatisfied_coupling_excludes_closed
#print axioms adapter_obeys_t003
#print axioms coupling_exact_is_supplied_edges_only
#print axioms totality_is_not_completeness
#print axioms adapter_admit_is_not_closedness
#print axioms mixed_frontier_is_a_constructive_anti_closure
#print axioms mixed_plan_is_a_constructive_anti_closure
#print axioms truncated_enumeration_is_a_constructive_anti_closure
#print axioms stale_basis_is_a_constructive_anti_closure
#print axioms missing_relevant_dependency_is_a_constructive_anti_closure

end Residua.IEC.RelativeCompleteClosure.Tests
