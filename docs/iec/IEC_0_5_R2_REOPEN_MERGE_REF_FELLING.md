# IEC-0.5r2 — Reopen-event merge-ref felling record

```text
status        = operational counterexample recorded
closure_claim = 0
disposition   = Reepoch
IEC-1.0       = LOCKED
```

## Scope

This record explains why two repository `residua-gate` runs over the same IEC-0.5r2
head cannot serve as admission receipts. It changes no IEC theorem target, RCC
mapping, Admission-DAG ruling, disposer self-instance property, or proof status.

## Exact IEC head

```text
IEC head = 4626c790087b3b05649e1f98542d9f46f6144b5e
```

The supplemental source gate for that head remains a valid internal-consistency
observation:

```text
run 30562898436 / job 90940153254
IEC-0.5 primary                       PASS
IEC-0.5 independent                   PASS
source_checks                         on
```

It is not a repository-admission receipt.

## First reopen generation

The first close/reopen cycle generated repository run `30598135922`. Its event
was pinned to synthetic merge SHA:

```text
expected by event = c150d1eb3ec1cd11808847bce3ebf0903aa141ec
```

By the time the self-hosted `build-images` job fetched
`refs/pull/1980/merge`, GitHub had published the next synthetic merge:

```text
fetched from ref = e72e935e1b069a2695dc28c4527240e4a0e4c417
```

The job correctly refused instead of falling back to the IEC head or accepting a
different merge tree.

## Second reopen generation

A second close/reopen cycle generated repository run `30598246417`. Its event was
pinned to:

```text
expected by event = e72e935e1b069a2695dc28c4527240e4a0e4c417
```

The live merge ref had advanced again to:

```text
fetched from ref = a389a0cafd1f60dcab661a703ebbe0359572a8f0
```

`build-images` again correctly refused. Successful sub-jobs from either run are
not transported into an admission receipt.

## Countermodel and residue

The two observations instantiate one operational countermodel:

```text
close/reopen event
→ event records generation n of refs/pull/1980/merge
→ reopening causes GitHub to publish generation n+1
→ a later exact-ref fetch observes n+1
→ S8 drift guard refuses n ≠ n+1
```

Named residue:

```text
[reopen_event_pins_previous_synthetic_merge]
```

This is not an IEC content failure and not a reason to weaken the guard. The guard
is the mechanism that prevents a green result for an unobserved third tree.

## Lawful transition

The next repository-admission attempt is produced by a normal branch
`synchronize` event, not another close/reopen cycle. This record itself is the
meaningful head movement that creates that event.

Consequences:

```text
old IEC-0.5r2 head receipts      historical only
new synchronized head           fresh IEC-T026 basis
repository suite                 rerun from zero
IEC primary/independent checks   rerun at the new exact head
receipt transport                false
manual merge                     forbidden
force-push                       forbidden
IEC-1.0                          remains locked
```

No freeze is granted by this record.
