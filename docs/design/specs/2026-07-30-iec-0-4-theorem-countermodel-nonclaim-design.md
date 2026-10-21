# IEC-0.4 Theorem / Countermodel / Nonclaim Registry — Design r2

```text
status=candidate-for-independent-gate
closure_claim=0
disposition=Reepoch
parent=IEC-0.3r2@8f13c8ea83783084b46c3361d594c7d6f608f12a
```

## Goal

Turn the frozen twelve-term IEC vocabulary into an enumerated proof frontier before writing Lean or runtime code.

## Artifact split

```text
target family files -> theorem target manifest
base + extension countermodels -> countermodel aggregate
base + exact patch nonclaims -> nonclaim aggregate
coverage registry -> term, relation-law, and target/countermodel projections
main index -> parent/receipt/component/verifier identities and global summary
```

The split keeps individual registries reviewable while the manifests bind exact blobs and canonical array digests.

## r2 correction

The first draft enumerated 33 targets and 40 countermodels but did not route every IEC-0.3 relation-law default to a target. The r2 coverage pass adds exactly five target/countermodel pairs:

```text
CouplingEdge implicit closure
EvidencePolicy cross-context laundering
DispositionPlan cross-cut naive composition
FrontierItem kind-family closure
Disposition outcome-family closure
```

The final candidate shape is:

```text
38 targets across five families: 6 / 6 / 5 / 12 / 9
45 countermodels: 5 operational + 38 diagnostic + 2 self-instance
25 nonclaims
0 discharged
```

No new term, primitive, axis, runtime behavior, Lean theorem, RCC discharge, or IEC-NF is introduced.

## Acceptance

The primary and independent verifiers independently reconstruct all component arrays, apply the nonclaim patch, derive bidirectional target/countermodel maps, require coverage of all twelve terms and the load-bearing relation-law defaults, preserve the first five operational countermodels, bind IEC-0.3 source blobs, and reject closure/discharge/orphan/coverage/ontology drift mutants.
