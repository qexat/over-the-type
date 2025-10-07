(** {1 And} *)

(** [And] represents the conjunction, denoted [∧]. *)

(** The conjunction has two type parameters [a] and [b], with
    one constructor {!Both} that can only be introduced if
    {i both} [a] and [b] have a proof. *)

(** [t] is the conjunction type. *)
type (_, _) t = Both : 'a 'b. ('a * 'b) -> ('a, 'b) t

(** {2 Introduction and elimination rules} *)

(** [introduction] states that if we have both [a] and [b],
    then we can conclude [a ∧ b]. *)
val introduction : 'a 'b. 'a -> 'b -> ('a, 'b) t

(** [elimination_left] states that if we have [a ∧ b], then we
    can conclude [a]. *)
val elimination_left : 'a 'b. ('a, 'b) t -> 'a

(** [elimination_right] states that if we have [a ∧ b], then we
    can conclude [b]. *)
val elimination_right : 'a 'b. ('a, 'b) t -> 'b

(** {2 Properties} *)

(** {3 As an equivalence relation} *)

(** {4 Reflexivity} *)

(** [reflexivity] states that if we have [a], then we can
    conclude [a ∧ a]. *)
val reflexivity : 'a. 'a -> ('a, 'a) t

(** {4 Symmetry} *)

(** [symmetry] states that if we have [a ∧ b], then we can
    conclude [b ∧ a].

    See also {!val-commutativity}. *)
val symmetry : 'a 'b. ('a, 'b) t -> ('b, 'a) t

(** {4 Transitivity} *)

(** [transitivity] states that if we have [a ∧ b] and [b ∧ c],
    then we can conclude [a ∧ c]. *)
val transitivity
  : 'a 'b 'c.
  ('a, 'b) t -> ('b, 'c) t -> ('a, 'c) t

(** {3 As a logical operator} *)

(** {4 Identity} *)

(** [identity_left] states that we have [⊤ ∧ b], then we can
    conclude [b]. *)
val identity_left : 'b. (True.t, 'b) t -> 'b

(** [identity_right] states that if we have [a ∧ ⊤], then we can
    conclude [a]. *)
val identity_right : 'a. ('a, True.t) t -> 'a

(** {4 Associativity} *)

(** [associativity] states that if we have [(a ∧ b) ∧ c], then
    we can conclude [a ∧ (b ∧ c)]. *)
val associativity
  : 'a 'b 'c.
  (('a, 'b) t, 'c) t -> ('a, ('b, 'c) t) t

(** {4 Commutativity} *)

(** [commutativity] is the same as {!val-symmetry}. *)
val commutativity : 'a 'b. ('a, 'b) t -> ('b, 'a) t
