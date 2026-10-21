import Conflux.IECAdapter
import IEC.BoundedProfileFactorization

/-!
# IEC relative complete closure

The Conflux bounded-profile adapter still accepts caller `Bool`s for
completeness, totality, exclusivity, and coupling.  Those bits remain
transport.  This capstone is the product-level closedness predicate.

A cut-relative IEC context is closed exactly when the existing derived
certificates inhabit one packet:

* cut address is the preimage (T002);
* evidence is the exact tuple plus grounding (T007/T010);
* relative live-frontier completeness is an enumeration certificate over
  declared source items *and* source dependencies, not the outer
  completeness bit (T028/T029);
* the disposition plan's domain is exactly the supplied frontier
  (T021/T022/T024);
* coupling is checked on the supplied edges only (T034) and is satisfied
  by the plan under a declared constraint reader (T023);
* the structured frontier and plan are the attempt's frontierQ/planQ
  through an explicit artifact kernel (same shape as T002 cut binding);
* the source/sourceDeps lists are the declared sourceUniverseQ through
  an explicit enumeration kernel;
* the current observation is independent of the cut preimage (T026).

Plan totality does not imply completeness (T027).  Adapter admission does
not inhabit the packet (T008/T014).  The packet does not manufacture a
live institutional witness and does not flip `closure_claim`.

Prelude-only Lean 4.14; no Mathlib, custom axioms, or proof placeholders.
-/

namespace Residua.IEC.RelativeCompleteClosure

open Residua.Conflux.IECAdapter

structure FrontierItem where
  itemQ : String
  deriving DecidableEq, Repr

structure CouplingEdge where
  leftQ : String
  rightQ : String
  constraintQ : String
  deriving DecidableEq, Repr

structure LiveFrontier where
  items : List FrontierItem
  edges : List CouplingEdge
  deriving DecidableEq, Repr

structure DispositionEdge where
  itemQ : String
  outcomeQ : String
  targetInstitutionQ : String
  evidenceQ : String
  deriving DecidableEq, Repr

structure DispositionPlan where
  edges : List DispositionEdge
  deriving DecidableEq, Repr

structure SourceFact where
  factQ : String
  itemQ : String
  deriving DecidableEq, Repr

structure SourceDependency where
  factQ : String
  leftQ : String
  rightQ : String
  constraintQ : String
  deriving DecidableEq, Repr

structure ExtractionContext where
  sourceUniverseQ : String
  relevancePredicateQ : String
  extractorQ : String
  deriving DecidableEq, Repr

/-- Relevance is a declared reader on the explicit source universe. -/
structure FrontierSystem where
  relevant :
    SourceFact → InstitutionalCut → ExtractionContext → Bool
  relevantDep :
    SourceDependency → InstitutionalCut → ExtractionContext → Bool

/-- Constraint satisfaction is a declared reader, not a caller Boolean. -/
structure CouplingPolicy where
  satisfied :
    CouplingEdge → DispositionEdge → DispositionEdge → Bool

/-- Address realization for the structured frontier and plan.  Explicit
kernel, not a hash-injectivity axiom. -/
structure ArtifactKernel where
  frontierQ : LiveFrontier → String
  planQ : DispositionPlan → String

/-- Identity of the declared source universe.  Truncating the lists
without changing `sourceUniverseQ` is a mixed identity. -/
structure EnumerationKernel where
  universeQ : List SourceFact → List SourceDependency → String

/-- Independent current observation.  Copying the cut preimage into this
structure is a mixed identity when any field diverges. -/
structure CurrentObservation where
  historyHeadQ : String
  epochQ : String
  policyQ : String
  frontierQ : String
  planQ : String
  deriving DecidableEq, Repr

