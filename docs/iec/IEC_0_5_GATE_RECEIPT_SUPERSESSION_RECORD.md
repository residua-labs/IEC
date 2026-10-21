# IEC-0.5 gate-receipt supersession record

```text
status                     = superseded-by-pending
closure_claim              = 0
disposition                = Advanced
IEC-1.0                    = LOCKED
superseded_candidate_1     = 543916896862d26b948e8dda5b6a33fc8843f524
superseded_candidate_2     = eef319aa0e70302937e9dc100bba0c64f150e122
superseded_candidate_3     = abf2545e174d2c2644983fa5dfe78729b6cf0477
superseded_candidate_4     = 0319417280b18aa3e14a5975e5ba95c35218949d
superseded_candidate_5     = 2e404d8a2e0f9628674162e73701505830fd9fd1
superseded_candidate_6     = 3ec617569b42019684a1db8cfee30c6116eab0f5
superseded_candidate_7     = fa22a29abf4ef820e30c4f3a7acfb1c9e44f9095
repository_replay_parent_1 = 569f33b07b8491fc0d5e808c5565d1a4135aebf3
repository_replay_parent_2 = c498424e837daec526536ee99b132ea33a7df841
repository_replay_merge_2  = faee1bba207c288ed97e17a276c38f1c24a07ca6
repository_replay_parent_3 = d2a34341600912738030e57a13771becbb584356
repository_replay_merge_3  = a9bf9b4e3918fa054aeade6b9efe0abac0fd74c8
repository_replay_parent_4 = da3118466ef68375bd52d82343bf6cf4895758ed
repository_replay_merge_4  = 223b38fa82f0de6e74aa7fa91de7ff2174141458
repository_gate_run_4      = 30544803558
superseded_gate_run_5      = 30549733779
failed_exact_gate_run_6    = 30550744678
quiet_window_issue         = 1995
quiet_window_ack_comment   = 5132006972
supersession_reason        = decision-relevant main basis moved; no receipt transported
required_next_receipt      = repository residua-gate suite at the next exact candidate head
```

## Ruling

`543916896862d26b948e8dda5b6a33fc8843f524` remains the historical IEC-0.5r1
artifact state that established the 38/38 mapping, six admission rulings, seven
self-instance properties, `closure_claim=0`, and `disposition=Advanced`.

It is **not** a freeze basis and is not forward-carried as an admission receipt.
The repository `residua-gate` suite failed on that head because three tracked IEC
configuration/code surfaces retained a dead pre-extraction namespace. The
lane-authored exact-head workflows proved internal IEC artifact consistency, not
repository admission.

The three live/config fragments have been replaced by the stable machine locator
`github-repository-id:1227901578`, with IEC-0.1/0.2 parent identities rebound.
That repair does not reactivate the stale receipt. Under IEC-T026, the next head
must be checked as a new exact basis.

## Second repository-gate refusal

`eef319aa0e70302937e9dc100bba0c64f150e122` is also superseded. Its
repository `residua-gate` run reached the repository-conventions ratchet and
refused eight IEC verifier scripts that were absent from the canonical
`docs/python_surface.txt` inventory. The files existed and the IEC-local gates
used them, but the repository had not admitted their Python surface.

The repair refreshed that canonical inventory and proved the delta was exactly
those eight verifier paths. It did not transport either earlier receipt. The
post-repair commit became a new IEC-T026 basis and required a new exact-head
repository gate plus exact-head IEC checks.

## Third repository-gate refusal

`abf2545e174d2c2644983fa5dfe78729b6cf0477` is also superseded. It repaired
the canonical Python surface, and its exact-head IEC checks were green, but
repository `residua-gate` run `30536503599` correctly refused the candidate at
`tip_diff_deletion_refuse`: the IEC branch had diverged from current `main`, was
375 commits behind the run's current-main basis, and presented 87 current-main
files as undeclared deletions. This was a repository-basis failure, not an
IEC-local verifier failure.

