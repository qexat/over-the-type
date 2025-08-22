let contradict : type a b. (a -> False.t) -> a -> b =
  fun hypothesis contradiction ->
  False.ex_falso_quodlibet (hypothesis contradiction)
