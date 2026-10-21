# IEC-0.5r2 permanent verifier consumption — design

## Status and scope

This slice discharges disposer condition C1 only: the two mutation-bearing IEC-0.5r2 verifiers become permanent consumers of the canonical repository-admission path.

It does **not** grant the r2 freeze, transport any earlier receipt, unlock IEC-1.0, implement the RULING-005 actual-read subset relation, ratify the Admission DAG, activate the disposer seat, or change any IEC/RCC proof status.

## Existing canonical consumer

The `python` job in `.github/workflows/residua-gate.yml` already runs the direct, uncached `s8_frozen_evidence` block on every gate execution. That block invokes:

```text
residua-internal verifier verify_s8_input_completeness_teeth (not included)
```

M2.3 derives its gate suite from the same `python` and `lean` workflow `run:` blocks, so this one checked-in entrypoint is consumed by both GitHub Actions and the independent M2.3 admission runner. No second scheduling authority is introduced.

## C1 wire

Extend the residua-internal verifier `verify_s8_input_completeness_teeth` (not included) so its normal execution:

1. resolves the four immutable source commits required by IEC source checks;
2. compiles both IEC-0.5r2 verifiers;
3. runs both verifiers with `--self-test` and source checks enabled;
4. refuses an unavailable source commit as `[iec_0_5_source_ref_unavailable]`;
5. refuses any verifier failure as `[iec_0_5_r2_permanent_consumption_failed]`; and
6. confirms that verifier execution leaves the checked-out tree clean.

The two consumed commands are exactly:

```bash
python3 residua-internal verifier verify_iec_0_5_map_independently (not included) --self-test
python3 residua-internal verifier verify_iec_rcc_dependency_closure_disposition (not included) --self-test
```

The path is deliberately outside `skip_or_run.py`, S8 receipt restore/mint, and every temporary path fast lane. The existing workflow command remains direct and always-run; no cache identity or receipt can bypass the mutation suites.

## Source-ref behavior

The candidate branch is historically stacked, while ordinary Actions checkout may be shallow. The consumer first asks Git whether each pinned commit is already present. Missing commits are fetched by exact immutable SHA; the Admission-DAG source also has the stable `refs/pull/1969/head` fallback. The commit object must resolve after fetch or the gate fails closed.

## Receipt boundary

The candidate artifact keeps:

```text
digests.receipt_q = null
```

Filling that field would move the object being certified and create circular self-receipting. C2 is satisfied later by a non-null **external freeze-grant receipt** that binds the new candidate head, generated merge tree, complete repository verdict, and fresh-main deletion boundary. This C1 slice creates no receipt.

## Nonclaims

- `closure_claim` remains zero.
- All 38 IEC targets remain `not_discharged`.
- Current RCC machine authority remains E6/E7/E8.
- Disposer construction remains `Advanced`; activation remains `Await(Klaus RATIFY)`.
- IEC-1.0 remains locked behind C3 and the remaining phase-transition conditions.
