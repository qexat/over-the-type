type _ t =
  | False : False.t t
  | True : True.t t

let weaken : type a. a t -> bool = function
  | False -> false
  | True -> true
