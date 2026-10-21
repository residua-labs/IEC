import Conflux.ProfileInstallationGate
import RCC.RC1DurableTrace

/-!
# Conflux profile family / RCC RC-1 realization contract

The five MST-NF profiles supply the typed step vocabulary. RCC RC-1 remains
the closure engine and the sole branch scheduler. This module states the
conditional realization contract between them without claiming that a landed
profile family already has a production history/store realization.

The construction is deliberately parameterized by an installed profile
family, a sealed-snapshot projection, an RC-1 execution, a verdict adapter,
and selected-edge realization coverage. None of those authorities is
manufactured here, and a landing receipt is not treated as a live binding.
-/

namespace Residua.Conflux.RCCCompositeSeam

open Residua.Conflux.MSTNFComposition
open Residua.Conflux.ProfileInstallationGate
open Residua.RCC
open Residua.RCC.ClosurePrerequisites
open Residua.RCC.RelativeCompleteClosure
open Residua.RCC.RC1StepMSTBinding
open Residua.RCC.RC1StepVerdictAdapter
open Residua.RCC.RC1DurableTrace

/-! ## Typed candidate event identities -/

inductive DurableAddressKind where
  | event
  | occurrence
  deriving DecidableEq, Repr

structure DurableAddress (kind : DurableAddressKind) where
  value : String
  nonempty : value.isEmpty = false
  deriving Repr

abbrev EventQ := DurableAddress .event
abbrev OccurrenceQ := DurableAddress .occurrence

/-! ## Institutional coordinates are projections of the sealed RCC snapshot -/

/--
`policyQ` and `cutQ` are not ambient strings.  They are deterministic
projections of RC-1's already sealed source window; epoch and assumption root
are projected from their corresponding sealed FC-1 coordinates.

The projection requires faithful typed encodings of each declared semantic
coordinate. Canonical-byte codecs, digest collision handling and live source
authority remain later AddressKernel/installation obligations.
-/
structure InstitutionalSnapshotProjection
    {State : Type}
    (C : ClosureContext State) where
  Policy : Type
  Cut : Type
  epochQ : C.Epoch → String
  assumptionRootQ : C.AssumptionRoot → String
  policyAt :
    FinalizedSourceWindow C.SourceAuthority C.Watermark C.Partition → Policy
  cutAt :
    FinalizedSourceWindow C.SourceAuthority C.Watermark C.Partition → Cut
  policyQ : Policy → String
  cutQ : Cut → String
  epochQNonempty : ∀ value, (epochQ value).isEmpty = false
  assumptionRootQNonempty :
    ∀ value, (assumptionRootQ value).isEmpty = false
  policyQNonempty : ∀ value, (policyQ value).isEmpty = false
  cutQNonempty : ∀ value, (cutQ value).isEmpty = false
  epochQFaithful : ∀ {left right}, epochQ left = epochQ right → left = right
  assumptionRootQFaithful :
    ∀ {left right}, assumptionRootQ left = assumptionRootQ right → left = right
  policyQFaithful : ∀ {left right}, policyQ left = policyQ right → left = right
  cutQFaithful : ∀ {left right}, cutQ left = cutQ right → left = right

def InstitutionalSnapshotProjection.coordinatesAt
    {State : Type}
    {C : ClosureContext State}
    (projection : InstitutionalSnapshotProjection C)
    (state : State) : InstitutionalCoordinates :=
  let coordinates := (C.snapshotAt state).coordinates
  { epochQ := projection.epochQ coordinates.epoch
    policyQ := projection.policyQ (projection.policyAt coordinates.sourceWindow)
    cutQ := projection.cutQ (projection.cutAt coordinates.sourceWindow)
    assumptionRootQ := projection.assumptionRootQ coordinates.assumptionRoot }

