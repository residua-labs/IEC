# IEC-0.0 — Pinned Source Window and Upstream Claim Matrix v0.1

```text
status                     = frozen
frozen_at                  = 2026-07-29
documentation_alignment    = r1
closure_claim              = 0
disposition                = Reepoch
next_allowed               = IEC-0.1 Operational Countermodel Registry
```

## 1. Frozen lineage

```text
Minimal Structure Theory
        ↓
      MST-NF                 IEC formal foundation
        ↓
     Residua                 MST-NF runtime
        │
        └── RCC              relative-closure checker

IET paper ──MST-NF normalization──> IET-NF
CRT paper ──MST-NF normalization──> CRT-NF
```

IEC is normalized directly against MST-NF. IET, CRT, IET-NF and CRT-NF are
explanatory and normalized precedents; they are not IEC's runtime or formal
foundation. `IEC-NF` is not assumed.

## 2. Claim authority

| Claim class | Governing authority | Forbidden promotion |
|---|---|---|
| Structural theorem | Pinned MST-NF Lean proof bodies | Prose enlarging theorem scope |
| IET/CRT normalized theorem | Pinned IET-NF/CRT-NF Lean | Restoring paper-era claims removed by NF |
| Runtime behavior | Residua semantics, canonical wire, gates and receipts | Declaration treated as execution |
| Closure status | RCC registry and refreeze receipt | Green CI treated as global closure |
| Motivation | IET/CRT/agent–reality papers | Motivation treated as proof |
| Operational failure | Pinned ADR/ledger evidence | One institution's incident universalized |

## 3. Machine-admitted source inventory

This section is a byte-for-byte projection of
`IEC_0_0_PINNED_SOURCE_WINDOW_V0_1.json`. It is the authoritative human-readable
inventory. Adding a research pointer below does not add a source to the frozen
window.

<!-- IEC-0.0-MACHINE-ARTIFACT-INVENTORY:BEGIN -->
[
  {
    "repository": "github-repository-id:1227901578",
    "path": "docs/CRT_NF_SOURCE_OF_TRUTH_INDEX.md",
    "blob_sha": "e9a978454ecb70de86f8da5c94584703518ca203"
  },
  {
    "repository": "github-repository-id:1227901578",
    "path": "docs/IETNF_SCOPE.md",
    "blob_sha": "9dbd0b6dfb62fbe542e45d81bcd88cd1d570dbbb"
  },
  {
    "repository": "github-repository-id:1227901578",
    "path": "lean/core/MSTNFObjectMWE.lean",
    "blob_sha": "34520e05857aefebea62ddd370e227e16ce4818d"
  },
  {
    "repository": "github-repository-id:1227901578",
    "path": "lean/crt/CRTAxesMachineVerdictMWE.lean",
    "blob_sha": "3065a170347019124ee7d156d301df300d039734"
  },
  {
    "repository": "github-repository-id:1227901578",
    "path": "lean/crt/IETNFFromMSTNFMWE.lean",
    "blob_sha": "20923ba574108cf9d23d3282c8c18cf8b84d426f"
  },
  {
    "repository": "github-repository-id:1227901578",
    "path": "lean/fdt/CRTScopedFinalNoFourthComplete.lean",
    "blob_sha": "d0aeb1a005dbc0f0fd4ee13a4276eff0b2ef32d4"
  },
  {
    "repository": "github-repository-id:1227901578",
    "path": "lean/methodology/GenericResidueExhaustionSchemaMWE.lean",
    "blob_sha": "3001fe7e19bf0c8358bd83f1381122747e23344e"
  },
  {
    "repository": "minustwo/canonical-reality-theory",
    "path": "main.tex",
    "blob_sha": "6d203433beafb3f64491c5e952f72481850d3b54"
  },
  {
    "repository": "minustwo/inferential-equilibrium-theory",
    "path": "MASTER_INDEX.md",
    "blob_sha": "1386733c2cb6716ef7d36afa33c809bad589de7a"
  },
  {
    "repository": "minustwo/inferential-equilibrium-theory",
    "path": "conjectures/ie_conjectures.md",
    "blob_sha": "0ba2ac4712125a63c41641784329086885e97117"
  },
  {
    "repository": "minustwo/market-structure-theory",
    "path": "papers/attack-escape/INSTITUTION_INTERFACE_NOTE_v0_2.md",
    "blob_sha": "db4e159fbc9c160ccacf731e2b089d1d5e46c93e"
  },
  {
    "repository": "minustwo/market-structure-theory",
    "path": "papers/crt/CRT_STACK_INTERFACE_v0_2.md",
    "blob_sha": "b33c972d114abb28e7c6fb621a63d83f3c009746"
  },
  {
    "repository": "minustwo/market-structure-theory",
    "path": "papers/crt/IET_OPEN_INTERFACE_v0_2.md",
    "blob_sha": "e51013c9ed89dc53b320d76545e890d470c5c391"
  },
  {
    "repository": "minustwo/residua",
    "path": "residua-internal rcc conformance record RCC_FORMAL_PROOF_REGISTRY_V1.json (not included)",
    "blob_sha": "ce0a9d5b894cbef7500b0908d13ff128a057b18d"
  },
  {
    "repository": "minustwo/residua",
    "path": "coordination/ledger/graph-test-0727.jsonl",
    "blob_sha": "a04a91396e474c4ebffe5487155f7c71c617ad53"
  },
  {
    "repository": "minustwo/residua",
    "path": "docs/ADR_SELF_MEASUREMENT_AND_EXECUTION_BINDING.md",
    "blob_sha": "1b7dbe1a193c0cb0a0aee5d6a872a2f63f67352f"
  },
  {
    "repository": "minustwo/residua",
    "path": "docs/ARCHITECTURE.md",
    "blob_sha": "eec3e69870b110adb478e9e93873cf91344bc8ae"
  },
  {
    "repository": "minustwo/residua",
    "path": "docs/METHOD_FORMAL_THEORY_CONSTRUCTION.md",
    "blob_sha": "2d69bc719e2667d9f5f4651e8d71006012a958a5"
  },
  {
    "repository": "minustwo/residua",
    "path": "docs/SPEC.md",
    "blob_sha": "97d714061f8ad24aac6f740eb7d5b3c8c0e7199e"
  },
  {
    "repository": "minustwo/residua",
    "path": "RCC/FormalCore.lean (residua-labs/RCC)",
    "blob_sha": "dc0e311bd0b7985283dc7b12c3796e87e9f5ca7a"
  }
]
<!-- IEC-0.0-MACHINE-ARTIFACT-INVENTORY:END -->
The machine alias `github-repository-id:1227901578` denotes the private GitHub repository historically named `minustwo/codex-proof-workbench`. The immutable GitHub repository id, commit, path, and blob identify the source; the historical name appears only here as Markdown provenance, never as a live executable/config namespace.