The lawful repair did not allowlist the deletions and did not rerun against a
moving stale ref. PR #1980 was retargeted to `main`; GitHub's repository-native
merge computation produced merge commit
`5655f6e7d46c1beeeeb317259339b3e768facb89`, whose first parent is exact
`main@569f33b07b8491fc0d5e808c5565d1a4135aebf3`. Independent compare metadata
showed it was ahead of that parent, behind by zero, and changed exactly the 55 IEC
surfaces with zero deletions. That merge tree was adopted as the new branch
parent. This record update moves the head once more, so the resulting commit is a
fresh IEC-T026 candidate and receives no transported receipt.

## Repository-native candidate pre-admission supersession

`0319417280b18aa3e14a5975e5ba95c35218949d` lawfully repaired the stale-main
deletion basis: relative to exact
`main@569f33b07b8491fc0d5e808c5565d1a4135aebf3` it was ahead, behind by zero,
and carried zero deletions. Before repository admission completed, the full
extraction tripwire exposed two signed append-only ledger rows inherited from
that exact main parent. Both rows legitimately referenced the still-used sibling
theory authority, but the raw repository name collided with the extraction-source
namespace watched on non-Markdown surfaces.

The rows were not rewritten, deleted, or path-whitelisted on this IEC head. The
next candidate used the repository's existing exact
`(path, line, fragment, line_sha256)` grandfather mechanism for precisely those
two immutable event IDs. Any byte drift, line drift, stale entry, or third
occurrence remained a failure. That head movement created a new IEC-T026 basis;
no repository or lane-local receipt was transported.

## Fourth repository-gate refusal: live main moved during the suite

`2e404d8a2e0f9628674162e73701505830fd9fd1` is also superseded. Its exact
clean-checkout IEC workflow `30544914631` passed the current-main ancestry check,
zero-deletion boundary, extraction tripwire, and all IEC-0.1 through IEC-0.5
primary and independent source verifiers. Repository run `30544803558` then
passed conformance, image, Rust, benchmark, fuzz, Lean, and both cross-box jobs.
The Python job passed every preceding gate and failed only its final
freshly-fetched-main `tip_diff_deletion_refuse` step.

During that full repository run, `main` advanced by two commits from
`569f33b07b8491fc0d5e808c5565d1a4135aebf3` to
`c498424e837daec526536ee99b132ea33a7df841`. The first added the 13-file
`apps/nf-belief-census/` surface; the second edited the two inherited ledger rows.
The final gate therefore correctly observed exactly 13 current-main paths absent
from the candidate and refused with
`[stale_branch_ci_green_masks_mass_deletion]`. A near-complete green suite cannot
outlive its decision-relevant main basis.

No deletion allowlist is introduced and no successful sub-job is promoted into a
repository receipt. GitHub's repository-native merge
`faee1bba207c288ed97e17a276c38f1c24a07ca6` combines exact candidate
`2e404d8a2e0f9628674162e73701505830fd9fd1` with exact
`main@c498424e837daec526536ee99b132ea33a7df841`; compare metadata showed the
merge was behind that parent by zero and carried no deleted path. That merge tree
is the next replay basis.

Current main no longer contains the watched dead-namespace fragment on the two
ledger lines, so the prior two-entry extraction grandfather would be stale and
is removed, restoring the grandfather inventory to `[]`. This removal does **not**
ratify main's in-place ledger rewrite, repair its disclosed event-id/D1-mirror
divergence, or convert repository substrate history into IEC proof. It only keeps
the replay faithful to the exact main bytes and preserves the extraction check's
shrink-only stale-entry law.

The replay merge, grandfather retirement, and this record update all move the
candidate head. Under IEC-T026, both earlier machine receipts are invalidated and
the resulting exact head requires a fresh repository suite plus fresh exact-head
IEC primary/independent verification before disposer judgment.

## Fifth basis supersession: main moved again after exact-head IEC success

`3ec617569b42019684a1db8cfee30c6116eab0f5` is superseded before it can carry
a repository receipt. Exact clean-checkout workflow `30549863854`, job
`90895409681`, passed current-main ancestry, zero-deletion safety, extraction, and
all IEC-0.1 through IEC-0.5 primary and independent source gates at that exact
head. Repository run `30549733779` also began on that exact head and reached green
results in conformance, image, Rust, benchmark, fuzz, Lean, and both cross-box
jobs while its long Python matrix continued.

