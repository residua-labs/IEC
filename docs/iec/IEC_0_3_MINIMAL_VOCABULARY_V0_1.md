# IEC-0.3 — Minimal Vocabulary Freeze r2

```text
status=candidate_for_freeze  closure_claim=0  disposition=Reepoch
basis=IEC-0.2@f77b8fa3ae48 (FREEZE GRANTED)  next=IEC-0.4 (LOCKED)
```

## Boundary

IEC-0.3 freezes only names required by the five operational countermodels and the sole IEC-0.2 survivor. Naming is not primitive creation. MST-NF `q/a/σ/ρ`, Residua `Capability`, `Identity_q`, receipts, and RCC `History/Projection/Reepoch/GroundedEvidence` are reused, not redefined. No parallel `AgentRef` is introduced.

A Phase-0 name is admitted only when it records a distinction that would otherwise collapse. Every admitted name therefore carries `required_by` and `deletion_residue`. Every relation or predicate also states its default transitivity, composition rule, and revocation behavior; silence on those properties is not a freeze.

## Terms

<!-- IEC-0.3-TERM-INVENTORY:BEGIN -->
[
  "IEC-VOC-001",
  "IEC-VOC-002",
  "IEC-VOC-003",
  "IEC-VOC-004",
  "IEC-VOC-005",
  "IEC-VOC-006",
  "IEC-VOC-007",
  "IEC-VOC-008",
  "IEC-VOC-009",
  "IEC-VOC-010",
  "IEC-VOC-011",
  "IEC-VOC-012"
]
<!-- IEC-0.3-TERM-INVENTORY:END -->

| Term | Kind | Required by | Deletion residue |
|---|---|---|---|
| `InstitutionRef` | opaque_reference | IEC-OCM-005, IEC-PROFILE-DISPOSITION-001 | institution-lineage references become indistinguishable from agent/resource qrefs at the IEC vocabulary boundary |
| `InstitutionalCut` | context | IEC-OCM-005, IEC-PROFILE-DISPOSITION-001 | one plan can replay across unrelated institution lineages, epochs, history heads, or cut events |
| `CutRelation` | open_relation_family | IEC-OCM-005 | successor and new-genesis collapse into either a closed enum or an untyped target tag |
| `Successor` | distinguished_cut_relation | IEC-OCM-005 | explicitly dispositioned continuation conflates with new institutional existence |
| `NewGenesis` | distinguished_cut_relation | IEC-OCM-005 | new institutional existence conflates with inherited continuation |
| `LiveFrontier` | supplied_carrier | IEC-OCM-005, IEC-RC-LIVE-FRONTIER-COMPLETENESS-001 | the disposition domain and the distinction between supplied items and omitted items cannot be stated |
| `FrontierItem` | carrier_member | IEC-OCM-005, IEC-RC-LIVE-FRONTIER-COMPLETENESS-001 | a live identity, capability, obligation, resource, effect, or dispute has no common carrier position |
| `CouplingEdge` | relation | IEC-OCM-005, IEC-RC-LIVE-FRONTIER-COMPLETENESS-001 | cross-item consistency constraints and omitted dependencies become invisible |
| `DispositionPlan` | relation | IEC-OCM-005 | exit or fork disposition collapses into death, abandonment, or an untyped bulk transfer |
| `DispositionEdge` | relation_member | IEC-OCM-005 | no per-item outcome, target, and evidence-reference relation remains checkable |
| `EvidencePolicy` | policy_parameter | IEC-OCM-001, IEC-PROFILE-DISPOSITION-001 | green verdicts or merely nonempty evidence references silently become binding institutional judgments |
| `LiveFrontierCompleteness` | open_predicate | IEC-RC-LIVE-FRONTIER-COMPLETENESS-001 | totality over supplied items masquerades as proof that no relevant live item or dependency was omitted |

## Relation, composition, and revocation laws

| Term | Transitivity | Composition | Revocation / historical treatment |
|---|---|---|---|
| `InstitutionRef` | `not_applicable` | `only_through_explicit_typed_relation` | `reference_history_persists_current_recognition_or_validity_separate` |
| `InstitutionalCut` | `not_applicable` | `input_to_live_frontier_and_disposition_profile_only` | `cut_event_history_persists_current_validity_may_retract_or_reepoch` |
| `CutRelation` | `nontransitive_by_default` | `only_by_explicit_lineage_transport_theorem` | `current_validity_retractable_historical_claim_persists` |
| `Successor` | `nontransitive_by_default` | `requires_explicit_successor_chain_proof` | `current_validity_retractable_history_persists` |
| `NewGenesis` | `nontransitive_by_default` | `no_authority_or_state_bridge_without_explicit_relation` | `existence_event_history_persists_current_recognition_may_retract` |
| `LiveFrontier` | `not_applicable` | `consumed_by_DispositionPlan_and_LiveFrontierCompleteness` | `snapshot_supersedable_historical_evidence_persists` |
| `FrontierItem` | `not_applicable` | `only_through_explicit_CouplingEdge_and_DispositionEdge` | `liveness_may_end_identity_and_history_persist` |
| `CouplingEdge` | `nontransitive_and_nonsymmetric_by_default` | `only_through_explicit_constraint_semantics` | `edge_invalidatable_and_omission_reopens_completeness` |
| `DispositionPlan` | `not_applicable` | `evaluated_only_by_named_profile_sequential_plans_require_explicit_history_transport` | `rejectable_supersedable_or_historically_admitted_current_validity_separate` |
| `DispositionEdge` | `not_applicable` | `only_through_EvidencePolicy_and_CouplingEdge_checks` | `edge_validity_retractable_historical_admission_persists` |
| `EvidencePolicy` | `nontransitive_by_default` | `explicit_policy_conjunction_or_bridge_only_green_cannot_synthesize_policy` | `policy_change_requires_revalidation_or_Reepoch` |
| `LiveFrontierCompleteness` | `not_applicable` | `precondition_for_disposition_not_derived_from_plan_totality` | `judgment_retractable_when_omission_or_dependency_is_discovered` |

