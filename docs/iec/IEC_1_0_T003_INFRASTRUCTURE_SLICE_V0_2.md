# IEC-1.0 T003 infrastructure semantic slice v0.2

This successor occurrence preserves the frozen v0.1 theorem and RED/GREEN
evidence while retiring three current-use whole-file assumptions:

- the historical checker blob is relocated byte-for-byte to
  `residua-internal verifier verify_iec_t003_factorization_v0_1 (not included)`;
- the old `lakefile.lean` blob remains historical evidence, but current use
  verifies only the exact `IECBoundedProfileFactorization` target block;
- the old `residua-gate.yml` blob remains historical evidence, but current use
  verifies only the T003 build target and the exact axiom/checker steps.

Current authority is:

```text
residua-internal Rust gate iec_t003_gate.rs (not included)
residua-internal iec conformance record IEC_1_0_T003_INFRASTRUCTURE_SLICE_V0_2.json (not included)
residua-internal iec conformance record IEC_T003_V0_1_CHECKER_BYTES (not included)
```

The verifier reuses every non-infrastructure v0.1 check, validates the relocated
legacy blob, extracts the two current semantic slices, and runs a self-test:

```text
unrelated workflow or Lake growth     accepted
T003 axiom-command mutation           refused
T003 Lake-root mutation               refused
duplicate T003 checker step           refused
```

This closes infrastructure pin transport for T003 only. It does not discharge
IEC-T004, IEC-T005, IEC-T006, IEC-T024, global RCC M1, slot coherence, admitted
history, or `GlobalEpochClosed`. `closure_claim=0`.
