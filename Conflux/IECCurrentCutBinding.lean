import Conflux.RCCCompositeSeam
import Conflux.IECAdapter

/-!
# Conflux binding of the current IEC cut to an RCC snapshot

The RCC snapshot does not contain ambient `policyQ` or `cutQ` strings.  This
module therefore selects one typed cut entry through the snapshot's sealed
address-registry coordinate and requires that entry to retain the exact sealed
source and proposal windows.  The IEC cut then binds epoch, history head,
policy, cut address, and assumption root to that selected entry and snapshot.

This is an abstract registry contract.  It does not manufacture a concrete
AddressKernel, a live source observation, frontier completeness, SCM
correspondence, or live closure.
-/

namespace Residua.Conflux.IECCurrentCutBinding

open Residua.Conflux.IECAdapter
open Residua.Conflux.MSTNFComposition
open Residua.Conflux.RCCCompositeSeam
open Residua.RCC.ClosurePrerequisites
open Residua.RCC.RelativeCompleteClosure

/--
The sealed RCC address registry selects exactly one IEC cut entry.  Address
injectivity prevents two distinct policy/cut entries from sharing the same
registered address.
-/
structure InstitutionalCutRegistryKernel
    {State : Type}
    (C : ClosureContext State)
    (EntryAddress : Type) where
  Entry : Type
  currentEntry : C.AddressRegistry → Entry
  sourceWindowOf :
    Entry → FinalizedSourceWindow C.SourceAuthority C.Watermark C.Partition
  proposalWindowOf : Entry → C.ProposalWindow
  cutOf : Entry → InstitutionalCut
  addressOf : Entry → EntryAddress
  registeredAddress : C.AddressRegistry → EntryAddress
  registryExact :
    ∀ registry, addressOf (currentEntry registry) = registeredAddress registry
  addressInjective :
    ∀ {left right}, addressOf left = addressOf right → left = right

def InstitutionalCutRegistryKernel.currentEntryAt
    {State : Type}
    {C : ClosureContext State}
    {EntryAddress : Type}
    (registry : InstitutionalCutRegistryKernel C EntryAddress)
    (state : State) : registry.Entry :=
  registry.currentEntry (C.snapshotAt state).coordinates.addressRegistry

def InstitutionalCutRegistryKernel.currentCutAt
    {State : Type}
    {C : ClosureContext State}
    {EntryAddress : Type}
    (registry : InstitutionalCutRegistryKernel C EntryAddress)
    (state : State) : InstitutionalCut :=
  registry.cutOf (registry.currentEntryAt state)

/-- Faithful encodings of RCC coordinates already carried by the snapshot. -/
structure CoordinateCodec
    {State : Type}
    (C : ClosureContext State) where
  epochQ : C.Epoch → String
  historyHeadQ : C.HistoryHead → String
  assumptionRootQ : C.AssumptionRoot → String
  epochQNonempty : ∀ value, (epochQ value).isEmpty = false
  historyHeadQNonempty : ∀ value, (historyHeadQ value).isEmpty = false
  assumptionRootQNonempty :
    ∀ value, (assumptionRootQ value).isEmpty = false
  epochQFaithful : ∀ {left right}, epochQ left = epochQ right → left = right
  historyHeadQFaithful :
    ∀ {left right}, historyHeadQ left = historyHeadQ right → left = right
  assumptionRootQFaithful :
    ∀ {left right},
      assumptionRootQ left = assumptionRootQ right → left = right

