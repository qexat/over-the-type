(** {1 And then} *)

(** [And_then] represents a pair where the right handside
    depends on the left.

    {b Note:} To my knowledge, this logical operator does not
    have an "official" (or agreed upon) symbol, but I will use
    [&>] for the rest of the documentation. *)

(** [t] is the ordered (dependent) pair type. *)
type (_, _) t =
  | And_then : 'a 'b. ('a * ('a -> 'b)) -> ('a, 'b) t

(** {2 Introduction and elimination rules} *)

(** [introduction] states that if we have [a], and we know that
    [a → b], then we can conclude [a &> b]. *)
val introduction : 'a 'b. 'a -> ('a -> 'b) -> ('a, 'b) t

(** [elimination_left] states that if we have [a &> b], then we
    can conclude [a]. *)
val elimination_left : 'a 'b. ('a, 'b) t -> 'a

(** [elimination_right] states that if we have [a &> b], then
    we can conclude [b]. *)
val elimination_right : 'a 'b. ('a, 'b) t -> 'b

(** {2 Properties} *)

(** {3 As a preorder} *)

(** {4 Reflexivity} *)

(** [reflexivity] states that if we have [a], then we can
    conclude [a &> a]. *)
val reflexivity : 'a. 'a -> ('a, 'a) t

(** {4 Transitivity} *)

(** [transitivity] states that if we have [a &> b] and
    [b &> c], then we can conclude [a &> c].

    See also: {!val-associativity}. *)
val transitivity
  : 'a 'b 'c.
  ('a, 'b) t -> ('b, 'c) t -> ('a, 'c) t

(** {3 As a logical operator} *)

(** {4 Identity} *)

(** [identity_left] states that if we have [⊤ &> b], then we
    can conclude [b]. *)
val identity_left : 'b. (True.t, 'b) t -> 'b

(** [identity_right] states that if we have [a &> ⊤], then we
    can conclude [a]. *)
val identity_right : 'a. ('a, True.t) t -> 'a

(** {4 Absorption} *)

(** [absorption_left] states that if we have [⊥ &> b], then we
    can conclude [⊥]. This implies that [⊥ &> b] cannot be
    proven. *)
val absorption_left : 'b. (False.t, 'b) t -> False.t

(** [absorption_right] states that if we have [a &> ⊥], then we
    can conclude [⊥].

    This is equivalent to the principle of non-contradiction:
    see {!Classical.Laws.non_contradiction}. *)
val absorption_right : 'a. ('a, False.t) t -> False.t

(** {4 Associativity} *)

(** [associativity] states that if we have [a &> b] and
    [b &> c], then we can conclude [a &> c].

    See also: {!val-transitivity}. *)
val associativity
  : 'a 'b 'c.
  ('a, 'b) t -> ('b, 'c) t -> ('a, 'c) t

(** {3 As an ordered version of ∧}

    [a &> b] can be converted back-and-forth to [a ∧ b] ;
    however, care must be taken as it is not a loseless
    transformation. *)

(** [order] converts a conjunction to an ordered pair. *)
val order : 'a 'b. ('a, 'b) And.t -> ('a, 'b) t
[@@alert unsafe "this operation is lossy and unsafe"]

(** [unorder] converts an ordered pair to a conjunction. *)
val unorder : 'a 'b. ('a, 'b) t -> ('a, 'b) And.t

(** {3 Currying, uncurrying}

    Since [a &> b] is a pair (which resembles a conjunction),
    it preserves some of the properties of [a ∧ b], namely its
    relation with [→] with respect to currying/uncurrying. *)

(** [curry_binary] states that we can curry [(a &> b) → c] to
    [a → b → c]. *)
val curry_binary
  : 'a 'b 'c.
  (('a, 'b) t -> 'c) -> 'a -> 'b -> 'c

(** [uncurry_binary] states that we can uncurry [a → b → c] to
    [(a &> b) → c]. *)
val uncurry_binary
  : 'a 'b 'c.
  ('a -> 'b -> 'c) -> ('a, 'b) t -> 'c

(** {3 As a partial functor}

    While [a &> b] is invariant with respect to its left
    handside -- due to the fact that [a] is in both positive
    and negative positions -- it remains covariant with respect
    to its right handside, making it as such a partial functor.
    
    Because of partiality, it is neither applicative, nor
    selective, and even less of a monad. *)

(** [map f a_and_then_b] applies [f] to the right handside of
    the ordered pair [a_and_then_b]. *)
val map : 'a 'b 'c. ('b -> 'c) -> ('a, 'b) t -> ('a, 'c) t
