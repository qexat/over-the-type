(** {1 And} *)

(** [And] represents the conjunction, denoted [∧]. *)

(** The conjunction has two type parameters [a] and [b], with
    one constructor {!Conjunction} that can only be introduced
    if {i both} [a] and [b] have a proof. *)

(** [t] is the conjunction type. *)
type (_, _) t = Conjunction : 'a 'b. ('a * 'b) -> ('a, 'b) t

(** {2 Introduction and elimination rules} *)

(** [both] states that if we have both [a] and [b], then we can
    conclude [a ∧ b]. *)
val both : 'a 'b. 'a -> 'b -> ('a, 'b) t

(** [left] states that if we have [a ∧ b], then we can conclude
    [a]. *)
val left : 'a 'b. ('a, 'b) t -> 'a

(** [right] states that if we have [a ∧ b], then we can
    conclude [b]. *)
val right : 'a 'b. ('a, 'b) t -> 'b

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

(** {4 Commutativity} *)

(** [commutativity] is the same as {!val-symmetry}. *)
val commutativity : 'a 'b. ('a, 'b) t -> ('b, 'a) t
