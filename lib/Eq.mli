(** {1 Equality}

[Eq] represents equality, following the definition of
Martin-Löf's identity type. *)

(* Note: the types of inner modules are called [ty] to avoid
   clashing with equality's *)

(** Equality has two type parameters, but its only constructor,
    {!Refl}, requires them to be the same ; in other words, we
    cannot construct a proof of equality of two terms if they
    are different. *)

(** [t] is the equality type. *)
type (_, _) t = Refl : 'a. 'a -> ('a, 'a) t

(** {2 Properties} *)

(** Equality satisfies numerous properties. *)

(** {3 As an equivalence relation} *)

(** {4 Reflexivity} *)

(** [reflexivity a] states that if we have [a], then we can
    conclude [a = a]. *)
val reflexivity : 'a. 'a -> ('a, 'a) t

(** {4 Symmetry} *)

(** [symmetry eq_a_b] states that if we have [a = b], then we
    can conclude [b = a]. *)
val symmetry : 'a 'b. ('a, 'b) t -> ('b, 'a) t

(** {4 Transitivity} *)

(** [transitivity eq_a_b eq_b_c] states that if we have [a = b]
    and [b = c], then we can conclude [a = c]. *)
val transitivity
  : 'a 'b 'c.
  ('a, 'b) t -> ('b, 'c) t -> ('a, 'c) t

(** {3 As an inductive type} *)

module Induction : sig
  (** [Induction] is a proof of induction on equality, which
      also happens to match Leibniz's definition of equality. *)

  module type ARGS = sig
    (** [ARGS] regroups all the required arguments for the
        induction. *)

    (** [ty] is {i some} type. It really doesn't matter which
        one.
        
        We will take the example of weathers.
        
        Note that the parameter is used here as a way to
        discriminate between specific inhabitants of [ty]. *)
    type _ ty

    (** [x] is a discriminant for [ty] that represents some
        value of that type.
        
        For our example, let's say that it's the rain. *)
    type x

    (** [_p] is an unfortunate implementation detail: OCaml
        does not let us constraint parameters of abstract
        types directly. *)
    type 'a _p

    (** [p] represents a proposition about ['a], which is a
        member of [ty].
        
        It could be the statement:
        "Given a weather, the floor is wet." *)
    type 'a p = 'a _p constraint 'a = 'b ty

    (** [px] is a proof that [p] holds for [x] specifically.

        Indeed, rain makes the floor wet. *)
    val px : x ty p

    (** [a] is another discriminant for [ty]. *)
    type a

    (** [eq_x_a] is a proof that [x = a].
    
        [a] is also the rain! *)
    val eq_x_a : (x, a) t
  end

  module type TYPE = sig
    (** [TYPE] represents the conclusion of the induction
        principle applied to some instance of [ARGS]. *)

    (** [Args] is all the hypotheses needed. *)
    module Args : ARGS

    open Args

    (** [pa] is the proof that the proposition [p] also holds
        when applied to [a].
        
        Therefore, the weather [a] makes the floor wet. *)
    val pa : a ty p
  end

  (** [Make Args] builds the conclusion of the induction based
      on the hypotheses [Args]. *)
  module Make : (Args : ARGS) -> TYPE
  (* (_ : ARGS) looks ugly *)
  [@@warning "-67"]

  (** [induction] states that given a type [ty], a value
      [x : ty], a proposition [P (a : ty)] and a proof of
      [P x], then for every [a : ty] that is equal to [x], we
      can conclude [P a].
      
      We know that the rain makes the floor wet, so every
      weather that is the same as the rain also makes the floor
      wet. *)
  val induction : (module ARGS) -> (module TYPE)
end
