[@@@warning "-65"]

type tt = TT
type _ t = () : tt t

let tt : tt t = ()

module Uniqueness = struct
  module Hypotheses = struct
    type 'a ty = 'a t
    type x = tt
    type 'a _p = ('a, tt t) Eq.t
    type 'a p = 'a _p constraint 'a = 'b ty

    let px : x ty _p = Refl ()
  end

  module Conclusion = Eq.Induction.Make (Hypotheses)
end

let uniqueness : type a. a t -> (a t, tt t) Eq.t =
  fun () -> Uniqueness.Conclusion.pa (Refl TT)
