# IEC-0.5 RCC Dependency / Closure-Disposition — Design r1

```text
status=candidate-for-independent-gate
closure_claim=0
disposition=Advanced
parent=IEC-0.4r2@089cbb3d23fe5f34864dec82a039ee077ba89702
freeze_ref=1178ece6d7f24ea21274b666c14854dfe5a35f73
```

## Goal

Map the frozen IEC-0.4 proof frontier into the RCC obligation space, derive the next lawful RCC branch, and adjudicate the admission-DAG and disposer-role questions carried by the freeze. IEC-0.5 does not write Lean proofs, add ontology, or activate governance.

## Artifact graph

1. Five dependency-family registries
   - address profile: 6 targets
   - evidence: 6 targets
   - capability/effect: 5 targets
   - cut/lineage: 12 targets
   - frontier: 9 targets
2. `IEC_RCC_TARGET_DEPENDENCY_MAP_V0_1.json`
   - binds the five family bytes, counts, and array digests;
   - reconstructs exactly IEC-T001..IEC-T038.
3. `IEC_ADMISSION_DAG_ALIGNMENT_V0_1.json`
   - forbids a parallel `AdmissionPoint`;
   - treats `InstitutionalCut` as the typed admission basis;
   - identifies IEC-T026 as the third-tree law;
   - separates generic admission laws from lineage-only laws.
4. `IEC_DISPOSER_ROLE_SELF_INSTANCE_V0_1.json`
   - records one Residua self-instance, not the template;
   - separates role, Identity_q, scoped Capability, effect, and history;
   - records election/removal/succession/multi-seat obligations;
   - derives `Advanced` for construction and `Await(Klaus RATIFY)` for activation.
5. `IEC_RCC_DEPENDENCY_CLOSURE_DISPOSITION_MAP_V0_1.json`
   - binds the exact IEC-0.4 parent and freeze ledger;
   - distinguishes current RCC machine proof from historical-only proof snapshots;
   - embeds all 38 dependency rows;
   - derives the overall branch.
6. Human record plus primary and independently written verifiers.

## RCC authority boundary

The current proof registry at `1178ece6d7f24ea21274b666c14854dfe5a35f73` discharges only `E6`, `E7`, and `E8`. The RCC v2 fold is a target catalog and historical proof snapshot. Its `E5/RCC-13/RCC-14/RCC-25` entries are not reusable as current machine proof until whole-chain refreeze.

## Branch derivation

Every IEC target remains open and carries an explicit `Advanced / dispatch_propose` next action. No live-danger or mandatory rescope blocks starting work. Therefore the global result is `Advanced`. The self-instance's ratification wait is a local activation branch and cannot override dispatchable theory work.

## Anti-proliferation rulings

- No new `AdmissionPoint`.
- No universal `Disposer`.
- No new IEC term, Residua constructor, MST-NF axis, or IEC-NF.
- `Successor` and `NewGenesis` are conditional relation values, not labels for every PR.
- The first Phase-1 slice reuses the bounded IEC-0.2 profile.

## Verification teeth

Both checkers must reject:

- closure or target-discharge escalation;
- removal/reordering of any IEC target;
- missing or unknown RCC dependencies;
- a historical RCC proof promoted to current;
- a non-`Advanced` overall branch while dispatchable work exists;
- family/manifest/component/source drift;
- a parallel `AdmissionPoint`;
- denial of T026's ordinary-admission applicability;
- promotion of lineage-only laws to all PRs;
- role-label-to-Capability coercion;
- omitted or self-synthesized RATIFY;
- instance-specific threshold promoted to IEC law;
- a fabricated receipt before independent freeze;
- human/machine inventory drift.

## IEC-0.5-R2-ADMISSION-REPIN-DESIGN

    The r2 amendment changes only the Admission-DAG evidence cut and the consequences
    mechanically downstream from that identity. It pins `0179ac8af4d9c6e3d9b23605cac6de678ce2bffb` / `ef9d34faa149a735b66b23315b2b6ffb2321696d`,
    revalidates RULING-005 against the dependency-relation and actual-read-subset sections,
    preserves the r1 freeze historically, forbids receipt transport, and keeps the Phase-1
    slice locked until r2 refreeze plus repository landing. It introduces no IEC primitive,
    Residua constructor, MST-NF axis, theorem discharge, or Admission-DAG ratification.
