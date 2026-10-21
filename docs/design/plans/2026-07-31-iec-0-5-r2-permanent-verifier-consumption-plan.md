# IEC-0.5r2 permanent verifier consumption — implementation plan

1. Reuse the existing direct `s8_frozen_evidence` workflow block rather than adding a second scheduler.
2. Extend `residua-internal verifier verify_s8_input_completeness_teeth (not included)` with explicit IEC-0.5r2 C1 consumption.
3. Resolve and verify the four immutable source refs needed by full source checks.
4. Compile and run both IEC-0.5r2 verifiers with `--self-test`; never pass `--no-source-check` and never route through receipt skip/mint.
5. Fail closed with named residues when a source ref or verifier cannot be consumed.
6. Verify that the two mutation suites leave the worktree clean.
7. Run the normal PR repository gate on the new exact head and generated merge tree.
8. Read the new Python job logs to confirm both PASS lines report `source_checks=on` and the final fresh-main boundary reports `deleted=0 / undeclared=0`.
9. Treat `e370a657...`, `da8f1291...`, and runs `30598552517` / `30598942809` as historical occurrences only; transport no verdict or receipt.
10. After complete green evidence, write a fresh disposer-facing C1 status update. Do not grant the r2 freeze and do not unlock IEC-1.0; C2 and C3 remain separately binding.
