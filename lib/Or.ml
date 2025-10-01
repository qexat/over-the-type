type (_, _) t =
  | Intro_left : 'a 'b. 'a -> ('a, 'b) t
  | Intro_right : 'a 'b. 'b -> ('a, 'b) t

let left : type a b. a -> (a, b) t = fun a -> Intro_left a
let right : type a b. b -> (a, b) t = fun b -> Intro_right b

let elimination
  : type a b c. (a -> c) -> (b -> c) -> (a, b) t -> c
  =
  fun left_elimination right_elimination -> function
  | Intro_left a -> left_elimination a
  | Intro_right b -> right_elimination b

let reflexivity : type a. a -> (a, a) t = fun a -> Intro_left a

let symmetry : type a b. (a, b) t -> (b, a) t = function
  | Intro_left a -> Intro_right a
  | Intro_right b -> Intro_left b

let identity_left : type b. (False.t, b) t -> b = function
  | Intro_right b -> b

let identity_right : type a. (a, False.t) t -> a = function
  | Intro_left a -> a

let associativity
  : type a b c. ((a, b) t, c) t -> (a, (b, c) t) t
  = function
  | Intro_left (Intro_left a) -> Intro_left a
  | Intro_left (Intro_right b) -> Intro_right (Intro_left b)
  | Intro_right c -> Intro_right (Intro_right c)

let commutativity = symmetry