/--
One registry-selected IEC cut at one exact RCC snapshot.  The source and
proposal windows are equal as typed values, not merely as caller labels.
-/
structure CurrentCutAt
    {State : Type}
    {C : ClosureContext State}
    {EntryAddress : Type}
    (registry : InstitutionalCutRegistryKernel C EntryAddress)
    (projection : InstitutionalSnapshotProjection C)
    (codec : CoordinateCodec C)
    (algorithms : Algorithms)
    (state : State) : Prop where
  sourceWindowExact :
    registry.sourceWindowOf (registry.currentEntryAt state) =
      (C.snapshotAt state).coordinates.sourceWindow
  proposalWindowExact :
    registry.proposalWindowOf (registry.currentEntryAt state) =
      (C.snapshotAt state).coordinates.proposalWindow
  cutAddressExact :
    (registry.currentCutAt state).cutQ =
      algorithms.cutQ (registry.currentCutAt state).preimage
  epochExact :
    (registry.currentCutAt state).preimage.sourceEpochQ =
      codec.epochQ (C.snapshotAt state).coordinates.epoch
  historyHeadExact :
    (registry.currentCutAt state).preimage.sourceHistoryHeadQ =
      codec.historyHeadQ (C.snapshotAt state).coordinates.historyHead
  assumptionRootExact :
    (registry.currentCutAt state).assumptionRootQ =
      codec.assumptionRootQ (C.snapshotAt state).coordinates.assumptionRoot
  projectionEpochExact :
    projection.epochQ (C.snapshotAt state).coordinates.epoch =
      codec.epochQ (C.snapshotAt state).coordinates.epoch
  projectionAssumptionRootExact :
    projection.assumptionRootQ (C.snapshotAt state).coordinates.assumptionRoot =
      codec.assumptionRootQ (C.snapshotAt state).coordinates.assumptionRoot
  policyExact :
    projection.policyQ
        (projection.policyAt (C.snapshotAt state).coordinates.sourceWindow) =
      (registry.currentCutAt state).institutionPolicyQ
  cutExact :
    projection.cutQ
        (projection.cutAt (C.snapshotAt state).coordinates.sourceWindow) =
      (registry.currentCutAt state).cutQ
  policyNamed : (registry.currentCutAt state).institutionPolicyQ ≠ ""

namespace CurrentCutAt

private theorem institutional_coordinates_eq
    {left right : InstitutionalCoordinates}
    (epoch : left.epochQ = right.epochQ)
    (policy : left.policyQ = right.policyQ)
    (cut : left.cutQ = right.cutQ)
    (assumption : left.assumptionRootQ = right.assumptionRootQ) :
    left = right := by
  cases left
  cases right
  simp_all

theorem coordinates_exact
    {State : Type}
    {C : ClosureContext State}
    {EntryAddress : Type}
    {registry : InstitutionalCutRegistryKernel C EntryAddress}
    {projection : InstitutionalSnapshotProjection C}
    {codec : CoordinateCodec C}
    {algorithms : Algorithms}
    {state : State}
    (current : CurrentCutAt registry projection codec algorithms state) :
    (registry.currentCutAt state).coordinates = projection.coordinatesAt state := by
  exact institutional_coordinates_eq
    (current.epochExact.trans current.projectionEpochExact.symm)
    current.policyExact.symm
    current.cutExact.symm
    (current.assumptionRootExact.trans
      current.projectionAssumptionRootExact.symm)

theorem cut_address_bound
    {State : Type}
    {C : ClosureContext State}
    {EntryAddress : Type}
    {registry : InstitutionalCutRegistryKernel C EntryAddress}
    {projection : InstitutionalSnapshotProjection C}
    {codec : CoordinateCodec C}
    {algorithms : Algorithms}
    {state : State}
    (current : CurrentCutAt registry projection codec algorithms state) :
    (registry.currentCutAt state).cutQ =
      algorithms.cutQ (registry.currentCutAt state).preimage :=
  current.cutAddressExact

end CurrentCutAt

/-- An IEC attempt is at the current cut only when it carries that exact cut. -/
structure AttemptAt
    {State : Type}
    {C : ClosureContext State}
    {EntryAddress : Type}
    {registry : InstitutionalCutRegistryKernel C EntryAddress}
    {projection : InstitutionalSnapshotProjection C}
    {codec : CoordinateCodec C}
    {algorithms : Algorithms}
    {state : State}
    (current : CurrentCutAt registry projection codec algorithms state)
    (attempt : AttemptClass) : Prop where
  cutExact : attempt.cut = registry.currentCutAt state
  basisCurrent : attempt.outer.basisCurrent = true

