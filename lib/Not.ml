type -'a t = 'a -> False.t

let contrapositive : type a b. (a -> b) -> b t -> a t =
  fun a_implies_b not_b a -> not_b (a_implies_b a)

let double_introduction : type a. a -> a t t = fun x f -> f x
let ( ~~ ) = double_introduction

(* elimination of double negation cannot be proven
   constructively, as it requires "undoing" function
   application, thus it is an axiom *)
external double_elimination : 'a. 'a t t -> 'a = "%identity"

let cocontrapositive : type a b. (b t -> a t) -> a -> b =
  fun not_b_implies_not_a a ->
  let not_not_a = double_introduction a in
  let not_not_b =
    contrapositive not_b_implies_not_a not_not_a
  in
  double_elimination not_not_b
