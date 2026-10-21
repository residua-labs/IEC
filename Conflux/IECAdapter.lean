import Conflux.MSTNFComposition
import IEC.BoundedProfileFactorization

/-!
# IEC bounded disposition profile for Conflux

This is a current-main re-cut of the IEC minimal-vocabulary profile. It keeps
three layers distinct:

* outer preparation checks cut-address realization, supplied frontier
  completeness, and current basis;
* the active bounded profile checks the seven frozen disposition obligations;
* RCC later interprets Await/Reepoch/address refusal and admitted history.

`LiveFrontierCompleteness` is never inferred from plan totality. The concrete
evidence leg binds evidence, item, outcome, target institution, the complete
cut context, and a verifier/receipt grounding chain. This remains a candidate:
it is not an IEC freeze, production-exhaustive checker, SCM correspondence, or
live institutional authority claim.
-/

namespace Residua.Conflux.IECAdapter

open Residua.RCC.StepExecModel
open Residua.Conflux.MSTNFComposition

/-- T002's intrinsic cut preimage. -/
structure CutPreimage where
  sourceInstitutionQ : String
  sourceEpochQ : String
  sourceHistoryHeadQ : String
  cutEventQ : String
  targetRelationMapQ : String
  deriving DecidableEq, Repr

/-- The wider institution-policy and assumption roots are Conflux/RCC context.
They are not claimed as fields already proved by IEC T002. -/
structure InstitutionalCut where
  preimage : CutPreimage
  cutQ : String
  institutionPolicyQ : String
  assumptionRootQ : String
  deriving DecidableEq, Repr

def InstitutionalCut.coordinates (cut : InstitutionalCut) :
    InstitutionalCoordinates where
  epochQ := cut.preimage.sourceEpochQ
  policyQ := cut.institutionPolicyQ
  cutQ := cut.cutQ
  assumptionRootQ := cut.assumptionRootQ

structure EvidencePolicy where
  evidencePolicyQ : String
  institutionPolicyQ : String
  expectedEvidenceQ : String
  expectedItemQ : String
  expectedOutcomeQ : String
  expectedTargetInstitutionQ : String
  requireForeign : Bool
  deriving DecidableEq, Repr

structure EvidenceEdge where
  evidenceQ : String
  itemQ : String
  outcomeQ : String
  targetInstitutionQ : String
  sourceInstitutionQ : String
  sourceEpochQ : String
  sourceHistoryHeadQ : String
  cutEventQ : String
  targetRelationMapQ : String
  authorQ : String
  foreignQ : String
  deriving DecidableEq, Repr

structure EvidenceGrounding where
  verifierQ : String
  receiptChainQ : String
  deriving DecidableEq, Repr

/-- Seven checks frozen by the bounded T005/T006 profile. No catch-all is
included and no production-exhaustiveness claim is made. -/
structure BoundedChecks where
  cutBound : Bool
  frontierForm : Bool
  planDomain : Bool
  total : Bool
  exclusive : Bool
  couplingCompatible : Bool
  deriving DecidableEq, Repr

/-- Open/control conditions do not belong to the seven-class profile rho. -/
structure OuterChecks where
  liveFrontierComplete : Bool
  basisCurrent : Bool
  deriving DecidableEq, Repr

structure RawAttempt where
  cut : InstitutionalCut
  frontierQ : String
  planQ : String
  evidencePolicy : EvidencePolicy
  evidence : EvidenceEdge
  grounding : EvidenceGrounding
  targetProjectionQ : String
  checks : BoundedChecks
  outer : OuterChecks
  observationMetadata : String
  deriving DecidableEq, Repr

structure AttemptClass where
  cut : InstitutionalCut
  frontierQ : String
  planQ : String
  evidencePolicy : EvidencePolicy
  evidence : EvidenceEdge
  grounding : EvidenceGrounding
  targetProjectionQ : String
  checks : BoundedChecks
  outer : OuterChecks
  deriving DecidableEq, Repr

def q (raw : RawAttempt) : AttemptClass where
  cut := raw.cut
  frontierQ := raw.frontierQ
  planQ := raw.planQ
  evidencePolicy := raw.evidencePolicy
  evidence := raw.evidence
  grounding := raw.grounding
  targetProjectionQ := raw.targetProjectionQ
  checks := raw.checks
  outer := raw.outer

/-- Address realization is an explicit input, not a hash-injectivity axiom. -/
structure Algorithms where
  cutQ : CutPreimage → String

def CutAddressBound (algorithms : Algorithms) (attempt : AttemptClass) : Prop :=
  attempt.cut.cutQ = algorithms.cutQ attempt.cut.preimage