namespace AttemptAt

theorem class_coordinates_exact
    {State : Type}
    {C : ClosureContext State}
    {EntryAddress : Type}
    {registry : InstitutionalCutRegistryKernel C EntryAddress}
    {projection : InstitutionalSnapshotProjection C}
    {codec : CoordinateCodec C}
    {algorithms : Algorithms}
    {state : State}
    {current : CurrentCutAt registry projection codec algorithms state}
    {attempt : AttemptClass}
    (bound : AttemptAt current attempt) :
    IECAdapter.classCoordinates attempt = some (projection.coordinatesAt state) := by
  simp only [IECAdapter.classCoordinates]
  rw [bound.cutExact, current.coordinates_exact]

theorem cut_address_bound
    {State : Type}
    {C : ClosureContext State}
    {EntryAddress : Type}
    {registry : InstitutionalCutRegistryKernel C EntryAddress}
    {projection : InstitutionalSnapshotProjection C}
    {codec : CoordinateCodec C}
    {algorithms : Algorithms}
    {state : State}
    {current : CurrentCutAt registry projection codec algorithms state}
    {attempt : AttemptClass}
    (bound : AttemptAt current attempt) : CutAddressBound algorithms attempt := by
  unfold CutAddressBound
  rw [bound.cutExact]
  exact current.cutAddressExact

end AttemptAt

/-- A policy change under the declared entry semantics must move the entry
address; retaining the old registered address cannot hide it. -/
theorem policy_change_requires_entry_address_change
    {State : Type}
    {C : ClosureContext State}
    {EntryAddress : Type}
    (registry : InstitutionalCutRegistryKernel C EntryAddress)
    {left right : registry.Entry}
    (changed :
      (registry.cutOf left).institutionPolicyQ ≠
        (registry.cutOf right).institutionPolicyQ) :
    registry.addressOf left ≠ registry.addressOf right := by
  intro sameAddress
  exact changed (congrArg (fun entry => (registry.cutOf entry).institutionPolicyQ)
    (registry.addressInjective sameAddress))

structure CandidateStatus where
  registrySelectedEntry : Bool
  typedSourceWindowExact : Bool
  typedProposalWindowExact : Bool
  currentCutCoordinatesExact : Bool
  concreteRegistryAddressKernel : Bool
  concreteIECCutAddressKernel : Bool
  liveSourceAuthority : Bool
  proposalUniverseComplete : Bool
  liveFrontierComplete : Bool
  basisCurrentAuthority : Bool
  scmCorrespondence : Bool
  installedLiveBinding : Bool
  closureClaim : Bool
  deriving DecidableEq, Repr

def candidateStatus : CandidateStatus where
  registrySelectedEntry := true
  typedSourceWindowExact := true
  typedProposalWindowExact := true
  currentCutCoordinatesExact := true
  concreteRegistryAddressKernel := false
  concreteIECCutAddressKernel := false
  liveSourceAuthority := false
  proposalUniverseComplete := false
  liveFrontierComplete := false
  basisCurrentAuthority := false
  scmCorrespondence := false
  installedLiveBinding := false
  closureClaim := false

theorem candidate_does_not_claim_live_current_cut_or_closure :
    candidateStatus.concreteRegistryAddressKernel = false ∧
      candidateStatus.concreteIECCutAddressKernel = false ∧
      candidateStatus.liveSourceAuthority = false ∧
      candidateStatus.proposalUniverseComplete = false ∧
      candidateStatus.liveFrontierComplete = false ∧
      candidateStatus.basisCurrentAuthority = false ∧
      candidateStatus.scmCorrespondence = false ∧
      candidateStatus.installedLiveBinding = false ∧
      candidateStatus.closureClaim = false := by
  decide

end Residua.Conflux.IECCurrentCutBinding
