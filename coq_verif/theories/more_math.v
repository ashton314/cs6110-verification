Require Import ZArith.
Open Scope Z_scope.

Lemma mul_2_eq_add : forall (x : Z), 2 * x = x + x.
Proof.
  intros x.
  replace (2 * x) with (x + x).
  reflexivity.
  apply Z.add_diag.
Qed.
