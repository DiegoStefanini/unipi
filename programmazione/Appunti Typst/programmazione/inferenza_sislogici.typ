#import "../template.typ": *

== Regole di Inferenza e Sistemi Logici

Data una produzione S $::=$ a b $|$ a S b possiamo scriverla in due modi:
- lettura generativa (o produttiva): la grammatica è vista come un insieme di regole di riscrittura, la produzione si legge da sinistra verso destra e se trovo il simbolo S posso rimpiazzarlo con a S b
- lettura induttiva (costruttiva): la grammatica è una definizione induttiva, la produzione si legge da destra verso sinistra e ogni produzione è una clausola che spiega come costruire stringhe valide; presa una stringa w qualsiasi in L(S) concludo che anche a w b è in L(S)

=== Regole di inferenza

Per definire la semantica del linguaggio Mao verranno utilizzate le regole di inferenza. Date premesse $p$ e conclusione $q$ possiamo definire le regole di inferenza come:

#align(center)[
  #box(stroke: (bottom: 1pt), inset: 5pt)[$p_1 space ... space p_n$] \
  $q$ #h(1cm) (Nome-Regola)
]

Se tutte le premesse sono vere allora si può trarre la conclusione $q$; se le premesse sono vuote allora si ha un #underline[assioma] di forma (assioma).

#align(center)[
  #box(stroke: (bottom: 1pt), inset: 5pt)[$ $] \
  $q$ #h(1cm) (Nome-assioma)
]

Le regole di inferenza vengono utilizzate per derivare nuovi giudizi a partire dalle verità già note.

==== Produzioni come regole di inferenza

#figure(
  image("../images/produz_inf.png", width: 40%),
)

=== Sistemi logici

Un sistema logico è un insieme di regole di inferenza che possono essere applicate per dimostrare la validità di formule.

#figure(
  image("../images/gram.png", width: 25%),
)

#example[
  Prendendo come riferimento la grammatica nell'immagine precedente, $2 times 3$ è un'espressione valida?

  #figure(
    image("../images/sis_log.png", width: 50%),
  )
]

==== Derivazione

#definition[
  Una derivazione nel sistema logico è una sequenza di passaggi che partendo dagli assiomi e applicando le regole giustificano una certa conclusione, scritto $d tack q$, si legge "la derivazione d dimostra il giudizio q" oppure "d è una derivazione per q"
]

Le derivazioni sono definite come segue:
- ogni assioma del sistema logico è una derivazione per q
- se $frac(p_1 space ... space p_n, q)$ è regola del sistema logico le cui premesse sono derivabili $d_1 tack p_1, ..., d_n tack p_n$, allora $frac(d_1 space ... space d_n, q)$

#figure(
  image("../images/es_deriv.png", width: 30%),
)

==== Alberi di derivazioni

Anche le derivazioni formano una #underline[struttura ad albero], anche se in questo caso la radice è posta verso il basso.

#figure(
  image("../images/albero_deriv.png", width: 40%),
)

==== Grammatiche come sistemi logici

Formalmente invece dei blocchetti colorati, introduciamo le formule $x in L(X)$, col significato che la stringa x appartiene al linguaggio di X.

#figure(
  image("../images/gramm_logi.png", width: 30%),
)

Ad ogni produzione della grammatica (dove $omega_i in T^*$ e $X_i in N$) associamo una regola di inferenza

#figure(
  image("../images/prod_infere.png", width: 30%),
)

==== Valutazione di espressioni

I sistemi logici permettono di assegnare un significato ad espressioni e comandi seguendone la struttura grammaticale.

#example[
  riprendendo la grammatica ambigua delle espressioni con sole cifre:

  #figure(
    image("../images/espress.png", width: 50%),
  )

  presa un'espressione w: se w è una cifra allora il valore è il numero che rappresenta; se w = $w_1 + w_2$ è la somma di Espressione e il valore è la somma dei valori; analogamente vale anche per il prodotto.
]

