# IEC C3 Countermodel Closure Implementation Plan


**Goal:** Close the executable C3 countermodels so the two IEC verifier edges can only pass with an exact non-vacuous inventory, a current runtime trace, canonical repository confinement, and explicitly content-addressed `git show` reads.

**Architecture:** Keep one always-run gate, `residua-internal verifier verify_actual_read_subset (not included)`. The gate owns the exact two-edge inventory, records direct reads with `sys.addaudithook`, judges every trace through one production verdict function, and treats subprocess reads as exact semantic subedges declared in `scripts/iec_declared_inputs.json`. The manifest remains data: it may overdeclare direct inputs, but it cannot change edge identity or authorize wildcard subprocesses.

**Tech Stack:** Python standard library, CPython audit hooks, Git object identity, JSON manifest, GitHub Actions.

## Global Constraints

- Runtime reads, not static imports or path taxonomy, are authoritative.
- Acceptance law is `actual_reads ⊆ declared_inputs`; over-declaration is safe and under-declaration refuses.
- Missing, incomplete, or stale traces refuse with `[actual_read_trace_unavailable]`.
- Direct path escape or under-declaration refuses with `[actual_read_outside_declared_input_set]`.
- Scope remains the two IEC registry-consuming verifier edges only; no general Admission-DAG scheduler is introduced.
- Candidate artifacts do not contain their own freeze receipt.

---

### Task 1: Ratchet the exact edge inventory

**Files:**
- Modify: `residua-internal verifier verify_actual_read_subset (not included)`
- Modify: `scripts/iec_declared_inputs.json`

**Interfaces:**
- Consumes: manifest object from `scripts/iec_declared_inputs.json`.
- Produces: `validate_manifest(manifest) -> list[tuple[str, str]]`.

- [ ] Add immutable expected specs for exactly `verify_iec_0_5_map_independently` and `verify_iec_rcc_dependency_closure_disposition`, including verifier path, `--self-test` argv, and subprocess read-set name.
- [ ] Add live mutants for empty inventory, dropped edge, verifier substitution, and duplicate shadow; each must produce `[actual_read_trace_unavailable]` through `validate_manifest`.
- [ ] Iterate the immutable expected inventory after validation, never the manifest-provided list.

### Task 2: Use one nonce-bound production judge

**Files:**
- Modify: `residua-internal verifier verify_actual_read_subset (not included)`

**Interfaces:**
- Produces: `judge_trace(name, trace, verifier_exit, declared, expected_nonce=..., declared_subprocess_reads=...)`.

- [ ] Generate the nonce in `check_edge`, pass it into `run_under_recorder`, and pass the same nonce into `judge_trace`.
- [ ] Route both real edges and missing/stale-trace tests through `judge_trace`.
- [ ] Confirm an uninstalled trace and a mismatched nonce both return `[actual_read_trace_unavailable]`.

### Task 3: Replace the basename exception with exact Git read subedges

**Files:**
- Modify: `residua-internal verifier verify_actual_read_subset (not included)`
- Modify: `scripts/iec_declared_inputs.json`

**Interfaces:**
- Manifest subprocess record: `{tool: "git-show", ref: <40 hex>, path: <repo relative>, blob: <40 hex>}`.
- Runtime record: executable, full argv, cwd, and whether an explicit environment was supplied.

- [ ] Declare the exact historical `ref:path:blob` reads performed by the two IEC verifiers.
- [ ] Accept only `git -C <exact repo> show <declared ref>:<declared path>` with no alternate cwd or explicit environment.
- [ ] Prevalidate each declared subedge by computing the Git blob hash of `git show` output.
- [ ] Refuse symbolic refs, other commands, foreign roots, undeclared refs/paths, executable substitution, raw exec/spawn, or Git environment redirection.

### Task 4: Canonicalize path confinement and run the full tooth battery

**Files:**
- Modify: `residua-internal verifier verify_actual_read_subset (not included)`

**Interfaces:**
- Produces: `normalize_read_path(path, repo_root) -> (repo_relative | None, escape | None)`.

- [ ] Use `realpath` plus `commonpath`; record the canonical target, not the lexical symlink name.
- [ ] Ignore only explicit interpreter library roots derived from `sysconfig`, not substring matches or the entire `sys.prefix` tree.
- [ ] Add a synthetic repository symlink-to-external countermodel and require `[actual_read_outside_declared_input_set]`.
- [ ] Run `python3 -m py_compile residua-internal verifier verify_actual_read_subset (not included)`.
- [ ] Run the synthetic countermodel suite covering inventory, missing/stale trace, exact/non-exact Git calls, and symlink escape.
- [ ] Run `python3 residua-internal verifier verify_actual_read_subset (not included)` in the full repository when the historical Git objects are available; any unavailable object is a typed refusal, never a skip.
