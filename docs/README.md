# IEC documentation

- `iec/` — the IEC research record: IEC-0.0 pinned source window and upstream
  claim matrix, IEC-0.1 operational countermodel registry, IEC-0.2 nearest-object
  collision analysis, IEC-0.3 minimal vocabulary, IEC-0.4 theorem / countermodel /
  non-claim registry, IEC-0.5 RCC dependency and closure disposition (plus its
  gate-receipt supersession record and the R2 reopen record), IEC-1.0 T003 and J1
  current-basis notes, and the Phase A proof-strength audit.
- `design/specs/` and `design/plans/` — the design specs and implementation plans
  written for each IEC stage.

## Note on references

These documents were written inside the larger Residua repository. Lean
references have been rewritten to the public paths of this repository
(`IEC/…`, `Conflux/…`, `IECTests/…`), of
[residua-labs/RCC](https://github.com/residua-labs/RCC) (`RCC/…`), or of
[residua-labs/MST-NF](https://github.com/residua-labs/MST-NF) (`MSTNF/…`) where the
module is published. Module paths in this repository map from Residua as follows:

| Residua module | This repository |
|---|---|
| `algorithms.IECBoundedProfileFactorization` | `IEC.BoundedProfileFactorization` |
| `algorithms.ResiduaIECRelativeCompleteClosure` | `IEC.RelativeCompleteClosure` |
| `algorithms.ResiduaIECConfluxAdapter` | `Conflux.IECAdapter` |
| `algorithms.ResiduaConfluxIECCurrentCutBinding` | `Conflux.IECCurrentCutBinding` |
| `algorithms.ResiduaConfluxMSTNFComposition` | `Conflux.MSTNFComposition` |
| `algorithms.ResiduaConfluxProfileInstallationGate` | `Conflux.ProfileInstallationGate` |
| `algorithms.ResiduaConfluxRCCCompositeSeam` | `Conflux.RCCCompositeSeam` |
| `algorithms.ResiduaRCC<Name>` | `RCC.<Name>` (residua-labs/RCC) |
| `algorithms.<Module>Tests` | `IECTests.<Name>` |

Many documents mention Residua-internal artifacts that are **not** published:
machine conformance records, SCM targets, the Rust gate, Python verifiers, the
Docker axiom gate and CI workflows. Their paths have been replaced by neutral
descriptions such as "residua-internal verifier ... (not included)". Content
hashes, git blob ids and commit ids are historical and kept verbatim for
traceability. Issue/PR numbers (`#NNN`)
refer to the private Residua tracker. `github-repository-id:1227901578` is the
private research workbench, parts of which are published as residua-labs/MST-NF.