Definiamo un predicato di valutazione per ogni categoria sintattica $w arrow.b.double_X v$, spesso abbreviato con $w arrow.b.double v$, si legge dicendo che "il termine $w in T^*$) del linguaggio di $X in N$ ha valore $v$

#figure(
  image("../images/espress_valutaz.png", width: 50%),
)

#figure(
  image("../images/espress_valutaz_1.png", width: 50%),
)

#figure(
  image("../images/espress_valutaz_2.png", width: 50%),
)

== Induzione

#definition[
  L'induzione è un principio fondamentale che permette di trattare insiemi infiniti di oggetti, attraverso un numero finito di regole o casi.
]

Il principio di induzione ci permette di costruire un numero infinito di un insieme mediante un numero finito di regole, definire il comportamento di una funzione su un insieme infinito di elementi descrivendo il comportamento su casi finiti e dimostrare che una proprietà è valida per tutti gli elementi di un insieme finito, esaminando un numero finito di casi.

=== Induzione matematica

Voglio dimostrare che una proprietà è valida per tutti i naturali. Preso un generico $n$, assumendo che la proprietà sia vera per $n$, dimostro che è vera anche per $n + 1$.

#example[
  Voglio dimostrare che per ogni naturale positivo $n$, la somma dei primi $n$ positivi è la metà del prodotto $n$ e $n + 1$.
  $ 1 + 2 + 3 + 4 + ... + n = frac(n(n + 1), 2) $

  Caso induttivo: prendo un generico n, assumo valga $1 + 2 + 3 + 4 + ... + n = frac(n(n + 1), 2)$ e cerco di dimostrare che $1 + 2 + 3 + 4 + ... + n + (n + 1) = frac((n + 1)(n + 2), 2)$
]

#figure(
  image("../images/induz.png", width: 50%),
)

=== Induzione strutturale

Voglio dimostrare che una proprietà è valida per tutte le stringhe $s in T^*$ di un linguaggio generato da una grammatica. Nel caso base dimostro la proprietà per le stringhe $omega in T^*$ che compaiono nella parte destra delle produzioni atomiche (X $::=$ $omega$). Nei casi induttivi, presa una qualsiasi altra produzione non atomica dimostro che se la proprietà è valida per le stringhe $s_1, ..., s_n in T^*$, allora deve valere anche per $omega_0 s_1 omega_1 s_2 ... s_n omega_n$

=== Induzione sulle derivazioni

Voglio dimostrare che una proprietà è valida per tutti i giudizi derivabili in un sistema logico. Nel caso base dimostro la proprietà è valida per tutte le conclusioni degli assiomi. Nel caso induttivo, presa una qualsiasi altra regola di inferenza dimostro che se la proprietà è valida per tutte le premesse allora vale anche per la conclusione.

#figure(
  image("../images/induz_deriv.png", width: 70%),
)

== Esercizi: Dimostrazioni Induttive su Grammatiche

In questa sezione vengono presentati esercizi di dimostrazione per induzione strutturale su grammatiche context-free. Per ogni esercizio si richiede di dimostrare una proprieta' valida per tutte le stringhe del linguaggio generato.

=== Esercizio 1: Bilanciamento di $a$ e $b$

#example(title: "Grammatica")[
  Data la grammatica:
  $ S ::= a S b | a b $

  Dimostrare per induzione strutturale che ogni stringa $w in L(S)$ soddisfa $\#_a (w) = \#_b (w)$, dove $\#_a (w)$ indica il numero di occorrenze del simbolo $a$ nella stringa $w$.
]

#demonstration[
  Procediamo per induzione strutturale sulla derivazione di $w$.

  *Caso base:* $S arrow.r a b$

  La stringa generata e' $w = a b$. Contiamo le occorrenze:
  - $\#_a (a b) = 1$
  - $\#_b (a b) = 1$

  Quindi $\#_a (w) = \#_b (w) = 1$. #sym.checkmark

  *Caso induttivo:* $S arrow.r a S b$

  Assumiamo per ipotesi induttiva che la stringa $w'$ generata da $S$ soddisfi $\#_a (w') = \#_b (w') = k$ per qualche $k >= 1$.

  La nuova stringa e' $w = a w' b$. Contiamo le occorrenze:
  - $\#_a (a w' b) = 1 + \#_a (w') = 1 + k$
  - $\#_b (a w' b) = \#_b (w') + 1 = k + 1$

  Quindi $\#_a (w) = \#_b (w) = k + 1$. #sym.checkmark
]

