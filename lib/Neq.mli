(** {1 Nonequality} *)

(** [Neq] encodes nonequality (distinctiveness) as a type.

    The term {i inequality} is not used here to avoid
    ambiguities. *)

(** [t] is the nonequality type. *)
type ('a, 'b) t = ('a, 'b) Eq.t Negation.t

(** {2 Properties} *)

(** Non-equality satisfies some properties. *)

(** {3 As an apartness relation} *)

(** {4 Symmetry} *)

(** [symmetry] states that if we have [a ≠ b], then we can
    conclude [b ≠ a]. *)
val symmetry : 'a 'b. ('a, 'b) t -> ('b, 'a) t
