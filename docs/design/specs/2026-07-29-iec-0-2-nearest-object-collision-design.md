# IEC-0.2 Nearest-Object Collision Analysis — Design r6

```text
status        = candidate-for-independent-gate
revision      = r6
closure_claim = 0
disposition   = Reepoch
```

## Goal

Finish the Phase-0 nearest-object collision without inventing an IEC ontology,
new MST-NF axis, Residua constructor, or unproved representation theorem.

## Architecture

The machine boundary is split into two artifacts:

```text
collision registry
  pins parents, sources, verdicts, profile contract and surviving OPEN

lineage diagnostic fixture
  supplies finite cut/frontier/policy/plan witnesses and expected q/a/σ/ρ
```

The verifier binds the fixture by exact Git-blob identity, re-derives every
fixture digest and result, and rejects declared results that do not match the
executed profile.

## Parent binding

IEC-0.2 consumes the exact IEC-0.0 window already bound by IEC-0.1:

```text
path + SHA-256 bytes + Git blob bytes + frozen status
```

Inherited evidence additionally binds repository, frozen ref, path and blob.
This prevents a child from coordinating a moved parent window with rewritten
source refs.

## Bounded domain profile

A profile instance supplies:

```text
institutional cut
LiveFrontier
EvidencePolicy
DispositionPlan
```

The cut source identities are nonempty. The policy supplies exact
`(item_q,outcome,successor_q) -> evidence_q` bindings. The plan is a relation
exactly over the frontier.

The evaluator returns:

```text
q      meta-fixture profile digest
a      all named checks
σ      admitted cut-relative successor projection
ρ      one typed failure payload
```

GOOD admits. BAD differs only at the coupled shipment-effect successor and
returns `coupling_incompatible`. A lawful new-genesis positive path exists while
the old capability remains with a successor.

## Generality and anti-vacuity

The main fixture instantiates all six candidate item kinds, both transfer
relations and nonempty couplings. Separate successor-only and new-genesis-only
positive controls use one kind and no couplings. Main coverage therefore proves
fixture bite without becoming a universal institutional ontology.

## Result boundary

```text
4 absorbed
1 partially absorbed
1 frontier-completeness survivor
0 new IEC primitives
0 new MST-NF axes
IEC-NF not assumed
```

The result is a bounded Phase-0 diagnostic. It is not a Lean theorem, general
representation theorem, or Residua runtime implementation.
