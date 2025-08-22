let non_contradiction
  : type a. (a, a Negation.t) And.t Negation.t
  = function
  | Conjunction (a, not_a) -> Tactic.contradict not_a a
