#import "../template.typ": *

=== Derivazioni e Linguaggi Generati

=== Derivativo immediato

#definition[
  Data una grammatica $G = (T, N, P)$, e date due stringhe $beta, beta' in S^*$ di simboli terminali e non terminali, si dice che $beta'$ è un *derivativo immediato* di $beta$, scrivendo $beta arrow.r beta'$ se e solo se partendo da $beta$ è possibile ottenere $beta'$ applicando una produzione:
  - $beta$ contiene occorrenza di un qualche simbolo non terminale: $beta = beta_1 times beta_2$ per stringhe $beta_1, beta_2 in S^*$ e $X in N$
  - esiste una produzione $X ::= alpha$ tale che $beta_1 = beta_1 alpha beta_2$
]

#example[
  $beta =$ Exp + Exp Op 2, se Exp $::=$ Num allora $beta' =$ Exp + Num Op 2
]

=== Derivativo

#definition[
  Data una grammatica $G = (T, N, P)$, e date due stringhe $beta, beta' in S^*$ di simboli terminali e non terminali, si dice che $beta'$ è un *derivativo* di $beta$, scrivendo $beta arrow.r^* beta'$ se e solo se partendo da $beta$ è possibile ottenere $beta'$ applicando un numero qualsiasi di produzioni, passo dopo passo ($beta arrow.r beta_1 arrow.r beta_2 arrow.r ... arrow.r beta_n = beta'$)
]

=== Linguaggio generato

#definition[
  Data una grammatica $G = (T, N, P)$ e un simbolo non terminale $X in N$, il linguaggio di $X$, scritto $L(X)$ è #underline[l'insieme di tutti e soli i derivativi $beta in T^*$ di $X$] \
  $L(X) = {w | w in T^*, X arrow.r^* w}$
]

==== Quali stringhe appartengono al linguaggio?

Data una grammatica $G = (T, N, P)$ una stringa di terminali $w in T^*$ appartiene al linguaggio $L(X)$ del non terminale $X in N$ se partendo dal simbolo $X$ e applicando una o più volte le regole di produzione, si può ottenere la stringa $w in T^*$ composta da solo terminali. Invece non appartiene al linguaggio se partendo dal simbolo $X$ e indipendentemente da come si applicano le regole di produzione, non è possibile generare i terminali della stringa.

#example(title: $bb(N)$)[
  Riprendendo l'esempio dei numeri naturali \
  Cifra $::=$ 0 $|$ 1 $|$ 2 $|$ ... $|$ 9 \
  Num $::=$ Cifra $|$ Num Cifra \
  Op $::=$ + $|$ $times$ \
  Esp $::=$ Num $|$ Esp Op Esp

  Modifichiamolo affinché non possa generare numeri che hanno 0 come cifra più significativa: \
  NonZero $::=$ 1 $|$ 2 $|$ 3 $|$ ... $|$ 9 \
  Cifra $::=$ 0 $|$ NonZero \
  Pos $::=$ Cifra $|$ Pos Cifra \
  Num $::=$ 0 $|$ Pos
]
