type (_, _) t =
  | And_then : 'a 'b. ('a * ('a -> 'b)) -> ('a, 'b) t

let introduction : type a b. a -> (a -> b) -> (a, b) t =
  fun a a_implies_b -> And_then (a, a_implies_b)

let elimination_left : type a b. (a, b) t -> a = function
  | And_then (a, _) -> a

let elimination_right : type a b. (a, b) t -> b = function
  | And_then (a, b) -> b a

let map : type a b c. (b -> c) -> (a, b) t -> (a, c) t =
  fun b_implies_c (And_then (a, a_implies_b)) ->
  And_then (a, fun a -> b_implies_c (a_implies_b a))

let reflexivity : type a. a -> (a, a) t =
  fun a -> introduction a Fun.id

let transitivity : type a b c. (a, b) t -> (b, c) t -> (a, c) t =
  fun a_and_then_b (And_then (_, b_implies_c)) ->
  map b_implies_c a_and_then_b

let identity_left : type b. (True.t, b) t -> b =
  elimination_right

let identity_right : type a. (a, True.t) t -> a =
  elimination_left

let absorption_left : type b. (False.t, b) t -> False.t =
  elimination_left

let absorption_right : type a. (a, False.t) t -> False.t =
  elimination_right

let associativity = transitivity

let order : type a b. (a, b) And.t -> (a, b) t =
  fun (Both (a, b)) -> And_then (a, fun _ -> b)

let unorder : type a b. (a, b) t -> (a, b) And.t =
  fun (And_then (a, a_implies_b)) -> Both (a, a_implies_b a)

let curry_binary : type a b c. ((a, b) t -> c) -> a -> b -> c =
  fun a_and_then_b_implies_c a b ->
  a_and_then_b_implies_c (order (Both (a, b)))

let uncurry_binary : type a b c. (a -> b -> c) -> (a, b) t -> c =
  fun a_implies_b_implies_c (And_then (a, a_implies_b)) ->
  a_implies_b_implies_c a (a_implies_b a)