structure IECContext where
  algorithms : Algorithms
  artifacts : ArtifactKernel
  enumeration : EnumerationKernel
  attempt : AttemptClass
  frontier : LiveFrontier
  plan : DispositionPlan
  extract : ExtractionContext
  source : List SourceFact
  sourceDeps : List SourceDependency
  sys : FrontierSystem
  coupling : CouplingPolicy
  current : CurrentObservation

def Covers (edges : List DispositionEdge) (itemQ : String) : Prop :=
  ∃ edge, edge ∈ edges ∧ edge.itemQ = itemQ

def UniqueCover (edges : List DispositionEdge) (itemQ : String) : Prop :=
  Covers edges itemQ ∧
    ∀ {left right : DispositionEdge},
      left ∈ edges →
        right ∈ edges →
          left.itemQ = itemQ →
            right.itemQ = itemQ →
              left = right

def PlanTotal (plan : DispositionPlan) (frontier : LiveFrontier) : Prop :=
  ∀ item, item ∈ frontier.items → Covers plan.edges item.itemQ

def PlanExclusive (plan : DispositionPlan) (frontier : LiveFrontier) : Prop :=
  ∀ item, item ∈ frontier.items → UniqueCover plan.edges item.itemQ

/-- T021: no ghost plan edge. -/
def PlanDomain (plan : DispositionPlan) (frontier : LiveFrontier) : Prop :=
  ∀ edge, edge ∈ plan.edges →
    ∃ item, item ∈ frontier.items ∧ item.itemQ = edge.itemQ

def PlanNonempty (plan : DispositionPlan) : Prop :=
  plan.edges ≠ []

def FrontierNonempty (frontier : LiveFrontier) : Prop :=
  frontier.items ≠ []

def FrontierWellFormed (frontier : LiveFrontier) : Prop :=
  (∀ item, item ∈ frontier.items → item.itemQ ≠ "") ∧
    ∀ {left right : FrontierItem},
      left ∈ frontier.items →
        right ∈ frontier.items →
          left.itemQ = right.itemQ →
            left = right

/-- Coupling is a predicate on the supplied edges.  It does not add a
symmetric, reversed, or transitive edge. -/
def CouplingExact (frontier : LiveFrontier) : Prop :=
  ∀ edge, edge ∈ frontier.edges →
    edge.constraintQ ≠ "" ∧
      (∃ left, left ∈ frontier.items ∧ left.itemQ = edge.leftQ) ∧
        ∃ right, right ∈ frontier.items ∧ right.itemQ = edge.rightQ

/-- T023: every supplied coupling constraint is satisfied by the plan. -/
def CouplingCompatible
    (policy : CouplingPolicy)
    (frontier : LiveFrontier)
    (plan : DispositionPlan) : Prop :=
  ∀ edge, edge ∈ frontier.edges →
    ∃ left right,
      left ∈ plan.edges ∧
        right ∈ plan.edges ∧
          left.itemQ = edge.leftQ ∧
            right.itemQ = edge.rightQ ∧
              policy.satisfied edge left right = true

def CurrentBasis (C : IECContext) : Prop :=
  C.current.historyHeadQ ≠ "" ∧
    C.attempt.cut.preimage.sourceHistoryHeadQ = C.current.historyHeadQ ∧
      C.attempt.cut.preimage.sourceEpochQ = C.current.epochQ ∧
        C.attempt.cut.institutionPolicyQ = C.current.policyQ ∧
          C.attempt.frontierQ = C.current.frontierQ ∧
            C.attempt.planQ = C.current.planQ

/-- The structured frontier is the attempt's frontierQ. -/
def FrontierBound (C : IECContext) : Prop :=
  C.attempt.frontierQ ≠ "" ∧
    C.attempt.frontierQ = C.artifacts.frontierQ C.frontier

/-- The structured plan is the attempt's planQ. -/
def PlanBound (C : IECContext) : Prop :=
  C.attempt.planQ ≠ "" ∧
    C.attempt.planQ = C.artifacts.planQ C.plan

