# IEC-0.5 — RCC Dependency and Closure-Disposition Map r1

```text
status          = candidate_for_refreeze
closure_claim   = 0
disposition     = Advanced
basis           = IEC-0.4r2 @ 089cbb3d23fe5f34864dec82a039ee077ba89702 (FROZEN)
freeze ledger   = 1178ece6d7f24ea21274b666c14854dfe5a35f73
freeze bell     = 5127027450
next            = IEC-1.0 (LOCKED until IEC-0.5r2 refreeze and repository landing)
```

## Purpose

IEC-0.5 does not prove the 38 IEC targets. It maps every frozen IEC-0.4 target to the RCC obligation surface that must be satisfied before that target can be discharged, records current proof authority, derives the lawful RCC branch, and adjudicates the two open cross-line questions carried by the IEC-0.4 freeze:

1. whether admission-DAG work reuses `InstitutionalCut` rather than minting a parallel admission-point object;
2. which cut-lineage laws apply to ordinary repository admissions.

It also registers the current Residua architect/disposer seat as the first **candidate self-instance**, never as the IEC template.

## r2 Admission-DAG exact source re-pin

IEC-0.5r1 at `b15093873246f3d07fe14328495d0eab649997b4` remains a historical frozen occurrence. Its Admission-DAG
component was pinned before the ADR added verifier scheduling, classification,
proof-carrying admission, rented-`a`, and categorical-exemption analysis. Under IEC-T025
the old freeze is preserved historically; under IEC-T026 its current-use receipt is not
transported.

IEC-0.5r2 consumes the exact source cut:

```text
ref   0179ac8af4d9c6e3d9b23605cac6de678ce2bffb
blob  ef9d34faa149a735b66b23315b2b6ffb2321696d
```

RULING-005 is revalidated on that cut. Verifier work is derived from declared inputs,
and a declaration is admissible only when it is checked as a superset of actual reads.
Path taxonomy is not proof of required work; any temporary path fast lane carries a typed
unsoundness residue and a shrink obligation. This re-pin does not implement that subset
check, ratify the Admission DAG, or unlock IEC-1.0. Both exact-head receipts and repository
admission must be recomputed for r2.

## Proof authority and historical boundary

Current machine proof authority is:

```text
ref       1178ece6d7f24ea21274b666c14854dfe5a35f73
registry  residua-internal rcc conformance record RCC_FORMAL_PROOF_REGISTRY_V1.json (not included)
current discharged RCC ids:
  E6 E7 E8
```

The RCC v2 source catalog at `5da54eb12f547c8ba33191f408dbafe3fe91896b` enumerates the 107 target names and scopes, but it is not current machine discharge. Its historical snapshot recorded `E5 E6 E7 E8 RCC-13 RCC-14 RCC-25`; the same source forbids reuse after the fold until whole-chain refreeze. IEC-0.5 therefore treats only `E6/E7/E8` as current proof authority. None of the 38 IEC targets is discharged.

## Why the branch is `Advanced`

The RCC runtime priority is:

```text
Halt(live danger)
> Advanced(dispatchable work)
> Reepoch(semantic rescope)
> Await(external wake)
> Halt(stalled)
```

All 38 IEC targets have a named proof, runtime, or source-enumeration next action. There is no live-danger row and no target that requires theory growth before any work can start. The disposer-role self-instance has an external activation wake (`Klaus RATIFY`), but that one local `Await` does not freeze the 38-target dispatchable frontier.

```text
open targets       38
dispatchable       38
result             Advanced
action             dispatch_propose
closure_claim      0
```

`Advanced` means “lawful work exists.” It does not mean closed, proved, implemented, or ratified.

## Dependency-family inventory

<!-- IEC-0.5-FAMILY-INVENTORY:BEGIN -->
[
  "address_profile",
  "evidence",
  "capability_effect",
  "cut_lineage",
  "frontier"
]
<!-- IEC-0.5-FAMILY-INVENTORY:END -->

Each family file is content-bound by `IEC_RCC_TARGET_DEPENDENCY_MAP_V0_1.json`; the aggregate target array is reproduced in the top-level closure-disposition map.

## Frozen IEC target inventory

