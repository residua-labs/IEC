# IEC-0.2 — Nearest-Object Collision Analysis v0.1-r6

```text
status          = candidate_for_freeze
revision        = r6
closure_claim   = 0
disposition     = Reepoch
basis           = IEC-0.1 operational countermodels
implementation  = Phase-0 meta-diagnostic only
Lean            = none
next_on_freeze  = IEC-0.3 Minimal Vocabulary Freeze
```

## 1. Purpose and authority boundary

IEC-0.2 asks whether each IEC-0.1 failure already fits the structure supplied by
MST-NF and the existing Residua/RCC runtime, or leaves a genuinely independent
institutional residue.

```text
MST-NF CoreObject / residue structure
→ Residua q / a / σ / ρ runtime discipline
→ existing invariant or seam
→ composition
→ runtime overlay
→ independent residual
```

An `absorbed` verdict is not a theorem discharge. It means the current evidence
does not justify a new IEC primitive, new MST-NF axis, or IEC-NF.

IEC-0.2r6 is intentionally still `Reepoch`: it enumerates the next theory
frontier while RCC full closure remains open.

## 2. Parent-window binding

A child node may not silently refreeze its parent. IEC-0.2 therefore consumes the
exact IEC-0.0 window that IEC-0.1 already bound:

```text
source-window path
+ SHA-256 of exact bytes
+ Git blob identity of exact bytes
+ required frozen status
```

It also consumes the exact IEC-0.1 countermodel-registry blob. A coordinated
change to the IEC-0.0 repository commit and all inherited evidence refs is still
rejected because the parent source-window bytes no longer match the IEC-0.1
binding.

Inherited evidence identity is:

```text
repository + frozen ref + path + blob_sha
```

The verifier also keeps the IEC-0.0 marked human source inventory equal to the
machine source inventory.

## 3. Machine evidence inventory

<!-- IEC-0.2-V02-EVIDENCE-INVENTORY:BEGIN -->
[
  "E-CAP",
  "E-CONFLUX",
  "E-CRT-INST",
  "E-CRT-SEI",
  "E-IDVERIFY",
  "E-IE4",
  "E-IETNF",
  "E-MSTNF-CORE",
  "E-MSTNF-RESIDUE",
  "E-RCC",
  "E-RECOG",
  "E-RESIDUA-QASR",
  "E-SPINE"
]
<!-- IEC-0.2-V02-EVIDENCE-INVENTORY:END -->

The evidence split remains explicit:

```text
E-MSTNF-CORE     CoreObject / Adm / D / exactness / residues
E-MSTNF-RESIDUE  generic residue-exhaustion and pullback
E-RESIDUA-QASR   executable q / a / σ / ρ discipline
```

`MSTNFObjectMWE` is not described as a complete q/a/σ/ρ execution profile.

## 4. Global collision result

```text
countermodels analyzed                  5
absorbed without new IEC primitive      4
partially absorbed                      1
surviving open targets                  1
new IEC primitives earned               0
new MST-NF axes earned                   0
IEC-NF                                  not assumed
```

The stable rulings are:

```text
EvidencePolicy is explicit policy data.
Declaration ≠ decision ≠ capability ≠ effect ≠ receipt ≠ retirement.
DisposerRole ↛ MayDispose ↛ Disposed ↛ LineageDispositionComplete.
Identity / knowledge / role ↛ executable capability.
```

A disposer is optional role or policy data. An institution may have none.

## 5. Exit/fork diagnostic

### 5.1 Bound institutional cut

The diagnostic is relative to one content-addressed cut context:

```text
source_institution_q
source_epoch_q
source_history_head_q
cut_event_q
successor/new-genesis relations
```

The four source identities must be non-empty opaque identities. Merely hashing
empty fields does not create a valid institutional cut.

The fixture cut contains:

```text
inst:B  successor
inst:C  successor
inst:D  new_genesis
```

Successor identities are unique; both relation classes are present; policy
targets must be inside the cut; and a transfer outcome must match the target's
cut relation.

### 5.2 Supplied LiveFrontier

At the cut, the finite supplied frontier contains:

```text
identity claims
capabilities
obligations
resource interests or custodies
owned or in-flight effects
unresolved disputes
coupling/dependency edges
```

