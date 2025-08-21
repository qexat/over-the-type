type -'a t = 'a -> False.t

let intro_double_negation : type a. a -> a t t = fun x f -> f x
let ( ~~ ) = intro_double_negation
