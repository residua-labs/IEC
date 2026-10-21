# IEC‑0.1 Operational Countermodel Registry Implementation Plan


**Goal:** Freeze IEC‑0.0 and add a five-row, evidence-bound IEC operational countermodel registry with a deterministic independent verifier.

**Architecture:** The human-readable IEC document and machine JSON registry share one fixed countermodel basis. A stdlib-only Python verifier checks registry structure, source-window identity, pinned historical evidence, exact JSONL selectors, and rejection mutants. No IEC ontology, Lean theorem, Residua runtime semantic change, or RCC discharge is introduced.

**Tech Stack:** Markdown, JSON, Python 3 standard library, Git object identity, GitHub branch/PR workflow.

## Global Constraints

- IEC formal foundation is MST-NF.
- IEC runtime is Residua.
- RCC is the closure checker.
- IET and CRT are theoretical/normalized references only.
- `IEC-NF` is not assumed.
- `closure_claim` remains exactly `0`.
- `disposition` remains exactly `Reepoch`.
- The current Residua institution is evidence and a future self-instance, not the universal template.
- No existing Residua runtime, evaluator, gate, or Lean semantics file is modified.

---

### Task 1: Freeze the approved IEC‑0.0 source window

**Files:**
- Create: `docs/iec/IEC_0_0_UPSTREAM_CLAIM_MATRIX_V0_1.md`
- Create: `docs/iec/IEC_0_0_PINNED_SOURCE_WINDOW_V0_1.json`

**Interfaces:**
- Consumes: the approved IEC‑0.0 lineage and source decisions from the prior session.
- Produces: a frozen, machine-readable source window whose SHA-256 and Git blob SHA are consumed by Task 2 and Task 3.

- [ ] **Step 1: Write the approved frozen source window**

Set the Markdown header to:

```text
status          = frozen
frozen_at       = 2026-07-29
closure_claim   = 0
disposition     = Reepoch
```

Set JSON fields:

```json
{
  "status": "frozen",
  "frozen_at": "2026-07-29",
  "closure_claim": 0,
  "disposition": "Reepoch"
}
```

Pin the approved repository commits, critical artifact blob SHAs, lineage, nonclaims, and `next_allowed_node`.

- [ ] **Step 2: Validate JSON and identities**

Run:

```bash
python3 -m json.tool docs/iec/IEC_0_0_PINNED_SOURCE_WINDOW_V0_1.json >/dev/null
sha256sum docs/iec/IEC_0_0_PINNED_SOURCE_WINDOW_V0_1.json
```

Expected SHA-256:

```text
b30f2b5aa0754a2c743fa1d445a03305722f67e8f9697eeefe82d43dafde778a
```

Expected Git blob SHA:

```text
cc2dcb02fd37b25e78fc79a60d7b53fdad76ab63
```

- [ ] **Step 3: Commit**

```bash
git add docs/iec/IEC_0_0_*
git commit -m "docs(iec): freeze phase-0 source window"
```

---

### Task 2: Add the operational countermodel registry

**Files:**
- Create: `docs/iec/IEC_0_1_OPERATIONAL_COUNTERMODEL_REGISTRY_V0_1.md`
- Create: `residua-internal iec conformance record IEC_OPERATIONAL_COUNTERMODEL_REGISTRY_V0_1.json (not included)`

**Interfaces:**
- Consumes: Task 1 source-window SHA-256 `b30f2...778a` and blob SHA `cc2dc...ab63`.
- Produces: exact countermodel IDs `IEC-OCM-001` through `IEC-OCM-005` and target IDs `IEC-P0-EVIDENCE-001`, `IEC-P0-BINDING-001`, `IEC-P0-SCOPE-001`, `IEC-P0-AUTHORITY-001`, `IEC-P0-EXIT-001`.

- [ ] **Step 1: Write the machine registry**

Use schema:

```text
iec-operational-countermodel-registry/v0.1
```

Require:

```json
{
  "status": "passed",
  "freeze_status": "candidate_for_freeze",
  "closure_claim": 0,
  "disposition": "Reepoch",
  "next_allowed_node": "IEC-0.2 Nearest-Object Collision Analysis"
}
```

The five ordered countermodels are:

```text
IEC-OCM-001 SelfMeasurementWithoutForeignFactor
IEC-OCM-002 DeclarationWithoutExecutionBinding
IEC-OCM-003 DisposerInsideDisposedSystem
IEC-OCM-004 KnowledgeInheritedAuthorityNotInherited
IEC-OCM-005 ExitOnlyByDeath
```

Each row must include all fields enforced by Task 3's `REQUIRED_COUNTERMODEL_FIELDS`.

- [ ] **Step 2: Pin evidence**

Document evidence uses:

```text
ref  dbd3f4b5405db49164f84f399733078c3e11ba63
ADR blob 1b7dbe1a193c0cb0a0aee5d6a872a2f63f67352f
graph-test blob a04a91396e474c4ebffe5487155f7c71c617ad53
```

JSONL selectors:

```text
IEC-OCM-003 object_q 9dfb210676ac805d8f818326d0cdaf26928b3a66dfe7a50c167230c09ec72c92
IEC-OCM-004 object_q 4c38ae404dcdd58b1d1cf6dd640503b5d2ca4010fd16f1a8afbaaf02ad817bdb
IEC-OCM-005 object_q 47b43f8cd7e77b61a3c5ab685f73e6c017d0909af9e2f95dc943ad2f04d17977
```

