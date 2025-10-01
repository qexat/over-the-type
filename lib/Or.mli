(** {1 Or} *)

(** [Or] represents disjunction, denoted [∨]. *)

(** The disjunction has two type parameters [a] and [b], with
    two constructors {!Intro_left} and {!Intro_right} which
    allow to construct a proof of [a ∨ b] either with a proof
    of [a] or a proof of [b] respectively. *)

(** [t] is the disjunction type. *)
type (_, _) t =
  | Intro_left : 'a 'b. 'a -> ('a, 'b) t
  | Intro_right : 'a 'b. 'b -> ('a, 'b) t

(** {2 Introduction rules} *)

(** [left] states that no matter what [b] is, if we have a
    proof of [a], then we can conclude [a ∨ b]. *)
val left : 'a 'b. 'a -> ('a, 'b) t

(** [right] states that no matter what [a] is, if we have a
    proof of [b], then we can conclude [a ∨ b]. *)
val right : 'a 'b. 'b -> ('a, 'b) t

(** {2 Elimination rule} *)

(** [elimination] states that if [a] implies [c] and [b] also
    implies [c], and we have [a ∨ b], then we can conclude [c]. *)
val elimination
  : 'a 'b 'c.
  ('a -> 'c) -> ('b -> 'c) -> ('a, 'b) t -> 'c

(** {2 Properties} *)

(** {3 As a tolerance relation} *)

(** {4 Reflexivity} *)

(** [reflexivity] states that if we have [a], then we can
    conclude [a ∨ a]. *)
val reflexivity : 'a. 'a -> ('a, 'a) t

(** {4 Symmetry} *)

(** [symmetry] states that if we have [a ∨ b], then we can
    conclude [b ∨ a].

    See also {!val-commutativity}. *)
val symmetry : 'a 'b. ('a, 'b) t -> ('b, 'a) t

(** {3 As a logical operator} *)

(** {4 Identity} *)

(** [identity_left] states that if we have [⊥ ∨ b], then we
    can conclude [b]. *)
val identity_left : 'b. (False.t, 'b) t -> 'b

(** [identity_right] states that if we have [a ∨ ⊥], then we can
    conclude [a]. *)
val identity_right : 'a. ('a, False.t) t -> 'a

(** {4 Associativity} *)

(** [associativity] states that if we have [(a ∨ b) ∨ c], then
    we can conclude [a ∨ (b ∨ c)]. *)
val associativity
  : 'a 'b 'c.
  (('a, 'b) t, 'c) t -> ('a, ('b, 'c) t) t

(** {4 Commutativity} *)

(** [commutativity] is the same as {!val-symmetry}. *)
val commutativity : 'a 'b. ('a, 'b) t -> ('b, 'a) t