/-- The enumerated lists are the declared source universe. -/
def EnumerationBound (C : IECContext) : Prop :=
  C.extract.sourceUniverseQ ≠ "" ∧
    C.extract.sourceUniverseQ =
      C.enumeration.universeQ C.source C.sourceDeps

def ExtractionDeclared (ctx : ExtractionContext) : Prop :=
  ctx.sourceUniverseQ ≠ "" ∧
    ctx.relevancePredicateQ ≠ "" ∧
    ctx.extractorQ ≠ ""

def MatchesDep (edge : CouplingEdge) (dep : SourceDependency) : Prop :=
  edge.leftQ = dep.leftQ ∧
    edge.rightQ = dep.rightQ ∧
      edge.constraintQ = dep.constraintQ

/-- T028/T029: relative completeness against the declared source universe. -/
structure RelativeCompletenessCertificate
    (sys : FrontierSystem)
    (cut : InstitutionalCut)
    (ctx : ExtractionContext)
    (frontier : LiveFrontier)
    (source : List SourceFact)
    (sourceDeps : List SourceDependency) where
  declared : ExtractionDeclared ctx
  nonvacuous :
    ∃ fact, fact ∈ source ∧ sys.relevant fact cut ctx = true
  coverage :
    ∀ fact,
      fact ∈ source →
        sys.relevant fact cut ctx = true →
          ∃ item, item ∈ frontier.items ∧ item.itemQ = fact.itemQ
  soundness :
    ∀ item,
      item ∈ frontier.items →
        ∃ fact,
          fact ∈ source ∧
            sys.relevant fact cut ctx = true ∧
              fact.itemQ = item.itemQ
  edgeCoverage :
    ∀ dep,
      dep ∈ sourceDeps →
        sys.relevantDep dep cut ctx = true →
          ∃ edge, edge ∈ frontier.edges ∧ MatchesDep edge dep
  edgeSoundness :
    ∀ edge,
      edge ∈ frontier.edges →
        ∃ dep,
          dep ∈ sourceDeps ∧
            sys.relevantDep dep cut ctx = true ∧
              MatchesDep edge dep

/-- The exact IEC packet.  There is no `closed` or completeness Boolean. -/
structure IECClosedPacket (C : IECContext) where
  cutBound : CutAddressBound C.algorithms C.attempt
  exactEvidence : ExactEvidence C.attempt
  frontierBound : FrontierBound C
  planBound : PlanBound C
  enumerationBound : EnumerationBound C
  completeness :
    RelativeCompletenessCertificate
      C.sys C.attempt.cut C.extract C.frontier C.source C.sourceDeps
  frontierNonempty : FrontierNonempty C.frontier
  frontierForm : FrontierWellFormed C.frontier
  planNonempty : PlanNonempty C.plan
  planTotal : PlanTotal C.plan C.frontier
  planExclusive : PlanExclusive C.plan C.frontier
  planDomain : PlanDomain C.plan C.frontier
  couplingExact : CouplingExact C.frontier
  couplingCompatible :
    CouplingCompatible C.coupling C.frontier C.plan
  basisCurrent : CurrentBasis C

def IECClosed (C : IECContext) : Prop :=
  Nonempty (IECClosedPacket C)

theorem iec_closed_iff_packet (C : IECContext) :
    IECClosed C ↔ Nonempty (IECClosedPacket C) :=
  Iff.rfl

