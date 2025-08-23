type o = Zero [@@warning "-37"]

type 'n s = Succ : 'n t -> 'n s [@@warning "-37"]

and 'n t =
  | O : o t
  | S : 'n t -> 'n s t

type zero = o t
type 'n succ = 'm s t constraint 'n = 'm t

let zero : zero = O
let succ : 'n -> 'n succ = fun n -> S n
let pred : 'n succ -> 'n = fun (S n) -> n

type one = zero succ
type two = one succ
type three = two succ
type four = three succ
type five = four succ
type six = five succ
type seven = six succ
type eight = seven succ
type nine = eight succ
type ten = nine succ

let one : one = succ zero
let two : two = succ one
let three : three = succ two
let four : four = succ three
let five : five = succ four
let six : six = succ five
let seven : seven = succ six
let eight : eight = succ seven
let nine : nine = succ eight
let ten : ten = succ nine

module Even = struct
  type _ prop =
    | O_is_even : zero prop
    | S_S_is_even : 'n prop -> 'n succ succ prop
end

module Odd = struct
  type _ prop =
    | I_is_odd : one prop
    | S_S_is_odd : 'n prop -> 'n succ succ prop
end
