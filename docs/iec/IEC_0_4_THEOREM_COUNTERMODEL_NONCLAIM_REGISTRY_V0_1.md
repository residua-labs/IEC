# IEC-0.4 — Theorem / Countermodel / Nonclaim Registry r2

```text
status          = candidate_for_freeze
closure_claim   = 0
disposition     = Reepoch
basis           = IEC-0.3r2 @ 8f13c8ea83783084b46c3361d594c7d6f608f12a (FROZEN)
next            = IEC-0.5 (LOCKED)
```

## Purpose

IEC-0.4 turns the collision-constrained IEC-0.3 vocabulary into an **enumerated open proof frontier**. It proves nothing yet and adds no IEC primitive, MST-NF axis, IEC-NF, Residua runtime behavior, or RCC discharge.

```text
38 theorem targets
45 countermodels
25 nonclaims
0 discharged targets
0 new IEC primitives
0 new MST-NF axes
IEC-NF not assumed
```

The r1 draft had 33 targets and 40 countermodels. A second relation-law coverage pass found five omissions: implicit closure of `CouplingEdge`, cross-context laundering of `EvidencePolicy`, naive composition of `DispositionPlan`, accidental closure of `FrontierItem` kinds, and accidental closure of the disposition outcome family. r2 adds exactly one target and one countermodel for each omission before freeze.

## Target inventory

<!-- IEC-0.4-TARGET-INVENTORY:BEGIN -->
["IEC-T001","IEC-T002","IEC-T003","IEC-T004","IEC-T005","IEC-T006","IEC-T007","IEC-T008","IEC-T009","IEC-T010","IEC-T011","IEC-T012","IEC-T013","IEC-T014","IEC-T015","IEC-T016","IEC-T017","IEC-T018","IEC-T019","IEC-T020","IEC-T021","IEC-T022","IEC-T023","IEC-T024","IEC-T025","IEC-T026","IEC-T027","IEC-T028","IEC-T029","IEC-T030","IEC-T031","IEC-T032","IEC-T033","IEC-T034","IEC-T035","IEC-T036","IEC-T037","IEC-T038"]
<!-- IEC-0.4-TARGET-INVENTORY:END -->

### Address and bounded-profile structure — 6 targets

| ID | Name | Kind | Statement |
|---|---|---|---|
| `IEC-T001` | `InstitutionRefAddressKindSound` | `safety` | Accepted equality involving an InstitutionRef is confined to the institution-lineage address kind; equality with Identity_q or a FrontierItem q requires an explicit typed bridge. |
| `IEC-T002` | `InstitutionalCutIdentityBinding` | `safety` | The bounded profile q commits to source InstitutionRef, source epoch q, source history-head q, cut-event q, and the target CutRelation map; a decision-relevant difference changes q or is refused as an address collision. |
| `IEC-T003` | `BoundedProfileFactorization` | `factorization` | Under fixed profile semantics, equal profile q values produce identical a, σ, and ρ outcomes. |
| `IEC-T004` | `DispositionOutcomePartition` | `safety` | Every evaluated bounded disposition profile returns exactly one of Admit with σ and no ρ, or Residue with typed ρ and no σ. |
| `IEC-T005` | `TypedDispositionResidueCoverage` | `safety` | Every named failed admissibility check has a typed ρ; no failure is represented only by false, an empty string, or an untyped catch-all. |
| `IEC-T006` | `BoundedDispositionProfileExactness` | `exactness` | The bounded profile admits exactly when cut binding, frontier form, exact plan domain, evidence-policy validity, disposition totality, exclusivity, and coupling compatibility all hold. |

### Evidence and policy-relative admission — 6 targets

| ID | Name | Kind | Statement |
|---|---|---|---|
| `IEC-T007` | `EvidencePolicyExplicitAdmission` | `safety` | A DispositionEdge is evidence-valid only when the active EvidencePolicy accepts its exact evidence_q, item_q, outcome, target InstitutionRef, and InstitutionalCut context. |
| `IEC-T008` | `GreenDoesNotSynthesizeBinding` | `non_derivability` | A green verdict or nonempty evidence_q does not by itself entail an accepted EvidencePolicy judgment or a binding admission. |
| `IEC-T009` | `ConditionalForeignFactorRequirement` | `safety` | If an EvidencePolicy explicitly requires a foreign or non-author factor, evidence controlled only by the author cannot admit. |
| `IEC-T010` | `EvidenceReferenceRequiresGrounding` | `non_derivability` | The identity of evidence_q is not a proof of the referenced claim; any grounded-evidence claim requires an explicit verifier or receipt chain for that reference. |
| `IEC-T011` | `EvidencePolicyChangeRequiresRevalidation` | `history` | A decision-relevant EvidencePolicy change invalidates reuse of the old admission as current; it requires revalidation or Reepoch while preserving the historical admission record. |
| `IEC-T035` | `EvidencePolicyAcceptanceIsContextRelative` | `non_derivability` | Acceptance under one EvidencePolicy, InstitutionRef, epoch, or InstitutionalCut does not entail acceptance under another context unless an explicit policy conjunction or bridge proves it. |