Every `item_q` is unique, every kind is recognized, every coupling endpoint
exists, and every coupling constraint is recognized by the bound policy.

Frontier completeness remains OPEN. Checking all supplied items does not prove
that no live item or dependency was omitted.

### 5.3 Policy-bound evidence relation

Each disposition edge carries exactly:

```text
item_q
outcome
successor_q
evidence_q
```

`evidence_q` is not accepted merely because it is non-empty. The supplied policy
contains an explicit finite acceptance relation:

```text
(item_q, outcome, successor_q) ↦ accepted evidence_q
```

A fresh non-empty but unbound evidence key is refused. This is policy data for
the diagnostic, not a universal IEC evidence standard.

### 5.4 Relation over exactly the frontier

Before totality or coupling checks, the verifier requires:

```text
cut-context well-formedness
cut-context binding
frontier well-formedness
plan domain exactly over the frontier
outcome/evidence validity under the policy
totality
exclusive single-valuedness
coupling compatibility
```

Unknown plan items are not ignored. Missing fields, duplicate exclusive edges,
unknown outcomes, forged evidence and target-relation mismatch are typed
refusals.

## 6. Executed q / a / σ / ρ profile

The Phase-0 meta-diagnostic executes the entire result shape rather than merely
listing four names in prose.

```text
q
  = meta-fixture digest of
    cut_context_q + frontier_q + disposition_plan_q + policy_q

a
  = conjunction of all named checks

σ
  = on Admit, the cut-relative successor projection
  = otherwise none

ρ
  = on Residue, one typed failure payload
  = otherwise none
```

The registry fixes this mapping exactly; changing it to decorative or arbitrary
strings makes the verifier fail.

The fixture digest is canonical-JSON SHA-256 for the meta-check only. It is not
Residua canonical wire identity and does not substitute for a future Residua
implementation.

## 7. Positive and negative controls

GOOD and BAD share:

```text
the same parent-bound source window
the same institutional cut
the same complete supplied frontier
the same policy and evidence acceptance relation
the same item-local state
one policy-valid evidenced edge for every item
```

GOOD includes a lawful new-genesis positive path:

```text
id:branch-d
  outcome     = new_genesis
  successor_q = inst:D
```

The old capability still goes to successor B. Thus the fixture demonstrates:

```text
new institutional existence
≠ automatic inheritance of old executable authority
```

GOOD returns:

```text
Admit
σ = cut-relative successor projection
ρ = none
```

BAD differs only by moving the coupled in-flight shipment effect from lawful
successor B to lawful successor C. Every earlier check passes; only the supplied
`same_successor` coupling with `obl:deliver` fails.

BAD returns:

```text
Residue
σ = none
ρ.code = coupling_incompatible
```

The verifier re-derives q, a, σ and ρ; it does not trust declared expected
booleans or result payloads.

## 8. Collision decision

```text
InstitutionalLineageDisposition
→ absorbed as an existing q/a/σ/ρ domain profile
  GIVEN an exact parent window,
        a well-formed bound institutional cut,
        a complete LiveFrontier,
        and a supplied evidence policy

IEC-RC-LIVE-FRONTIER-COMPLETENESS-001
→ remains OPEN as a domain instance of
  enumeration/dependency extraction
```

The survivor does not earn an IEC primitive, MST-NF axis, Residua constructor or
IEC-NF.

## 9. Required independent gate

At the exact candidate head, a complete checkout must execute:

```bash
python3 residua-internal verifier verify_iec_nearest_object_collision_registry (not included) --self-test
```

The only acceptable result is:

```text
IEC nearest-object collision registry r6: PASS
(5 collisions, 4 absorbed, 1 partial,
 1 frontier-completeness survivor, source_checks=on)
exit 0
```

## 10. Nonclaims

```text
closure_claim = 0
No IEC ontology or disposer primitive is frozen.
The disposition profile is not yet a Lean theorem or Residua runtime program.
The diagnostic JSON digests are not Residua q.
No universal evidence policy is asserted.
No claim that all real live items or dependencies can be discovered.
No RCC target is discharged.
IEC-0.3 remains locked until IEC-0.2 is frozen.
```
