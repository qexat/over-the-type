(** {1 Not}

[Not] represents the logical opposite of a type. *)

(** [t] is the propositional negation type.
    Negating a type is equivalent to saying that it implies
    [False]. *)
type 'a t = 'a -> False.t

(** {2 Properties} *)

(** [reciprocal] states if we know that [a] implies [b], then
    we can conclude that the negation of [b] implies the
    negation of [a].

    For example, we know that the rain makes the ground wet.
    Therefore, if the ground is not wet, we can conclude that
    it is not raining. *)
val reciprocal : 'a 'b. ('a -> 'b) -> 'b t -> 'a t

(** [intro_double_not a] states that if we have [a], then
    we can conclude [¬¬a] (read: not not [a]). *)
val intro_double_not : 'a. 'a -> 'a t t

val ( ~~ ) : 'a. 'a -> 'a t t
