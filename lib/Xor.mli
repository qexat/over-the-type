(** {1 Xor} *)

(** [Xor] represents exclusive disjunction, noted [⊻]. *)

(** [t] is the exclusive disjunction type. *)
type (_, _) t =
  | Left : 'a 'b. ('a * 'b Not.t) -> ('a, 'b) t
  | Right : 'a 'b. ('a Not.t * 'b) -> ('a, 'b) t

(** {2 Introduction rules} *)

(** There are two ways of introducing [a ⊻ b]: either by
    providing a proof of [a] and the negation of [b], or by
    providing a proof of [b] and the negation of [a]. *)

(** [introduction_left] states that if we have a proof of [a]
    and the negation of [b], then we can conclude [a ⊻ b]. *)
val introduction_left : 'a 'b. 'a -> 'b Not.t -> ('a, 'b) t

(** [introduction_right] states that if we have the negation of
    [b] and a proof of [a], then we can conclude [a ⊻ b]. *)
val introduction_right : 'a 'b. 'a Not.t -> 'b -> ('a, 'b) t

(** {2 Elimination rules} *)

(** [elimination] is the intuitionistic case analysis.
    If we can prove [c] given [a] and the negation of [b], or
    given the negation of [a] and [b], then we can prove [c]
    from [a ⊻ b]. *)
val elimination
  : 'a 'b 'c.
  ('a -> 'b Not.t -> 'c)
  -> ('a Not.t -> 'b -> 'c)
  -> ('a, 'b) t
  -> 'c

(** [elimination_left] is a special case of [elimination].
    If we can prove [c] when we have [a] or when we have its
    negation, then we can conclude [c] from [a ⊻ b]. *)
val elimination_left
  : 'a 'b 'c.
  ('a -> 'c) -> ('a Not.t -> 'c) -> ('a, 'b) t -> 'c

(** [elimination_right] is the same as {!elimination_left}
    but with [b] instead of [a]. *)
val elimination_right
  : 'a 'b 'c.
  ('b Not.t -> 'c) -> ('b -> 'c) -> ('a, 'b) t -> 'c

(** [elimination_both] is a special case of [elimination].
    If we can prove [c] whether we have [a] or [b], then we can
    conclude [c] from [a ⊻ b].
    
    This elimination is reminiscent from [∨], as [⊻] is a
    restricted (linear) version of that connector. *)
val elimination_both
  : 'a 'b 'c.
  ('a -> 'c) -> ('b -> 'c) -> ('a, 'b) t -> 'c

(** [elimination_neither] is the same as {!elimination_both},
    but with the negation of [a] and the negation of [b]. *)
val elimination_neither
  : 'a 'b 'c.
  ('a Not.t -> 'c) -> ('b Not.t -> 'c) -> ('a, 'b) t -> 'c

(** {2 Properties} *)

(** {3 As an apartness relation} *)

(** {4 Irreflexivity} *)

(** [irreflexivity] states that given a proof of [a], we can
    never conclude that [a ⊻ a]. *)
val irreflexivity : 'a. 'a -> ('a, 'a) t Not.t

(** [irreflexivity_contra] is the contrapositive of
    [irreflexivity]. *)
val irreflexivity_contra : 'a. ('a, 'a) t -> 'a Not.t

(** [self_inverse] states that [⊻] cannot relate any
    proposition to itself. *)
val self_inverse : 'a. ('a, 'a) t Not.t

(** [self_absurd] states if we have a proof where [⊻] relates
    a proposition to itself, then we can conclude anything.

    This property is derived from the fact that [⊻] is
    {!self_inverse}. *)
val self_absurd : 'a 'b. ('a, 'a) t -> 'b

(** {4 Coreflexivity} *)

(** Coreflexivity is the converse of reflexivity.

    A relation that is coreflexive is not necessarily
    reflexive, and vice-versa. *)

(** [coreflexivity] states that if we have [a ⊻ a], then we
    have [a].

    This property is derived from the fact that [⊻] is
    {!self_inverse}. It is a special case of {!self_absurd}. *)
val coreflexivity : 'a. ('a, 'a) t -> 'a

(** {4 Symmetry} *)

(** [symmetry] states that if we have [a ⊻ b], then we can
    conclude [b ⊻ a].

    See also {!val-commutativity}. *)
val symmetry : 'a 'b. ('a, 'b) t -> ('b, 'a) t

(** {3 As the negation of an equivalence relation} *)

(** {4 Introduction rules} *)

(** As [⊻] is an apartness relation, we can prove the negation
    of [a ⊻ b] if we know that [a = b]. *)

(** [xnor_of_eq] states that if we have [a = b], then we can
    never conclude [a ⊻ b]. *)
val xnor_of_eq : 'a 'b. ('a, 'b) Eq.t -> ('a, 'b) t Not.t

(** [xnor_of_both] states that if we have both [a] and [b],
    then we can never conclude [a ⊻ b]. *)
val xnor_of_both : 'a 'b. ('a, 'b) And.t -> ('a, 'b) t Not.t

(** [xnor_of_neither] states that if we have neither [a] nor
    [b], then we can never conclude [a ⊻ b]. *)
val xnor_of_neither
  : 'a 'b.
  ('a Not.t, 'b Not.t) And.t -> ('a, 'b) t Not.t

(** {3 As a logical operator} *)

(** {4 Identity} *)

(** [identity_left] states that if we have [⊥ ⊻ b], then we
    can conclude [b]. *)
val identity_left : 'b. (False.t, 'b) t -> 'b

(** [identity_right] states that if we have [a ⊻ ⊥], then we can
    conclude [a]. *)
val identity_right : 'a. ('a, False.t) t -> 'a

(** {4 Associativity} *)

(** TODO: [⊻]'s associativity cannot be proven constructively
    by itself, but we do have the law of excluded middle. *)

(** {4 Commutativity} *)

(** [commutativity] is the same as {!val-symmetry}. *)
val commutativity : 'a 'b. ('a, 'b) t -> ('b, 'a) t