theorem InstitutionalSnapshotProjection.coordinates_nonempty
    {State : Type}
    {C : ClosureContext State}
    (projection : InstitutionalSnapshotProjection C)
    (state : State) :
    (projection.coordinatesAt state).epochQ.isEmpty = false ∧
      (projection.coordinatesAt state).policyQ.isEmpty = false ∧
      (projection.coordinatesAt state).cutQ.isEmpty = false ∧
      (projection.coordinatesAt state).assumptionRootQ.isEmpty = false := by
  exact
    ⟨projection.epochQNonempty _, projection.policyQNonempty _,
      projection.cutQNonempty _, projection.assumptionRootQNonempty _⟩

/-! ## Profile realization of one RC-1 advance -/

structure CompositeSettledEvent
    (F : ProfileFamily)
    {State : Type}
    (C : ClosureContext State) where
  profileClass : F.TaggedClass
  representative : F.TaggedRep
  preHead : C.HistoryHead
  postHead : C.HistoryHead

/-- Faithful address codec for the currently available class/representative
preimages. This is not yet the full occurrence/judgment/receipt envelope. -/
structure EventIdentityCodec (F : ProfileFamily) where
  eventQ : F.TaggedClass → F.TaggedRep → EventQ
  occurrenceQ : F.TaggedClass → OccurrenceQ
  eventQFaithful :
    ∀ {leftClass rightClass leftRep rightRep},
      eventQ leftClass leftRep = eventQ rightClass rightRep →
        leftClass = rightClass ∧ leftRep = rightRep
  occurrenceQFaithful :
    ∀ {left right}, occurrenceQ left = occurrenceQ right → left = right

/--
The only new realization data. `rawOfAdvance` is indexed by the exact RC-1
packet. `eventOfClass` is constrained to project to the composite profile's
`sigma`. The candidate application fixes its post-head to the next sealed
history head while authoritative RCC history remains an open residue.
-/
structure CompositeStepBinding
    (installed : InstalledProfileFamily)
    {State : Type}
    (C : ClosureContext State)
    (projection : InstitutionalSnapshotProjection C) where
  rawOfAdvance :
    {before after : State} →
      AdvancePacket C before after → installed.family.TaggedRaw
  evidenceOfRaw :
    (before : State) → installed.family.TaggedRaw →
      (C.adapter.index.world before).Evidence
  rawBindsAdvanceEvidence :
    ∀ {before after : State} (packet : AdvancePacket C before after),
      evidenceOfRaw before (rawOfAdvance packet) =
        C.advanceEvidenceAt before before after
  rawCoordinatesBound :
    ∀ {before after : State} (packet : AdvancePacket C before after),
      let raw := rawOfAdvance packet
      match raw.1 with
      | .belief => installed.family.rawCoordinates raw.1 raw.2 = none
      | _ =>
          installed.family.rawCoordinates raw.1 raw.2 =
            some (projection.coordinatesAt before)
  eventOfClass :
    installed.family.TaggedClass →
      Option (CompositeSettledEvent installed.family C)
  eventClassExact :
    ∀ {cls event}, eventOfClass cls = some event → event.profileClass = cls
  sigmaProjects :
    ∀ cls,
      Option.map CompositeSettledEvent.representative (eventOfClass cls) =
        installed.compositeModel.sigma cls
  identityCodec : EventIdentityCodec installed.family
  admittedEventOfSettled :
    (before : State) → CompositeSettledEvent installed.family C →
      (C.adapter.index.world before).AdmittedEvent
  eventBindsAdvanceAdmission :
    ∀ {before after : State} (packet : AdvancePacket C before after)
      (event : CompositeSettledEvent installed.family C),
      eventOfClass
          (installed.compositeModel.q (rawOfAdvance packet)) = some event →
        admittedEventOfSettled before event =
          C.advanceEventAt before before after
  settled : CompositeSettledEvent installed.family C → Prop
  candidateApplyRepresentative : State → installed.family.TaggedRep → State
  candidateHistoryEventQs : State → List EventQ
  applicationBindsHistory :
    ∀ (before : State) (event : CompositeSettledEvent installed.family C),
      candidateHistoryEventQs
          (candidateApplyRepresentative before event.representative) =
        candidateHistoryEventQs before ++
          [identityCodec.eventQ event.profileClass event.representative]
  applicationBindsPostHead :
    ∀ (before : State) (event : CompositeSettledEvent installed.family C),
      event.postHead =
        (C.snapshotAt
          (candidateApplyRepresentative before
            event.representative)).coordinates.historyHead

