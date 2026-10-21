import Conflux.MSTNFComposition

/-!
# Conflux profile installation gate

Formal profile composition and repository installation are different claims.
This module makes the distinction executable:

* a branch candidate may be typechecked and reviewed;
* an installed profile must be observed on the declared `main` bytes;
* a live-bound profile is a later stage and cannot be inferred from landing.

The gate is deliberately independent of Git or GitHub. Their observations
enter as typed content coordinates and are compared here. No candidate branch
is treated as part of the installed Conflux profile family.
-/

namespace Residua.Conflux.ProfileInstallationGate

open Residua.Conflux.MSTNFComposition

inductive ArtifactStage where
  | branchCandidate
  | landedOnMain
  | liveBound
  deriving DecidableEq, Repr

/-- Declaration carried by one profile artifact. `artifactQ` commits to the
actual profile bytes; `dependencyClosureQ` commits to all imported definitions
on which the artifact relies. -/
structure ArtifactPin where
  kind : ProfileKind
  stage : ArtifactStage
  mainCommitQ : String
  artifactQ : String
  dependencyClosureQ : String
  modelQ : String
  deriving DecidableEq, Repr

/-- Independently observed repository coordinates. -/
structure LandingObservation where
  expectedKind : ProfileKind
  observedMainCommitQ : String
  observedArtifactQ : String
  observedDependencyClosureQ : String
  observedModelQ : String
  deriving DecidableEq, Repr

inductive IntakeResidue where
  | branchCandidateNotInstalled
  | emptyMainCommit
  | emptyArtifact
  | emptyDependencyClosure
  | emptyModelCommitment
  | profileKindMismatch
  | mainCommitMismatch
  | artifactMismatch
  | dependencyClosureMismatch
  | modelMismatch
  deriving DecidableEq, Repr

def firstResidue (pin : ArtifactPin) (observation : LandingObservation) :
    Option IntakeResidue :=
  if pin.stage = .branchCandidate then
    some .branchCandidateNotInstalled
  else if pin.mainCommitQ.isEmpty then
    some .emptyMainCommit
  else if pin.artifactQ.isEmpty then
    some .emptyArtifact
  else if pin.dependencyClosureQ.isEmpty then
    some .emptyDependencyClosure
  else if pin.modelQ.isEmpty then
    some .emptyModelCommitment
  else if pin.kind ≠ observation.expectedKind then
    some .profileKindMismatch
  else if pin.mainCommitQ ≠ observation.observedMainCommitQ then
    some .mainCommitMismatch
  else if pin.artifactQ ≠ observation.observedArtifactQ then
    some .artifactMismatch
  else if pin.dependencyClosureQ ≠ observation.observedDependencyClosureQ then
    some .dependencyClosureMismatch
  else if pin.modelQ ≠ observation.observedModelQ then
    some .modelMismatch
  else
    none

def pinMatches (pin : ArtifactPin) (observation : LandingObservation) : Prop :=
  firstResidue pin observation = none

theorem branch_candidate_cannot_install
    (pin : ArtifactPin) (observation : LandingObservation)
    (candidate : pin.stage = .branchCandidate) :
    firstResidue pin observation = some .branchCandidateNotInstalled := by
  simp [firstResidue, candidate]

theorem matching_implies_not_branch_candidate
    (pin : ArtifactPin) (observation : LandingObservation)
    (admitted : pinMatches pin observation) :
    pin.stage ≠ .branchCandidate := by
  intro candidate
  unfold pinMatches at admitted
  rw [branch_candidate_cannot_install pin observation candidate] at admitted
  contradiction

theorem matching_facts
    (pin : ArtifactPin) (observation : LandingObservation)
    (admitted : pinMatches pin observation) :
    pin.stage ≠ .branchCandidate ∧
    pin.kind = observation.expectedKind ∧
    pin.mainCommitQ = observation.observedMainCommitQ ∧
    pin.artifactQ = observation.observedArtifactQ ∧
    pin.dependencyClosureQ = observation.observedDependencyClosureQ ∧
    pin.modelQ = observation.observedModelQ := by
  unfold pinMatches firstResidue at admitted
  split at admitted <;> simp_all
  split at admitted <;> simp_all
  split at admitted <;> simp_all
  split at admitted <;> simp_all
  split at admitted <;> simp_all
  split at admitted <;> simp_all
  split at admitted <;> simp_all
  split at admitted <;> simp_all
  split at admitted <;> simp_all

theorem matching_binds_kind
    (pin : ArtifactPin) (observation : LandingObservation)
    (admitted : pinMatches pin observation) :
    pin.kind = observation.expectedKind :=
  (matching_facts pin observation admitted).2.1

theorem matching_binds_main_commit
    (pin : ArtifactPin) (observation : LandingObservation)
    (admitted : pinMatches pin observation) :
    pin.mainCommitQ = observation.observedMainCommitQ :=
  (matching_facts pin observation admitted).2.2.1

theorem matching_binds_artifact
    (pin : ArtifactPin) (observation : LandingObservation)
    (admitted : pinMatches pin observation) :
    pin.artifactQ = observation.observedArtifactQ :=
  (matching_facts pin observation admitted).2.2.2.1

