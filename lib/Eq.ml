type (_, _) t = Refl : 'a. 'a -> ('a, 'a) t

let reflexivity : type a. a -> (a, a) t = fun a -> Refl a

let symmetry : type a b. (a, b) t -> (b, a) t = function
  | Refl a -> Refl a

let transitivity : type a b c. (a, b) t -> (b, c) t -> (a, c) t =
  fun (Refl a) (Refl _) -> Refl a

module Induction = struct
  module type HYPOTHESES = sig
    type x
    type _ ty
    type 'a _p
    type 'a p = 'a _p constraint 'a = 'b ty

    val px : x ty p

    type a

    val x_eq_a : (x, a) t
  end

  module type CONCLUSION = sig
    module Hypotheses : HYPOTHESES
    open Hypotheses

    val pa : a ty p
  end

  module Make (Hypotheses : HYPOTHESES) : CONCLUSION = struct
    module Hypotheses = Hypotheses
    open Hypotheses

    let pa : a ty p =
      match x_eq_a with
      | Refl _ -> px
  end

  let induction : (module HYPOTHESES) -> (module CONCLUSION) =
    fun (module I) -> (module Make (I))
end
