(** {1 Law} *)

(** Laws of classical logic. *)

(** {2 Law of Non-Contradiction} *)

(** [non_contradiction] states that we cannot have a proof of
    [a] and a proof of its negation at the same time. *)
val non_contradiction : 'a. ('a, 'a Not.t) And.t Not.t
