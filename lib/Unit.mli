(** {1 Unit} *)

(** [Unit] is a type with a single inhabitant: [()], which is
    also called [tt]. *)

(* We are intentionally replacing the built-in [unit] type. *)
[@@@warning "-65"]

(** This [tt] type is used as a discriminant for the [Unit]
    type. *)
type tt

(** [t] is the [unit] type. *)
type _ t = () : tt t

(** [tt] is the sole member of the [Unit] type. *)
val tt : tt t

(** [uniqueness] states that if we have a value of type [Unit],
    then it must be [()]. *)
val uniqueness : 'a. 'a t -> ('a t, tt t) Eq.t
