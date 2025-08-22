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

let identity_left : type b. (True.t, b) t -> b = function
  | Conjunction (I, b) -> b

let identity_right : type a. (a, True.t) t -> a = function
  | Conjunction (a, I) -> a

let associativity
  : type a b c. ((a, b) t, c) t -> (a, (b, c) t) t
  = function
  | Conjunction (Conjunction (a, b), c) -> both a (both b c)

let commutativity = symmetry
