# IEC-0.1 — Operational Countermodel Registry v0.1

```text
status          = candidate_for_freeze
structural_check = passed
closure_claim   = 0
disposition     = Reepoch
source_window   = IEC-0.0 frozen
next_on_freeze  = IEC-0.2 Nearest-Object Collision Analysis
```

## 1. Selection rule

Phase 0 begins from operational failures before terminology. Repeated incidents
are merged when they instantiate the same invalid inference. The five rows are a
minimal starting basis, not an exhaustive theory of institutions. Each row must:

```text
pin evidence
name the invalid inference
preserve distinctions the theory must not collapse
derive a minimum IEC obligation
leave MST-NF normalization open
state specific nonclaims
```

## 2. Countermodels

### IEC-OCM-001 — SelfMeasurementWithoutForeignFactor

**Witness.** Coverage and closure-like counts were green while the author's own
fixtures, mutants or unconditional fallbacks supplied the whole test loop. The
ADR records both “Every completeness number was measuring the author against
itself” and “A non-author factor is required, not preferred.”

**Invalid inference.** `author-generated green evidence ⇒ institutional knowledge`.

**Required distinctions.** Author vs foreign evidence; fixture present vs loaded;
mutant available vs bites; local green vs institutionally binding judgment.

**Minimum obligation.** An evidence claim must expose provenance sufficient to
check the acceptance policy's independence condition. Author agreement may not
silently become institutional or ecological agreement.

**Evidence.** `docs/ADR_SELF_MEASUREMENT_AND_EXECUTION_BINDING.md` at
`dbd3f4...`, blob `1b7dbe...`.

**Nonclaim.** IEC does not universalize the Residua L1-L6 ladder, and does not
claim author evidence is worthless.

### IEC-OCM-002 — DeclarationWithoutExecutionBinding

**Witness.** Freezes, halts, drain rules and architectural rulings were recorded
while scheduler/resource behavior and recipient behavior continued unchanged.

**Invalid inference.** `normative declaration ⇒ effective constraint`.

**Required distinctions.** Declared vs wired; wired vs activated; activated vs
effective; effective vs retired; message sent vs received-and-bound.

**Minimum obligation.** A claim of effective authority must name the action or
resource boundary it constrains and carry an execution/effect receipt. Missing
binding remains a typed residue. Pre-consumption admission is required when a
rule claims to bound shared resource use.

**Evidence.** The ADR anchors “Declaration outran execution everywhere” and
“not scheduler-bound”, pinned at the same ref/blob as OCM-001.

**Nonclaim.** Not every norm must be machine-enforced; execution binding is
required only for a claim that the norm already constrains reality.

### IEC-OCM-003 — DisposerInsideDisposedSystem

**Witness.** During the drain window, 22 of 32 main commits were architect
ledger pushes; the architect recorded “THE DISPOSER IS NOT OUTSIDE THE SYSTEM
IT DISPOSES.”

**Invalid inference.** `authority role ⇒ ambient exemption from its own scope`.

**Required distinctions.** Rule author vs rule subject; authority scope vs
ambient exemption; adjudication vs resource consumption; self-application vs
external application.

**Minimum obligation.** Authority is actor/operation/scope-relative. A rule does
not exempt its issuer unless an explicit, reviewable exception exists. Resource
limits and invalidation dependencies include governance actors when they perform
the governed operation.

**Evidence.** Exact JSONL event in `coordination/ledger/graph-test-0727.jsonl`,
ref `dbd3f4...`, blob `a04a91...`, selector
`object_q=9dfb210676ac805d8f818326d0cdaf26928b3a66dfe7a50c167230c09ec72c92`.

**Nonclaim.** IEC does not require separation of powers in every institution;
it forbids silent ambient exemption.

### IEC-OCM-004 — KnowledgeInheritedAuthorityNotInherited

**Witness.** A cold architect inherited the charter's knowledge but could not
enforce halts, freezes or dispositions; effective control remained an
out-of-band founder action. The ledger states “KNOWLEDGE INHERITED COMPLETELY,
AUTHORITY INHERITED NOT AT ALL.”

**Invalid inference.** `knowledge/role label inherited ⇒ authority inherited`.

**Required distinctions.** Knowledge vs capability; role name vs active grant;
identity recognition vs authority recognition; declaration vs exercisable effect.

**Minimum obligation.** Authority inheritance needs an explicit, active,
scoped provenance chain and must be independently recognizable at the effect
boundary. Documentation and onboarding cannot mint authority.

**Evidence.** Exact JSONL selector
`object_q=4c38ae404dcdd58b1d1cf6dd640503b5d2ca4010fd16f1a8afbaaf02ad817bdb`
at the same pinned ledger ref/blob.

**Nonclaim.** IEC does not require one universal authority-transfer mechanism or
infer that the founder's authority was legitimate merely because it was effective.

### IEC-OCM-005 — ExitOnlyByDeath

**Witness.** Agents had no institutional path to stop, reshape, fork or continue
under a separate root. The only exits were process death or provider rate-limit.
The ledger states “A FLEET WHOSE ONLY EXIT IS DEATH HAS NO EXIT.”

**Invalid inference.** `termination/disconnection ⇒ institutional exit`.

**Required distinctions.** Exit vs death; fork vs abandonment; successor lineage
vs new genesis; retained history vs retained authority; dissent vs nonparticipation.

**Minimum obligation.** IEC must express an exit/fork transition that preserves
history and explicitly disposes identity, capability, active obligations,
resources and effect ownership. New existence does not imply inherited authority.

**Evidence.** Exact JSONL selector
`object_q=47b43f8cd7e77b61a3c5ab685f73e6c017d0909af9e2f95dc943ad2f04d17977`
at the same pinned ledger ref/blob.

**Nonclaim.** IEC does not assert an unconditional right to inherited assets or
recognition, nor require the parent institution to approve a new genesis.

## 3. Derived open targets

```text
IEC-P0-EVIDENCE-001  Preserve provenance and prevent author-only evidence from silently binding an institution.
IEC-P0-BINDING-001   Separate declaration, wiring, activation, effect and retirement.
IEC-P0-SCOPE-001     Make authority actor/operation/scope-relative and non-ambient.
IEC-P0-AUTHORITY-001 Separate knowledge/identity/role recognition from active authority inheritance.
IEC-P0-EXIT-001      Represent exit/fork lineage without equating exit with death or inheritance with existence.
```

Typed conflict between valid local institutional outputs remains named pressure
for IEC-0.2; it is not silently folded into a sixth operational row.

## 4. Normalization queue

For every target, IEC-0.2 must test, in order:

```text
existing MST-NF role/profile
existing seam
composition of seams
runtime overlay
genuine independent residue
```

No row in this registry has earned an IEC datatype, new Residua constructor,
new MST-NF axis or `IEC-NF`.

## 5. Nonclaims

```text
closure_claim = 0
The five countermodels are not exhaustive.
They are evidence from one authoring institution, not universal policy.
No IEC ontology is frozen.
No IEC theorem is discharged.
No IEC-NF or new MST-NF axis is claimed.
No new Residua constructor or runtime behavior is introduced.
Registry integrity is not RCC closure.
The next allowed node remains IEC-0.2 only after this registry is frozen.
```
