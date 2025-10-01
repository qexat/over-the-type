type -'a t = 'a -> False.t

let reciprocal : type a b. (a -> b) -> b t -> a t =
  fun a_implies_b not_b a -> not_b (a_implies_b a)

let double_introduction : type a. a -> a t t = fun x f -> f x
let ( ~~ ) = double_introduction

(* elimination of double negation cannot be proven
   constructively, as it requires "undoing" function
   application, thus it is an axiom *)
external double_elimination : 'a. 'a t t -> 'a = "%identity"