#example(title: "Alberi di derivazione")[
  Mostriamo gli alberi di derivazione per alcune stringhe del linguaggio:

  *Stringa $a b$* (caso base):
  ```
      S
     / \
    a   b
  ```

  *Stringa $a a b b$* (una applicazione della regola ricorsiva):
  ```
        S
      / | \
     a  S  b
       / \
      a   b
  ```

  *Stringa $a a a b b b$* (due applicazioni della regola ricorsiva):
  ```
          S
        / | \
       a  S  b
        / | \
       a  S  b
         / \
        a   b
  ```
]

#note[
  Il linguaggio $L(S) = \{a^n b^n | n >= 1\}$ e' l'esempio classico di linguaggio context-free non regolare. La proprieta' dimostrata ($\#_a = \#_b$) e' necessaria ma non sufficiente per caratterizzare il linguaggio (ad esempio $a b a b$ ha lo stesso numero di $a$ e $b$ ma non appartiene a $L(S)$).
]

=== Esercizio 2: Stringhe con esattamente una $c$

#example(title: "Grammatica")[
  Data la grammatica:
  $ S ::= b S a | a S b | c $

  Dimostrare per induzione strutturale che ogni stringa $w in L(S)$ soddisfa:
  + $\#_c (w) = 1$ (esattamente una occorrenza di $c$)
  + $\#_a (w) = \#_b (w)$ (stesso numero di $a$ e $b$)
]

#demonstration[
  Procediamo per induzione strutturale sulla derivazione di $w$.

  *Caso base:* $S arrow.r c$

  La stringa generata e' $w = c$. Verifichiamo:
  - $\#_c (c) = 1$ #sym.checkmark
  - $\#_a (c) = 0 = \#_b (c)$ #sym.checkmark

  *Caso induttivo 1:* $S arrow.r b S a$

  Assumiamo per ipotesi induttiva che la stringa $w'$ generata da $S$ soddisfi $\#_c (w') = 1$ e $\#_a (w') = \#_b (w') = k$ per qualche $k >= 0$.

  La nuova stringa e' $w = b w' a$. Verifichiamo:
  - $\#_c (b w' a) = \#_c (w') = 1$ #sym.checkmark
  - $\#_a (b w' a) = \#_a (w') + 1 = k + 1$
  - $\#_b (b w' a) = 1 + \#_b (w') = 1 + k = k + 1$

  Quindi $\#_a (w) = \#_b (w) = k + 1$. #sym.checkmark

  *Caso induttivo 2:* $S arrow.r a S b$

  Assumiamo per ipotesi induttiva che la stringa $w'$ generata da $S$ soddisfi $\#_c (w') = 1$ e $\#_a (w') = \#_b (w') = k$ per qualche $k >= 0$.

  La nuova stringa e' $w = a w' b$. Verifichiamo:
  - $\#_c (a w' b) = \#_c (w') = 1$ #sym.checkmark
  - $\#_a (a w' b) = 1 + \#_a (w') = 1 + k$
  - $\#_b (a w' b) = \#_b (w') + 1 = k + 1$

  Quindi $\#_a (w) = \#_b (w) = k + 1$. #sym.checkmark
]

#example(title: "Alberi di derivazione")[
  Mostriamo gli alberi di derivazione per alcune stringhe del linguaggio:

  *Stringa $c$* (caso base):
  ```
    S
    |
    c
  ```

  *Stringa $b c a$* (regola $b S a$):
  ```
      S
    / | \
   b  S  a
      |
      c
  ```

  *Stringa $a c b$* (regola $a S b$):
  ```
      S
    / | \
   a  S  b
      |
      c
  ```

  *Stringa $a b c a b$* (composizione di regole):
  ```
          S
        / | \
       a  S  b
        / | \
       b  S  a
          |
          c
  ```
  Derivazione: $S arrow.r a S b arrow.r a b S a b arrow.r a b c a b$
]

