# IEC-1.0 J1 current-basis disposition v0.4

- Bound basis: `e791fd269ebe161990d640162eeabb4504cdf0e0`
- Disposition: `SatisfiedCurrentBasis`
- Reader universe: `0..55` / 56 constructors
- Evaluator universe: `0..25 + 27/28/29/32/33/34 + 41/42` / 34
- Generated routing: 56 arms / 20 shape-helper modules, source-exact
- Live rewrites: `Sub/Lte/Gt/Gte/AndE/OrE/NotE`
- Kernel-retained: `EqE(6)`
- Preservation rows: 7 direct + 2 nested + 2 EqE retained
- Controls: BoolLit Preserved; ListLen both-residue Refused
- Teeth: 7 live module mutants + 1 evalr-authoritative retired-EqE counterexample
- Off-type soundness: 10/10, evalr-authoritative
- Excluded from rewriting: `Mul/Div/Mod`
- IEC targets: `not_discharged`
- `closure_claim=0`

Machine authority:
`residua-internal iec conformance record IEC_1_0_J1_K_EXPAND_PRESERVATION_V0_4.json (not included)`.

EqE remains in K because native equality succeeds on Boolean operands while its
retired Lt-based derivation refuses. Structural recursion is generated from the
reader declaration and typed AST annotations; the verifier rejects unresolved
arms, stale generated files, surviving superseded hand-classified modules, or
drift in the seven rewrite slots.

This closes J1 only on the bound occurrence. It does not prove universal
semantic equivalence, discharge IEC targets, or extend the separate finite-point
C1b/C2/C3 fixed-point result.
