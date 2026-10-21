# IEC-0.4 Theorem / Countermodel / Nonclaim Registry — Plan r2

- [x] Bind exact frozen IEC-0.3r2 artifacts and independent freeze receipt.
- [x] Preserve the five operational countermodels as rows 1–5.
- [x] Enumerate the original 33 theorem targets and 40 countermodels.
- [x] Run a second coverage pass over every frozen term and relation-law field.
- [x] Add five missing relation/openness targets and five matching countermodels.
- [x] Freeze the final 38-target / 45-countermodel / 25-nonclaim frontier.
- [x] Split target families and bind them through a manifest.
- [x] Aggregate base and relation-law countermodels without rewriting history.
- [x] Apply the IEC-NC-025 frontier-count correction through an explicit patch.
- [x] Record term, relation-law, bidirectional target/countermodel, OCM, and deferred-term coverage.
- [x] Add primary and independently written reconstruction verifiers with mutation batteries.
- [ ] Run both verifiers with source checks on in an exact full-history checkout.
- [ ] Obtain disposer theory judgment over the 38/45/25 frontier.
- [ ] Unlock IEC-0.5 only after IEC-0.4 freeze.

```bash
python3 -m py_compile \
  residua-internal verifier verify_iec_0_4_registry_independently (not included) \
  residua-internal verifier verify_iec_theorem_countermodel_nonclaim_registry (not included)

python3 residua-internal verifier verify_iec_0_4_registry_independently (not included) --self-test
python3 residua-internal verifier verify_iec_theorem_countermodel_nonclaim_registry (not included) --self-test
```
