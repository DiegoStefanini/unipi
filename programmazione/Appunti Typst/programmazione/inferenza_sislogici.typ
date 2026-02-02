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