instance (algorithms : Algorithms) (attempt : AttemptClass) :
    Decidable (CutAddressBound algorithms attempt) := by
  unfold CutAddressBound
  infer_instance

/-- T007/T010 exact evidence tuple and grounding. `policyQ` is not silently
identified with the narrower `evidencePolicyQ`; an explicit projection equality
binds the evidence policy to the institutional policy. -/
def ExactEvidence (attempt : AttemptClass) : Prop :=
  attempt.evidencePolicy.institutionPolicyQ = attempt.cut.institutionPolicyQ ∧
  attempt.evidence.evidenceQ = attempt.evidencePolicy.expectedEvidenceQ ∧
  attempt.evidence.itemQ = attempt.evidencePolicy.expectedItemQ ∧
  attempt.evidence.outcomeQ = attempt.evidencePolicy.expectedOutcomeQ ∧
  attempt.evidence.targetInstitutionQ =
    attempt.evidencePolicy.expectedTargetInstitutionQ ∧
  attempt.evidence.sourceInstitutionQ =
    attempt.cut.preimage.sourceInstitutionQ ∧
  attempt.evidence.sourceEpochQ = attempt.cut.preimage.sourceEpochQ ∧
  attempt.evidence.sourceHistoryHeadQ =
    attempt.cut.preimage.sourceHistoryHeadQ ∧
  attempt.evidence.cutEventQ = attempt.cut.preimage.cutEventQ ∧
  attempt.evidence.targetRelationMapQ =
    attempt.cut.preimage.targetRelationMapQ ∧
  attempt.grounding.verifierQ ≠ "" ∧
  attempt.grounding.receiptChainQ ≠ "" ∧
  (attempt.evidencePolicy.requireForeign = false ∨
    attempt.evidence.foreignQ ≠ attempt.evidence.authorQ)

instance (attempt : AttemptClass) : Decidable (ExactEvidence attempt) := by
  unfold ExactEvidence
  infer_instance

inductive ProfileResidue where
  | cutUnbound
  | frontierMalformed
  | planDomainMismatch
  | evidenceRejected
  | totalityFailure
  | exclusivityFailure
  | couplingIncompatible
  deriving DecidableEq, Repr

inductive OuterResidue where
  | cutAddressMismatch
  | liveFrontierCompletenessOpen
  | staleBasis
  deriving DecidableEq, Repr

structure Representative where
  cut : InstitutionalCut
  frontierQ : String
  planQ : String
  evidencePolicyQ : String
  targetProjectionQ : String
  deriving DecidableEq, Repr

inductive Verdict where
  | admit (representative : Representative)
  | residue (reason : ProfileResidue)
  | addressRefuse (reason : OuterResidue)
  | await (reason : OuterResidue)
  | reepoch (reason : OuterResidue)
  deriving DecidableEq, Repr

/-- Outer preparation precedes bounded-profile admission. -/
def outerVerdict (algorithms : Algorithms) (attempt : AttemptClass) :
    Option Verdict :=
  if ¬ CutAddressBound algorithms attempt then
    some (.addressRefuse .cutAddressMismatch)
  else if !attempt.outer.liveFrontierComplete then
    some (.await .liveFrontierCompletenessOpen)
  else if !attempt.outer.basisCurrent then
    some (.reepoch .staleBasis)
  else
    none

def boundedVerdict (attempt : AttemptClass) : Verdict :=
  if !attempt.checks.cutBound then .residue .cutUnbound
  else if !attempt.checks.frontierForm then .residue .frontierMalformed
  else if !attempt.checks.planDomain then .residue .planDomainMismatch
  else if ¬ ExactEvidence attempt then .residue .evidenceRejected
  else if !attempt.checks.total then .residue .totalityFailure
  else if !attempt.checks.exclusive then .residue .exclusivityFailure
  else if !attempt.checks.couplingCompatible then
    .residue .couplingIncompatible
  else
    .admit
      { cut := attempt.cut
        frontierQ := attempt.frontierQ
        planQ := attempt.planQ
        evidencePolicyQ := attempt.evidencePolicy.evidencePolicyQ
        targetProjectionQ := attempt.targetProjectionQ }

def decide (algorithms : Algorithms) (attempt : AttemptClass) : Verdict :=
  match outerVerdict algorithms attempt with
  | some result => result
  | none => boundedVerdict attempt

def active (algorithms : Algorithms) (attempt : AttemptClass) : Bool :=
  match decide algorithms attempt with
  | .addressRefuse _ | .await _ | .reepoch _ => false
  | .admit _ | .residue _ => true

def admissible (algorithms : Algorithms) (attempt : AttemptClass) : Bool :=
  match decide algorithms attempt with
  | .admit _ => true
  | _ => false

