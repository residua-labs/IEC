import Conflux.IECCurrentCutBinding

namespace Residua.Conflux.IECCurrentCutBinding.Tests

open Residua.Conflux.IECAdapter
open Residua.Conflux.RCCCompositeSeam
open Residua.RCC.RelativeCompleteClosure

theorem same_registered_address_selects_same_entry
    {State EntryAddress : Type}
    {C : ClosureContext State}
    (registry : InstitutionalCutRegistryKernel C EntryAddress)
    {left right : C.AddressRegistry}
    (sameRegistered :
      registry.registeredAddress left = registry.registeredAddress right) :
    registry.currentEntry left = registry.currentEntry right := by
  apply registry.addressInjective
  calc
    registry.addressOf (registry.currentEntry left) =
        registry.registeredAddress left := registry.registryExact left
    _ = registry.registeredAddress right := sameRegistered
    _ = registry.addressOf (registry.currentEntry right) :=
      (registry.registryExact right).symm

theorem stale_source_window_entry_is_refused
    {State EntryAddress : Type}
    {C : ClosureContext State}
    {registry : InstitutionalCutRegistryKernel C EntryAddress}
    {projection : InstitutionalSnapshotProjection C}
    {codec : CoordinateCodec C}
    {algorithms : Algorithms}
    {state : State}
    (current : CurrentCutAt registry projection codec algorithms state)
    (stale :
      registry.sourceWindowOf (registry.currentEntryAt state) ≠
        (C.snapshotAt state).coordinates.sourceWindow) : False :=
  stale current.sourceWindowExact

theorem stale_proposal_window_entry_is_refused
    {State EntryAddress : Type}
    {C : ClosureContext State}
    {registry : InstitutionalCutRegistryKernel C EntryAddress}
    {projection : InstitutionalSnapshotProjection C}
    {codec : CoordinateCodec C}
    {algorithms : Algorithms}
    {state : State}
    (current : CurrentCutAt registry projection codec algorithms state)
    (stale :
      registry.proposalWindowOf (registry.currentEntryAt state) ≠
        (C.snapshotAt state).coordinates.proposalWindow) : False :=
  stale current.proposalWindowExact

theorem forged_cut_address_is_refused
    {State EntryAddress : Type}
    {C : ClosureContext State}
    {registry : InstitutionalCutRegistryKernel C EntryAddress}
    {projection : InstitutionalSnapshotProjection C}
    {codec : CoordinateCodec C}
    {algorithms : Algorithms}
    {state : State}
    (current : CurrentCutAt registry projection codec algorithms state)
    (forged :
      (registry.currentCutAt state).cutQ ≠
        algorithms.cutQ (registry.currentCutAt state).preimage) : False :=
  forged current.cutAddressExact

theorem stale_epoch_is_refused
    {State EntryAddress : Type}
    {C : ClosureContext State}
    {registry : InstitutionalCutRegistryKernel C EntryAddress}
    {projection : InstitutionalSnapshotProjection C}
    {codec : CoordinateCodec C}
    {algorithms : Algorithms}
    {state : State}
    (current : CurrentCutAt registry projection codec algorithms state)
    (stale :
      (registry.currentCutAt state).preimage.sourceEpochQ ≠
        codec.epochQ (C.snapshotAt state).coordinates.epoch) : False :=
  stale current.epochExact

theorem stale_history_head_is_refused
    {State EntryAddress : Type}
    {C : ClosureContext State}
    {registry : InstitutionalCutRegistryKernel C EntryAddress}
    {projection : InstitutionalSnapshotProjection C}
    {codec : CoordinateCodec C}
    {algorithms : Algorithms}
    {state : State}
    (current : CurrentCutAt registry projection codec algorithms state)
    (stale :
      (registry.currentCutAt state).preimage.sourceHistoryHeadQ ≠
        codec.historyHeadQ (C.snapshotAt state).coordinates.historyHead) : False :=
  stale current.historyHeadExact

theorem stale_assumption_root_is_refused
    {State EntryAddress : Type}
    {C : ClosureContext State}
    {registry : InstitutionalCutRegistryKernel C EntryAddress}
    {projection : InstitutionalSnapshotProjection C}
    {codec : CoordinateCodec C}
    {algorithms : Algorithms}
    {state : State}
    (current : CurrentCutAt registry projection codec algorithms state)
    (stale :
      (registry.currentCutAt state).assumptionRootQ ≠
        codec.assumptionRootQ (C.snapshotAt state).coordinates.assumptionRoot) :
    False :=
  stale current.assumptionRootExact

