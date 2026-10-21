import RCC.StepExecModel
import RCC.FormalCore

/-!
# Conflux as the composite runtime of MST-NF-derived profiles

This file fixes the dependency direction used by the Conflux integration:

* MST-NF is the only theoretical root;
* TaskNF, BeliefNF, BA-NF, IEC, and Conflux collaboration are typed profiles;
* Conflux is their tagged runtime composition, not a replacement theory;
* RCC consumes the composite state as its normalization/closure engine;
* a Residua live binding is a separate implementation obligation.

The module is intentionally parametric. It does not claim that branch-only
TaskNF, BeliefNF, or BA-NF artifacts are already present on `main`, and it does
not manufacture a live closure certificate.

Prelude-only Lean 4.14; no Mathlib, `sorry`, custom axioms, or executable host
semantics.
-/

namespace Residua.Conflux.MSTNFComposition

open Residua.RCC
open Residua.RCC.StepExecModel

/-! ## 1. The closed family of MST-NF profile roles -/

/-- RCC is deliberately absent: it is the closure engine over this family,
not a sixth admission profile. -/
inductive ProfileKind where
  | task
  | belief
  | beliefAdmission
  | institution
  | collaboration
  deriving DecidableEq, Repr

/-- IEC coordinates are explicit inputs to every profile class. No profile
may recover them from ambient process state. -/
structure InstitutionalCoordinates where
  epochQ : String
  policyQ : String
  cutQ : String
  assumptionRootQ : String
  deriving DecidableEq, Repr

/-- A family of MST-NF step models sharing one typed dispatch surface.

Each component has the ordinary `q/a/sigma/rho` laws from
`RCC.StepExecModel.Profile`. The extra context equation records that quotient
formation cannot silently change IEC coordinates. -/
structure ProfileFamily where
  Raw : ProfileKind → Type
  Class : ProfileKind → Type
  Rep : ProfileKind → Type
  Residue : ProfileKind → Type
  Outcome : ProfileKind → Type
  q : (kind : ProfileKind) → Raw kind → Class kind
  evalRaw : (kind : ProfileKind) → Raw kind → Outcome kind
  evalClass : (kind : ProfileKind) → Class kind → Outcome kind
  active : (kind : ProfileKind) → Class kind → Bool
  admissible : (kind : ProfileKind) → Class kind → Bool
  rho : (kind : ProfileKind) → Class kind → Option (Residue kind)
  sigma : (kind : ProfileKind) → Class kind → Option (Rep kind)
  rawCoordinates :
    (kind : ProfileKind) → Raw kind → Option InstitutionalCoordinates
  classCoordinates :
    (kind : ProfileKind) → Class kind → Option InstitutionalCoordinates
  quotientFactorization :
    ∀ kind raw, evalRaw kind raw = evalClass kind (q kind raw)
  quotientPreservesCoordinates :
    ∀ kind raw, rawCoordinates kind raw = classCoordinates kind (q kind raw)
  beliefIdentityIsIntrinsic :
    ∀ raw, rawCoordinates .belief raw = none
  beliefAdmissionIsContextual :
    ∀ raw, ∃ coordinates, rawCoordinates .beliefAdmission raw = some coordinates
  taskAdmissionIsContextual :
    ∀ raw, ∃ coordinates, rawCoordinates .task raw = some coordinates
  institutionIsContextual :
    ∀ raw, ∃ coordinates, rawCoordinates .institution raw = some coordinates
  collaborationIsContextual :
    ∀ raw, ∃ coordinates, rawCoordinates .collaboration raw = some coordinates
  representativeImpliesAdmissible :
    ∀ kind cls rep, sigma kind cls = some rep → admissible kind cls = true
  residueTotality :
    ∀ kind cls,
      active kind cls = true →
      admissible kind cls = false →
      ∃ residue, rho kind cls = some residue
  representativePrecision :
    ∀ kind cls,
      active kind cls = true →
      admissible kind cls = true →
      ∃ rep, sigma kind cls = some rep

namespace ProfileFamily

/-- Every family member is independently an ordinary MST-NF step model. -/
def componentModel (F : ProfileFamily) (kind : ProfileKind) : Model where
  Raw := F.Raw kind
  Class := F.Class kind
  Rep := F.Rep kind
  Residue := F.Residue kind
  Outcome := F.Outcome kind
  q := F.q kind
  evalRaw := F.evalRaw kind
  evalClass := F.evalClass kind
  active := F.active kind
  admissible := F.admissible kind
  rho := F.rho kind
  sigma := F.sigma kind

