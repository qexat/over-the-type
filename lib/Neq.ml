type ('a, 'b) t = ('a, 'b) Eq.t Negation.t

let symmetry : type a b. (a, b) t -> (b, a) t =
  fun f x -> f (Eq.symmetry x)
