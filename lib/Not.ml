type -'a t = 'a -> False.t

let reciprocal : type a b. (a -> b) -> b t -> a t =
  fun a_implies_b not_b a -> not_b (a_implies_b a)

let intro_double_not : type a. a -> a t t = fun x f -> f x
let ( ~~ ) = intro_double_not

(* elimination of double negation cannot be proven
   constructively, as it requires "undoing" function
   application, thus it is an axiom *)
external elim_double_not : 'a. 'a t t -> 'a = "%identity"