/-- Joint sufficiency: closedness is exactly the derived certificates. -/
theorem iec_closed_iff_certificates (C : IECContext) :
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
                                  CurrentBasis C := by
  constructor
  · intro closed
    obtain ⟨packet⟩ := closed
    exact
      ⟨packet.cutBound, packet.exactEvidence, packet.frontierBound,
        packet.planBound, packet.enumerationBound, ⟨packet.completeness⟩,
        packet.frontierNonempty, packet.frontierForm, packet.planNonempty,
        packet.planTotal, packet.planExclusive, packet.planDomain,
        packet.couplingExact, packet.couplingCompatible,
        packet.basisCurrent⟩
  · intro h
    rcases h with
      ⟨cutBound, exactEvidence, frontierBound, planBound, enumerationBound,
        ⟨completeness⟩, frontierNonempty, frontierForm, planNonempty,
        planTotal, planExclusive, planDomain, couplingExact,
        couplingCompatible, basisCurrent⟩
    exact ⟨{
      cutBound := cutBound
      exactEvidence := exactEvidence
      frontierBound := frontierBound
      planBound := planBound
      enumerationBound := enumerationBound
      completeness := completeness
      frontierNonempty := frontierNonempty
      frontierForm := frontierForm
      planNonempty := planNonempty
      planTotal := planTotal
      planExclusive := planExclusive
      planDomain := planDomain
      couplingExact := couplingExact
      couplingCompatible := couplingCompatible
      basisCurrent := basisCurrent
    }⟩

theorem closed_implies_cut_bound
    {C : IECContext} (closed : IECClosed C) :
    CutAddressBound C.algorithms C.attempt := by
  obtain ⟨packet⟩ := closed
  exact packet.cutBound

theorem closed_implies_exact_evidence
    {C : IECContext} (closed : IECClosed C) :
    ExactEvidence C.attempt := by
  obtain ⟨packet⟩ := closed
  exact packet.exactEvidence

theorem closed_implies_relative_completeness
    {C : IECContext} (closed : IECClosed C) :
    Nonempty
      (RelativeCompletenessCertificate
        C.sys C.attempt.cut C.extract C.frontier
          C.source C.sourceDeps) := by
  obtain ⟨packet⟩ := closed
  exact ⟨packet.completeness⟩

theorem closed_implies_plan_total
    {C : IECContext} (closed : IECClosed C) :
    PlanTotal C.plan C.frontier := by
  obtain ⟨packet⟩ := closed
  exact packet.planTotal

theorem closed_implies_plan_domain
    {C : IECContext} (closed : IECClosed C) :
    PlanDomain C.plan C.frontier := by
  obtain ⟨packet⟩ := closed
  exact packet.planDomain

theorem closed_implies_plan_exclusive
    {C : IECContext} (closed : IECClosed C) :
    PlanExclusive C.plan C.frontier := by
  obtain ⟨packet⟩ := closed
  exact packet.planExclusive

theorem closed_implies_coupling_exact
    {C : IECContext} (closed : IECClosed C) :
    CouplingExact C.frontier := by
  obtain ⟨packet⟩ := closed
  exact packet.couplingExact

theorem closed_implies_coupling_compatible
    {C : IECContext} (closed : IECClosed C) :
    CouplingCompatible C.coupling C.frontier C.plan := by
  obtain ⟨packet⟩ := closed
  exact packet.couplingCompatible

theorem closed_implies_frontier_bound
    {C : IECContext} (closed : IECClosed C) :
    FrontierBound C := by
  obtain ⟨packet⟩ := closed
  exact packet.frontierBound

theorem closed_implies_plan_bound
    {C : IECContext} (closed : IECClosed C) :
    PlanBound C := by
  obtain ⟨packet⟩ := closed
  exact packet.planBound

theorem closed_implies_enumeration_bound
    {C : IECContext} (closed : IECClosed C) :
    EnumerationBound C := by
  obtain ⟨packet⟩ := closed
  exact packet.enumerationBound

theorem closed_implies_current_basis
    {C : IECContext} (closed : IECClosed C) :
    CurrentBasis C := by
  obtain ⟨packet⟩ := closed
  exact packet.basisCurrent

