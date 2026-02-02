#import "../template.typ": *

=== Alfabeti, Stringhe e Linguaggi

=== Alfabeto

#definition[
  Un alfabeto $A$ è un insieme #underline[finito] di simboli (chiamati terminali)
]

#example(title: "alfabeto dei caratteri dell'alfabeto italiano")[
  $A_1 = {a, b, c, d, ..., z}$
]

#example(title: "alfabeto delle cifre binarie")[
  $A_2 = {0, 1}$
]

=== Stringa

Una stringa di un alfabeto $A$ è una sequenza di lunghezza finita di simboli dell'alfabeto

#definition[
  $forall a in A, a_1 a_2 ... a_n$ con $n >= 0$
]

==== Lunghezza di stringa

Il numero naturale $n$ è detto #underline[lunghezza] della stringa e si denota con $|s|$

#note[
  Se $n = 0$ la stringa $s$ è chiamata #underline[stringa vuota] e viene rappresentata con $epsilon$
]

#example[
  $|a b f b z| = 5$ \
  $|epsilon| = 0$
]

==== Stringhe di lunghezza fissata

#definition[
  Definiamo l'insieme $A^n$ come l'insieme di tutte e sole le stringhe sull'alfabeto $A$ che hanno lunghezza $n$
]

#example[
  $A = {0, 1}$ \
  $A^0 = {epsilon}$ \
  $A^1 = A = {0, 1}$ \
  $A^2 = {00, 01, 11, 10}$
]

==== Stringhe sull'alfabeto

Definiamo l'insieme $A^*$ come l'insieme di tutte le stringhe sull'alfabeto $A$

#definition[
  $A^* = union.big_(n >= 0) A^n = {epsilon} union A^1 union A^2 union A^3 union ...$
]

#note[
  Se $A$ non è vuoto, $A^*$ è infinito!
]

=== Un linguaggio

Un #underline[linguaggio] $L$ su un alfabeto $A$ è un #underline[sottoinsieme] di $A^*$

#definition[
  $L subset.eq A^*$
]

#note[
  Linguaggi particolari:
  - linguaggio vuoto: $emptyset$
  - linguaggio di tutte le possibili stringhe su $A$: $A^*$
]

=== Descrizione dei linguaggi

#definition[
  Descrivere un linguaggio di programmazione significa descrivere l'insieme delle stringhe ben formate del linguaggio, che chiamiamo programmi
]

#note[
  I programmi ammissibili sono infiniti!
]

È possibile identificare l'insieme delle stringhe ben formate che caratterizzano un linguaggio come:
- Insieme delle stringhe *generate* da una #underline[grammatica]: *metodo generativo*
- Insieme delle stringhe *riconosciute* da un automa: *metodo riconoscitivo*

=== Le grammatiche formali

La grammatica è una tripla $G = (T, N, P)$ dove:
- #underline[$T$] è l'insieme dei simboli *terminali* che sostituiscono l'alfabeto di riferimento
- #underline[$N$] è l'insieme dei simboli *non terminali* che introducono le categorie sintattiche
- con $S = T union N$, $P subset.eq S^* times S^*$, che è l'insieme delle *produzioni* della grammatica con forma $alpha ::= beta$, dove $alpha$ contiene *almeno* un *non-terminale*

=== Gerarchia di Chomsky

Le grammatiche possono essere classificate in base alla forma delle loro produzioni.

#align(center)[
  #block(
    width: 60%,
    inset: 15pt,
    stroke: 1pt + gray,
    radius: 5pt,
  )[
    #align(center)[
      #block(fill: rgb("#BBDEFB"), inset: 10pt, radius: 5pt, width: 100%)[
        *Tipo 0 - Generali*
        #block(fill: rgb("#FFCDD2"), inset: 10pt, radius: 5pt, width: 85%)[
          *Tipo 1 - Monotone*
          #block(fill: rgb("#C8E6C9"), inset: 10pt, radius: 5pt, width: 85%)[
            *Tipo 2 - Libere dal contesto*
            #block(fill: rgb("#FFF9C4"), inset: 10pt, radius: 5pt, width: 85%)[
              *Tipo 3 - Regolari*
            ]
          ]
        ]
      ]
    ]
  ]
]

=== Backus-Naur form (BNF)

È un modo compatto per scrivere una grammatica: tutte le produzioni che si riferiscono allo stesso non terminale sono raggruppate utilizzando il simbolo "$|$" come separatore.

#example[
  Direzione $::=$ sinistra $|$ destra \
  Consiglio $::=$ svolta a Direzione $|$ prosegui dritto \
  Percorso $::=$ Consiglio $|$ Consiglio, poi Percorso
]

==== Linguaggio delle espressioni aritmetiche

con questo insieme $L subset.eq A^* = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, times, +}^*$ possiamo descrivere il linguaggio delle espressioni aritmetiche con una grammatica.

#example(title: $bb(N)$)[
  Cifra $::=$ 0 $|$ 1 $|$ 2 $|$ ... $|$ 9 \
  Num $::=$ Cifra $|$ Num Cifra \
  Op $::=$ + $|$ $times$ \
  Esp $::=$ Num $|$ Esp Op Esp
]

#note[
  Ogni produzione definisce come costruire espressioni valide
]
