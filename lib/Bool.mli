(** {1 Bool} *)

(** [Bool] represents the two truth values of logic, [True] and
    [False]. *)

(** [t] is the boolean type. *)
type _ t =
  | False : False.t t
  | True : True.t t

(** [weaken] "forgets" which boolean value it is, converting it
    to OCaml's built-in one. *)
val weaken : 'a. 'a t -> bool
