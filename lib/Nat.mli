(** {1 Nat} *)

(** [Nat] represents the natural integers (including 0),
    following the definition of Peano. *)

(** [o] is the discriminant for [0].
    As such, [o Nat.t] is this number specifically. *)
type o = private Zero

(** [s] is the discriminant for the successor of some number
    [n], that is [n + 1]. *)
type 'n s = private Succ : 'n t -> 'n s

(** [t] is the type of natural integers.  *)
and 'n t =
  | O : o t
  | S : 'n t -> 'n s t

(** {2 Constructors} *)

(** The types [zero] and [succ] exist for convenience and
    readability of type annotations. *)

(** [zero] is the type of [0]. *)
type zero = o t

(** [succ n] is the type of the successor of [n]. *)
type 'n succ = 'm s t constraint 'n = 'm t

(** [zero] is the number [0]. *)
val zero : zero

(** [succ n] produces the successor of [n], that is [n + 1]. *)
val succ : 'n -> 'n succ

(** [pred n] produces the predecessor of [n], that is [n - 1]. *)
val pred : 'n succ -> 'n

(** {2 One to ten} *)

(** This section lays out numbers from one to ten and their
    type, again for convenience and readability. *)

type one = zero succ
type two = one succ
type three = two succ
type four = three succ
type five = four succ
type six = five succ
type seven = six succ
type eight = seven succ
type nine = eight succ
type ten = nine succ

val one : one
val two : two
val three : three
val four : four
val five : five
val six : six
val seven : seven
val eight : eight
val nine : nine
val ten : ten

(** {2 Properties} *)

(** {3 Evenness and oddness} *)

(** This section defines two propisitions, [Even] and [Odd],
    that state whether a number is divisible by 2 or not,
    respectively. *)

module Even : sig
  (** [Even] is defined from two statements:
      - [0] is even
      - If [n] is even, then [S (S n)] ([n + 2]) is also even. *)
  type _ prop =
    | O_is_even : zero prop
    | S_S_is_even : 'n prop -> 'n succ succ prop
end

module Odd : sig
  (** [Odd] is defined from two statements:
      - [1] is odd
      - If [n] is odd, then [S (S n)] ([n + 2]) is also odd. *)
  type _ prop =
    | I_is_odd : one prop
    | S_S_is_odd : 'n prop -> 'n succ succ prop
end
