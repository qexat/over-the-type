(** {1 Bool} *)

(** [Bool] represents the two truth values of logic, [True] and
    [False]. *)

(** [t] is the boolean type. *)
type _ t =
  | False : False.t t
  | True : True.t t

(** [dichotomy] states that if we have a value of type [Bool],
    then it must be either [False] or [True]. *)
val dichotomy : 'a. 'a t -> (False.t t, True.t t) Or.t

(** [weaken] "forgets" which boolean value it is, converting it
    to OCaml's built-in one. *)
val weaken : 'a. 'a t -> bool
