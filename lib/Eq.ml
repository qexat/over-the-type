type (_, _) t = Refl : 'a. 'a -> ('a, 'a) t

let reflexivity : type a. a -> (a, a) t = fun a -> Refl a

let symmetry : type a b. (a, b) t -> (b, a) t = function
  | Refl a -> Refl a

let transitivity : type a b c. (a, b) t -> (b, c) t -> (a, c) t =
  fun (Refl a) (Refl _) -> Refl a

module Induction = struct
  module type ARGS = sig
    type x
    type _ ty
    type 'a _p
    type 'a p = 'a _p constraint 'a = 'b ty

    val px : x ty p

    type a

    val eq_x_a : (x, a) t
  end

  module type TYPE = sig
    module Args : ARGS
    open Args

    val pa : a ty p
  end

  module Make (Args : ARGS) : TYPE = struct
    module Args = Args
    open Args

    let pa : a ty p =
      match eq_x_a with
      | Refl _ -> px
  end

  let induction : (module ARGS) -> (module TYPE) =
    fun (module I) -> (module Make (I))
end