The defaults above are deliberately conservative:

```text
CutRelation / Successor / NewGenesis
  are non-transitive unless an explicit lineage-transport proof composes them.

CouplingEdge
  is neither transitive nor symmetric unless its constraint semantics says so.

EvidencePolicy
  does not propagate merely because one institution accepted evidence.

Historical occurrence
  is preserved when current validity, recognition, or policy is retracted.
```

`Successor` does not inherit all state or authority. `NewGenesis` records new existence and does not inherit old authority. `LiveFrontier` is supplied; supply is not completeness. `FrontierItem` kinds and disposition outcomes remain policy-open. The six item kinds and `same_successor` constraint used by IEC-0.2 are anti-vacuity fixtures, not a universal institutional ontology.

## Existing bounded disposition profile

```text
q = cut_q + frontier_q + plan_q + evidence_policy_q
a = cut/form/domain/evidence/totality/exclusivity/coupling checks
σ = admitted plan + cut-relative target projection
ρ = one typed failure payload
open precondition = LiveFrontierCompleteness
```

This is a bounded profile, not a new IEC primitive, Lean theorem, general representation theorem, or Residua constructor.

## Canonicalization

```text
InstitutionalLiveFrontierCompleteness → LiveFrontierCompleteness
InstitutionalLineageDisposition → DispositionPlan + existing q/a/σ/ρ profile
Disposer → optional role/policy data + scoped Capability
Authority(I) → forbidden ambient alias; use scoped Capability provenance
```

## Fourteen frontier-omission reports

<!-- IEC-0.3-EVIDENCE-INVENTORY:BEGIN -->
[
  "IEC-LF-EVIDENCE-001",
  "IEC-LF-EVIDENCE-002",
  "IEC-LF-EVIDENCE-003",
  "IEC-LF-EVIDENCE-004",
  "IEC-LF-EVIDENCE-005",
  "IEC-LF-EVIDENCE-006",
  "IEC-LF-EVIDENCE-007",
  "IEC-LF-EVIDENCE-008",
  "IEC-LF-EVIDENCE-009",
  "IEC-LF-EVIDENCE-010",
  "IEC-LF-EVIDENCE-011",
  "IEC-LF-EVIDENCE-012",
  "IEC-LF-EVIDENCE-013",
  "IEC-LF-EVIDENCE-014"
]
<!-- IEC-0.3-EVIDENCE-INVENTORY:END -->

Each row records an architect-ledger report that a capability existed but was absent from a decision-time planning frontier. Row 004 also preserves the later correction: the first Conflux statement overstated coverage; the mapping found 3 exact and 12 NONE primitives, so the capability is partial-corrected.

The registry replays the source-bound reports. It does **not** independently re-run every underlying implementation, proof, PR, or cross-repository artifact. The fourteen reports instantiate the pressure behind `LiveFrontierCompleteness`; they do not prove completeness and do not mint fourteen concepts.

`CapabilityRegister` is the **designated domain self-instance** over capability/knowledge claims. IEC-0.3 does not claim that the register has been implemented or activated. Its local rule that unregistered capabilities are unavailable for planning is house policy, not universal IEC law.

## Forbidden coercions

<!-- IEC-0.3-NONCOERCION-INVENTORY:BEGIN -->
[
  "IEC-NC-001",
  "IEC-NC-002",
  "IEC-NC-003",
  "IEC-NC-004",
  "IEC-NC-005",
  "IEC-NC-006",
  "IEC-NC-007",
  "IEC-NC-008",
  "IEC-NC-009",
  "IEC-NC-010",
  "IEC-NC-011",
  "IEC-NC-012",
  "IEC-NC-013",
  "IEC-NC-014"
]
<!-- IEC-0.3-NONCOERCION-INVENTORY:END -->

```text
Identity_q ↛ Capability
InstitutionRef ↛ ambient/global Authority
Member/Role/Identity/Knowledge/Documentation ↛ Capability
DisposerRole ↛ MayDispose ↛ Disposed ↛ LineageDispositionComplete
Declaration ↛ Capability/Effect/Receipt/current effectiveness
GreenVerdict ↛ BindingInstitutionalJudgment
Termination/Disconnection ↛ InstitutionalExit
NewGenesis ↛ inherited authority
Successor ↛ inheritance of all state
Disposition totality over supplied frontier ↛ LiveFrontierCompleteness
local institutional closure ↛ ecology closure
repository house rule ↛ IEC universal law
```

## Deferred

<!-- IEC-0.3-DEFERRED-INVENTORY:BEGIN -->
[
  "Institution",
  "Authority",
  "Jurisdiction",
  "Recognition",
  "Treaty",
  "Federation",
  "InstitutionalExit",
  "InstitutionalFork",
  "Conflict",
  "Civilization",
  "World",
  "Disposer",
  "IEC-NF"
]
<!-- IEC-0.3-DEFERRED-INVENTORY:END -->

`Conflict` remains `IEC-PRESSURE-CONFLICT-001`. No rich ontology, IEC-NF, new MST-NF axis, Lean theorem, Residua behavior, or RCC discharge is claimed. `LiveFrontierCompleteness` remains OPEN.
