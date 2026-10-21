# IEC-1.0 T003 current-basis disposition v0.1

- Target: `IEC-T003 / BoundedProfileFactorization`
- Bound basis: `4880e53e0e3286346c0aa48be2d466d90face8c4`
- Countermodel: `IEC-CM008 / SameQDifferentOutcome`
- Disposition: `SatisfiedCurrentBasis`
- Proof surface: Prelude-only Lean plus an independent finite checker
- `closure_claim=0`

Fixed profile semantics exposes `q : Raw -> Class` and class-indexed
`a/sigma/rho`. The production theorem proves that equal q values produce equal
admissibility, optional representative, optional typed residue, and bundled
result. A fixture contains two distinct raw aliases in one profile class. A
raw-sensitive mutant keeps q fixed while changing the result, and the
independent checker must catch it as IEC-CM008.

RED authority is permanently retained in
`residua-internal iec conformance record IEC_1_0_T003_RED_RECEIPT_V0_1.json (not included)`: before the production
module existed, the intended import test failed on the missing Lean module and
the pull-request-visible workflow self-deleted after recording that result.

Machine authority after GREEN verification:
`residua-internal iec conformance record IEC_1_0_T003_BOUNDED_PROFILE_FACTORIZATION_V0_1.json (not included)`.

This closes T003 only on the exact bound occurrence. It does not impose the
sigma/rho outcome partition, prove typed residue totality or full
bounded-profile exactness, establish lawful Successor/NewGenesis non-vacuity,
discharge global RCC M1, prove slot coherence or an admitted history trace, or
set `closure_claim=1`.