theorem substituted_policy_projection_is_refused
    {State EntryAddress : Type}
    {C : ClosureContext State}
    {registry : InstitutionalCutRegistryKernel C EntryAddress}
    {projection : InstitutionalSnapshotProjection C}
    {codec : CoordinateCodec C}
    {algorithms : Algorithms}
    {state : State}
    (current : CurrentCutAt registry projection codec algorithms state)
    (substituted :
      projection.policyQ
          (projection.policyAt (C.snapshotAt state).coordinates.sourceWindow) ≠
        (registry.currentCutAt state).institutionPolicyQ) : False :=
  substituted current.policyExact

theorem substituted_cut_projection_is_refused
    {State EntryAddress : Type}
    {C : ClosureContext State}
    {registry : InstitutionalCutRegistryKernel C EntryAddress}
    {projection : InstitutionalSnapshotProjection C}
    {codec : CoordinateCodec C}
    {algorithms : Algorithms}
    {state : State}
    (current : CurrentCutAt registry projection codec algorithms state)
    (substituted :
      projection.cutQ
          (projection.cutAt (C.snapshotAt state).coordinates.sourceWindow) ≠
        (registry.currentCutAt state).cutQ) : False :=
  substituted current.cutExact

theorem substituted_attempt_cut_is_refused
    {State EntryAddress : Type}
    {C : ClosureContext State}
    {registry : InstitutionalCutRegistryKernel C EntryAddress}
    {projection : InstitutionalSnapshotProjection C}
    {codec : CoordinateCodec C}
    {algorithms : Algorithms}
    {state : State}
    {current : CurrentCutAt registry projection codec algorithms state}
    {attempt : AttemptClass}
    (bound : AttemptAt current attempt)
    (substituted : attempt.cut ≠ registry.currentCutAt state) : False :=
  substituted bound.cutExact

theorem current_attempt_coordinates_are_exact
    {State EntryAddress : Type}
    {C : ClosureContext State}
    {registry : InstitutionalCutRegistryKernel C EntryAddress}
    {projection : InstitutionalSnapshotProjection C}
    {codec : CoordinateCodec C}
    {algorithms : Algorithms}
    {state : State}
    {current : CurrentCutAt registry projection codec algorithms state}
    {attempt : AttemptClass}
    (bound : AttemptAt current attempt) :
    IECAdapter.classCoordinates attempt =
      some (projection.coordinatesAt state) :=
  bound.class_coordinates_exact

theorem stale_basis_cannot_form_current_attempt
    {State EntryAddress : Type}
    {C : ClosureContext State}
    {registry : InstitutionalCutRegistryKernel C EntryAddress}
    {projection : InstitutionalSnapshotProjection C}
    {codec : CoordinateCodec C}
    {algorithms : Algorithms}
    {state : State}
    {current : CurrentCutAt registry projection codec algorithms state}
    {attempt : AttemptClass}
    (stale : attempt.outer.basisCurrent = false) :
    ¬ AttemptAt current attempt := by
  intro bound
  have impossible : false = true := stale.symm.trans bound.basisCurrent
  exact Bool.false_ne_true impossible

theorem incomplete_frontier_remains_await
    {State EntryAddress : Type}
    {C : ClosureContext State}
    {registry : InstitutionalCutRegistryKernel C EntryAddress}
    {projection : InstitutionalSnapshotProjection C}
    {codec : CoordinateCodec C}
    {algorithms : Algorithms}
    {state : State}
    {current : CurrentCutAt registry projection codec algorithms state}
    {attempt : AttemptClass}
    (bound : AttemptAt current attempt)
    (incomplete : attempt.outer.liveFrontierComplete = false) :
    IECAdapter.decide algorithms attempt =
      .await .liveFrontierCompletenessOpen := by
  unfold IECAdapter.decide IECAdapter.outerVerdict
  simp [bound.cut_address_bound, incomplete]

theorem raw_metadata_does_not_change_current_coordinates
    (raw : RawAttempt) (otherMetadata : String) :
    IECAdapter.rawCoordinates raw =
      IECAdapter.rawCoordinates
        { raw with observationMetadata := otherMetadata } := rfl

#print axioms same_registered_address_selects_same_entry
#print axioms stale_source_window_entry_is_refused
#print axioms stale_proposal_window_entry_is_refused
#print axioms forged_cut_address_is_refused
#print axioms stale_epoch_is_refused
#print axioms stale_history_head_is_refused
#print axioms stale_assumption_root_is_refused
#print axioms substituted_policy_projection_is_refused
#print axioms substituted_cut_projection_is_refused
#print axioms substituted_attempt_cut_is_refused
#print axioms current_attempt_coordinates_are_exact
#print axioms stale_basis_cannot_form_current_attempt
#print axioms incomplete_frontier_remains_await
#print axioms raw_metadata_does_not_change_current_coordinates
#print axioms policy_change_requires_entry_address_change
#print axioms candidate_does_not_claim_live_current_cut_or_closure

end Residua.Conflux.IECCurrentCutBinding.Tests