<!-- IEC-0.5-TARGET-INVENTORY:BEGIN -->
[
  "IEC-T001",
  "IEC-T002",
  "IEC-T003",
  "IEC-T004",
  "IEC-T005",
  "IEC-T006",
  "IEC-T007",
  "IEC-T008",
  "IEC-T009",
  "IEC-T010",
  "IEC-T011",
  "IEC-T012",
  "IEC-T013",
  "IEC-T014",
  "IEC-T015",
  "IEC-T016",
  "IEC-T017",
  "IEC-T018",
  "IEC-T019",
  "IEC-T020",
  "IEC-T021",
  "IEC-T022",
  "IEC-T023",
  "IEC-T024",
  "IEC-T025",
  "IEC-T026",
  "IEC-T027",
  "IEC-T028",
  "IEC-T029",
  "IEC-T030",
  "IEC-T031",
  "IEC-T032",
  "IEC-T033",
  "IEC-T034",
  "IEC-T035",
  "IEC-T036",
  "IEC-T037",
  "IEC-T038"
]
<!-- IEC-0.5-TARGET-INVENTORY:END -->

| IEC target | Name | Family | RCC dependencies | Branch | Lawful next work |
|---|---|---|---|---|---|
| `IEC-T001` | `InstitutionRefAddressKindSound` | `address_profile` | `RCC-0`, `AK-1`, `AK-3`, `AK-8`, `RCC-26` | `Advanced` | Instantiate the institution-lineage address kind, prove cross-kind refusal, and replay a collision mutant. |
| `IEC-T002` | `InstitutionalCutIdentityBinding` | `address_profile` | `RCC-0`, `AK-1`, `AK-2`, `AK-3`, `AK-10`, `RCC-16`, `RCC-17`, `RCC-47` | `Advanced` | Formalize the cut codec/factorization and run one-field omission plus stale-basis mutants. |
| `IEC-T003` | `BoundedProfileFactorization` | `address_profile` | `RCC-0`, `AK-4`, `E3`, `E4`, `M1` | `Advanced` | Prove equal profile q values factor a, sigma, and rho for the bounded disposition profile. |
| `IEC-T004` | `DispositionOutcomePartition` | `address_profile` | `E1`, `RCC-18`, `RCC-25`, `M1` | `Advanced` | Encode the exclusive Admit-or-Residue result and reject double/neither outcomes. |
| `IEC-T005` | `TypedDispositionResidueCoverage` | `address_profile` | `E1`, `RCC-18`, `ME-1`, `M1` | `Advanced` | Enumerate every named bounded-profile failure and prove total typed residue coverage. |
| `IEC-T006` | `BoundedDispositionProfileExactness` | `address_profile` | `R2`, `E1`, `E3`, `E4`, `M1`, `RCC-25` | `Advanced` | Prove soundness/completeness of the bounded profile and bind it to executable conformance. |
| `IEC-T007` | `EvidencePolicyExplicitAdmission` | `evidence` | `R2`, `R4`, `RCC-32`, `RCC-35`, `RCC-39` | `Advanced` | Define the context-indexed evidence predicate over the exact edge tuple and run rebound/forged mutants. |
| `IEC-T008` | `GreenDoesNotSynthesizeBinding` | `evidence` | `R2`, `R4`, `CM-2`, `RCC-39` | `Advanced` | Prove non-derivability of binding admission from green or nonempty evidence alone. |
| `IEC-T009` | `ConditionalForeignFactorRequirement` | `evidence` | `RCC-32`, `RCC-33`, `RCC-35`, `RCC-36` | `Advanced` | Implement one policy that requires a foreign factor, with author-only refusal and foreign-factor positive witness. |
| `IEC-T010` | `EvidenceReferenceRequiresGrounding` | `evidence` | `R2`, `R4`, `E2`, `E3`, `RCC-32`, `CM-2` | `Advanced` | Model evidence references separately from proofs and require an explicit verifier or receipt chain. |
| `IEC-T011` | `EvidencePolicyChangeRequiresRevalidation` | `evidence` | `R4`, `RCC-14`, `RCC-21`, `RCC-23`, `RCC-29` | `Advanced` | Bind admissions to policy q and prove stale-current refusal with historical preservation. |
| `IEC-T012` | `IdentityKnowledgeRoleDoNotMintCapability` | `capability_effect` | `R1`, `RCC-0`, `RCC-26`, `RCC-39` | `Advanced` | Encode typed non-coercions and require an explicit capability grant positive witness. |
| `IEC-T013` | `NoAmbientGovernanceExemption` | `capability_effect` | `R4`, `RCC-34`, `RCC-39`, `RCC-47` | `Advanced` | Apply the actor/action/resource capability predicate to governance actors and test explicit exceptions. |
| `IEC-T014` | `CapabilityEffectDispositionSeparation` | `capability_effect` | `RCC-26`, `RCC-30`, `RCC-31`, `WI-5`, `EF-1` | `Advanced` | Separate permission, occurrence, receipt, disposition, and frontier completeness in types and runtime. |
| `IEC-T015` | `RevocationBlocksFutureEffectsPreservesHistory` | `capability_effect` | `RCC-14`, `RCC-21`, `RCC-29`, `RCC-30`, `RCC-31`, `RCC-37` | `Advanced` | Prove revocation blocks future authorization while preserving admitted historical receipts. |
| `IEC-T016` | `DeclarationToEffectBinding` | `capability_effect` | `RCC-15`, `RCC-30`, `RCC-31`, `WI-5`, `WI-6` | `Advanced` | Build the declaration-to-capability-to-effect-to-observation chain and refuse unwired declarations. |
| `IEC-T017` | `CutRelationSingleTagPerTarget` | `cut_lineage` | `M1`, `RCC-42`, `RCC-43`, `RCC-45` | `Advanced` | Prove one relation tag per target at a cut and exercise a mixed-target positive control. |
| `IEC-T018` | `CutRelationCompositionIsExplicit` | `cut_lineage` | `C2`, `TA-2`, `RCC-24`, `RCC-44` | `Advanced` | Define non-transitive base relations and a separately evidenced lineage-transport composition theorem. |
| `IEC-T019` | `NewGenesisDoesNotInheritCapability` | `cut_lineage` | `RCC-26`, `RCC-29`, `RCC-37`, `RCC-44` | `Advanced` | Construct new-existence and explicit-bridge witnesses while proving no implicit capability inheritance. |
| `IEC-T020` | `SuccessorDoesNotInheritAllState` | `cut_lineage` | `C2`, `RCC-23`, `RCC-24`, `RCC-29`, `RCC-44` | `Advanced` | Prove only explicitly dispositioned items transport to a successor; reject copy-all-state. |
| `IEC-T021` | `DispositionPlanDomainExactness` | `cut_lineage` | `R5`, `E2`, `RCC-48`, `M1` | `Advanced` | Prove plan-domain equality with the supplied frontier and reject ghost/missing edges. |
| `IEC-T022` | `DispositionTotalityAndExclusiveSingleValuedness` | `cut_lineage` | `R5`, `RCC-42`, `RCC-43`, `RCC-48`, `M1` | `Advanced` | Prove totality plus exclusive single-valuedness and execute missing/double-edge mutants. |
| `IEC-T023` | `CouplingCompatibility` | `cut_lineage` | `C2`, `FC-2`, `RCC-48`, `RCC-49`, `RCC-51` | `Advanced` | Define constraint semantics for supplied coupling edges and prove compatible-plan preservation. |
| `IEC-T024` | `BoundedDispositionProfileNonVacuity` | `cut_lineage` | `RCC-19`, `E1`, `E5`, `M1`, `FC-3` | `Advanced` | Keep lawful Successor and NewGenesis positive controls plus the relation-only negative control. |
| `IEC-T025` | `HistoricalDispositionCurrentValiditySeparation` | `cut_lineage` | `RCC-14`, `RCC-21`, `RCC-29`, `RCC-53` | `Advanced` | Separate historical occurrence from current validity for relations, snapshots, edges, plans, and receipts. |
| `IEC-T026` | `StaleCutRequiresRevalidationOrReepoch` | `cut_lineage` | `RCC-16`, `RCC-21`, `RCC-23`, `RCC-29`, `RCC-47` | `Advanced` | Bind current use to the exact cut/frontier/policy basis and return typed stale residue or Reepoch. |
| `IEC-T027` | `SuppliedTotalityDoesNotImplyCompleteness` | `frontier` | `E2`, `R5`, `RCC-48`, `WI-2` | `Advanced` | Prove the two-world non-derivability result: identical supplied frontier and total plan, different omitted reality. |
| `IEC-T028` | `FrontierExtractionSoundness` | `frontier` | `R2`, `R4`, `E2`, `E3`, `WI-3` | `Advanced` | Define source support for extracted items/edges and reject invented carrier elements. |
| `IEC-T029` | `RelativeLiveFrontierCompleteness` | `frontier` | `E2`, `RCC-21`, `RCC-48`, `WI-2`, `C3` | `Advanced` | Freeze a declared source universe/relevance predicate and prove relative item plus dependency-edge coverage. |
| `IEC-T030` | `FrontierExtractionDeterminism` | `frontier` | `E3`, `E4`, `RCC-16`, `AK-4` | `Advanced` | Prove fixed history/cut/universe/context yields one frontier q and replay identical inputs. |
| `IEC-T031` | `OmissionDiscoveryRetractsCompleteness` | `frontier` | `RCC-14`, `RCC-21`, `RCC-23`, `RCC-29` | `Advanced` | Model an omission event that retracts current completeness while preserving the old judgment historically. |
| `IEC-T032` | `OmissionReopensDependentsPreservesUnrelated` | `frontier` | `RCC-14`, `RCC-21`, `C1`, `C2`, `RCC-48` | `Advanced` | Prove dependency-closed reopen/migration and preservation of dispositions with no dependency path. |
| `IEC-T033` | `CapabilityRegisterKnownReportCoverage` | `frontier` | `E2`, `E3`, `R5`, `RCC-21` | `Advanced` | Implement/query the designated 14-row self-instance while preserving instance/template separation. |
| `IEC-T034` | `CouplingEdgeNoImplicitClosure` | `frontier` | `C2`, `FC-2`, `RCC-48`, `RCC-49` | `Advanced` | Check exactly supplied or explicitly derived edges; reject invented symmetry/transitivity. |
| `IEC-T035` | `EvidencePolicyAcceptanceIsContextRelative` | `evidence` | `R4`, `RCC-29`, `RCC-37`, `C2`, `TA-2` | `Advanced` | Index acceptance by policy/institution/epoch/cut and require an explicit bridge for transport. |
| `IEC-T036` | `SequentialDispositionCompositionIsExplicit` | `cut_lineage` | `C1`, `C2`, `RCC-23`, `RCC-29`, `RCC-47`, `RCC-49` | `Advanced` | State history-transport/revalidation preconditions and reject naive unions across cuts. |
| `IEC-T037` | `FrontierItemKindIsPolicyOpen` | `frontier` | `E2`, `R1`, `RCC-24`, `M1` | `Advanced` | Admit one policy-declared seventh kind and reject a six-kind hard-coded implementation. |
| `IEC-T038` | `DispositionOutcomeFamilyIsPolicyOpen` | `cut_lineage` | `E1`, `RCC-18`, `RCC-24`, `ME-1`, `M1` | `Advanced` | Admit one policy-declared third outcome and reject a two-outcome hard-coded implementation. |

