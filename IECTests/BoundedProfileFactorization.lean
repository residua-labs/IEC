import IEC.BoundedProfileFactorization

open Residua.IEC.T003

namespace Residua.IEC.T003.Tests

inductive Raw where
  | aliasA
  | aliasB
  | rejected
  deriving DecidableEq

inductive Class where
  | admitted
  | rejected
  deriving DecidableEq

inductive Rep where
  | settled
  deriving DecidableEq

inductive Residue where
  | failed
  | rawSensitive
  deriving DecidableEq

def q : Raw → Class
  | .aliasA => .admitted
  | .aliasB => .admitted
  | .rejected => .rejected

def admissible : Class → Bool
  | .admitted => true
  | .rejected => false

def sigma : Class → Option Rep
  | .admitted => some .settled
  | .rejected => none

def rho : Class → Option Residue
  | .admitted => none
  | .rejected => some .failed

def fixture : FixedProfileSemantics Raw Class Rep Residue where
  q := q
  admissible := admissible
  sigma := sigma
  rho := rho

theorem aliases_distinct : Raw.aliasA ≠ Raw.aliasB := by
  decide

theorem aliases_same_q : fixture.q .aliasA = fixture.q .aliasB := by
  rfl

theorem aliases_same_result :
    result fixture .aliasA = result fixture .aliasB :=
  result_factors_through_q fixture aliases_same_q

theorem nontrivial_same_q_witness :
    ∃ left right : Raw,
      left ≠ right ∧
      fixture.q left = fixture.q right ∧
      result fixture left = result fixture right := by
  refine ⟨.aliasA, .aliasB, aliases_distinct, aliases_same_q, ?_⟩
  exact aliases_same_result

/-- Forbidden implementation convention: inspect raw identity after q. -/
def mutantResult : Raw → ProfileResult Rep Residue
  | .aliasA => result fixture .aliasA
  | .aliasB =>
      { admissible := true
        sigma := none
        rho := some .rawSensitive }
  | .rejected => result fixture .rejected

theorem mutant_same_q_different_outcome :
    fixture.q .aliasA = fixture.q .aliasB ∧
    mutantResult .aliasA ≠ mutantResult .aliasB := by
  constructor
  · rfl
  · decide

end Residua.IEC.T003.Tests