- [ ] **Step 3: Write the human-readable registry**

For each countermodel, repeat the exact operational witness, invalid inference, required distinctions, minimum obligation, evidence identity, and specific nonclaims. State that typed value conflict remains later pressure rather than silently becoming a sixth row.

- [ ] **Step 4: Validate JSON shape**

Run:

```bash
python3 -m json.tool residua-internal iec conformance record IEC_OPERATIONAL_COUNTERMODEL_REGISTRY_V0_1.json (not included) >/dev/null
```

Expected: exit `0`.

- [ ] **Step 5: Commit**

```bash
git add docs/iec/IEC_0_1_* residua-internal iec conformance record IEC_OPERATIONAL_COUNTERMODEL_REGISTRY_V0_1.json (not included)
git commit -m "docs(iec): enumerate operational countermodels"
```

---

### Task 3: Add the deterministic registry verifier

**Files:**
- Create: `residua-internal verifier verify_iec_operational_countermodel_registry (not included)`

**Interfaces:**
- Consumes: Task 1 source window and Task 2 machine registry.
- Produces: CLI exit `0` with `PASS` or exit `1` with a deterministic list of failures.

- [ ] **Step 1: Implement identity helpers**

Implement:

```python
def sha256(data: bytes) -> str: ...
def blob_sha(data: bytes) -> str: ...
def git_show(root: Path, ref: str, path: str) -> bytes: ...
```

`git_show` must execute:

```text
git -C <root> show <ref>:<path>
```

and fail closed on a nonzero result.

- [ ] **Step 2: Implement evidence checks**

Implement exact functions:

```python
def check_evidence(root: Path, evidence: dict[str, Any], source_checks: bool) -> list[str]: ...
```

A JSONL selector must match exactly one row. Every anchor must occur in that selected raw row.

- [ ] **Step 3: Implement registry validation**

Implement:

```python
def validate(registry: dict[str, Any], root: Path, source_checks: bool) -> list[str]: ...
```

It must enforce exact schema, five IDs and order, five target IDs and order, unique IDs, complete target coverage, source-window identity, evidence, normalization status, at least five registry nonclaims, `closure_claim=0`, and `disposition=Reepoch`.

- [ ] **Step 4: Implement rejection mutants**

Implement `self_tests` with these seven mutants:

```text
closure claim escalation
missing fifth countermodel
duplicate countermodel id
evidence removed
normalization prematurely closed
nonclaims erased
source window identity drift
```

Every mutant must be rejected.

- [ ] **Step 5: Run local structure verification**

Run:

```bash
python3 residua-internal verifier verify_iec_operational_countermodel_registry (not included) \
  --no-source-check --self-test
```

Expected:

```text
IEC operational countermodel registry: PASS (5 countermodels, source_checks=off)
```

- [ ] **Step 6: Run full pinned-source verification**

Run from a real checkout containing commit `dbd3f4...`:

```bash
python3 residua-internal verifier verify_iec_operational_countermodel_registry (not included) --self-test
```

Expected:

```text
IEC operational countermodel registry: PASS (5 countermodels, source_checks=on)
```

- [ ] **Step 7: Commit**

```bash
git add residua-internal verifier verify_iec_operational_countermodel_registry (not included)
git commit -m "test(iec): verify operational countermodel registry"
```

---

### Task 4: Review and publish the candidate

**Files:**
- Create: `docs/design/specs/2026-07-29-iec-0-1-operational-countermodel-registry-design.md`
- Create: `docs/design/plans/2026-07-29-iec-0-1-operational-countermodel-registry.md`

**Interfaces:**
- Consumes: all prior tasks.
- Produces: a draft PR whose claim is limited to Phase‑0 registry integrity.

- [ ] **Step 1: Run consistency scans**

```bash
grep -RE "closure_claim[[:space:]]*[:=][[:space:]]*[1-9]" docs/iec residua-internal IEC conformance records (not included) && exit 1 || true
grep -RE "IEC-NF is established|global closure is established|universal institution policy" docs/iec residua-internal IEC conformance records (not included) && exit 1 || true
python3 -m json.tool docs/iec/IEC_0_0_PINNED_SOURCE_WINDOW_V0_1.json >/dev/null
python3 -m json.tool residua-internal iec conformance record IEC_OPERATIONAL_COUNTERMODEL_REGISTRY_V0_1.json (not included) >/dev/null
python3 residua-internal verifier verify_iec_operational_countermodel_registry (not included) --self-test
```

Expected: all commands exit `0`; the final verifier prints `PASS`.

- [ ] **Step 2: Review scope**

Confirm the diff contains no changes to Residua-internal Lean, Python, Rust, binding or CI sources (not included).

- [ ] **Step 3: Open a draft PR**

Title:

```text
IEC Phase 0: freeze source window and enumerate operational countermodels
```

The body must state:

```text
closure_claim=0
No IEC ontology or IEC-NF is introduced.
Full source checks are performed by the committed verifier in a real checkout.
Next node remains IEC-0.2 after registry freeze.
```