/-- Family laws discharge the standard MST-NF profile obligations component by
component. -/
theorem componentProfile (F : ProfileFamily) (kind : ProfileKind) :
    Profile (F.componentModel kind) where
  quotient_factorization := F.quotientFactorization kind
  representative_implies_admissible := F.representativeImpliesAdmissible kind
  residue_totality := F.residueTotality kind
  representative_precision := F.representativePrecision kind

end ProfileFamily

/-! A named, reusable bundle for the five typed MST-NF role profiles.  The
bundle contains no runtime or authority fields; Conflux/RCC/IEC layers may
consume it without turning a role conjunction into a second theory root. -/
structure MSTNFRoleProfiles (F : ProfileFamily) : Prop where
  task : Profile (F.componentModel .task)
  belief : Profile (F.componentModel .belief)
  beliefAdmission : Profile (F.componentModel .beliefAdmission)
  institution : Profile (F.componentModel .institution)
  collaboration : Profile (F.componentModel .collaboration)

namespace MSTNFRoleProfiles

def ofFamily (F : ProfileFamily) : MSTNFRoleProfiles F := {
  task := ProfileFamily.componentProfile F .task
  belief := ProfileFamily.componentProfile F .belief
  beliefAdmission := ProfileFamily.componentProfile F .beliefAdmission
  institution := ProfileFamily.componentProfile F .institution
  collaboration := ProfileFamily.componentProfile F .collaboration
}

theorem toConjunction (F : ProfileFamily) (roles : MSTNFRoleProfiles F) :
    Profile (F.componentModel .task) ∧
      Profile (F.componentModel .belief) ∧
      Profile (F.componentModel .beliefAdmission) ∧
      Profile (F.componentModel .institution) ∧
      Profile (F.componentModel .collaboration) :=
  ⟨roles.task, roles.belief, roles.beliefAdmission, roles.institution,
    roles.collaboration⟩

end MSTNFRoleProfiles

namespace ProfileFamily

abbrev TaggedRaw (F : ProfileFamily) := Sigma F.Raw
abbrev TaggedClass (F : ProfileFamily) := Sigma F.Class
abbrev TaggedRep (F : ProfileFamily) := Sigma F.Rep
abbrev TaggedResidue (F : ProfileFamily) := Sigma F.Residue
abbrev TaggedOutcome (F : ProfileFamily) := Sigma F.Outcome

/-- Values from different profile kinds cannot become equal inside a tagged
carrier. This is the type-level refusal of cross-profile naked-digest reuse. -/
theorem taggedValuesOfDifferentKindsNe
    {Carrier : ProfileKind → Type}
    {leftKind rightKind : ProfileKind}
    (different : leftKind ≠ rightKind)
    (left : Carrier leftKind)
    (right : Carrier rightKind) :
    (⟨leftKind, left⟩ : Sigma Carrier) ≠ ⟨rightKind, right⟩ := by
  intro equal
  exact different (congrArg Sigma.fst equal)

/-- Conflux combines profiles by a typed dependent sum. The tag is part of
the class, representative, residue, and outcome; no naked digest or untyped
payload can cross a profile boundary. -/
def compositeModel (F : ProfileFamily) : Model where
  Raw := F.TaggedRaw
  Class := F.TaggedClass
  Rep := F.TaggedRep
  Residue := F.TaggedResidue
  Outcome := F.TaggedOutcome
  q := fun raw => ⟨raw.1, F.q raw.1 raw.2⟩
  evalRaw := fun raw => ⟨raw.1, F.evalRaw raw.1 raw.2⟩
  evalClass := fun cls => ⟨cls.1, F.evalClass cls.1 cls.2⟩
  active := fun cls => F.active cls.1 cls.2
  admissible := fun cls => F.admissible cls.1 cls.2
  rho := fun cls => (F.rho cls.1 cls.2).map (Sigma.mk cls.1)
  sigma := fun cls => (F.sigma cls.1 cls.2).map (Sigma.mk cls.1)