/-- T027: covering every supplied item does not inhabit completeness. -/
theorem plan_total_does_not_imply_completeness
    {C : IECContext}
    (_total : PlanTotal C.plan C.frontier)
    (missing :
      ∃ fact,
        fact ∈ C.source ∧
          C.sys.relevant fact C.attempt.cut C.extract = true ∧
            ¬ ∃ item, item ∈ C.frontier.items ∧ item.itemQ = fact.itemQ) :
    ¬ Nonempty
        (RelativeCompletenessCertificate
          C.sys C.attempt.cut C.extract C.frontier
            C.source C.sourceDeps) := by
  intro inhabited
  obtain ⟨certificate⟩ := inhabited
  rcases missing with ⟨fact, memSource, relevant, notRepresented⟩
  exact
    notRepresented (certificate.coverage fact memSource relevant)

theorem missing_relevant_fact_excludes_closed
    {C : IECContext}
    (missing :
      ∃ fact,
        fact ∈ C.source ∧
          C.sys.relevant fact C.attempt.cut C.extract = true ∧
            ¬ ∃ item, item ∈ C.frontier.items ∧ item.itemQ = fact.itemQ) :
    ¬ IECClosed C := by
  intro closed
  exact
    plan_total_does_not_imply_completeness
      (closed_implies_plan_total closed) missing
      (closed_implies_relative_completeness closed)

theorem missing_relevant_dependency_excludes_closed
    {C : IECContext}
    (missing :
      ∃ dep,
        dep ∈ C.sourceDeps ∧
          C.sys.relevantDep dep C.attempt.cut C.extract = true ∧
            ¬ ∃ edge, edge ∈ C.frontier.edges ∧ MatchesDep edge dep) :
    ¬ IECClosed C := by
  intro closed
  obtain ⟨certificate⟩ := closed_implies_relative_completeness closed
  rcases missing with ⟨dep, mem, relevant, notRepresented⟩
  exact notRepresented (certificate.edgeCoverage dep mem relevant)

theorem invented_coupling_edge_excludes_closed
    {C : IECContext}
    (invented :
      ∃ edge,
        edge ∈ C.frontier.edges ∧
          ¬ ∃ dep,
            dep ∈ C.sourceDeps ∧
              C.sys.relevantDep dep C.attempt.cut C.extract = true ∧
                MatchesDep edge dep) :
    ¬ IECClosed C := by
  intro closed
  obtain ⟨certificate⟩ := closed_implies_relative_completeness closed
  rcases invented with ⟨edge, mem, unsupported⟩
  exact unsupported (certificate.edgeSoundness edge mem)

theorem unbound_cut_excludes_closed
    {C : IECContext}
    (unbound : ¬ CutAddressBound C.algorithms C.attempt) :
    ¬ IECClosed C :=
  fun closed => unbound (closed_implies_cut_bound closed)

theorem inexact_evidence_excludes_closed
    {C : IECContext}
    (inexact : ¬ ExactEvidence C.attempt) :
    ¬ IECClosed C :=
  fun closed => inexact (closed_implies_exact_evidence closed)

theorem empty_plan_excludes_closed
    {C : IECContext}
    (empty : ¬ PlanNonempty C.plan) :
    ¬ IECClosed C := by
  intro closed
  obtain ⟨packet⟩ := closed
  exact empty packet.planNonempty

theorem empty_frontier_excludes_closed
    {C : IECContext}
    (empty : ¬ FrontierNonempty C.frontier) :
    ¬ IECClosed C := by
  intro closed
  obtain ⟨packet⟩ := closed
  exact empty packet.frontierNonempty

theorem plan_not_total_excludes_closed
    {C : IECContext}
    (gap : ¬ PlanTotal C.plan C.frontier) :
    ¬ IECClosed C :=
  fun closed => gap (closed_implies_plan_total closed)

theorem ghost_plan_edge_excludes_closed
    {C : IECContext}
    (ghost : ¬ PlanDomain C.plan C.frontier) :
    ¬ IECClosed C :=
  fun closed => ghost (closed_implies_plan_domain closed)

