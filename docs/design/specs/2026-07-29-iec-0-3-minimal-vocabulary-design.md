# IEC-0.3 Minimal Vocabulary — Design r2

```text
status=candidate-for-independent-gate  closure_claim=0  disposition=Reepoch
```

Freeze the smallest collision-constrained vocabulary after IEC-0.2. The output has four surfaces:

1. reused MST-NF / Residua / RCC terms;
2. twelve minimal IEC Phase-0 names with explicit deletion residues;
3. fourteen forbidden coercions;
4. thirteen deferred rich terms.

`Identity_q` is reused instead of minting `AgentRef`. `LiveFrontierCompleteness` is the canonical open survivor. `InstitutionalLineageDisposition` is retired as an independent name and represented by the existing bounded `q/a/σ/ρ` disposition profile.

A vocabulary freeze is incomplete if relation behavior remains implicit. Each admitted name therefore states:

```text
signature
scope
default transitivity
composition rule
revocation / historical treatment
boundary
nearest object
runtime realization
specific nonclaims
```

Defaults are conservative: cut relations and coupling edges do not compose automatically; policy acceptance does not propagate automatically; historical occurrence persists when current validity is retracted.

`CapabilityRegister` is a designated domain self-instance, not a template and not an implementation claim in IEC-0.3. Fourteen source-bound architect-ledger reports motivate it, but the evidence registry does not independently re-run every underlying artifact. No Lean theorem, runtime behavior, RCC discharge, new IEC primitive, new MST-NF axis, or IEC-NF is claimed.
