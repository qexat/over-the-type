(** {1 Tactics} *)

(** This module contains several tactics for classical logic. *)

(** [contradict] allows to prove any goal if proofs of both [a]
    and its negation appear in the hypotheses. *)
val contradict : 'a 'b. ('a -> False.t) -> 'a -> 'b
