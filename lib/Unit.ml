[@@@warning "-65"]

type tt
type _ t = () : tt t

let tt : tt t = ()

let uniqueness : type a. a t -> (a t, tt t) Eq.t = function
  | () -> Refl ()