def representative (algorithms : Algorithms) (attempt : AttemptClass) :
    Option Representative :=
  match decide algorithms attempt with
  | .admit rep => some rep
  | _ => none

/-- Only active bounded-profile failures inhabit rho. Await/Reepoch/address
refusal remain RCC-visible outer outcomes. -/
def residue (algorithms : Algorithms) (attempt : AttemptClass) :
    Option ProfileResidue :=
  match decide algorithms attempt with
  | .residue reason => some reason
  | _ => none

def model (algorithms : Algorithms) : Model where
  Raw := RawAttempt
  Class := AttemptClass
  Rep := Representative
  Residue := ProfileResidue
  Outcome := Verdict
  q := q
  evalRaw := fun raw => decide algorithms (q raw)
  evalClass := decide algorithms
  active := active algorithms
  admissible := admissible algorithms
  rho := residue algorithms
  sigma := representative algorithms

theorem profile (algorithms : Algorithms) : Profile (model algorithms) where
  quotient_factorization := by intro raw; rfl
  representative_implies_admissible := by
    intro cls rep hrep
    cases hdecision : decide algorithms cls <;>
      simp [model, representative, admissible, hdecision] at hrep ⊢
  residue_totality := by
    intro cls hactive hnot
    cases hdecision : decide algorithms cls with
    | admit rep => simp [model, admissible, hdecision] at hnot
    | residue reason => exact ⟨reason, by simp [model, residue, hdecision]⟩
    | addressRefuse reason =>
        simp [model, active, hdecision] at hactive
    | await reason =>
        simp [model, active, hdecision] at hactive
    | reepoch reason =>
        simp [model, active, hdecision] at hactive
  representative_precision := by
    intro cls _ hadmitted
    cases hdecision : decide algorithms cls with
    | admit rep => exact ⟨rep, by simp [model, representative, hdecision]⟩
    | residue reason => simp [model, admissible, hdecision] at hadmitted
    | addressRefuse reason => simp [model, admissible, hdecision] at hadmitted
    | await reason => simp [model, admissible, hdecision] at hadmitted
    | reepoch reason => simp [model, admissible, hdecision] at hadmitted

def rawCoordinates (raw : RawAttempt) : Option InstitutionalCoordinates :=
  some raw.cut.coordinates

def classCoordinates (attempt : AttemptClass) :
    Option InstitutionalCoordinates :=
  some attempt.cut.coordinates

theorem quotient_preserves_coordinates (raw : RawAttempt) :
    rawCoordinates raw = classCoordinates ((model algorithms).q raw) := rfl

theorem every_attempt_is_contextual (raw : RawAttempt) :
    ∃ coordinates, rawCoordinates raw = some coordinates :=
  ⟨raw.cut.coordinates, rfl⟩

theorem metadata_aliases_factor
    (raw : RawAttempt) (otherMetadata : String) :
    (model algorithms).q raw =
      (model algorithms).q { raw with observationMetadata := otherMetadata } :=
  rfl

theorem supplied_totality_does_not_imply_completeness
    (algorithms : Algorithms) (attempt : AttemptClass)
    (address : CutAddressBound algorithms attempt)
    (incomplete : attempt.outer.liveFrontierComplete = false) :
    decide algorithms attempt = .await .liveFrontierCompletenessOpen := by
  simp [decide, outerVerdict, address, incomplete]

theorem stale_basis_reepochs
    (algorithms : Algorithms) (attempt : AttemptClass)
    (address : CutAddressBound algorithms attempt)
    (complete : attempt.outer.liveFrontierComplete = true)
    (stale : attempt.outer.basisCurrent = false) :
    decide algorithms attempt = .reepoch .staleBasis := by
  simp [decide, outerVerdict, address, complete, stale]

theorem green_without_exact_binding_is_refused
    (algorithms : Algorithms) (attempt : AttemptClass)
    (prepared : outerVerdict algorithms attempt = none)
    (cut : attempt.checks.cutBound = true)
    (frontier : attempt.checks.frontierForm = true)
    (domain : attempt.checks.planDomain = true)
    (notExact : ¬ ExactEvidence attempt) :
    decide algorithms attempt = .residue .evidenceRejected := by
  simp [decide, prepared, boundedVerdict, cut, frontier, domain, notExact]

theorem coordinate_movement_changes_class
    {left right : AttemptClass}
    (moved : left.cut.coordinates ≠ right.cut.coordinates) :
    left ≠ right := by
  intro equal
  exact moved (congrArg (fun attempt => attempt.cut.coordinates) equal)

end Residua.Conflux.IECAdapter
