#import "../template.typ": *

#nuova-lezione(1, "Sistemi Lineari, Matrici e Numeri Complessi")

= Sistemi Lineari

== Introduzione

L'obiettivo principale dell'algebra lineare è la risoluzione di *sistemi lineari*.

#definizione("Sistema Lineare")[
  Un sistema lineare in $m$ equazioni e $n$ incognite ha la forma:
  $
  cases(
    a_(1 1) x_1 + a_(1 2) x_2 + dots + a_(1 n) x_n = b_1,
    a_(2 1) x_1 + a_(2 2) x_2 + dots + a_(2 n) x_n = b_2,
    dots.v,
    a_(m 1) x_1 + a_(m 2) x_2 + dots + a_(m n) x_n = b_m
  )
  $
]

== Matrice Associata al Sistema

#definizione("Matrice Incompleta")[
  La *matrice incompleta* (o matrice dei coefficienti) del sistema lineare è:
  $
  A = mat(
    a_(1 1), a_(1 2), dots, a_(1 n);
    a_(2 1), a_(2 2), dots, a_(2 n);
    dots.v, dots.v, dots.down, dots.v;
    a_(m 1), a_(m 2), dots, a_(m n)
  )
  $
]

#definizione("Matrice Completa")[
  La *matrice completa* (o matrice aumentata) include anche i termini noti:
  $
  (A | b) = mat(
    a_(1 1), a_(1 2), dots, a_(1 n), |, b_1;
    a_(2 1), a_(2 2), dots, a_(2 n), |, b_2;
    dots.v, dots.v, dots.down, dots.v, |, dots.v;
    a_(m 1), a_(m 2), dots, a_(m n), |, b_m
  )
  $
]

*Notazione:* Per una matrice $A$, l'elemento $A(i, j)$ indica l'elemento in riga $i$ e colonna $j$.

#esempio[
  Dato il sistema:
  $
  cases(
    4x + 2y = 20,
    x + y = 7
  )
  $

  La matrice completa è:
  $
  mat(
    4, 2, |, 20;
    1, 1, |, 7
  )
  $
]

= Operazioni tra Matrici

== Somma di Matrici

#definizione("Somma di Matrici")[
  Date due matrici $A = (a_(i j))$ e $B = (b_(i j))$ di dimensione $m times n$, la somma $A + B$ è definita come:
  $
  A + B in M_(m times n) (KK)
  $
  dove $(A + B)_(i j) = a_(i j) + b_(i j)$
]

#nota[
  La somma è definita solo per matrici delle *stesse dimensioni*.
]

== Moltiplicazione per uno Scalare

#definizione("Prodotto Scalare")[
  Data una matrice $A in M_(m times n)(KK)$ e uno scalare $lambda in KK$:
  $
  lambda dot A in M_(m times n)(KK)
  $
  dove $(lambda A)_(i j) = lambda dot a_(i j)$
]

#esempio[
  $
  2 dot mat(1, 0; 0, 1; 1, 2) = mat(2, 0; 0, 2; 2, 4)
  $
]

== Moltiplicazione tra Matrici

#definizione("Prodotto Matriciale")[
  Date $A in M_(m times k)(KK)$ e $B in M_(k times n)(KK)$, il prodotto $C = A dot B$ è una matrice $C in M_(m times n)(KK)$ dove:
  $
  c_(i j) = sum_(l=1)^k a_(i l) dot b_(l j)
  $

  Il numero di *colonne* di $A$ deve essere uguale al numero di *righe* di $B$.
]

#esempio[
  $
  mat(1, 4; 3, 0; 1, 2)_(3 times 2) dot mat(0, 3, 4; 1, 0, 7)_(2 times 3) = mat(-1, 3, 28; 1, 8, 15; dots, dots, dots)_(3 times 3)
  $

  Calcolo elemento $(1,1)$: $1 dot 0 + 4 dot 1 = 4 - 1 = -1$ _(prodotto scalare riga per colonna)_

  Calcolo elemento $(1,3)$: $1 dot 4 + 4 dot 7 = 4 + 28 = 28$
]

= Proprietà delle Operazioni Matriciali

== Proprietà Distributiva

Date matrici $A, B in M_(m times k)$ e $C, D in M_(k times n)$:
$
(A + B)(C + D) = A C + A D + B C + B D
$

== Non Commutatività del Prodotto

#nota[
  Il prodotto tra matrici *non è commutativo*:
  $
  A B != B A
  $
]

