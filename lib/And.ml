type (_, _) t = Conjunction : 'a 'b. ('a * 'b) -> ('a, 'b) t

let both : type a b. a -> b -> (a, b) t =
  fun a b -> Conjunction (a, b)

let left : type a b. (a, b) t -> a = function
  | Conjunction (a, _) -> a

let right : type a b. (a, b) t -> b = function
  | Conjunction (_, b) -> b

let reflexivity : type a. a -> (a, a) t = fun a -> both a a

let symmetry : type a b. (a, b) t -> (b, a) t = function
  | Conjunction (a, b) -> both b a

let transitivity : type a b c. (a, b) t -> (b, c) t -> (a, c) t =
  fun a_and_b b_and_c -> both (left a_and_b) (right b_and_c)

let commutativity = symmetry