theorem plan_not_exclusive_excludes_closed
    {C : IECContext}
    (double : ¬ PlanExclusive C.plan C.frontier) :
    ¬ IECClosed C :=
  fun closed => double (closed_implies_plan_exclusive closed)

theorem stale_basis_excludes_closed
    {C : IECContext}
    (stale : ¬ CurrentBasis C) :
    ¬ IECClosed C :=
  fun closed => stale (closed_implies_current_basis closed)

theorem mixed_frontier_excludes_closed
    {C : IECContext}
    (mixed : ¬ FrontierBound C) :
    ¬ IECClosed C :=
  fun closed => mixed (closed_implies_frontier_bound closed)

theorem mixed_plan_excludes_closed
    {C : IECContext}
    (mixed : ¬ PlanBound C) :
    ¬ IECClosed C :=
  fun closed => mixed (closed_implies_plan_bound closed)

theorem truncated_enumeration_excludes_closed
    {C : IECContext}
    (truncated : ¬ EnumerationBound C) :
    ¬ IECClosed C :=
  fun closed => truncated (closed_implies_enumeration_bound closed)

theorem dangling_coupling_excludes_closed
    {C : IECContext}
    (dangling : ¬ CouplingExact C.frontier) :
    ¬ IECClosed C :=
  fun closed => dangling (closed_implies_coupling_exact closed)

theorem unsatisfied_coupling_excludes_closed
    {C : IECContext}
    (unsat : ¬ CouplingCompatible C.coupling C.frontier C.plan) :
    ¬ IECClosed C :=
  fun closed => unsat (closed_implies_coupling_compatible closed)

/-- T034: coupling is a predicate on the supplied edge list, not a closure. -/
theorem coupling_exact_is_supplied_edges_only
    (frontier : LiveFrontier) :
    CouplingExact frontier ↔
      ∀ edge, edge ∈ frontier.edges →
        edge.constraintQ ≠ "" ∧
          (∃ left, left ∈ frontier.items ∧ left.itemQ = edge.leftQ) ∧
            ∃ right, right ∈ frontier.items ∧ right.itemQ = edge.rightQ :=
  Iff.rfl

/-- T003 on the adapter model: equal class ⇒ equal a/σ/ρ. -/
def adapterSemantics (algorithms : Algorithms) :
    Residua.IEC.T003.FixedProfileSemantics
      RawAttempt AttemptClass Representative ProfileResidue where
  q := Residua.Conflux.IECAdapter.q
  admissible := admissible algorithms
  sigma := representative algorithms
  rho := residue algorithms

theorem adapter_obeys_t003 (algorithms : Algorithms) :
    ¬ Residua.IEC.T003.SameQDifferentOutcome (adapterSemantics algorithms) :=
  Residua.IEC.T003.same_q_different_outcome_impossible
    (adapterSemantics algorithms)

/-- Adapter completeness/totality Bools and even a green admit do not
inhabit `IECClosed`. -/
theorem adapter_admissible_does_not_imply_closed
    {C : IECContext}
    (_admitted : admissible C.algorithms C.attempt = true)
    (missing :
      ∃ fact,
        fact ∈ C.source ∧
          C.sys.relevant fact C.attempt.cut C.extract = true ∧
            ¬ ∃ item, item ∈ C.frontier.items ∧ item.itemQ = fact.itemQ) :
    ¬ IECClosed C :=
  missing_relevant_fact_excludes_closed missing

theorem completeness_bool_does_not_imply_closed
    {C : IECContext}
    (_bit : C.attempt.outer.liveFrontierComplete = true)
    (missing :
      ∃ fact,
        fact ∈ C.source ∧
          C.sys.relevant fact C.attempt.cut C.extract = true ∧
            ¬ ∃ item, item ∈ C.frontier.items ∧ item.itemQ = fact.itemQ) :
    ¬ IECClosed C :=
  missing_relevant_fact_excludes_closed missing

end Residua.IEC.RelativeCompleteClosure
