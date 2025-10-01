type (_, _) t = Both : 'a 'b. ('a * 'b) -> ('a, 'b) t

let introduction : type a b. a -> b -> (a, b) t =
  fun a b -> Both (a, b)

let elimination_left : type a b. (a, b) t -> a = function
  | Both (a, _) -> a

let elimination_right : type a b. (a, b) t -> b = function
  | Both (_, b) -> b

let reflexivity : type a. a -> (a, a) t =
  fun a -> introduction a a

let symmetry : type a b. (a, b) t -> (b, a) t = function
  | Both (a, b) -> introduction b a

let transitivity : type a b c. (a, b) t -> (b, c) t -> (a, c) t =
  fun a_and_b b_and_c ->
  introduction
    (elimination_left a_and_b)
    (elimination_right b_and_c)

let identity_left : type b. (True.t, b) t -> b = function
  | Both (I, b) -> b

let identity_right : type a. (a, True.t) t -> a = function
  | Both (a, I) -> a

let associativity
  : type a b c. ((a, b) t, c) t -> (a, (b, c) t) t
  = function
  | Both (Both (a, b), c) -> introduction a (introduction b c)

let commutativity = symmetry