#note[
  Questa grammatica genera il linguaggio delle stringhe palindrome? No! Ad esempio $a b c b a$ non e' generabile. La grammatica genera stringhe dove $c$ e' sempre al centro, ma le $a$ e $b$ a sinistra e destra di $c$ non sono necessariamente simmetriche.
]

=== Esercizio 3: Almeno una $a$

#example(title: "Grammatica")[
  Data la grammatica:
  $ S ::= S a | S b | a $

  Dimostrare per induzione strutturale che ogni stringa $w in L(S)$ soddisfa $\#_a (w) >= 1$.
]

#demonstration[
  Procediamo per induzione strutturale sulla derivazione di $w$.

  *Caso base:* $S arrow.r a$

  La stringa generata e' $w = a$. Verifichiamo:
  - $\#_a (a) = 1 >= 1$ #sym.checkmark

  *Caso induttivo 1:* $S arrow.r S a$

  Assumiamo per ipotesi induttiva che la stringa $w'$ generata da $S$ soddisfi $\#_a (w') >= 1$.

  La nuova stringa e' $w = w' a$. Verifichiamo:
  - $\#_a (w' a) = \#_a (w') + 1 >= 1 + 1 = 2 >= 1$ #sym.checkmark

  *Caso induttivo 2:* $S arrow.r S b$

  Assumiamo per ipotesi induttiva che la stringa $w'$ generata da $S$ soddisfi $\#_a (w') >= 1$.

  La nuova stringa e' $w = w' b$. Verifichiamo:
  - $\#_a (w' b) = \#_a (w') >= 1$ #sym.checkmark

  (Aggiungere una $b$ non cambia il numero di $a$, che rimane almeno 1.)
]

#example(title: "Alberi di derivazione")[
  Mostriamo gli alberi di derivazione per alcune stringhe del linguaggio:

  *Stringa $a$* (caso base):
  ```
    S
    |
    a
  ```

  *Stringa $a b$*:
  ```
      S
     / \
    S   b
    |
    a
  ```

  *Stringa $a a$*:
  ```
      S
     / \
    S   a
    |
    a
  ```

  *Stringa $a b a b$*:
  ```
            S
           / \
          S   b
         / \
        S   a
       / \
      S   b
      |
      a
  ```
  Derivazione: $S arrow.r S b arrow.r S a b arrow.r S b a b arrow.r a b a b$
]

#note[
  Questa grammatica genera il linguaggio $L(S) = \{a\} dot (a | b)^*$, cioe' tutte le stringhe su $\{a, b\}$ che iniziano con $a$. La proprieta' dimostrata ($\#_a >= 1$) e' una conseguenza immediata di questa caratterizzazione: ogni stringa inizia con almeno una $a$.
]

=== Osservazioni metodologiche

#note(title: "Schema generale per l'induzione strutturale")[
  Per dimostrare una proprieta' $P(w)$ per tutte le stringhe $w in L(S)$:

  + *Identificare i casi base*: produzioni della forma $X ::= omega$ dove $omega in T^*$ (solo terminali)

  + *Identificare i casi induttivi*: produzioni della forma $X ::= alpha_1 Y_1 alpha_2 Y_2 ... Y_n alpha_(n+1)$ dove $Y_i$ sono non-terminali

  + *Per ogni caso base*: verificare direttamente che $P(omega)$ vale

  + *Per ogni caso induttivo*: assumere che $P(w_i)$ valga per le stringhe $w_i$ generate dai non-terminali $Y_i$ (ipotesi induttiva), e dimostrare che $P(alpha_1 w_1 alpha_2 w_2 ... w_n alpha_(n+1))$ vale
]
