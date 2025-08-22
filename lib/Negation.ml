type -'a t = 'a -> False.t

let reciprocal : type a b. (a -> b) -> b t -> a t =
  fun a_implies_b not_b a -> not_b (a_implies_b a)

let intro_double_negation : type a. a -> a t t = fun x f -> f x
let ( ~~ ) = intro_double_negation