### Capability, action, and effect separation — 5 targets

| ID | Name | Kind | Statement |
|---|---|---|---|
| `IEC-T012` | `IdentityKnowledgeRoleDoNotMintCapability` | `noncoercion` | Identity_q, membership, role labels, knowledge, and documentation do not implicitly mint Capability. |
| `IEC-T013` | `NoAmbientGovernanceExemption` | `safety` | An actor performing a governed operation is checked by the same scoped Capability predicate even when that actor authored, administers, or disposes the rule; any exception is explicit policy data. |
| `IEC-T014` | `CapabilityEffectDispositionSeparation` | `noncoercion` | Capability does not imply that an effect occurred, and an EffectReceipt for one occurrence does not imply that a DispositionPlan or LiveFrontier is complete. |
| `IEC-T015` | `RevocationBlocksFutureEffectsPreservesHistory` | `history` | A currently revoked or invalid Capability cannot authorize a new effect, while already admitted History and valid historical EffectReceipt records remain historical facts. |
| `IEC-T016` | `DeclarationToEffectBinding` | `safety` | A claim of current effectiveness requires a matching current Capability and EffectReceipt chain; declaration or decision data alone is insufficient. |

### Institutional cut, lineage, and disposition — 12 targets

| ID | Name | Kind | Statement |
|---|---|---|---|
| `IEC-T017` | `CutRelationSingleTagPerTarget` | `safety` | Within one well-formed InstitutionalCut, each target InstitutionRef carries at most one CutRelation tag. |
| `IEC-T018` | `CutRelationCompositionIsExplicit` | `non_derivability` | CutRelation, Successor, and NewGenesis are not transitively composed by default; composition requires an explicit lineage-transport proof. |
| `IEC-T019` | `NewGenesisDoesNotInheritCapability` | `noncoercion` | NewGenesis establishes new institutional existence but does not inherit Capability from the source lineage without an explicit bridge. |
| `IEC-T020` | `SuccessorDoesNotInheritAllState` | `noncoercion` | Successor records explicitly dispositioned continuation but does not imply inheritance of every state item, Capability, obligation, resource interest, effect, or dispute. |
| `IEC-T021` | `DispositionPlanDomainExactness` | `safety` | The domain of a DispositionPlan is exactly the FrontierItem set supplied by its LiveFrontier: no ghost edge and no supplied item omitted. |
| `IEC-T022` | `DispositionTotalityAndExclusiveSingleValuedness` | `safety` | Every supplied FrontierItem receives an allowed disposition, and every item declared exclusive receives exactly one disposition edge. |
| `IEC-T023` | `CouplingCompatibility` | `safety` | Every CouplingEdge constraint supplied by the active policy is satisfied by the admitted DispositionPlan. |
| `IEC-T024` | `BoundedDispositionProfileNonVacuity` | `anti_vacuity` | The bounded profile admits at least one lawful Successor plan and one lawful NewGenesis plan, and refuses a plan that differs only by a load-bearing incompatible CouplingEdge outcome. |
| `IEC-T025` | `HistoricalDispositionCurrentValiditySeparation` | `history` | Retracting current validity of an InstitutionRef recognition, CutRelation, LiveFrontier snapshot, FrontierItem liveness, DispositionEdge, or plan does not erase the historical InstitutionalCut, admitted plan, or receipts. |
| `IEC-T026` | `StaleCutRequiresRevalidationOrReepoch` | `history` | When a q-bound cut, frontier, policy, or decision-relevant dependency changes, an old disposition receipt cannot remain current without revalidation; the system returns a typed residue or Reepoch. |
| `IEC-T036` | `SequentialDispositionCompositionIsExplicit` | `non_derivability` | DispositionPlans from different cuts, epochs, history heads, or policies cannot be unioned or sequentially composed into a current plan without explicit history transport and revalidation. |
| `IEC-T038` | `DispositionOutcomeFamilyIsPolicyOpen` | `anti_vacuity` | Successor and NewGenesis are distinguished CutRelation values, not a closed universal outcome enum; a policy-declared additional disposition outcome can be represented and checked without minting a new IEC primitive. |

### Live-frontier extraction, omission, and self-instance — 9 targets

