(** {1 Negation}

[Negation] represents the logical opposite of a type. *)

(** [t] is the negation type.
    Negating a type is equivalent to saying that it implies
    [False]. *)
type 'a t = 'a -> False.t

(** {2 Properties} *)

(** [intro_double_negation a] states that if we have [a], then
    we can conclude [¬¬a] (read: not not [a]). *)
val intro_double_negation : 'a. 'a -> 'a t t

val ( ~~ ) : 'a. 'a -> 'a t t