At `2026-07-30T14:08:19Z`, after those runs began, `main` advanced from
`c498424e837daec526536ee99b132ea33a7df841` to
`d2a34341600912738030e57a13771becbb584356` by appending one coordination-ledger
work-claim row. That one repository write changes the decision-relevant main cut.
The old exact-head IEC receipt is therefore stale immediately, and the repository
run cannot become a lawful freeze receipt even if all pre-boundary jobs finish
green. No successful sub-job is transported.

GitHub repository-native merge
`a9bf9b4e3918fa054aeade6b9efe0abac0fd74c8` combines exact candidate
`3ec617569b42019684a1db8cfee30c6116eab0f5` with exact
`main@d2a34341600912738030e57a13771becbb584356`. Independent compare metadata
showed the merge is behind that parent by zero and carries zero deleted paths.
That merge tree becomes the next IEC-T026 replay basis.

Because repeated concurrent main writes can make a correct 40-minute repository
suite perpetually stale at its final fresh-main boundary, issue `#1995` requests
one bounded 45-minute main-quiet window. This is coordination, not weakening: the
final gate remains live and must observe one stable `InstitutionalCut`. The replay
merge and this record update move the candidate head, so both machine receipts
must run again from zero.

## Sixth preflight supersession: main moved before the exact gate could start

`fa22a29abf4ef820e30c4f3a7acfb1c9e44f9095` is also superseded. It was the
repository-native replay of the IEC stack onto
`main@d2a34341600912738030e57a13771becbb584356`. Before exact workflow
`30550744678` could pass its current-main ancestry assertion, main advanced again
to `da3118466ef68375bd52d82343bf6cf4895758ed` through a second
coordination-ledger append. Job `90898437933` therefore failed at the ancestry
step before compiling or running any IEC verifier. No machine receipt exists for
this head.

Issue `#1995`, comment `5132006972`, grants a bounded 45-minute main-quiet window
and explicitly holds both git-ledger appends and their paired D1 writes. The hold
was relayed to cc so the claim-to-mirror loop cannot move the cut either. Branch
writes remain allowed because they do not move `main`; only a disclosed STOP-level
incident may break the window.

GitHub repository-native merge
`223b38fa82f0de6e74aa7fa91de7ff2174141458` combines exact superseded head
`fa22a29abf4ef820e30c4f3a7acfb1c9e44f9095` with exact quiet-window main
`da3118466ef68375bd52d82343bf6cf4895758ed`. Independent compare metadata showed
it is behind that parent by zero and carries zero deleted paths. The merge and
this record update create the next exact IEC-T026 candidate; both machine receipts
must now run from zero inside the granted window.

## Receipt law amendment

A freeze-class receipt is sufficient only when all of the following hold:

1. it names the exact candidate head;
2. the repository's own `residua-gate` suite succeeds on that exact head;
3. lane-local primary and independent verifiers also succeed where required;
4. the disposer separately performs the theory judgment;
5. any head movement invalidates the receipt and requires a new run.

A workflow written by the lane under review may establish internal consistency,
but cannot substitute for repository admission. A declaration checked only by
the engine that produced it is not independently admitted.

## RCC authority correction

Current machine authority remains exactly:

```text
E6 E7 E8
3 / 107
```

`E5` and the historical RCC-13/RCC-14/RCC-25 snapshot are not current reusable
machine discharge.

## Nonclaims

```text
no IEC-0.5 freeze is granted by this record
no prior head is silently transported forward
no IEC theorem is discharged
no IEC-NF or new MST-NF axis is introduced
no repository-gate success is claimed until the exact-head suite reports success
```

## IEC-0.5 r2 Admission-DAG re-pin

    Frozen r1 head `b15093873246f3d07fe14328495d0eab649997b4` and receipt comment `5133185447` remain
    historical evidence. They are not current-use authority for the expanded Admission-DAG
    source. The r2 branch replaces only the source cut and mechanically dependent identities,
    pins `0179ac8af4d9c6e3d9b23605cac6de678ce2bffb` / `ef9d34faa149a735b66b23315b2b6ffb2321696d`, and requires fresh exact-head IEC, repository-admission,
    and disposer receipts. IEC-1.0 stays locked throughout this amendment.
