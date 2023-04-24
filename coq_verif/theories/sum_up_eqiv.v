Require Import Arith.

Theorem zero_plus_n : forall n : nat, 0 + n = n.
Proof.
  intros.
  simpl.
  reflexivity.
Qed.

Theorem plus_zero_n: forall n : nat, n + 0 = n.
Proof.
  intros n.
  induction n as [| n' IHn'].
  - simpl. reflexivity.
  - simpl. rewrite -> IHn'. reflexivity.
Qed.

Theorem double_twice : forall n : nat, 2 * n = n + n.
Proof.
  intros.
  induction n as [| n' IHn'].
  - simpl. reflexivity.
  - simpl. rewrite -> plus_zero_n. reflexivity.
Qed.

Fixpoint sum_up (n : nat) :=
  match n with
  | O => O
  | S n' => n + sum_up n'
  end.

Compute sum_up 5.

Fixpoint div2 (n : nat) :=
  match n with
  | O => O
  | S O => O
  | S (S n') => S (div2 n')
  end.

Compute div2 5.
Compute div2 6.

Definition closed_form_sum (n : nat) : nat :=
  div2 (n * (n + 1)).

Compute closed_form_sum 5.
Compute closed_form_sum 9.

Theorem add_assoc : forall x y z : nat, x + (y + z) = x + y + z.
Proof.
  intros. induction x as [| x' IHn'].
  - simpl. reflexivity.
  - simpl. rewrite IHn'. reflexivity.
Qed.

Theorem plus_n_Sm : forall n m : nat, S (n + m) = n + (S m).
Proof.
  intros. induction n as [| n' IHn'].
  - simpl. reflexivity.
  - simpl. rewrite IHn'. reflexivity.
Qed.

Theorem plus_Sn_m : forall n m : nat, S n + m = S (n + m).
Proof.
  intros. simpl. reflexivity.
Qed.

Theorem add_comm : forall x y : nat, x + y = y + x.
Proof.
  intros. induction x as [| x' IHn'].
  - simpl. rewrite plus_zero_n. reflexivity.
  - simpl. rewrite IHn'. rewrite plus_n_Sm. reflexivity.
Qed.

(* Theorem mult_dist_over_add : forall m n x : nat, x * (m + n) = x * m + x * n. *)
(* Proof. *)
(*   intros. induction x as [| x' IHn']. *)
(*   - simpl. reflexivity. *)
(*   - simpl. rewrite IHn'. rewrite add_assoc. rewrite add_assoc. *)
(*     replace (m + n + x' * m) with (m + x' * m + n). reflexivity. *)
(*     rewrite add_comm. rewrite add_assoc. *)
(*     replace (n + m) with (m + n). reflexivity. apply add_comm. *)
(* Qed.                            (* Gosh what an awful proof *) *)

Theorem mult_Sn_m : forall n m : nat, S n * m = n * m + m.
Proof.
  intros. induction n as [| n' IHn'].
  - simpl. auto.
  - simpl. simpl in IHn'. rewrite IHn'. rewrite add_comm. reflexivity.
Qed.

Theorem mult_dist_over_add: forall m n x : nat, x * (m + n) = x * m + x * n.
Proof.
  intros. induction x as [| x' IHx'].
  - simpl. reflexivity.
  - repeat rewrite mult_Sn_m. rewrite IHx'. repeat rewrite add_assoc. ring.
  (* Yes, yes, I know we use the `ring' tactic here at the end---that would
  suffice to knock this entire proof out. But if you walk through the proof you
  can see how we use the inductive hypothesis and are left to a point where all
  you need to do is apply some simple term rewriting/reordering in
  already-defined ways. It's a little tedious, so we just throw `ring' at it to
  get it over with. *)
Qed.

Theorem mult_ident : forall n : nat, n * 1 = n.
Proof.
  intros. induction n as [| n' IHn'].
  - auto.
  - simpl. auto.
Qed.

Theorem add_conv_middle : forall a b c d : nat, a + b + c + d = a + c + b + d.
Proof.
  intros. rewrite <- add_assoc. rewrite <- add_assoc.
  replace (b + (c + d)) with (c + (b + d)).
  repeat rewrite add_assoc. reflexivity.
  rewrite add_comm. rewrite <- add_assoc. replace (d + c) with (c + d). reflexivity.
  apply add_comm.
Qed.

Theorem closed_equiv : forall n : nat, n * (n + 1) = 2 * sum_up n.
Proof.
  intros. induction n as [| n' IHn'].
  - auto.
  - assert (H: sum_up (S n') = S n' + sum_up n'). { auto. }
    rewrite H. rewrite mult_Sn_m. repeat rewrite mult_dist_over_add. rewrite <- IHn'. ring.
Qed.