/-- The composite Conflux dispatcher is itself an MST-NF profile; this is a
closure property of typed composition, not a new primitive. -/
theorem compositeProfile (F : ProfileFamily) : Profile F.compositeModel where
  quotient_factorization := by
    intro raw
    rcases raw with ⟨kind, raw⟩
    simp only [compositeModel]
    exact Sigma.ext rfl (heq_of_eq (F.quotientFactorization kind raw))
  representative_implies_admissible := by
    intro cls rep hrep
    rcases cls with ⟨kind, cls⟩
    simp only [compositeModel] at hrep ⊢
    cases hsigma : F.sigma kind cls with
    | none => simp [hsigma] at hrep
    | some componentRep =>
        exact F.representativeImpliesAdmissible kind cls componentRep hsigma
  residue_totality := by
    intro cls hactive hnot
    rcases cls with ⟨kind, cls⟩
    simp only [compositeModel] at hactive hnot ⊢
    obtain ⟨residue, hresidue⟩ := F.residueTotality kind cls hactive hnot
    exact ⟨⟨kind, residue⟩, by simp [hresidue]⟩
  representative_precision := by
    intro cls hactive hadmitted
    rcases cls with ⟨kind, cls⟩
    simp only [compositeModel] at hactive hadmitted ⊢
    obtain ⟨rep, hrep⟩ :=
      F.representativePrecision kind cls hactive hadmitted
    exact ⟨⟨kind, rep⟩, by simp [hrep]⟩

/-- The profile tag of a quotient result is exactly the tag of its raw input. -/
theorem quotient_preserves_kind (F : ProfileFamily) (raw : F.TaggedRaw) :
    (F.compositeModel.q raw).1 = raw.1 := rfl

/-- Optional IEC coordinates also factor through the composite quotient.
BeliefNF uses `none` because canonical belief identity is intrinsic; contextual
profiles use `some coordinates`. -/
theorem quotient_preserves_institutional_coordinates
    (F : ProfileFamily) (raw : F.TaggedRaw) :
    F.rawCoordinates raw.1 raw.2 =
      F.classCoordinates (F.compositeModel.q raw).1 (F.compositeModel.q raw).2 := by
  rcases raw with ⟨kind, raw⟩
  exact F.quotientPreservesCoordinates kind raw

/-! The complete role bundle and the tagged Conflux dispatcher remain on the
same MST-NF profile layer. RCC is intentionally absent from `ProfileKind`; it
consumes the resulting carrier as an engine rather than adding a sixth profile
role. -/
theorem composite_profile_and_roles_are_mstnf (F : ProfileFamily) :
    Profile F.compositeModel ∧ MSTNFRoleProfiles F :=
  ⟨ProfileFamily.compositeProfile F, MSTNFRoleProfiles.ofFamily F⟩

end ProfileFamily

/-! The MST-NF root is one atomic carrier.  Conflux/RCC/IEC consumers should
not have to accept a composite-profile proof and a role-family proof as two
caller-swappable values.  Both proofs are still projections of the same
`ProfileFamily`, but this carrier makes that root explicit at the unified
runtime boundary. -/
structure MSTNFRootExactChain (F : ProfileFamily) : Prop where
  composite : Profile F.compositeModel
  roles : MSTNFRoleProfiles F

namespace MSTNFRootExactChain

def ofFamily (F : ProfileFamily) : MSTNFRootExactChain F :=
  { composite := ProfileFamily.compositeProfile F
    roles := MSTNFRoleProfiles.ofFamily F }

theorem composite_exact (root : MSTNFRootExactChain F) :
    Profile F.compositeModel :=
  root.composite

theorem roles_exact (root : MSTNFRootExactChain F) :
    MSTNFRoleProfiles F :=
  root.roles

end MSTNFRootExactChain

/-! ## 2. Typed seams; completion is not admission -/

/-- Cross-profile conversions are explicit seams. In particular a TaskNF
representative first becomes evidence; it cannot inhabit the BA-NF
representative type. -/
structure SeamInterface (F : ProfileFamily) where
  TaskEvidence : Type
  taskSettlementToEvidence : F.Rep .task → TaskEvidence
  beliefAdmissionAttempt :
    TaskEvidence →
    F.Rep .belief →
    InstitutionalCoordinates →
    F.Raw .beliefAdmission
  admittedBeliefToStoreAttempt :
    F.Rep .beliefAdmission → F.Raw .collaboration

