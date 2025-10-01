let non_contradiction : type a. (a, a Not.t) And.t Not.t
  = function
  | Both (a, not_a) -> Tactics.contradict not_a a