theorem matching_binds_dependency_closure
    (pin : ArtifactPin) (observation : LandingObservation)
    (admitted : pinMatches pin observation) :
    pin.dependencyClosureQ = observation.observedDependencyClosureQ :=
  (matching_facts pin observation admitted).2.2.2.2.1

theorem matching_binds_model
    (pin : ArtifactPin) (observation : LandingObservation)
    (admitted : pinMatches pin observation) :
    pin.modelQ = observation.observedModelQ :=
  (matching_facts pin observation admitted).2.2.2.2.2

/-! ## Authoritative landing observation -/

/-- The production trust boundary for repository observations. Unlike the old
caller-paired pin/observation shape, one authority owns a single source window
and recomputes every kind's artifact, dependency closure, and exact model
commitment. A concrete implementation must bind `Receipt` to the admitted
repository observation mechanism. -/
structure LandingAuthority (family : ProfileFamily) where
  Receipt : Type
  receipt : Receipt
  sourceWindowQ : String
  sourceWindowNonempty : sourceWindowQ.isEmpty = false
  familyRootQ : String
  familyRootNonempty : familyRootQ.isEmpty = false
  RealizesFamilyRoot : ProfileFamily → String → Receipt → Prop
  familyRootWitness : RealizesFamilyRoot family familyRootQ receipt
  modelQ : ProfileKind → String
  modelQNonempty : ∀ kind, (modelQ kind).isEmpty = false
  observation : (kind : ProfileKind) → LandingObservation
  ObservedAtMain : LandingObservation → Receipt → Prop
  observationWitness :
    ∀ kind, ObservedAtMain (observation kind) receipt
  observationSound :
    ∀ kind, ObservedAtMain (observation kind) receipt →
      (observation kind).expectedKind = kind ∧
      (observation kind).observedMainCommitQ = sourceWindowQ ∧
      (observation kind).observedModelQ = modelQ kind
  RealizesExactModel :
    (kind : ProfileKind) →
    Residua.RCC.StepExecModel.Model → ArtifactPin → Prop
  realizationSound :
    ∀ kind model pin, RealizesExactModel kind model pin →
      pin.kind = kind ∧
      pin.mainCommitQ = sourceWindowQ ∧
      pin.modelQ = modelQ kind

/-- Only an installed family may be presented as the repository-backed
Conflux composition. The underlying formal family remains available for
candidate proofs, but it does not inhabit this structure without five landing
witnesses. -/
structure InstalledProfileFamily where
  family : ProfileFamily
  authority : LandingAuthority family
  pin : (kind : ProfileKind) → ArtifactPin
  pinKind : ∀ kind, (pin kind).kind = kind
  pinSourceWindow : ∀ kind, (pin kind).mainCommitQ = authority.sourceWindowQ
  pinModel : ∀ kind, (pin kind).modelQ = authority.modelQ kind
  realizationAdmitted :
    ∀ kind,
      authority.RealizesExactModel kind (family.componentModel kind) (pin kind)
  landingAdmitted :
    ∀ kind, pinMatches (pin kind) (authority.observation kind)

namespace InstalledProfileFamily

def compositeModel (installedFamily : InstalledProfileFamily) :=
  installedFamily.family.compositeModel

theorem compositeProfile (installedFamily : InstalledProfileFamily) :
    Residua.RCC.StepExecModel.Profile installedFamily.compositeModel :=
  installedFamily.family.compositeProfile

/-- A stage label is not runtime evidence. This predicate is named as a claim
about all pins and deliberately does not construct a live binding. -/
def allPinsClaimLiveStage (installedFamily : InstalledProfileFamily) : Prop :=
  ∀ kind, (installedFamily.pin kind).stage = .liveBound

theorem live_stage_claim_still_only_has_landing_evidence
    (installedFamily : InstalledProfileFamily)
    (_claim : installedFamily.allPinsClaimLiveStage) (kind : ProfileKind) :
    pinMatches (installedFamily.pin kind)
      (installedFamily.authority.observation kind) :=
  installedFamily.landingAdmitted kind

theorem all_profiles_share_one_source_window
    (installedFamily : InstalledProfileFamily) (left right : ProfileKind) :
    (installedFamily.pin left).mainCommitQ =
      (installedFamily.pin right).mainCommitQ := by
  rw [installedFamily.pinSourceWindow left, installedFamily.pinSourceWindow right]

theorem installed_profile_binds_exact_model_commitment
    (installedFamily : InstalledProfileFamily) (kind : ProfileKind) :
    (installedFamily.pin kind).modelQ =
      (installedFamily.authority.observation kind).observedModelQ := by
  rw [installedFamily.pinModel kind,
      (installedFamily.authority.observationSound kind
        (installedFamily.authority.observationWitness kind)).2.2]

theorem installed_profile_carries_exact_component_realization
    (installedFamily : InstalledProfileFamily) (kind : ProfileKind) :
    installedFamily.authority.RealizesExactModel kind
      (installedFamily.family.componentModel kind)
      (installedFamily.pin kind) :=
  installedFamily.realizationAdmitted kind

theorem installed_family_root_is_bound_to_exact_family
    (installedFamily : InstalledProfileFamily) :
    installedFamily.authority.RealizesFamilyRoot installedFamily.family
      installedFamily.authority.familyRootQ
      installedFamily.authority.receipt :=
  installedFamily.authority.familyRootWitness

end InstalledProfileFamily

end Residua.Conflux.ProfileInstallationGate
