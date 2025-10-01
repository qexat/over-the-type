type (_, _) t =
  | Left : 'a 'b. 'a -> ('a, 'b) t
  | Right : 'a 'b. 'b -> ('a, 'b) t

let introduction_left : type a b. a -> (a, b) t =
  fun a -> Left a

let introduction_right : type a b. b -> (a, b) t =
  fun b -> Right b

let elimination
  : type a b c. (a -> c) -> (b -> c) -> (a, b) t -> c
  =
  fun left_elimination right_elimination -> function
  | Left a -> left_elimination a
  | Right b -> right_elimination b

let reflexivity : type a. a -> (a, a) t = fun a -> Left a

let symmetry : type a b. (a, b) t -> (b, a) t = function
  | Left a -> Right a
  | Right b -> Left b

let identity_left : type b. (False.t, b) t -> b = function
  | Right b -> b

let identity_right : type a. (a, False.t) t -> a = function
  | Left a -> a

let associativity
  : type a b c. ((a, b) t, c) t -> (a, (b, c) t) t
  = function
  | Left (Left a) -> Left a
  | Left (Right b) -> Right (Left b)
  | Right c -> Right (Right c)

let commutativity = symmetry