| ID | Name | Kind | Statement |
|---|---|---|---|
| `IEC-T027` | `SuppliedTotalityDoesNotImplyCompleteness` | `non_derivability` | Total and compatible disposition over every supplied FrontierItem does not imply LiveFrontierCompleteness. |
| `IEC-T028` | `FrontierExtractionSoundness` | `safety` | Every FrontierItem and CouplingEdge produced by an extractor is supported by a source fact admitted by the declared extraction context and relevance predicate. |
| `IEC-T029` | `RelativeLiveFrontierCompleteness` | `open_completeness` | Relative to an explicitly declared source universe, relevance predicate, and extraction context, every relevant live item and dependency edge at an InstitutionalCut is represented in the LiveFrontier. |
| `IEC-T030` | `FrontierExtractionDeterminism` | `determinism` | For fixed History, InstitutionalCut, declared source universe, relevance predicate, and extraction context, frontier extraction yields the same LiveFrontier q. |
| `IEC-T031` | `OmissionDiscoveryRetractsCompleteness` | `history` | Discovery of a relevant omitted item or CouplingEdge retracts the current LiveFrontierCompleteness judgment while preserving the prior judgment as historical. |
| `IEC-T032` | `OmissionReopensDependentsPreservesUnrelated` | `locality` | After omission discovery, dispositions dependent on the omitted item or edge reopen or migrate, while dispositions with no dependency path remain valid. |
| `IEC-T033` | `CapabilityRegisterKnownReportCoverage` | `self_instance_conformance` | The designated CapabilityRegister self-instance can query and distinguish all fourteen frozen frontier-omission reports by capability, location, and status without becoming an IEC template. |
| `IEC-T034` | `CouplingEdgeNoImplicitClosure` | `non_derivability` | The bounded profile checks exactly the supplied CouplingEdges under explicit constraint semantics; it does not add symmetric, reversed, or transitive edges unless the policy explicitly derives and supplies them. |
| `IEC-T037` | `FrontierItemKindIsPolicyOpen` | `anti_vacuity` | FrontierItem kind tags are supplied by the active policy; the six IEC-0.2 fixture kinds are not a closed universal ontology, and a lawful policy-declared additional kind can enter a LiveFrontier. |

## Relation-law coverage

Every load-bearing IEC-0.3 default for transitivity, composition, or revocation is routed to at least one open target.

<!-- IEC-0.4-RELATION-LAW-COVERAGE:BEGIN -->
{"IEC-VOC-001.composition":["IEC-T001","IEC-T019"],"IEC-VOC-001.revocation":["IEC-T025"],"IEC-VOC-002.composition":["IEC-T002","IEC-T026","IEC-T036"],"IEC-VOC-002.revocation":["IEC-T025","IEC-T026"],"IEC-VOC-003.composition":["IEC-T018","IEC-T038"],"IEC-VOC-003.revocation":["IEC-T025"],"IEC-VOC-003.transitivity":["IEC-T018"],"IEC-VOC-004.composition":["IEC-T018"],"IEC-VOC-004.revocation":["IEC-T025"],"IEC-VOC-004.transitivity":["IEC-T018"],"IEC-VOC-005.composition":["IEC-T018","IEC-T019"],"IEC-VOC-005.revocation":["IEC-T025"],"IEC-VOC-005.transitivity":["IEC-T018"],"IEC-VOC-006.composition":["IEC-T021","IEC-T027","IEC-T029"],"IEC-VOC-006.revocation":["IEC-T025","IEC-T031"],"IEC-VOC-007.composition":["IEC-T021","IEC-T023","IEC-T037"],"IEC-VOC-007.revocation":["IEC-T025","IEC-T031"],"IEC-VOC-008.composition":["IEC-T023","IEC-T034"],"IEC-VOC-008.revocation":["IEC-T031","IEC-T032"],"IEC-VOC-008.transitivity":["IEC-T034"],"IEC-VOC-009.composition":["IEC-T006","IEC-T023","IEC-T036","IEC-T038"],"IEC-VOC-009.revocation":["IEC-T025","IEC-T026"],"IEC-VOC-010.composition":["IEC-T006","IEC-T007","IEC-T023"],"IEC-VOC-010.revocation":["IEC-T025"],"IEC-VOC-011.composition":["IEC-T007","IEC-T035"],"IEC-VOC-011.revocation":["IEC-T011"],"IEC-VOC-011.transitivity":["IEC-T035"],"IEC-VOC-012.composition":["IEC-T027","IEC-T029"],"IEC-VOC-012.revocation":["IEC-T031"]}
<!-- IEC-0.4-RELATION-LAW-COVERAGE:END -->

The five r2 additions are:

