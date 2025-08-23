let non_contradiction : type a. (a, a Not.t) And.t Not.t
  = function
  | Conjunction (a, not_a) -> Tactic.contradict not_a a
