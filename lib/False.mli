(** {1 False} *)

(** [False] encodes falsehood as a type.
    By being empty, there cannot exist a proof for it. *)

(** [t] is the false type. *)
type t = |

(** {2 Principles} *)

(** [ex_falso_quodlibet] states that if we have the proof of
    falsehood, then we can prove anything. *)
val ex_falso_quodlibet : 'a. t -> 'a
