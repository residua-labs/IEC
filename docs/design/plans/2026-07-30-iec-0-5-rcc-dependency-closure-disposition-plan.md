# IEC-0.5 RCC Dependency / Closure-Disposition — Plan r1

- [x] Bind IEC-0.4 frozen head, exact artifacts, ledger freeze row, and external bell id.
- [x] Bind current RCC proof authority and distinguish it from the historical v2 proof snapshot.
- [x] Map all 38 IEC targets to RCC obligation IDs and interfaces.
- [x] Split the map into five content-bound target-family registries and one manifest.
- [x] Give every IEC target one lawful `Advanced / dispatch_propose` next action.
- [x] Derive the overall RCC branch from the runtime priority rule.
- [x] Adjudicate admission-DAG vocabulary reuse and ordinary-PR cut applicability.
- [x] Register the disposer-as-role Residua self-instance candidate.
- [x] Select the bounded IEC-0.2 profile as the first lawful Phase-1 slice.
- [x] Preserve all thirteen deferred rich terms and `closure_claim=0`.
- [x] Add primary and independent mutation-bearing verifiers.
- [ ] Run both verifiers with `source_checks=on --self-test` at the exact candidate head.
- [ ] Obtain disposer theory judgment; only then freeze IEC-0.5 and unlock IEC-1.0.

```bash
python3 -m py_compile \
  residua-internal verifier verify_iec_rcc_dependency_closure_disposition (not included) \
  residua-internal verifier verify_iec_0_5_map_independently (not included)

python3 residua-internal verifier verify_iec_0_5_map_independently (not included) --self-test
python3 residua-internal verifier verify_iec_rcc_dependency_closure_disposition (not included) --self-test
```

## IEC-0.5-R2-ADMISSION-REPIN-PLAN

    1. Replace the r1 Admission-DAG source identity with `0179ac8af4d9c6e3d9b23605cac6de678ce2bffb` / `ef9d34faa149a735b66b23315b2b6ffb2321696d`.
    2. Recompute the alignment q, alignment blob, goal-registry q, component identities,
       verifier identities, and human-document identity without changing the 38-target map.
    3. Add refusal mutants for old-source rollback, decorative input declarations,
       missing shrink obligation, receipt transport, and premature Phase-1 unlock.
    4. Run both IEC-0.5 verifiers with source checks enabled against the fetched exact ADR cut.
    5. Treat the resulting head as candidate-for-refreeze; no prior receipt is transported.
