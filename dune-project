(lang dune 3.19)

(name over-the-type)

(version 0.1.0)

(generate_opam_files true)

(source
 (github qexat/over-the-type))

(authors "lexa <contact@qexat.com>")

(maintainers "lexa <contact@qexat.com>")

(license MIT)

(documentation https://qexat.github.io/over-the-type/)

(package
 (name over-the-type)
 (synopsis "Various experimentations at the edge of OCaml's type system")
 (description
  "Over The Type explores the confines of OCaml's powerful type system with a logician mind influenced by dependently-typed programming languages and proof assistants.")
 (depends
  (ocaml
   (>= 5.3)))
 (tags
  ("type system" GADT "martin lof" leibniz equality proof)))