#esempio[
  Date:
  $
  A = mat(1, 1; 2, 3) quad B = mat(-3, 4; 5, 2)
  $

  $
  A B = mat(-2, 6; -3, 14) quad B A = mat(5, 8; 5, 7)
  $

  Quindi $A B != B A$.
]

Di conseguenza, per il quadrato di una somma:
$
(A + B)^2 = (A + B)(A + B) = A^2 + A B + B A + B^2
$

#nota[
  $(A + B)^2 != A^2 + 2 A B + B^2$ perché $A B != B A$ in generale.
]

== Proprietà Associativa

Il prodotto matriciale è *associativo*:
$
(A B) C = A (B C)
$

== Altre Proprietà

- $A(B C) = A B + A C$ (distributiva a sinistra)
- $(lambda mu) A = lambda (mu A)$ (associatività scalare)
- $lambda (A + B) = lambda A + lambda B$ (distributiva scalare)

== Matrice Identità

#definizione("Matrice Identità")[
  La matrice identità $I_n in M_(n times n)$ ha $1$ sulla diagonale principale e $0$ altrove:
  $
  I = mat(
    1, 0, dots, 0;
    0, 1, dots, 0;
    dots.v, dots.v, dots.down, dots.v;
    0, 0, dots, 1
  )
  $
]

*Proprietà:* Per ogni matrice $A in M_(m times n)$:
$
I_m dot A = A = A dot I_n
$

= Numeri Complessi

== Definizione

#definizione("Insieme dei Numeri Complessi")[
  L'insieme dei numeri complessi è:
  $
  CC = {a + i b : a, b in RR}
  $
  dove $i$ è l'*unità immaginaria* con la proprietà:
  $
  i^2 = -1
  $
]

== Operazioni con i Numeri Complessi

=== Somma
$
(2 + 3i) + (4 - i) = 6 + 2i
$

=== Prodotto
$
(2 + 3i)(4 - i) = 8 - 6i + 12i - 3i^2 = 8 + 10i - 3(-1) = 11 + 10i
$

=== Coniugato

#definizione("Complesso Coniugato")[
  Il coniugato di $z = a + b i$ è:
  $
  overline(z) = a - b i
  $
]

*Proprietà utile:*
$
z dot overline(z) = (a + b i)(a - b i) = a^2 - (b i)^2 = a^2 + b^2 in RR
$

=== Divisione

Per dividere numeri complessi, si moltiplica numeratore e denominatore per il coniugato del denominatore:

#esempio[
  $
  (2 + 3i) / (4 - i) = (2 + 3i) / (4 - i) dot (4 + i) / (4 + i) = ((2 + 3i)(4 + i)) / (4^2 + 1^2) = (8 + 14i + 3i^2) / 17 = (5 + 14i) / 17
  $
]

= Teorema Fondamentale dell'Algebra

#teorema("Teorema Fondamentale dell'Algebra")[
  Ogni polinomio di grado $n$:
  $
  p(x) = a_0 + a_1 x + a_2 x^2 + dots + a_n x^n
  $
  con $a_0, a_1, dots, a_n in CC$, ammette esattamente $n$ radici complesse (contando la molteplicità delle radici).
]

= Trasformazioni Elementari e Metodo di Gauss

== Trasformazioni Elementari

Le seguenti operazioni *non cambiano le soluzioni* di un sistema lineare:

+ *Scambio:* Aggiungere a una equazione il multiplo di un'altra
+ *Moltiplicazione:* Moltiplicare una equazione per un numero non nullo
+ *Riordinamento:* Cambiare l'ordine delle equazioni

== Metodo di Eliminazione di Gauss

#esempio[
  Risolvere il sistema:
  $
  cases(
    x + y = 7,
    4x + 2y = 8
  )
  $

  *Matrice completa:*
  $
  mat(1, 1, |, 7; 4, 2, |, 8)
  $

  *Passo 1:* $E q_2 arrow.r E q_2 - 4 E q_1$
  $
  mat(1, 1, |, 7; 0, -2, |, -20)
  $
  Forma *ridotta per righe* (a scala, struttura a gradini)

  *Passo 2:* $E q_2 arrow.r -1/2 E q_2$
  $
  mat(1, 1, |, 7; 0, 1, |, 10)
  $

  *Passo 3:* $E q_1 arrow.r E q_1 - E q_2$
  $
  mat(1, 0, |, -3; 0, 1, |, 10)
  $
  Forma *completamente ridotta* per righe

  *Soluzione:* $(x, y) = (-3, 10)$
]
