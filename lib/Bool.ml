type _ t =
  | False : False.t t
  | True : True.t t

let dichotomy : type a. a t -> (False.t t, True.t t) Or.t
  = function
  | False -> Left False
  | True -> Right True

let weaken : type a. a t -> bool = function
  | False -> false
  | True -> true
