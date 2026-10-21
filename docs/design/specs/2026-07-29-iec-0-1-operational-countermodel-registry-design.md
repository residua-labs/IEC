# IEC‑0.1 Operational Countermodel Registry Design

```text
status        = approved_by_conversation
approved_at   = 2026-07-29
closure_claim = 0
```

## Objective

Freeze the first evidence-bound countermodel basis for IEC before any institutional ontology or Lean datatype is introduced. The artifact must convert operational failures in the Residua authoring institution into named invalid inferences, distinctions that IEC must preserve, and open Phase‑0 obligations.

## Context and constraints

- IEC is normalized directly against MST-NF.
- Residua is the runtime substrate.
- RCC checks relative closure.
- IET and CRT are theoretical and normalized precedents, not IEC's implementation base.
- `IEC-NF` is not assumed.
- The current Residua institution is evidence and a future self-instance, never the universal template.
- The Phase‑0 product is an enumerated open frontier, not a closure claim.

## Approaches considered

### A. Incident catalogue

Record every operational failure as a separate row.

**Rejected:** this would overfit one session, duplicate repeated manifestations, and generate terminology from incident names rather than discriminating structure.

### B. Evidence-bound normalized countermodel registry

Merge incidents that share one invalid inference. For each retained failure shape, pin source identity, name the invalid inference, preserve the required distinctions, derive a minimum IEC obligation, and leave MST-NF normalization open.

**Selected:** this follows the RCC-derived formal-theory-construction method and produces a finite, falsifiable frontier without inventing IEC ontology.

### C. Immediate Lean institution kernel

Define `Institution`, `Authority`, `Fork`, and related objects, then search for proofs.

**Rejected:** the operational counterexamples have not yet been collided against the nearest MST-NF, IET-NF, CRT-NF, Residua, and RCC structures. Lean at this point would mechanize ambiguous words.

## Selected countermodel basis

The registry contains exactly five failure shapes:

1. `SelfMeasurementWithoutForeignFactor`
2. `DeclarationWithoutExecutionBinding`
3. `DisposerInsideDisposedSystem`
4. `KnowledgeInheritedAuthorityNotInherited`
5. `ExitOnlyByDeath`

They are selected because they constrain five different future interfaces:

```text
evidence acceptance
declaration-to-effect binding
authority scope and self-application
authority inheritance and recognition
exit/fork lineage
```

Resource admission is captured as a binding obligation under countermodels 2 and 3. Typed value conflict remains a named later pressure and is not silently folded into the five.

## Artifact architecture

### Frozen source documents

- `docs/iec/IEC_0_0_UPSTREAM_CLAIM_MATRIX_V0_1.md`
- `docs/iec/IEC_0_0_PINNED_SOURCE_WINDOW_V0_1.json`

These are promoted from candidate status to frozen status without changing the approved source window.

### Human-readable countermodel document

- `docs/iec/IEC_0_1_OPERATIONAL_COUNTERMODEL_REGISTRY_V0_1.md`

Responsibilities:

- explain the selection rule;
- preserve the observed operational meaning;
- state invalid inferences and nonclaims;
- enumerate the five derived Phase‑0 targets;
- keep all normalization verdicts open.

### Machine registry

- `residua-internal iec conformance record IEC_OPERATIONAL_COUNTERMODEL_REGISTRY_V0_1.json (not included)`

Responsibilities:

- exact five-ID registry;
- pinned source-window identity;
- source evidence refs, blob SHAs, selectors, and anchors;
- required distinctions and obligations;
- derived open-target IDs;
- `closure_claim=0`, `disposition=Reepoch`.

### Independent structural checker

- `residua-internal verifier verify_iec_operational_countermodel_registry (not included)`

Responsibilities:

- validate schema, IDs, counts, fields, target coverage, and nonclaims;
- verify the frozen source-window hash;
- re-read pinned historical source bytes with `git show`;
- verify document anchors and exact JSONL `object_q` selectors;
- run rejection mutants proving that the checker refuses missing evidence, missing countermodels, duplicate IDs, closure escalation, source drift, and premature NF claims.

## Data flow

```text
pinned IEC-0.0 source window
      +
ADR / content-addressed ledger evidence
      ↓
IEC operational countermodel registry
      ↓
structural/evidence verifier
      ↓
PASS means registry integrity only
      ↓
RCC disposition remains Reepoch
      ↓
IEC-0.2 performs nearest-object collision analysis
```

## Error handling

The verifier fails closed and prints every deterministic error. It does not repair the registry, infer missing evidence, accept approximate anchors, or fetch mutable latest-source content. Evidence is checked at the pinned commit and blob identity.

## Verification strategy

1. Registry-only validation with source checks disabled for local construction.
2. Seven in-memory negative mutants must all be refused.
3. In a real repository checkout, full source checks use `git show <ref>:<path>` and exact Git blob identity.
4. The PR carries no IEC theorem or runtime claim.

## Nonclaims

- The five countermodels are not exhaustive.
- None has yet earned a new MST-NF axis or `IEC-NF`.
- No universal institution policy is selected.
- No institution ontology is frozen.
- Structural verification of the registry is not RCC closure.