namespace CompositeStepBinding

def classOf
    {installed : InstalledProfileFamily}
    {State : Type}
    {C : ClosureContext State}
    {projection : InstitutionalSnapshotProjection C}
    (binding : CompositeStepBinding installed C projection)
    {before after : State}
    (packet : AdvancePacket C before after) : installed.family.TaggedClass :=
  installed.compositeModel.q (binding.rawOfAdvance packet)

def surface
    {installed : InstalledProfileFamily}
    {State : Type}
    {C : ClosureContext State}
    {projection : InstitutionalSnapshotProjection C}
    (binding : CompositeStepBinding installed C projection) : StepSurface C where
  StepClass := installed.family.TaggedClass
  SettledEvent := CompositeSettledEvent installed.family C
  classOf := binding.classOf
  active := installed.compositeModel.active
  admitted := installed.compositeModel.admissible
  sigma := binding.eventOfClass
  preHead := CompositeSettledEvent.preHead
  settled := binding.settled
  append := fun before event after =>
    after = binding.candidateApplyRepresentative before event.representative

/-- Quotient formation retains the declared institutional projection computed
from the before-state snapshot. BeliefNF remains intrinsic. Source authority
for policy/cut is a separately named open residue. -/
theorem class_coordinates_bound
    {installed : InstalledProfileFamily}
    {State : Type}
    {C : ClosureContext State}
    {projection : InstitutionalSnapshotProjection C}
    (binding : CompositeStepBinding installed C projection)
    {before after : State}
    (packet : AdvancePacket C before after) :
    let raw := binding.rawOfAdvance packet
    let cls := binding.classOf packet
    match raw.1 with
    | .belief => installed.family.classCoordinates cls.1 cls.2 = none
    | _ =>
        installed.family.classCoordinates cls.1 cls.2 =
          some (projection.coordinatesAt before) := by
  have preserved :
      installed.family.rawCoordinates
          (binding.rawOfAdvance packet).1 (binding.rawOfAdvance packet).2 =
        installed.family.classCoordinates
          (binding.classOf packet).1 (binding.classOf packet).2 := by
    simpa [classOf, InstalledProfileFamily.compositeModel] using
    installed.family.quotient_preserves_institutional_coordinates
      (binding.rawOfAdvance packet)
  have bound := binding.rawCoordinatesBound packet
  cases kind : (binding.rawOfAdvance packet).1 <;>
    simp only [kind] at bound ⊢ <;>
    exact preserved.symm.trans bound

/-- A selected event is the exact profile representative selected by
`sigma`; the event wrapper cannot substitute another tagged representative. -/
theorem event_projects_exact_sigma
    {installed : InstalledProfileFamily}
    {State : Type}
    {C : ClosureContext State}
    {projection : InstitutionalSnapshotProjection C}
    (binding : CompositeStepBinding installed C projection)
    {cls : installed.family.TaggedClass}
    {event : CompositeSettledEvent installed.family C}
    (selected : binding.eventOfClass cls = some event) :
    installed.compositeModel.sigma cls = some event.representative := by
  have projected := binding.sigmaProjects cls
  rw [selected] at projected
  simpa using projected.symm

/-- An append witness is definitionally the instance-supplied candidate
application and fixes its post-head to the sealed after-state. The authoritative
RCC history relation remains a separately named open residue. -/
theorem append_binds_state_history_and_post_head
    {installed : InstalledProfileFamily}
    {State : Type}
    {C : ClosureContext State}
    {projection : InstitutionalSnapshotProjection C}
    (binding : CompositeStepBinding installed C projection)
    {before after : State}
    {event : CompositeSettledEvent installed.family C}
    (appended : binding.surface.append before event after) :
    after = binding.candidateApplyRepresentative before event.representative ∧
      binding.candidateHistoryEventQs after =
        binding.candidateHistoryEventQs before ++
          [binding.identityCodec.eventQ event.profileClass event.representative] ∧
      event.postHead = (C.snapshotAt after).coordinates.historyHead := by
  have stateExact :
      after = binding.candidateApplyRepresentative before event.representative :=
    appended
  subst after
  exact
    ⟨rfl, binding.applicationBindsHistory before event,
      binding.applicationBindsPostHead before event⟩