- `IEC-T034 / IEC-CM041`: supplied `CouplingEdge` relations are not silently made symmetric or transitively closed;
- `IEC-T035 / IEC-CM042`: evidence acceptance remains relative to policy and institutional context;
- `IEC-T036 / IEC-CM043`: disposition plans do not compose across cuts or epochs by naive union;
- `IEC-T037 / IEC-CM044`: the six IEC-0.2 item kinds remain fixtures rather than a universal ontology;
- `IEC-T038 / IEC-CM045`: `Successor` and `NewGenesis` remain distinguished values in an open policy outcome family.

## Discharge boundary

Every target is `open / not_discharged`. Later discharge requires:

```text
precise formal statement
positive non-vacuity witness when behavior is permitted
at least one registered countermodel
machine-checkable declaration or executable conformance check
independent checker
exact source and artifact identities
axiom footprint for Lean proofs
specific nonclaims preserved
```

The number 38 is a frontier, not a completion percentage and not a claim of permanent exhaustiveness.

## Countermodel inventory

<!-- IEC-0.4-COUNTERMODEL-INVENTORY:BEGIN -->
["IEC-CM001","IEC-CM002","IEC-CM003","IEC-CM004","IEC-CM005","IEC-CM006","IEC-CM007","IEC-CM008","IEC-CM009","IEC-CM010","IEC-CM011","IEC-CM012","IEC-CM013","IEC-CM014","IEC-CM015","IEC-CM016","IEC-CM017","IEC-CM018","IEC-CM019","IEC-CM020","IEC-CM021","IEC-CM022","IEC-CM023","IEC-CM024","IEC-CM025","IEC-CM026","IEC-CM027","IEC-CM028","IEC-CM029","IEC-CM030","IEC-CM031","IEC-CM032","IEC-CM033","IEC-CM034","IEC-CM035","IEC-CM036","IEC-CM037","IEC-CM038","IEC-CM039","IEC-CM040","IEC-CM041","IEC-CM042","IEC-CM043","IEC-CM044","IEC-CM045"]
<!-- IEC-0.4-COUNTERMODEL-INVENTORY:END -->

`IEC-CM001`–`IEC-CM005` preserve the five operational IEC-0.1 countermodels. `IEC-CM006`–`IEC-CM045` are discriminating specifications; registration does not claim every mutant has already executed.

## Nonclaim inventory

<!-- IEC-0.4-NONCLAIM-INVENTORY:BEGIN -->
["IEC-NC-001","IEC-NC-002","IEC-NC-003","IEC-NC-004","IEC-NC-005","IEC-NC-006","IEC-NC-007","IEC-NC-008","IEC-NC-009","IEC-NC-010","IEC-NC-011","IEC-NC-012","IEC-NC-013","IEC-NC-014","IEC-NC-015","IEC-NC-016","IEC-NC-017","IEC-NC-018","IEC-NC-019","IEC-NC-020","IEC-NC-021","IEC-NC-022","IEC-NC-023","IEC-NC-024","IEC-NC-025"]
<!-- IEC-0.4-NONCLAIM-INVENTORY:END -->

The nonclaims preserve: no rich `Institution`; no ambient `Authority`; no `Jurisdiction`, `Recognition`, `Treaty`, `Federation`, full Exit/Fork, or `Conflict` semantics; no `Civilization`, `World`, or global sovereign; no IEC-NF/new axis; no theorem or runtime discharge; no RCC/ecology closure; no absolute physical-world completeness; no universal disposer/evidence ladder; and no morality, legitimacy, consent, value-ordering, or physical-identity theorem.

`IEC-NC-025` is corrected to say that **38 targets, 45 countermodels, and 25 nonclaims** form the current Phase-0.4 frontier.

## Central survivor

```text
IEC-RC-LIVE-FRONTIER-COMPLETENESS-001
LiveFrontierCompleteness
```

Targets `IEC-T027`–`IEC-T033` split the survivor into non-derivability, soundness, relative completeness, determinism, retraction, dependency-local invalidation, and self-instance coverage. Absolute physical-world completeness remains outside scope.

## Deferred ontology remains unchanged

<!-- IEC-0.4-DEFERRED-INVENTORY:BEGIN -->
["Institution","Authority","Jurisdiction","Recognition","Treaty","Federation","InstitutionalExit","InstitutionalFork","Conflict","Civilization","World","Disposer","IEC-NF"]
<!-- IEC-0.4-DEFERRED-INVENTORY:END -->

`Conflict` remains `IEC-PRESSURE-CONFLICT-001`; no target promotes a deferred term.

## Parent and verification binding

```text
PR               1946
freeze comment   5125713264
workflow run     30508782603
workflow job     90764167938
subject head     8f13c8ea83783084b46c3361d594c7d6f608f12a
machine result   source_checks=on PASS
```

IEC-0.4 remains `Reepoch` and candidate-only until both IEC-0.4 verifiers pass in an exact full-history checkout and the disposer reviews the 38/45/25 frontier. IEC-0.5 remains locked.
