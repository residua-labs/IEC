/-!
# IEC-T003 — Bounded Profile Factorization

For one fixed bounded-profile semantics, raw observations can reach
admissibility, representative, and residue only through `q`.

This module closes only IEC-T003 on a bound occurrence. It deliberately does
not impose the sigma/rho partition (T004), typed residue coverage (T005), full
profile exactness (T006), or lawful-plan non-vacuity (T024).

Prelude-only Lean 4. No Mathlib, no `sorry`, no hash-injectivity axiom.
-/

namespace Residua.IEC.T003

universe u v w x

/-- One fixed profile semantics. Every decision function consumes the profile
class, never raw identity. -/
structure FixedProfileSemantics
    (Raw : Type u) (Class : Type v) (Rep : Type w) (Residue : Type x) where
  q : Raw → Class
  admissible : Class → Bool
  sigma : Class → Option Rep
  rho : Class → Option Residue

/-- The exact T003 observation surface. T004 will later constrain which
sigma/rho combinations are lawful; T003 only proves factorization. -/
structure ProfileResult (Rep : Type w) (Residue : Type x) where
  admissible : Bool
  sigma : Option Rep
  rho : Option Residue
  deriving DecidableEq

/-- Raw evaluation is composition through q by construction. -/
def result
    (P : FixedProfileSemantics Raw Class Rep Residue)
    (raw : Raw) : ProfileResult Rep Residue :=
  { admissible := P.admissible (P.q raw)
    sigma := P.sigma (P.q raw)
    rho := P.rho (P.q raw) }

/-- Equal profile classes force equal admissibility results. -/
theorem admissible_factors_through_q
    (P : FixedProfileSemantics Raw Class Rep Residue)
    {left right : Raw}
    (hq : P.q left = P.q right) :
    P.admissible (P.q left) = P.admissible (P.q right) :=
  congrArg P.admissible hq

/-- Equal profile classes force equal optional representatives. -/
theorem sigma_factors_through_q
    (P : FixedProfileSemantics Raw Class Rep Residue)
    {left right : Raw}
    (hq : P.q left = P.q right) :
    P.sigma (P.q left) = P.sigma (P.q right) :=
  congrArg P.sigma hq

/-- Equal profile classes force equal optional typed residues. -/
theorem rho_factors_through_q
    (P : FixedProfileSemantics Raw Class Rep Residue)
    {left right : Raw}
    (hq : P.q left = P.q right) :
    P.rho (P.q left) = P.rho (P.q right) :=
  congrArg P.rho hq

/-- The complete bounded T003 result factors through q. -/
theorem result_factors_through_q
    (P : FixedProfileSemantics Raw Class Rep Residue)
    {left right : Raw}
    (hq : P.q left = P.q right) :
    result P left = result P right :=
  congrArg
    (fun cls =>
      ({ admissible := P.admissible cls
         sigma := P.sigma cls
         rho := P.rho cls } : ProfileResult Rep Residue))
    hq

/-- IEC-CM008, stated as the forbidden same-q/different-result shape. -/
def SameQDifferentOutcome
    (P : FixedProfileSemantics Raw Class Rep Residue) : Prop :=
  ∃ left right,
    P.q left = P.q right ∧ result P left ≠ result P right

/-- Under fixed semantics IEC-CM008 is impossible. -/
theorem same_q_different_outcome_impossible
    (P : FixedProfileSemantics Raw Class Rep Residue) :
    ¬ SameQDifferentOutcome P := by
  intro h
  cases h with
  | intro left hleft =>
    cases hleft with
    | intro right hpair =>
      exact hpair.2 (result_factors_through_q P hpair.1)

end Residua.IEC.T003