end CompositeStepBinding

/-! ## Exact package consumed by RCC RC-1 -/

/-- Installed profile outcomes are translated to the closed RC-1 verdict
vocabulary by one explicit commuting bridge. The adapter's raw carrier,
quotient, class evaluator, rho and sigma are therefore not independently
invented. -/
structure ProfileVerdictTranslation
    (installed : InstalledProfileFamily)
    {State : Type}
    {C : ClosureContext State}
    {projection : InstitutionalSnapshotProjection C}
    (step : CompositeStepBinding installed C projection) where
  translate :
    installed.family.TaggedOutcome →
      StepVerdictModel.Outcome step.surface.SettledEvent
        installed.family.TaggedResidue
  admittedIffAccepted :
    ∀ cls,
      installed.compositeModel.admissible cls = true ↔
        ∃ event,
          translate (installed.compositeModel.evalClass cls) =
            .accepted event
  representativeIffAccepted :
    ∀ cls event,
      step.eventOfClass cls = some event ↔
        translate (installed.compositeModel.evalClass cls) =
          .accepted event
  residueTotality :
    ∀ cls,
      installed.compositeModel.active cls = true →
      installed.compositeModel.admissible cls = false →
      ∃ residue,
        installed.compositeModel.rho cls = some residue ∧
          (translate (installed.compositeModel.evalClass cls) = .reject residue ∨
           translate (installed.compositeModel.evalClass cls) = .await residue ∨
           translate (installed.compositeModel.evalClass cls) = .reepoch residue ∨
           translate (installed.compositeModel.evalClass cls) = .fatal residue)

def ProfileVerdictTranslation.adapter
    {installed : InstalledProfileFamily}
    {State : Type}
    {C : ClosureContext State}
    {projection : InstitutionalSnapshotProjection C}
    {step : CompositeStepBinding installed C projection}
    (translation : ProfileVerdictTranslation installed step) :
    Adapter C step.surface where
  Raw := installed.family.TaggedRaw
  Residue := installed.family.TaggedResidue
  q := installed.compositeModel.q
  evalRaw := fun raw => translation.translate (installed.compositeModel.evalRaw raw)
  evalClass := fun cls =>
    translation.translate (installed.compositeModel.evalClass cls)
  rho := installed.compositeModel.rho
  quotient_factorization := by
    intro raw
    exact congrArg translation.translate
      (installed.compositeProfile.quotient_factorization raw)
  admitted_iff_accepted := translation.admittedIffAccepted
  representative_iff_accepted := translation.representativeIffAccepted
  residue_totality := translation.residueTotality

/--
An installed family participates in RC-1 only after the instance supplies the
real RC-1 execution, verdict coherence, and coverage of every selected edge by
a settled append.  This is not constructible from installation pins alone.
-/
structure RC1Instance
    {W : WakeSystem}
    {C : ClosureContext W.State}
    (K : RC1BranchKernel W C) where
  installed : InstalledProfileFamily
  projection : InstitutionalSnapshotProjection C
  step : CompositeStepBinding installed C projection
  execution : RC1Execution K
  verdictTranslation : ProfileVerdictTranslation installed step
  coverage : SelectedAdvanceRealizationCoverage K step.surface

namespace RC1Instance

/-- The headline is the existing RCC theorem, specialized to the supplied
profile-related surface. It does not weaken `GlobalEpochClosed`, invent a
second scheduler, or discharge the open authority residues below. -/
theorem core_transition_iff_durable_accepted_trace_and_closed
    {W : WakeSystem}
    {C : ClosureContext W.State}
    {K : RC1BranchKernel W C}
    (realization : RC1Instance K)
    {start finish : W.State} :
    (ProofCarryingOutcome.coreObject K.toBranchSystem).D start finish ↔
      ∃ (trace : DurableTrace K realization.step.surface start finish)
        (verdicts : List realization.step.surface.SettledEvent),
        Nonempty
            (DurableTrace.AcceptedVerdictTrace
              realization.verdictTranslation.adapter trace verdicts) ∧
          GlobalEpochClosed C finish :=
  rc1_core_transition_iff_durable_accepted_trace_and_closed
    realization.execution realization.step.surface realization.coverage

