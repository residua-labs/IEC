import Conflux.IECAdapter

namespace Residua.Conflux.IECAdapter.Tests

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
  expectedItemQ := "item-q"
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

def boundedChecks : BoundedChecks where
  cutBound := true
  frontierForm := true
  planDomain := true
  total := true
  exclusive := true
  couplingCompatible := true

def outerChecks : OuterChecks where
  liveFrontierComplete := true
  basisCurrent := true

def admittedClass : AttemptClass where
  cut := cut
  frontierQ := "frontier-q"
  planQ := "plan-q"
  evidencePolicy := evidencePolicy
  evidence := evidence
  grounding := grounding
  targetProjectionQ := "target-projection-q"
  checks := boundedChecks
  outer := outerChecks

def raw : RawAttempt where
  cut := cut
  frontierQ := admittedClass.frontierQ
  planQ := admittedClass.planQ
  evidencePolicy := evidencePolicy
  evidence := evidence
  grounding := grounding
  targetProjectionQ := admittedClass.targetProjectionQ
  checks := boundedChecks
  outer := outerChecks
  observationMetadata := "nonsemantic-observation-a"

theorem lawful_plan_admits :
    admissible algorithms admittedClass = true := by
  decide

theorem raw_q_drops_observation_metadata :
    (model algorithms).q raw =
      (model algorithms).q { raw with
        observationMetadata := "nonsemantic-observation-b" } := by
  rfl

def incompleteFrontier : AttemptClass :=
  { admittedClass with
    outer := { outerChecks with liveFrontierComplete := false } }

theorem supplied_totality_cannot_close_omission :
    decide algorithms incompleteFrontier =
      .await .liveFrontierCompletenessOpen := by
  decide

def staleBasis : AttemptClass :=
  { admittedClass with outer := { outerChecks with basisCurrent := false } }

theorem stale_basis_is_not_profile_rho :
    decide algorithms staleBasis = .reepoch .staleBasis ∧
      residue algorithms staleBasis = none := by
  decide

def forgedCutAddress : AttemptClass :=
  { admittedClass with cut := { cut with cutQ := "forged-cut-q" } }

theorem forged_cut_is_outer_address_refusal :
    decide algorithms forgedCutAddress =
      .addressRefuse .cutAddressMismatch := by
  decide

def greenButWrongItem : AttemptClass :=
  { admittedClass with evidence := { evidence with itemQ := "other-item-q" } }

theorem green_does_not_synthesize_binding :
    decide algorithms greenButWrongItem = .residue .evidenceRejected := by
  decide

def ungroundedEvidence : AttemptClass :=
  { admittedClass with grounding := { grounding with receiptChainQ := "" } }

theorem evidence_reference_requires_grounding :
    decide algorithms ungroundedEvidence = .residue .evidenceRejected := by
  decide

def stalePolicy : AttemptClass :=
  { admittedClass with
    cut := { cut with institutionPolicyQ := "stale-policy-q" } }

theorem stale_policy_is_a_different_class : stalePolicy ≠ admittedClass := by
  decide

theorem all_seven_profile_residues_are_reachable :
    decide algorithms
      { admittedClass with checks := { boundedChecks with cutBound := false } } =
        .residue .cutUnbound ∧
    decide algorithms
      { admittedClass with checks := { boundedChecks with frontierForm := false } } =
        .residue .frontierMalformed ∧
    decide algorithms
      { admittedClass with checks := { boundedChecks with planDomain := false } } =
        .residue .planDomainMismatch ∧
    decide algorithms greenButWrongItem = .residue .evidenceRejected ∧
    decide algorithms
      { admittedClass with checks := { boundedChecks with total := false } } =
        .residue .totalityFailure ∧
    decide algorithms
      { admittedClass with checks := { boundedChecks with exclusive := false } } =
        .residue .exclusivityFailure ∧
    decide algorithms
      { admittedClass with
          checks := { boundedChecks with couplingCompatible := false } } =
        .residue .couplingIncompatible := by
  decide

#print axioms profile
#print axioms quotient_preserves_coordinates
#print axioms metadata_aliases_factor
#print axioms supplied_totality_does_not_imply_completeness
#print axioms stale_basis_reepochs
#print axioms green_without_exact_binding_is_refused
#print axioms coordinate_movement_changes_class
#print axioms supplied_totality_cannot_close_omission
#print axioms stale_basis_is_not_profile_rho
#print axioms forged_cut_is_outer_address_refusal
#print axioms green_does_not_synthesize_binding
#print axioms evidence_reference_requires_grounding
#print axioms all_seven_profile_residues_are_reachable

end Residua.Conflux.IECAdapter.Tests
