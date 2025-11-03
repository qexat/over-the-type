type (_, _) t =
  | Left : 'a 'b. ('a * 'b Not.t) -> ('a, 'b) t
  | Right : 'a 'b. ('a Not.t * 'b) -> ('a, 'b) t

let introduction_left : type a b. a -> b Not.t -> (a, b) t =
  fun a not_b -> Left (a, not_b)

let introduction_right : type a b. a Not.t -> b -> (a, b) t =
  fun not_a b -> Right (not_a, b)

let elimination
  : type a b c.
    (a -> b Not.t -> c) -> (a Not.t -> b -> c) -> (a, b) t -> c
  =
  fun elimination_left elimination_right -> function
  | Left (a, not_b) -> elimination_left a not_b
  | Right (not_a, b) -> elimination_right not_a b

let elimination_left
  : type a b c. (a -> c) -> (a Not.t -> c) -> (a, b) t -> c
  =
  fun a_implies_c not_a_implies_c ->
  elimination
    (fun a _ -> a_implies_c a)
    (fun not_a _ -> not_a_implies_c not_a)

let elimination_right
  : type a b c. (b Not.t -> c) -> (b -> c) -> (a, b) t -> c
  =
  fun not_b_implies_c b_implies_c ->
  elimination (fun _ -> not_b_implies_c) (fun _ -> b_implies_c)

let elimination_neither
  : type a b c.
    (a Not.t -> c) -> (b Not.t -> c) -> (a, b) t -> c
  =
  fun not_a_implies_c not_b_implies_c ->
  elimination
    (fun _ -> not_b_implies_c)
    (fun not_a _ -> not_a_implies_c not_a)

let elimination_both
  : type a b c. (a -> c) -> (b -> c) -> (a, b) t -> c
  =
  fun a_implies_c b_implies_c ->
  elimination (fun a _ -> a_implies_c a) (fun _ -> b_implies_c)

let self_inverse : type a. (a, a) t -> False.t = function
  | Left (a, not_a) -> not_a a
  | Right (not_a, a) -> not_a a

let self_absurd : type a b. (a, a) t -> b =
  fun a_xor_a -> False.ex_falso_quodlibet (self_inverse a_xor_a)

let xnor_of_both : type a b. (a, b) And.t -> (a, b) t Not.t =
  fun (Both (a, b)) a_xor_b ->
  elimination_neither
    (Not.double_introduction a)
    (Not.double_introduction b)
    a_xor_b

let xnor_of_neither
  : type a b. (a Not.t, b Not.t) And.t -> (a, b) t Not.t
  =
  fun (Both (not_a, not_b)) a_xor_b ->
  elimination_both not_a not_b a_xor_b

let coreflexivity : type a. (a, a) t -> a = self_absurd

let irreflexivity_contra : type a. (a, a) t -> a Not.t =
  self_absurd

let irreflexivity : type a. a -> (a, a) t Not.t =
  fun a a_xor_a -> (irreflexivity_contra a_xor_a) a

let xnor_of_eq : type a b. (a, b) Eq.t -> (a, b) t Not.t =
  function
  | Refl a -> irreflexivity a

let symmetry : type a b. (a, b) t -> (b, a) t =
  fun a_xor_b ->
  elimination
    (Fun.flip introduction_right)
    (Fun.flip introduction_left)
    a_xor_b

let identity_left : type b. (False.t, b) t -> b = function
  | Right (_not_false, b) -> b

let identity_right : type a. (a, False.t) t -> a = function
  | Left (a, _not_false) -> a

let commutativity = symmetry