## 4. Research-only pointers outside the frozen window

The following files were read during research but are **not admitted artifacts**
of IEC-0.0 and cannot support a child node unless a later reepoch explicitly
changes the machine source window:

```text
MSTNF/algorithms/MSTNFExecutionNoFifthRoleMWE.lean (residua-labs/MST-NF)
lean/crt/IETStabNFMWE.lean
lean/crt/IETCoreV02BridgeMWE.lean
lean/crt/IETIncentiveResidualMWE.lean
lean/crt/IETResidualSelfGrowthMWE.lean
lean/crt/IETRobustnessSelfGrowthMWE.lean
lean/crt/CRTResidueFreeCharacterizationMWE.lean
lean/crt/CRTNFNoFourthMWE.lean
docs/ADR_RESIDUA_RUNTIME.md
```

They remain useful explanatory or review context. They are not machine pins.

## 5. Upstream claim matrix

| IEC concern | Reusable basis or precedent | Residua realization | RCC role | Phase-0 disposition |
|---|---|---|---|---|
| Semantic identity | MST-NF carrier/equivalence discipline | canonical wire/content `q` | source/identity binding | reuse |
| Admission | MST-NF admissible subset/dynamics | `a`, gate and admission receipt | admitted-trace coverage | reuse; policy open |
| Representative | MST-NF fixed/admitted relation; Residua `σ` | admitted result/event | replay/projection | reuse |
| Unresolved remainder | MST-NF residue/exhaustion; Residua `ρ` | first-class typed residue | reopen/reepoch/halt | reuse |
| Agent adoption/revision | IET/IET-NF | domain programs | explicit assumptions | reference only |
| Correctness/source/dynamics | CRT/CRT-NF | validity/capability/effect programs | separate targets | diagnostic precedent |
| Authority | no ambient authority object | capability/delegation/effect gates | assumptions/revocation | collision |
| Scope | capability action/resource/constraints | q-addressed grant | intent/source coverage | collision |
| Cross-institution recognition | identity/equivariance precedents | identity/capability/fabric | seam compatibility | open |
| Valid-local-output conflict | determinization/Tier-2 precedents | typed conflict residue | disputed target open | open |
| Action and reality effect | CRT motivation | gate → receipt → history | reconciliation | runtime reuse |
| Exit/federation lineage | transport/history precedents | migration/ledger/effects | seam/gluing | collision |
| Ecology closure | none gives ambient global closure | no global authority field | only declared joint intent | open |

## 6. Runtime binding discipline

```text
IEC predicate/theorem
→ Residua program predicate
→ canonical wire q
→ gate result
→ admission receipt
→ effect occurrence/receipt, if reality changes
→ durable history
→ RCC re-check after invalidation
```

No stage is inferred because the previous stage is green.

## 7. Nonclaims

```text
closure_claim = 0
No IEC-NF or IEC ontology is frozen.
IET and CRT are references, not IEC's foundation or runtime.
RCC checks relative closure and does not define IEC content.
Residua's current governance rules are instance data, not universal law.
No global authority, consensus or ecology closure is assumed.
Agent adoption ≠ institutional admission.
Institutional admission ≠ historical or physical effect.
Local institutional closure ≠ ecology closure.
The documentation correction changes no machine source pin.
```