## Admission-DAG alignment rulings

<!-- IEC-0.5-ADMISSION-RULING-INVENTORY:BEGIN -->
[
  "IEC-ADMISSION-RULING-001",
  "IEC-ADMISSION-RULING-002",
  "IEC-ADMISSION-RULING-003",
  "IEC-ADMISSION-RULING-004",
  "IEC-ADMISSION-RULING-005",
  "IEC-ADMISSION-RULING-006"
]
<!-- IEC-0.5-ADMISSION-RULING-INVENTORY:END -->

```text
No new AdmissionPoint primitive.

what
  = q-addressed request content + declared operations/regions

where
  = InstitutionalCut, or a scope-narrowing projection of it

a
  = derived from what × where × active EvidencePolicy

third-tree law
  = IEC-T026 StaleCutRequiresRevalidationOrReepoch
```

An ordinary PR and an institution-level admission differ in scope, not in the need to bind a stable admission basis. Generic cut-binding, evidence-context, historical/current, and stale-cut laws apply to typed ordinary admissions. `Successor` and `NewGenesis` laws apply only when those relation values are actually used; IEC does not turn every PR into a fork.

The Admission-DAG document is a draft architecture input. Its statement that `InstitutionalCut` is the formalized “where” is accepted as a vocabulary-alignment ruling, not as theorem discharge, runtime activation, or ratification of the entire topology.