/-! ## 3. IEC-governed composite closure, normalized by RCC -/

/-- The seven independent facets whose conjunction defines one Conflux
composite fixed point. -/
structure ClosureFacets where
  State : Type
  taskFixed : State → Prop
  beliefFixed : State → Prop
  beliefAdmissionFixed : State → Prop
  institutionalCutCurrent : State → Prop
  collaborationFixed : State → Prop
  seamsExact : State → Prop
  globalIntentCovered : State → Prop

namespace ClosureFacets

def closed (F : ClosureFacets) (state : F.State) : Prop :=
  F.taskFixed state ∧
  F.beliefFixed state ∧
  F.beliefAdmissionFixed state ∧
  F.institutionalCutCurrent state ∧
  F.collaborationFixed state ∧
  F.seamsExact state ∧
  F.globalIntentCovered state

theorem task_of_closed (F : ClosureFacets) {state : F.State}
    (h : F.closed state) : F.taskFixed state := h.1

theorem belief_of_closed (F : ClosureFacets) {state : F.State}
    (h : F.closed state) : F.beliefFixed state := h.2.1

theorem beliefAdmission_of_closed (F : ClosureFacets) {state : F.State}
    (h : F.closed state) : F.beliefAdmissionFixed state := h.2.2.1

theorem institutionalCut_of_closed (F : ClosureFacets) {state : F.State}
    (h : F.closed state) : F.institutionalCutCurrent state := h.2.2.2.1

theorem collaboration_of_closed (F : ClosureFacets) {state : F.State}
    (h : F.closed state) : F.collaborationFixed state := h.2.2.2.2.1

theorem seams_of_closed (F : ClosureFacets) {state : F.State}
    (h : F.closed state) : F.seamsExact state := h.2.2.2.2.2.1

theorem intent_of_closed (F : ClosureFacets) {state : F.State}
    (h : F.closed state) : F.globalIntentCovered state := h.2.2.2.2.2.2

end ClosureFacets

/-- RCC executable data for the composite carrier. Only the RCC engine owns
normalization; Conflux supplies the carrier, facets, measure, and open step. -/
structure RCCClosureContract where
  facets : ClosureFacets
  measure : facets.State → Nat
  closedDecidable : (state : facets.State) → Decidable (facets.closed state)
  stepOpen :
    (state : facets.State) →
    ¬ facets.closed state →
    OpenStepResult facets.State measure state

namespace RCCClosureContract

def toRCCExec (C : RCCClosureContract) : Exec where
  State := C.facets.State
  measure := C.measure
  closed := C.facets.closed
  closedDecidable := C.closedDecidable
  stepOpen := C.stepOpen

/-- The composite CoreObject fixed points are exact by the generic RCC bridge.
No Conflux-specific fixed-point axiom is introduced. -/
theorem coreExact (C : RCCClosureContract) :
    (coreObject C.toRCCExec).Exact :=
  core_exact C.toRCCExec

end RCCClosureContract

/-! ## 4. Residua is a separately bound live instance -/

/-- These are implementation obligations, not facts proved by mere profile
composition. A value of this type must be supplied by admitted live evidence.
The explicit RCC state index prevents the obligation bundle from being reused
at a different closed state without dependent transport. -/
structure ResiduaLiveBinding
    (F : ProfileFamily)
    (C : RCCClosureContract)
    (classOf : C.facets.State → F.TaggedClass)
    (state : C.facets.State) where
  scmOwnsProfileSemantics : Prop
  scmOwnershipWitness : scmOwnsProfileSemantics
  frozenDualSubstrateExecutesSCM : Prop
  substrateBindingWitness : frozenDualSubstrateExecutesSCM
  admittedHistoryImplementsCompositeSigma : Prop
  historyBindingWitness : admittedHistoryImplementsCompositeSigma
  iecCoordinatesBoundToCurrentCut : Prop
  iecBindingWitness : iecCoordinatesBoundToCurrentCut
  /-- The live contract consumes closure at its indexed state, rather than
  carrying an unrelated state-free RCC obligation. -/
  rccClosedStateExact : C.facets.closed state
  rccCompositeClassAdmitted :
    F.compositeModel.admissible (classOf state) = true
  rccConsumesTheBoundCompositeState : Prop
  rccBindingWitness : rccConsumesTheBoundCompositeState

end Residua.Conflux.MSTNFComposition
