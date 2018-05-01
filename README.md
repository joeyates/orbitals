# Orbitals

Calculate atomic orbital configurations.

These configurations can be calculated via an iterative method,
using data tables based on a small set of rules.

This program aims to demonstrate exactly how much information is needed,
and how to obtain correct results from that information for any known
element, simply by supplying its atomic number.

# Atomic Orbitals

## Electrons

The electrons in an atom are arranged in orbitals.

## Spin

Orbitals contain up to two electrons, one having positive spin and the other
negative. This **spin quantum number** ('m<sub>s</sub>') can be +1/2 or -1/2.

## Shells

Orbitals are grouped in shells indicated by increasing numeric values of the
**principal quantum number**, 'n'.

## Subshells

Within the shells are subshells indicated by numeric or letter values of 
the **azimuthal** quantum number, 'l'.

The letters used to name subshells derive from early observations of atoms.

0 - s - sharp
1 - p - principal
2 - d - diffuse
3 - f - fundamental
4, 5, 6, 7... - g, h, j, k...

So subshells are named according to their 'n' and 'l' values, e.g. '4p'

## Subshell orbitals

Each subshell contains a number of orbitals that depends on the subshell type:

* s - 1
* p - 3
* d - 5
* f - 7
* ...

Each orbital in a subshell has a different **magnetic quantum number**
('m<sub>l</sub>').
E.g. '4p<sub>-1</sub>'

So, each electron in an atom has a unique signature composed of:

* n - principal quantum number, energy,
* l - azimuthal quantum number, angular momentum,
* m<sub>l</sub> - magnetic quantum number, angular momentum vector component,
* m<sub>s</sub> - spin quantum number.

Also, the electron configuration of an atom can be indicated by listing
its subshells and the count of electrons present in the subshell.
E.g. '...,4p4'

# Example

Lithium has an atomic number of 3.
The loweset energy orbitals are 1s and 2s, each contain up to two electrons.
So Lithium's electron configuration is 1s2, 2s1.
In this case, the program prints out `[(1, :s, 2), [(2, :s, 1)]]`

# Documentation

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/orbitals](https://hexdocs.pm/orbitals).