## Disposer-as-role self-instance

<!-- IEC-0.5-DISPOSER-PROPERTY-INVENTORY:BEGIN -->
[
  "IEC-DISP-001",
  "IEC-DISP-002",
  "IEC-DISP-003",
  "IEC-DISP-004",
  "IEC-DISP-005",
  "IEC-DISP-006",
  "IEC-DISP-007"
]
<!-- IEC-0.5-DISPOSER-PROPERTY-INVENTORY:END -->

The first IEC self-instance is the current Residua architect/disposer seat:

```text
role claim
  = policy-defined FrontierItem kind

identity
  = existing Identity_q

may act
  = current scoped Capability

role change context
  = InstitutionalCut

role/capability transfer or revocation
  = DispositionPlan + DispositionEdge + EvidencePolicy

historical fact
  != current role validity
```

The instance requires:

- role/capability separation;
- proposer/disposer separation for the current non-monotone governance policy;
- admitted election/assignment events rather than prose labels;
- removal that blocks future acts while preserving history;
- explicit role-holder succession without copying all capability;
- explicit, instance-relative multi-seat policy;
- external Klaus RATIFY for the exact governed-seat configuration.

Existing code provides a recognized non-proposer disposition primitive and a distinct-signer threshold verifier, but does not yet provide one admitted role registry with election/removal/succession, integrated multi-seat production disposition, or an activated governed seat. Therefore:

```text
construction branch  = Advanced
activation branch    = Await
wake                 = Klaus RATIFY
```

This `Await` is local to activation. It does not change the IEC-0.5 overall `Advanced` branch.

## Phase transition

After IEC-0.5r2 refreezes and repository-lands, the first lawful Phase-1 candidate is:

<!-- IEC-0.5-PHASE1-SLICE:BEGIN -->
[
  "IEC-T003",
  "IEC-T004",
  "IEC-T005",
  "IEC-T006",
  "IEC-T024"
]
<!-- IEC-0.5-PHASE1-SLICE:END -->

```text
IEC-1.0 Bounded Disposition Profile Formal Core

target slice:
  IEC-T003 BoundedProfileFactorization
  IEC-T004 DispositionOutcomePartition
  IEC-T005 TypedDispositionResidueCoverage
  IEC-T006 BoundedDispositionProfileExactness
  IEC-T024 BoundedDispositionProfileNonVacuity
```

This slice is chosen because IEC-0.2 already has an executable bounded diagnostic profile and countermodels; Phase 1 can normalize that existing behavior before building richer ontology.

## Deferred ontology remains unchanged

<!-- IEC-0.5-DEFERRED-INVENTORY:BEGIN -->
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
<!-- IEC-0.5-DEFERRED-INVENTORY:END -->

No rich `Institution`, ambient `Authority`, `Jurisdiction`, `Recognition`, `Treaty`, `Federation`, full Exit/Fork ontology, `Conflict`, `Civilization`, `World`, universal `Disposer`, or `IEC-NF` is promoted.

## Nonclaims

```text
mapping to an RCC target is not discharge
historical RCC snapshots are not current proof authority
Advanced is not Closed
the Admission-DAG draft is not a proof or ratification
not every PR is an institutional fork
Successor/NewGenesis are conditional relation values
the disposer seat is one Residua instance, not the IEC template
Klaus RATIFY is not machine-derived
LiveFrontierCompleteness remains open
closure_claim = 0
```

## Candidate identities

```text
target_map_q            135488879142b6209683110c106e7e097af4b591e37642fe650118732c5fc7a6
admission_alignment_q   494ee82ece991c47ed4f1ff3c63478e76a2b1a1c137646bbac1994e11679ebed
disposer_instance_q     57257dc7a669b447b0de16adaef79cd57531b64fa555433b7c6e06651bbe5516
goal_registry_q         81757196bf361b3f3155e4d3b66d349a26965655b428a194296277c8ef373516
receipt_q               null (no independent IEC-0.5 receipt yet)
```