/-- A landing declaration cannot by itself construct this RC-1 instance:
selected-edge durable coverage remains an explicit field. -/
theorem selected_advance_requires_supplied_rc1_realization
    {W : WakeSystem}
    {C : ClosureContext W.State}
    {K : RC1BranchKernel W C}
    (realization : RC1Instance K)
    {before after : W.State}
    (edge : ProofCarryingTrace.SelectedAdvance K.toBranchSystem before after) :
    Nonempty
      (BoundAdvance realization.step.surface edge.advance.certificate) :=
  realization.coverage.cover edge

end RC1Instance

/-! The remaining authority boundaries are values in the formal vocabulary,
not prose-only TODOs. A subsequent realization must eliminate each one rather
than reinterpreting this conditional contract as live. -/
inductive SeamResidue where
  | policyCutSourceBindingUnadmitted
  | profilePayloadRealizationUnadmitted
  | occurrenceJudgmentReceiptEnvelopeUnadmitted
  | rccHistoryAuthorityUnadmitted
  | concreteSettlementAuthorityUnadmitted
  deriving DecidableEq, Repr

def openResidues : List SeamResidue :=
  [.policyCutSourceBindingUnadmitted,
   .profilePayloadRealizationUnadmitted,
   .occurrenceJudgmentReceiptEnvelopeUnadmitted,
   .rccHistoryAuthorityUnadmitted,
   .concreteSettlementAuthorityUnadmitted]

structure CandidateStatus where
  rc1KernelReused : Bool
  installedFamilyRequired : Bool
  declaredProjectionComputedFromSealedSnapshot : Bool
  policyCutSourceBinding : Bool
  selectedAdvanceCoverageRequired : Bool
  durableVerdictCoherenceRequired : Bool
  coordinateCodecFaithful : Bool
  classRepresentativeEventCodecFaithful : Bool
  occurrenceJudgmentReceiptEnvelopeBound : Bool
  profilePayloadRealizationBound : Bool
  installedTransitionAuthorityBound : Bool
  rccHistoryAuthorityBound : Bool
  concreteAppendAuthorityBound : Bool
  liveFamilyBound : Bool
  scmCorrespondence : Bool
  closureClaim : Bool
  deriving DecidableEq, Repr

def candidateStatus : CandidateStatus where
  rc1KernelReused := true
  installedFamilyRequired := true
  declaredProjectionComputedFromSealedSnapshot := true
  policyCutSourceBinding := false
  selectedAdvanceCoverageRequired := true
  durableVerdictCoherenceRequired := true
  coordinateCodecFaithful := true
  classRepresentativeEventCodecFaithful := true
  occurrenceJudgmentReceiptEnvelopeBound := false
  profilePayloadRealizationBound := false
  installedTransitionAuthorityBound := false
  rccHistoryAuthorityBound := false
  concreteAppendAuthorityBound := false
  liveFamilyBound := false
  scmCorrespondence := false
  closureClaim := false

theorem candidate_does_not_claim_live_or_global_closure :
    candidateStatus.policyCutSourceBinding = false ∧
      candidateStatus.occurrenceJudgmentReceiptEnvelopeBound = false ∧
      candidateStatus.profilePayloadRealizationBound = false ∧
      candidateStatus.installedTransitionAuthorityBound = false ∧
      candidateStatus.rccHistoryAuthorityBound = false ∧
      candidateStatus.concreteAppendAuthorityBound = false ∧
      candidateStatus.liveFamilyBound = false ∧
      candidateStatus.scmCorrespondence = false ∧
      candidateStatus.closureClaim = false := by
  decide

end Residua.Conflux.RCCCompositeSeam
