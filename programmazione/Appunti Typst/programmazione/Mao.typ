#import "../template.typ": *

=== Mao (Modello Astratto Operazionale)

=== Array e espressioni con effetti collaterali

#definition(title: "array - informale")[
  Un array è una struttura dati volta a trattare un insieme di dati omogenei in modo efficiente
]

Utilizzando `int[]` o `bool[]` e stabilito che una dichiarazione avviene come

#align(center)[
  `int[] voti = [x₁, x₂, x₃]`
]

Viene riservato un primo elemento in $l_b$ (indirizzo base) per memorizzare la lunghezza dell'array. Per ciascun valore della serie lo si accede attraverso la sua posizione $x$:

#align(center)[
  $l_b [x]$
]

Nella struttura memoria-ambiente, si rappresenta nel seguente modo l'indirizzo base e le successive:

#align(center)[
  $rho(x) = l_x$, $sigma(l_x) = l_b$ \
  $sigma(l_b) = 3$ \
  $sigma(l_b [0]) = 18$
]

#definition(title: "Array - formale")[
  Un array è una collezione finita dello stesso tipo, memorizzati contiguamente. Il numero degli elementi è la #underline[lunghezza dell'array]. Tipo e lunghezza sono fissati alla dichiarazione e sono statici (non possono essere cambiati una volta dichiarati)
]

Un array permette di trattare come entità atomiche intere collezioni e al contempo permette di accedere ai singoli elementi tramite indici posizionali con intervallo

#align(center)[
  $[0, "lunghezza")$
]

=== Sintassi

Per ottenere la lunghezza di un array è possibile utilizzare il costrutto `.length`

#example(title: "lunghezza array")[
  ```
  int[] voti = [18,30,23];

  voti.length = 3
  ```
]

La sintassi degli array in Mao è così grammaticalmente rappresentata:

#align(center)[
  $T &::= ... | T[]$ \
  $E &::= ... | "[" S "]" | "new" space T "[" E "]" | E "." "length" | E "[" E "]"$ \
  $S &::= E | E "," S$ \
  $C &::= ... | E "[" E "]" := E$
]

Dove:
- $T[]$: tipo array di elementi di tipo $T$
- $"[" S "]"$: letterale array (serie di espressioni)
- $"new" space T "[" E "]"$: allocazione di un nuovo array
- $E "." "length"$: lunghezza dell'array
- $E "[" E "]"$: accesso a un elemento

=== Valori e riferimenti

Se in MiniMao le celle di memoria contenevano solamente valori interi e booleani

#align(center)[
  $rho: bb(I) arrow.r.hook bb(L)$ e $sigma: bb(L) arrow.r.hook bb(V)$ dove $bb(V) = bb(Z) union bb(B)$
]

adesso in Mao si memorizzano anche gli indirizzi base degli array

#align(center)[
  $rho: bb(I) arrow.r.hook bb(L)$ e $sigma: bb(L) arrow.r.hook bb(V)$ dove $bb(V) = bb(Z) union bb(B) union bb(L)$
]

Ora si includono tra i valori anche le locazioni (riferimenti)

=== Espressioni "pure" e non

Se in MiniMao la presenza nella grammatica di sole espressioni pure ci permetteva la seguente semplificazione

#align(center)[
  $chevron.l E, rho, sigma chevron.r arrow.b.double (v, sigma') arrow.r chevron.l E, rho, sigma chevron.r arrow.b.double v$
]

Adesso con l'introduzione di #underline[allocazione di memoria] non è più possibile. Le espressioni che allocano memoria (come `new T[E]` o letterali array `[E1, E2, ...]`) producono anche una memoria modificata:

#align(center)[
  $chevron.l E, rho, sigma chevron.r arrow.b.double (v, sigma')$
]

=== Semantica degli Array

==== Allocazione di un array letterale

#align(center)[
  #box(stroke: (bottom: 1pt), inset: 3pt)[$chevron.l E_1, rho, sigma chevron.r arrow.b.double (v_1, sigma_1)$ #h(0.2cm) $...$ #h(0.2cm) $chevron.l E_n, rho, sigma_(n-1) chevron.r arrow.b.double (v_n, sigma_n)$ #h(0.2cm) $l_b, l_b+1, ..., l_b+n in.not "dom"(sigma_n)$] \
  $chevron.l [E_1, ..., E_n], rho, sigma chevron.r arrow.b.double (l_b, sigma_n[l_b |-> n][l_b+1 |-> v_1]...[l_b+n |-> v_n])$ #h(0.2cm) (Array-Lit)
]

#note[
  L'array viene memorizzato con la lunghezza in $l_b$ e gli elementi in $l_b+1, ..., l_b+n$.
]

==== Allocazione con new

#align(center)[
  #box(stroke: (bottom: 1pt), inset: 3pt)[$chevron.l E, rho, sigma chevron.r arrow.b.double (n, sigma')$ #h(0.3cm) $l_b, ..., l_b+n in.not "dom"(sigma')$] \
  $chevron.l "new" T[E], rho, sigma chevron.r arrow.b.double (l_b, sigma'[l_b |-> n][l_b+1 |-> "default"]...[l_b+n |-> "default"])$ #h(0.2cm) (Array-New)
]

==== Lunghezza

#align(center)[
  #box(stroke: (bottom: 1pt), inset: 3pt)[$chevron.l E, rho, sigma chevron.r arrow.b.double (l_b, sigma')$ #h(0.3cm) $sigma'(l_b) = n$] \
  $chevron.l E."length", rho, sigma chevron.r arrow.b.double (n, sigma')$ #h(0.5cm) (Array-Length)
]

==== Accesso

#align(center)[
  #box(stroke: (bottom: 1pt), inset: 3pt)[$chevron.l E_1, rho, sigma chevron.r arrow.b.double (l_b, sigma_1)$ #h(0.2cm) $chevron.l E_2, rho, sigma_1 chevron.r arrow.b.double (i, sigma_2)$ #h(0.2cm) $0 <= i < sigma_2(l_b)$] \
  $chevron.l E_1[E_2], rho, sigma chevron.r arrow.b.double (sigma_2(l_b + 1 + i), sigma_2)$ #h(0.3cm) (Array-Access)
]

==== Assegnamento in array

#align(center)[
  #box(stroke: (bottom: 1pt), inset: 3pt)[$chevron.l E_1, rho, sigma chevron.r arrow.b.double (l_b, sigma_1)$ #h(0.15cm) $chevron.l E_2, rho, sigma_1 chevron.r arrow.b.double (i, sigma_2)$ #h(0.15cm) $chevron.l E_3, rho, sigma_2 chevron.r arrow.b.double (v, sigma_3)$] \
  $chevron.l E_1[E_2] := E_3;, rho, sigma chevron.r arrow.r chevron.l rho, sigma_3[l_b + 1 + i |-> v] chevron.r$ #h(0.2cm) (Array-Assign)
]

=== Aliasing

#example(title: "Problema dell'aliasing")[
  Con l'aliasing si intende la copia di un array per riferimento:
  ```
  int[] a = [1, 2, 3];
  int[] b = a;        // b punta allo stesso array di a!
  b[0] := 99;         // modifica anche a[0]!
  ```

  Dopo l'esecuzione:
  - $rho = [a |-> l_a, b |-> l_b]$
  - $sigma(l_a) = sigma(l_b) = l_{"base"}$ (stesso indirizzo base!)

  Quindi `a[0]` e `b[0]` accedono alla stessa cella di memoria.
]

#note(title: "Conseguenza")[
  Quando si passa un array come parametro a una funzione, si passa il *riferimento*. Modifiche all'array nel corpo della funzione si riflettono sull'array originale.
]

=== Analisi statica e controllo di tipi

Grazie alle grammatiche le categorie sintattiche delle espressioni e dei comandi sono definite in maniera rigorosa, ma molti di essi, anche se sintatticamente validi, potrebbero portare ad un'altra categoria di eventi.

#definition(title: "analisi statica")[
  Con analisi statica si indicano i controlli fatti sul codice sorgente senza eseguire il programma
]

La maggior parte dei linguaggi moderni hanno diversi controlli con analisi statica, Mao si limita al #underline[controllo dei tipi (type checking)] che permette di rilevare problemi legati alla mancanza di coerenza tra i tipi delle variabili, costanti e operazioni.

=== Sistemi di tipi

In Mao il controllo dei tipi viene in modo formale attraverso #underline[regole di tipo] che stabiliscono le condizioni necessarie affinché espressione o comandi vengano considerati #underline[ben tipati]. Il controllo avviene in modo #underline[composizionale] cioè le regole di tipo per espressioni e comandi sono definite su giudizi di tipo sulle sue componenti; per fare ciò è necessario sapere quali tipi sono associati alle variabili nelle espressioni o nel comando.

=== Ambiente di tipo

#definition[
  L'ambiente di tipo $Gamma: bb(I) arrow.r.hook bb(T)$ è una funzione parziale che assegna agli identificatori: $Gamma(x) = "int"$ che significa #underline[assumere che x abbia tipo int]
]

Scriviamo $"Id" : T$ per dire $Gamma("Id") = T$.
$ Gamma = {"Id"_1 : T_1, "Id"_2 : T_2, ..., "Id"_n : T_n} $

#example[
  Dopo le seguenti dichiarazioni
  ```
  int temp = 2;
  bool y = true;
  ```
  Si troverà $Gamma = {x : "int", y : "bool"}$
]

=== Variabili libere in un'espressione

Data un'espressione $E in bb(E)$, la funzione $"fv"(.): bb(E) arrow.r cal(P)_("fin")(bb(I))$ restituisce l'insieme di tutte le variabili che occorrono in $E$, dette #underline[variabili libere]. La funzione viene definita per induzione nel modo seguente:

#align(center)[
  $"fv"(n) &= emptyset$ \
  $"fv"("true") &= emptyset$ \
  $"fv"("false") &= emptyset$ \
  $"fv"("Id") &= {"Id"}$ \
  $"fv"(E_1 "bop" E_2) &= "fv"(E_1) union "fv"(E_2)$ \
  $"fv"("uop" E) &= "fv"(E)$ \
  $"fv"((E)) &= "fv"(E)$ \
  $"fv"(E_1[E_2]) &= "fv"(E_1) union "fv"(E_2)$ \
  $"fv"(E."length") &= "fv"(E)$ \
  $"fv"("new" T[E]) &= "fv"(E)$
]

#example[
  $"fv"($`x+3`$) = "fv"($`x`$) union "fv"($`3`$) = {$`x`$}$
]

#example[
  $"fv"($`new int[a.length]`$) = {$`a`$}$
]

#example[
  $"fv"($`x%7 == z*x`$) = {$`x, z`$}$
]

Dato un comando $C in bb(C)$, la funzione $"fv"(.): bb(C) arrow.r cal(P)_("fin")(bb(I))$ restituisce l'insieme di tutte le variabili che occorrono in $C$ senza essere dichiarate. La funzione è definita per induzione ma richiede $"dv"(.): bb(C) arrow.r cal(P)_("fin")(bb(I))$ che restituisce le variabili introdotte da dichiarazioni.

#align(center)[
  $"fv"("skip";) &= emptyset$ \
  $"fv"(T space "Id" = E;) &= "fv"(E)$ \
  $"fv"("Id" := E;) &= {"Id"} union "fv"(E)$ \
  $"fv"(E_1[E_2] := E_3;) &= "fv"(E_1) union "fv"(E_2) union "fv"(E_3)$ \
  $"fv"(C_1 C_2) &= "fv"(C_1) union ("fv"(C_2) backslash "dv"(C_1))$ \
  $"fv"({C}) &= "fv"(C)$ \
  $"fv"("if"(E){C_1}"else"{C_2}) &= "fv"(E) union "fv"(C_1) union "fv"(C_2)$ \
  $"fv"("while"(E){C}) &= "fv"(E) union "fv"(C)$
]

Dove $"dv"(C)$ è l'insieme delle variabili dichiarate in $C$:
#align(center)[
  $"dv"(T space "Id" = E;) &= {"Id"}$ \
  $"dv"(C_1 C_2) &= "dv"(C_1) union "dv"(C_2)$ \
  $"dv"("altri comandi") &= emptyset$
]

=== Giudizi di tipo per espressioni

Dato un ambiente di tipo $Gamma$ e una espressione $E$ tale che $"fv"(E) subset.eq "dom"(Gamma)$ possiamo derivare un #underline[giudizio di tipo], scritto $Gamma tack E : T$ che si legge "nell'ambiente $Gamma$, l'espressione $E$ è ben tipata e ha tipo $T$"

=== Giudizi di tipo per i comandi

Dato un ambiente di tipo $Gamma$ e un comando $C$ tale che $"fv"(C) subset.eq "dom"(Gamma)$ possiamo derivare un #underline[giudizio di tipo], scritto $Gamma tack C : Gamma'$ che si legge "nell'ambiente $Gamma$, il comando $C$ è ben tipato e rende disponibile l'ambiente locale $Gamma'$"

=== Regole di Type Checking per espressioni

==== Valori

#align(center)[
  #box(stroke: (bottom: 1pt), inset: 3pt)[$n in bb(Z)$] \
  $Gamma tack n : "int"$ #h(1cm) (T-Int)
]

#align(center)[
  #box(stroke: (bottom: 1pt), inset: 3pt)[$ $] \
  $Gamma tack "true" : "bool"$ #h(1cm) (T-True)
  #h(1cm)
  #box(stroke: (bottom: 1pt), inset: 3pt)[$ $] \
  $Gamma tack "false" : "bool"$ #h(1cm) (T-False)
]

==== Variabili

#align(center)[
  #box(stroke: (bottom: 1pt), inset: 3pt)[$Gamma("Id") = T$] \
  $Gamma tack "Id" : T$ #h(1cm) (T-Var)
]

==== Operatori aritmetici

#align(center)[
  #box(stroke: (bottom: 1pt), inset: 3pt)[$Gamma tack E_1 : "int"$ #h(0.3cm) $Gamma tack E_2 : "int"$] \
  $Gamma tack E_1 "aop" E_2 : "int"$ #h(0.5cm) (T-Aop) dove $"aop" in {+, -, times, div, mod}$
]

==== Operatori di confronto

#align(center)[
  #box(stroke: (bottom: 1pt), inset: 3pt)[$Gamma tack E_1 : "int"$ #h(0.3cm) $Gamma tack E_2 : "int"$] \
  $Gamma tack E_1 "cop" E_2 : "bool"$ #h(0.5cm) (T-Cop) dove $"cop" in {<, <=, >, >=, ==, !=}$
]

==== Operatori logici

#align(center)[
  #box(stroke: (bottom: 1pt), inset: 3pt)[$Gamma tack E_1 : "bool"$ #h(0.3cm) $Gamma tack E_2 : "bool"$] \
  $Gamma tack E_1 "lop" E_2 : "bool"$ #h(0.5cm) (T-Lop) dove $"lop" in {and, or}$
]

#align(center)[
  #box(stroke: (bottom: 1pt), inset: 3pt)[$Gamma tack E : "bool"$] \
  $Gamma tack not E : "bool"$ #h(1cm) (T-Not)
]

=== Regole di Type Checking per comandi

==== Skip

#align(center)[
  #box(stroke: (bottom: 1pt), inset: 3pt)[$ $] \
  $Gamma tack "skip"; : emptyset$ #h(1cm) (T-Skip)
]

==== Dichiarazione

#align(center)[
  #box(stroke: (bottom: 1pt), inset: 3pt)[$Gamma tack E : T$] \
  $Gamma tack T space "Id" = E; : {"Id" : T}$ #h(1cm) (T-Decl)
]

==== Assegnamento

#align(center)[
  #box(stroke: (bottom: 1pt), inset: 3pt)[$Gamma("Id") = T$ #h(0.3cm) $Gamma tack E : T$] \
  $Gamma tack "Id" := E; : emptyset$ #h(1cm) (T-Assign)
]

==== Sequenza

#align(center)[
  #box(stroke: (bottom: 1pt), inset: 3pt)[$Gamma tack C_1 : Gamma_1$ #h(0.3cm) $Gamma union Gamma_1 tack C_2 : Gamma_2$] \
  $Gamma tack C_1 C_2 : Gamma_1 union Gamma_2$ #h(0.5cm) (T-Seq)
]

==== Blocco

#align(center)[
  #box(stroke: (bottom: 1pt), inset: 3pt)[$Gamma tack C : Gamma'$] \
  $Gamma tack {C} : emptyset$ #h(1cm) (T-Block)
]

==== Condizionale

#align(center)[
  #box(stroke: (bottom: 1pt), inset: 3pt)[$Gamma tack E : "bool"$ #h(0.3cm) $Gamma tack C_1 : Gamma_1$ #h(0.3cm) $Gamma tack C_2 : Gamma_2$] \
  $Gamma tack "if"(E){C_1}"else"{C_2} : emptyset$ #h(0.3cm) (T-If)
]

==== While

#align(center)[
  #box(stroke: (bottom: 1pt), inset: 3pt)[$Gamma tack E : "bool"$ #h(0.3cm) $Gamma tack C : Gamma'$] \
  $Gamma tack "while"(E){C} : emptyset$ #h(0.5cm) (T-While)
]

#example(title: "Derivazione di tipo completa per espressione")[
  Verifichiamo che l'espressione `x + y * 2` sia ben tipata nell'ambiente $Gamma = {x : "int", y : "int"}$

  Costruiamo l'albero di derivazione dal basso verso l'alto:

  #align(center)[
    #box(stroke: (bottom: 1pt), inset: 3pt)[
      #box(stroke: (bottom: 1pt), inset: 3pt)[$ $] $y : "int" in Gamma$
      #h(0.5cm)
      #box(stroke: (bottom: 1pt), inset: 3pt)[$ $] $2 in bb(Z)$
    ] \
    #box(stroke: (bottom: 1pt), inset: 3pt)[$Gamma tack y : "int"$ #h(0.5cm) $Gamma tack 2 : "int"$] \
    $Gamma tack y * 2 : "int"$ #h(0.5cm) (T-Mult)
  ]

  E poi:
  #align(center)[
    #box(stroke: (bottom: 1pt), inset: 3pt)[
      $x : "int" in Gamma$ #h(0.5cm) $Gamma tack y * 2 : "int"$
    ] \
    $Gamma tack x + y * 2 : "int"$ #h(0.5cm) (T-Add)
  ]

  L'espressione è *ben tipata* con tipo `int` ✓
]

#example(title: "Derivazione di tipo per comando")[
  Verifichiamo che il comando sia ben tipato:
  ```
  int z = 0;
  z := x + 1;
  ```
  Con $Gamma_0 = {x : "int"}$

  *Passo 1*: Tipo di `int z = 0;`

  #align(center)[
    #box(stroke: (bottom: 1pt), inset: 3pt)[$Gamma_0 tack 0 : "int"$] \
    $Gamma_0 tack "int" space z = 0; : {z : "int"}$ #h(0.5cm) (T-Decl)
  ]

  Dopo la dichiarazione: $Gamma_1 = Gamma_0 union {z : "int"} = {x : "int", z : "int"}$

  *Passo 2*: Tipo di `z := x + 1;`

  Prima verifichiamo $x + 1$:
  #align(center)[
    #box(stroke: (bottom: 1pt), inset: 3pt)[$Gamma_1 tack x : "int"$ #h(0.3cm) $Gamma_1 tack 1 : "int"$] \
    $Gamma_1 tack x + 1 : "int"$ #h(0.5cm) (T-Add)
  ]

  Poi l'assegnamento:
  #align(center)[
    #box(stroke: (bottom: 1pt), inset: 3pt)[$z : "int" in Gamma_1$ #h(0.3cm) $Gamma_1 tack x + 1 : "int"$] \
    $Gamma_1 tack z := x + 1; : emptyset$ #h(0.5cm) (T-Assign)
  ]

  Il comando è *ben tipato* ✓
]

#example(title: "Errore di tipo")[
  Consideriamo:
  ```
  int x = 5;
  bool y = true;
  x := x + y;  // ERRORE!
  ```

  Con $Gamma = {x : "int", y : "bool"}$

  Tentiamo di derivare il tipo di `x + y`:
  - $Gamma tack x : "int"$ ✓
  - $Gamma tack y : "bool"$ ✓
  - Ma la regola (T-Add) richiede che *entrambi* gli operandi siano `int`!

  #align(center)[
    #box(stroke: (bottom: 1pt), inset: 3pt)[$Gamma tack E_1 : "int"$ #h(0.5cm) $Gamma tack E_2 : "int"$] \
    $Gamma tack E_1 + E_2 : "int"$
  ]

  Poiché $y$ ha tipo `bool` $eq.not$ `int`, la derivazione *fallisce*.

  Il programma è *mal tipato* e il compilatore segnala errore ✗
]

=== Esempi completi di derivazioni di type checking

#example(title: "Type checking di un programma con while")[
  Verifichiamo il type checking del seguente programma:
  ```
  int x = 5;
  int y = 6;
  while (x != y) {
    if (x < y) { x := x + 2; }
    else { y := y + 1; }
  }
  ```

  *Passo 1*: Partiamo dall'ambiente vuoto $Gamma_0 = emptyset$

  *Passo 2*: Type checking di `int x = 5;`
  #align(center)[
    #box(stroke: (bottom: 1pt), inset: 3pt)[$5 in bb(Z)$] \
    #box(stroke: (bottom: 1pt), inset: 3pt)[$Gamma_0 tack 5 : "int"$] \
    $Gamma_0 tack "int" space x = 5; : {x : "int"}$ #h(0.5cm) (T-Decl)
  ]
  Dopo questa dichiarazione: $Gamma_1 = Gamma_0 union {x : "int"} = {x : "int"}$

  *Passo 3*: Type checking di `int y = 6;` nell'ambiente $Gamma_1$
  #align(center)[
    #box(stroke: (bottom: 1pt), inset: 3pt)[$6 in bb(Z)$] \
    #box(stroke: (bottom: 1pt), inset: 3pt)[$Gamma_1 tack 6 : "int"$] \
    $Gamma_1 tack "int" space y = 6; : {y : "int"}$ #h(0.5cm) (T-Decl)
  ]
  Dopo questa dichiarazione: $Gamma_2 = Gamma_1 union {y : "int"} = {x : "int", y : "int"}$

  *Passo 4*: Verifica della condizione `x != y` nell'ambiente $Gamma_2$
  #align(center)[
    #box(stroke: (bottom: 1pt), inset: 3pt)[$Gamma_2(x) = "int"$ #h(0.5cm) $Gamma_2(y) = "int"$] \
    #box(stroke: (bottom: 1pt), inset: 3pt)[$Gamma_2 tack x : "int"$ #h(0.5cm) $Gamma_2 tack y : "int"$] \
    $Gamma_2 tack x != y : "bool"$ #h(0.5cm) (T-Cop)
  ]

  *Passo 5*: Verifica del ramo then `{ x := x + 2; }`

  Prima verifichiamo l'espressione `x + 2`:
  #align(center)[
    #box(stroke: (bottom: 1pt), inset: 3pt)[$Gamma_2(x) = "int"$ #h(0.5cm) $2 in bb(Z)$] \
    #box(stroke: (bottom: 1pt), inset: 3pt)[$Gamma_2 tack x : "int"$ #h(0.5cm) $Gamma_2 tack 2 : "int"$] \
    $Gamma_2 tack x + 2 : "int"$ #h(0.5cm) (T-Aop)
  ]

  Poi l'assegnamento:
  #align(center)[
    #box(stroke: (bottom: 1pt), inset: 3pt)[$Gamma_2(x) = "int"$ #h(0.3cm) $Gamma_2 tack x + 2 : "int"$] \
    $Gamma_2 tack x := x + 2; : emptyset$ #h(0.5cm) (T-Assign)
  ]

  E il blocco:
  #align(center)[
    #box(stroke: (bottom: 1pt), inset: 3pt)[$Gamma_2 tack x := x + 2; : emptyset$] \
    $Gamma_2 tack {x := x + 2;} : emptyset$ #h(0.5cm) (T-Block)
  ]

  *Passo 6*: Verifica del ramo else `{ y := y + 1; }` (analogamente)
  #align(center)[
    #box(stroke: (bottom: 1pt), inset: 3pt)[$Gamma_2(y) = "int"$ #h(0.3cm) $Gamma_2 tack y + 1 : "int"$] \
    $Gamma_2 tack y := y + 1; : emptyset$ #h(0.5cm) (T-Assign)
  ]
  #align(center)[
    #box(stroke: (bottom: 1pt), inset: 3pt)[$Gamma_2 tack y := y + 1; : emptyset$] \
    $Gamma_2 tack {y := y + 1;} : emptyset$ #h(0.5cm) (T-Block)
  ]

  *Passo 7*: Verifica della guardia `x < y`:
  #align(center)[
    #box(stroke: (bottom: 1pt), inset: 3pt)[$Gamma_2 tack x : "int"$ #h(0.3cm) $Gamma_2 tack y : "int"$] \
    $Gamma_2 tack x < y : "bool"$ #h(0.5cm) (T-Cop)
  ]

  *Passo 8*: Verifica del condizionale completo:
  #align(center)[
    #box(stroke: (bottom: 1pt), inset: 3pt)[$Gamma_2 tack x < y : "bool"$ #h(0.2cm) $Gamma_2 tack {x := x + 2;} : emptyset$ #h(0.2cm) $Gamma_2 tack {y := y + 1;} : emptyset$] \
    $Gamma_2 tack "if"(x < y){x := x + 2;}"else"{y := y + 1;} : emptyset$ #h(0.3cm) (T-If)
  ]

  *Passo 9*: Verifica del while completo:
  #align(center)[
    #box(stroke: (bottom: 1pt), inset: 3pt)[$Gamma_2 tack x != y : "bool"$ #h(0.3cm) $Gamma_2 tack "if"(x < y){...}"else"{...} : emptyset$] \
    $Gamma_2 tack "while"(x != y){"if"(x < y){x := x + 2;}"else"{y := y + 1;}} : emptyset$ #h(0.3cm) (T-While)
  ]

  *Passo 10*: Verifica della sequenza completa usando (T-Seq):
  #align(center)[
    #box(stroke: (bottom: 1pt), inset: 3pt)[$Gamma_0 tack "int" x = 5; : {x : "int"}$ #h(0.2cm) $Gamma_1 tack "int" y = 6; "while"... : {y : "int"}$] \
    $Gamma_0 tack "int" x = 5; "int" y = 6; "while"... : {x : "int", y : "int"}$ #h(0.3cm) (T-Seq)
  ]

  Il programma è *ben tipato*.
]

#example(title: "Type checking della funzione abs")[
  Verifichiamo che la funzione `abs` sia ben tipata:
  ```
  int abs(int n) {
    int m = n;
    if (m < 0) { m := -m; }
    return m;
  }
  ```

  Vogliamo dimostrare che $Gamma tack "abs" : ("int") arrow.r "int"$

  *Passo 1*: Costruiamo l'ambiente per il corpo della funzione.

  Secondo la regola (T-Fun), dobbiamo verificare il corpo nell'ambiente:
  $ Gamma' = Gamma union {n : "int"} $

  *Passo 2*: Type checking di `int m = n;` in $Gamma'$
  #align(center)[
    #box(stroke: (bottom: 1pt), inset: 3pt)[$Gamma'(n) = "int"$] \
    #box(stroke: (bottom: 1pt), inset: 3pt)[$Gamma' tack n : "int"$] \
    $Gamma' tack "int" space m = n; : {m : "int"}$ #h(0.5cm) (T-Decl)
  ]

  Aggiorniamo l'ambiente: $Gamma'' = Gamma' union {m : "int"} = Gamma union {n : "int", m : "int"}$

  *Passo 3*: Type checking della condizione `m < 0` in $Gamma''$
  #align(center)[
    #box(stroke: (bottom: 1pt), inset: 3pt)[$Gamma''(m) = "int"$ #h(0.5cm) $0 in bb(Z)$] \
    #box(stroke: (bottom: 1pt), inset: 3pt)[$Gamma'' tack m : "int"$ #h(0.5cm) $Gamma'' tack 0 : "int"$] \
    $Gamma'' tack m < 0 : "bool"$ #h(0.5cm) (T-Cop)
  ]

  *Passo 4*: Type checking dell'espressione `-m` in $Gamma''$

  L'operatore unario meno (negazione) richiede un operando intero:
  #align(center)[
    #box(stroke: (bottom: 1pt), inset: 3pt)[$Gamma'' tack m : "int"$] \
    $Gamma'' tack -m : "int"$ #h(0.5cm) (T-Neg)
  ]

  *Passo 5*: Type checking dell'assegnamento `m := -m;` in $Gamma''$
  #align(center)[
    #box(stroke: (bottom: 1pt), inset: 3pt)[$Gamma''(m) = "int"$ #h(0.3cm) $Gamma'' tack -m : "int"$] \
    $Gamma'' tack m := -m; : emptyset$ #h(0.5cm) (T-Assign)
  ]

  *Passo 6*: Type checking del blocco `{ m := -m; }` in $Gamma''$
  #align(center)[
    #box(stroke: (bottom: 1pt), inset: 3pt)[$Gamma'' tack m := -m; : emptyset$] \
    $Gamma'' tack {m := -m;} : emptyset$ #h(0.5cm) (T-Block)
  ]

  *Passo 7*: Type checking del condizionale (con else implicito = skip)
  #align(center)[
    #box(stroke: (bottom: 1pt), inset: 3pt)[$Gamma'' tack m < 0 : "bool"$ #h(0.2cm) $Gamma'' tack {m := -m;} : emptyset$ #h(0.2cm) $Gamma'' tack "skip"; : emptyset$] \
    $Gamma'' tack "if"(m < 0){m := -m;} : emptyset$ #h(0.3cm) (T-If)
  ]

  *Passo 8*: Type checking di `return m;` in $Gamma''$
  #align(center)[
    #box(stroke: (bottom: 1pt), inset: 3pt)[$Gamma''(m) = "int"$] \
    #box(stroke: (bottom: 1pt), inset: 3pt)[$Gamma'' tack m : "int"$] \
    $Gamma'' tack "return" m; : emptyset$ #h(0.5cm) (T-Return)
  ]

  Il tipo restituito (`int`) corrisponde al tipo di ritorno dichiarato.

  *Passo 9*: Type checking della sequenza del corpo della funzione
  #align(center)[
    #box(stroke: (bottom: 1pt), inset: 3pt)[$Gamma' tack "int" m = n; : {m : "int"}$ #h(0.2cm) $Gamma'' tack "if"(...){...} "return" m; : emptyset$] \
    $Gamma' tack "int" m = n; "if"(m < 0){m := -m;} "return" m; : {m : "int"}$ #h(0.2cm) (T-Seq)
  ]

  *Passo 10*: Applicazione della regola (T-Fun)
  #align(center)[
    #box(stroke: (bottom: 1pt), inset: 3pt)[$Gamma union {n : "int"} tack "int" m = n; "if"(m < 0){m := -m;} "return" m; : {m : "int"}$] \
    $Gamma tack "int" space "abs"("int" space n){...} : {"abs" : ("int") arrow.r "int"}$ #h(0.3cm) (T-Fun)
  ]

  Quindi $Gamma tack "abs" : ("int") arrow.r "int"$ come richiesto.
]

#example(title: "Type checking di funzione ricorsiva su array")[
  Verifichiamo il type checking della funzione ricorsiva:
  ```
  bool azzera(int[] a, int k, int p) {
    bool res = false;
    if ((p >= 0) && (p < a.length)) {
      if (a[p] == k) { a[p] := 0; res := true; }
      res := azzera(a, k, p+1);
    }
    return res;
  }
  ```

  Questa funzione cerca l'elemento `k` nell'array `a` a partire dalla posizione `p`, e se lo trova lo azzera.

  *Passo 1*: Poiché la funzione è ricorsiva, usiamo la regola (T-RecFun).

  L'ambiente per il corpo deve includere il tipo della funzione stessa:
  $ Gamma' = Gamma union {"azzera" : ("int"[], "int", "int") arrow.r "bool"} union {a : "int"[], k : "int", p : "int"} $

  *Passo 2*: Type checking di `bool res = false;` in $Gamma'$
  #align(center)[
    #box(stroke: (bottom: 1pt), inset: 3pt)[$ $] \
    #box(stroke: (bottom: 1pt), inset: 3pt)[$Gamma' tack "false" : "bool"$] \
    $Gamma' tack "bool" space "res" = "false"; : {"res" : "bool"}$ #h(0.5cm) (T-Decl)
  ]

  Aggiorniamo: $Gamma'' = Gamma' union {"res" : "bool"}$

  *Passo 3*: Type checking della condizione `(p >= 0) && (p < a.length)` in $Gamma''$

  Prima verifichiamo `p >= 0`:
  #align(center)[
    #box(stroke: (bottom: 1pt), inset: 3pt)[$Gamma''(p) = "int"$ #h(0.3cm) $0 in bb(Z)$] \
    #box(stroke: (bottom: 1pt), inset: 3pt)[$Gamma'' tack p : "int"$ #h(0.3cm) $Gamma'' tack 0 : "int"$] \
    $Gamma'' tack p >= 0 : "bool"$ #h(0.5cm) (T-Cop)
  ]

  Poi verifichiamo `a.length`:
  #align(center)[
    #box(stroke: (bottom: 1pt), inset: 3pt)[$Gamma''(a) = "int"[]$] \
    #box(stroke: (bottom: 1pt), inset: 3pt)[$Gamma'' tack a : "int"[]$] \
    $Gamma'' tack a."length" : "int"$ #h(0.5cm) (T-Length)
  ]

  Poi `p < a.length`:
  #align(center)[
    #box(stroke: (bottom: 1pt), inset: 3pt)[$Gamma'' tack p : "int"$ #h(0.3cm) $Gamma'' tack a."length" : "int"$] \
    $Gamma'' tack p < a."length" : "bool"$ #h(0.5cm) (T-Cop)
  ]

  Infine la congiunzione:
  #align(center)[
    #box(stroke: (bottom: 1pt), inset: 3pt)[$Gamma'' tack p >= 0 : "bool"$ #h(0.3cm) $Gamma'' tack p < a."length" : "bool"$] \
    $Gamma'' tack (p >= 0) and (p < a."length") : "bool"$ #h(0.5cm) (T-Lop)
  ]

  *Passo 4*: Type checking dell'accesso `a[p]` in $Gamma''$
  #align(center)[
    #box(stroke: (bottom: 1pt), inset: 3pt)[$Gamma'' tack a : "int"[]$ #h(0.3cm) $Gamma'' tack p : "int"$] \
    $Gamma'' tack a[p] : "int"$ #h(0.5cm) (T-ArrayAccess)
  ]

  *Passo 5*: Type checking della condizione `a[p] == k`
  #align(center)[
    #box(stroke: (bottom: 1pt), inset: 3pt)[$Gamma'' tack a[p] : "int"$ #h(0.3cm) $Gamma'' tack k : "int"$] \
    $Gamma'' tack a[p] == k : "bool"$ #h(0.5cm) (T-Cop)
  ]

  *Passo 6*: Type checking dell'assegnamento `a[p] := 0;`
  #align(center)[
    #box(stroke: (bottom: 1pt), inset: 3pt)[$Gamma'' tack a : "int"[]$ #h(0.3cm) $Gamma'' tack p : "int"$ #h(0.3cm) $Gamma'' tack 0 : "int"$] \
    $Gamma'' tack a[p] := 0; : emptyset$ #h(0.5cm) (T-ArrayAssign)
  ]

  *Passo 7*: Type checking dell'assegnamento `res := true;`
  #align(center)[
    #box(stroke: (bottom: 1pt), inset: 3pt)[$Gamma''("res") = "bool"$ #h(0.3cm) $Gamma'' tack "true" : "bool"$] \
    $Gamma'' tack "res" := "true"; : emptyset$ #h(0.5cm) (T-Assign)
  ]

  *Passo 8*: Type checking della chiamata ricorsiva `azzera(a, k, p+1)`

  Prima verifichiamo `p+1`:
  #align(center)[
    #box(stroke: (bottom: 1pt), inset: 3pt)[$Gamma'' tack p : "int"$ #h(0.3cm) $Gamma'' tack 1 : "int"$] \
    $Gamma'' tack p + 1 : "int"$ #h(0.5cm) (T-Aop)
  ]

  Poi la chiamata (usando il tipo di `azzera` presente in $Gamma''$):
  #align(center)[
    #box(stroke: (bottom: 1pt), inset: 3pt)[$Gamma''("azzera") = ("int"[], "int", "int") arrow.r "bool"$ #h(0.2cm) $Gamma'' tack a : "int"[]$ #h(0.2cm) $Gamma'' tack k : "int"$ #h(0.2cm) $Gamma'' tack p+1 : "int"$] \
    $Gamma'' tack "azzera"(a, k, p+1) : "bool"$ #h(0.3cm) (T-Call)
  ]

  *Passo 9*: Type checking dell'assegnamento `res := azzera(a, k, p+1);`
  #align(center)[
    #box(stroke: (bottom: 1pt), inset: 3pt)[$Gamma''("res") = "bool"$ #h(0.3cm) $Gamma'' tack "azzera"(a, k, p+1) : "bool"$] \
    $Gamma'' tack "res" := "azzera"(a, k, p+1); : emptyset$ #h(0.5cm) (T-Assign)
  ]

  *Passo 10*: Type checking di `return res;`
  #align(center)[
    #box(stroke: (bottom: 1pt), inset: 3pt)[$Gamma'' tack "res" : "bool"$] \
    $Gamma'' tack "return" "res"; : emptyset$ #h(0.5cm) (T-Return)
  ]

  Il tipo restituito (`bool`) corrisponde al tipo di ritorno dichiarato.

  *Passo 11*: Applicazione della regola (T-RecFun)
  #align(center)[
    #box(stroke: (bottom: 1pt), inset: 3pt)[$Gamma union {"azzera" : ("int"[], "int", "int") arrow.r "bool"} union {a : "int"[], k : "int", p : "int"} tack C : Gamma'''$] \
    $Gamma tack "bool" space "azzera"("int"[] space a, "int" space k, "int" space p){C} : {"azzera" : ("int"[], "int", "int") arrow.r "bool"}$
  ]
  dove $C$ rappresenta il corpo della funzione.

  Quindi $Gamma tack "azzera" : ("int"[], "int", "int") arrow.r "bool"$

  La funzione è *ben tipata* e ha tipo $("int"[], "int", "int") arrow.r "bool"$.
]

=== Controllo di tipi vs inferenza di tipo

Il sistema di tipi di Mao è progettato per controllare che i tipi dichiarati dal programmatore per le variabili corrispondano all'uso che viene fatto di esse. Molti linguaggi di programmazione non richiedono di dichiarare il tipo di variabile al momento della sua dichiarazione:
- o perché non vengono controllati (JS)
- o perché viene utilizzato un meccanismo di #underline[inferenza di tipo] (Golang): il contesto in cui viene usata la variabile determina il tipo

=== Tipi Base aggiuntivi - Char e stringhe

=== Caratteri

I caratteri sono utilizzati per rappresentare simboli, lettere e altri caratteri alfanumerici. In Mao il tipo `char` possono essere codificati `ASCII` o `Unicode`. I caratteri speciali vengono rappresentati da _sequenze di escape_.

#example[
  ```
  char lettera = 'R';
  char a_capo = '\n';
  ```
]

=== Stringhe

Le stringhe in Mao sono un array di caratteri, di tipo `char[]`.

#example[
  `['C', 'i', 'a', 'o'] = "Ciao"`
]

=== Assegnamento multiplo

Molti linguaggi permettono l'assegnamento multiplo, permettendo quindi di inizializzare più variabili contemporaneamente.

#example[
  `let x,y,z = 6,7,42;`
]

È anche possibile fare lo scambio delle variabili sfruttando l'assegnamento multiplo

```
x, y := y,x;
```

=== Sintassi assegnamento multiplo

#align(center)[
  $"LHS" &::= "Id" | "Id", "LHS"$ \
  $"RHS" &::= E | E, "RHS"$
]

Sfruttando queste nuove categorie sintattiche, generalizziamo i comandi atomici:

#align(center)[
  $C &::= ... | T space "LHS" = "RHS"; | "LHS" := "RHS";$
]

Dove LHS (Left-Hand Side) è la lista degli identificatori e RHS (Right-Hand Side) è la lista delle espressioni.

==== Type checking per assegnamento multiplo

Le variabili libere di LHS e RHS sono definite come:
#align(center)[
  $"fv"("Id") = {"Id"}$ #h(1cm) $"fv"("Id", "LHS") = {"Id"} union "fv"("LHS")$ \
  $"fv"(E) = "fv"(E)$ #h(1cm) $"fv"(E, "RHS") = "fv"(E) union "fv"("RHS")$
]

La regola di tipo richiede che ogni espressione abbia il tipo corrispondente all'identificatore:

#align(center)[
  #box(stroke: (bottom: 1pt), inset: 3pt)[$Gamma tack E_1 : T$ #h(0.2cm) $...$ #h(0.2cm) $Gamma tack E_n : T$ #h(0.2cm) $Gamma("Id"_i) = T$ per $i = 1..n$] \
  $Gamma tack "Id"_1, ..., "Id"_n := E_1, ..., E_n; : emptyset$ #h(0.3cm) (T-MultiAssign)
]

==== Semantica operazionale assegnamento multiplo

*Dichiarazione multipla*:
#align(center)[
  #box(stroke: (bottom: 1pt), inset: 3pt)[$chevron.l E_i, rho, sigma_(i-1) chevron.r arrow.b.double (v_i, sigma_i)$ per $i = 1..n$ #h(0.2cm) $l_1, ..., l_n in.not "dom"(sigma_n)$] \
  $chevron.l T space "Id"_1, ..., "Id"_n = E_1, ..., E_n;, rho, sigma chevron.r arrow.r chevron.l rho["Id"_1 |-> l_1]...["Id"_n |-> l_n], sigma_n[l_1 |-> v_1]...[l_n |-> v_n] chevron.r$
]

*Assegnamento multiplo*:
#align(center)[
  #box(stroke: (bottom: 1pt), inset: 3pt)[$chevron.l E_i, rho, sigma_(i-1) chevron.r arrow.b.double (v_i, sigma_i)$ per $i = 1..n$ #h(0.2cm) $rho("Id"_i) = l_i$ per $i = 1..n$] \
  $chevron.l "Id"_1, ..., "Id"_n := E_1, ..., E_n;, rho, sigma chevron.r arrow.r chevron.l rho, sigma_n[l_1 |-> v_1]...[l_n |-> v_n] chevron.r$
]

#note[
  L'assegnamento multiplo `x, y := y, x` permette lo swap in un solo comando perché tutte le espressioni RHS vengono valutate *prima* di effettuare gli assegnamenti.
]

=== Direttiva return

Permette di restituire il valore aggiornato di un'espressione qualsiasi.

#example[
  ```
  { count := count + 1; return count; }
  ```
]

La sintassi della direttiva `return` è la seguente:

#align(center)[
  $C ::= ... | "return" E;$
]

Data la seguente definizione di variabili libere:

#align(center)[
  $"fv"("return" E;) = "fv"(E)$
]

Per controllare il tipo dell'espressione:

#align(center)[
  #box(stroke: (bottom: 1pt), inset: 3pt)[$Gamma tack E : T$] \
  $Gamma tack "return" E; : emptyset$ #h(1cm) (T-Return)
]

La semantica operazionale del return:

#align(center)[
  #box(stroke: (bottom: 1pt), inset: 3pt)[$chevron.l E, rho, sigma chevron.r arrow.b.double (v, sigma')$] \
  $chevron.l "return" E;, rho, sigma chevron.r arrow.r (v, rho, sigma')$ #h(1cm) (Return)
]

=== Funzioni

Le funzioni servono per dare un nome ad un frammento di codice che calcola un valore in modo da poter riutilizzare il codice tutte le volte che vogliamo utilizzando parametri diversi.

- *Definizione di funzione*: momento in cui scriviamo il codice dell'espressione che vogliamo calcolare. specifichiamo l'input parametrico (parametri formali)
- *Invocazione di funzione*: momento nel programma in cui chiamo la funzione per eseguire il calcolo dell'espressione specificata, i parametri sono effettivi (parametri attuali)

#example[
  ```
  int max(int a, int b){
      int m = a;
      if (b>m) {
          m := b;
      }
      return m;
  }
  ...
  if(max(x,y) <10){
      z := max(x+2, y*3)
  } else {
      z := max(x/10, y-10);
  }
  ```
]

=== Corrispondenza tra parametri formali e attuali

La chiamata di funzione deve contenere espressioni corrispondenti in numero e in tipo a quelle dichiarate nell'intestazione. La comunicazione avviene tramite il passaggio di parametri. Ad ogni parametro formale della funzione deve corrispondere un'espressione nella stessa posizione tra i parametri attuali.

==== Passaggio parametri per valore

Il passaggio per valore è la modalità più comune: ogni parametro formale viene inizializzato con una copia del valore corrispondente del parametro attuale. Se i parametri formali vengono modificati all'interno della funzione, tali modifiche non influenzano i parametri attuali originali.

==== Passaggio parametri per riferimento

Il passaggio per riferimento avviene inizializzando i parametri formali con il riferimento ai corrispondenti argomenti attuali. Se i parametri formali vengono modificati all'interno della funzione, tale modifica influenza i parametri attuali originali.

#note[
  Quando un array viene passato come argomento attuale, stiamo implicitamente passando il riferimento all'array stesso $l_b$
]

=== Sintassi delle funzioni

La sintassi della dichiarazione di funzione:

#align(center)[
  $C ::= ... | T_R space "Id"(T_1 space "Id"_1, ..., T_n space "Id"_n){C}$
]

Dove $T_R$ è il tipo di ritorno (può essere `void` per funzioni senza valore di ritorno).

La sintassi della chiamata di funzione:

#align(center)[
  $E ::= ... | "Id"(E_1, ..., E_n)$
]

Il tipo di una funzione è rappresentato come:

#align(center)[
  $(T_1, ..., T_n) arrow.r T_R$
]

Dove $(T_1, ..., T_n)$ sono i tipi dei parametri formali e $T_R$ è il tipo di ritorno.

Definizione variabili libere di una funzione:

#align(center)[
  $"fv"(T_R space "Id"(T_1 space "Id"_1, ..., T_n space "Id"_n){C}) = "fv"(C) backslash {"Id"_1, ..., "Id"_n}$
]

Le variabili libere nel corpo della funzione escludono i parametri formali.

Regola di tipo per la dichiarazione di funzione:

#align(center)[
  #box(stroke: (bottom: 1pt), inset: 3pt)[$Gamma union {"Id"_1 : T_1, ..., "Id"_n : T_n} tack C : Gamma'$] \
  $Gamma tack T_R space "Id"(T_1 space "Id"_1, ..., T_n space "Id"_n){C} : {"Id" : (T_1, ..., T_n) arrow.r T_R}$ #h(0.5cm) (T-Fun)
]

Regola di tipo per l'invocazione:

#align(center)[
  #box(stroke: (bottom: 1pt), inset: 3pt)[$Gamma("Id") = (T_1, ..., T_n) arrow.r T_R$ #h(0.3cm) $Gamma tack E_1 : T_1$ #h(0.3cm) $...$ #h(0.3cm) $Gamma tack E_n : T_n$] \
  $Gamma tack "Id"(E_1, ..., E_n) : T_R$ #h(0.5cm) (T-Call)
]

=== Semantica operazionale delle funzioni

==== Dichiarazione di funzione

La dichiarazione di una funzione memorizza la "chiusura" (closure) nell'ambiente:

#align(center)[
  #box(stroke: (bottom: 1pt), inset: 3pt)[$ $] \
  $chevron.l T_R space "Id"(T_1 space "Id"_1, ..., T_n space "Id"_n){C}, rho, sigma chevron.r arrow.r chevron.l rho["Id" |-> ("Id"_1, ..., "Id"_n, C, rho)], sigma chevron.r$
]

#note[
  La chiusura contiene: i nomi dei parametri, il corpo della funzione, e l'ambiente al momento della dichiarazione (per le variabili libere).
]

==== Chiamata di funzione

La chiamata di funzione:
1. Valuta gli argomenti
2. Crea un nuovo ambiente con i parametri formali legati ai valori degli argomenti
3. Esegue il corpo della funzione
4. Restituisce il valore del return

#align(center)[
  #box(stroke: (bottom: 1pt), inset: 3pt)[
    $rho("Id") = ("Id"_1, ..., "Id"_n, C, rho_f)$ \
    $chevron.l E_i, rho, sigma_(i-1) chevron.r arrow.b.double (v_i, sigma_i)$ per $i = 1..n$ \
    $l_1, ..., l_n in.not "dom"(sigma_n)$ \
    $rho' = rho_f["Id"_1 |-> l_1]...["Id"_n |-> l_n]$ \
    $sigma' = sigma_n[l_1 |-> v_1]...[l_n |-> v_n]$ \
    $chevron.l C, rho', sigma' chevron.r arrow.r (v_r, rho'', sigma'')$
  ] \
  $chevron.l "Id"(E_1, ..., E_n), rho, sigma chevron.r arrow.b.double (v_r, sigma'')$ #h(0.3cm) (Call)
]

#note[
  L'ambiente della funzione ($rho_f$) viene esteso con i parametri, non l'ambiente del chiamante. Questo implementa lo *scoping statico*.
]

=== Ricorsione

In molti linguaggi di programmazione è ammessa la possibilità di definire funzioni ricorsive (funzione che richiama se stessa). La chiamata ricorsiva può essere:
- diretta: chiamata avviene direttamente in una espressione del corpo di $f$
- indiretta: $f$ contiene una chiamata a $g$ che a sua volta contiene una chiamata a $f$

Per avere possibile la ricorsione deve essere modificata la definizione di variabili libere:

#align(center)[
  $"fv"(T_R space "Id"(T_1 space "Id"_1, ..., T_n space "Id"_n){C}) = "fv"(C) backslash {"Id", "Id"_1, ..., "Id"_n}$
]

Il nome della funzione stessa viene escluso dalle variabili libere, permettendo così la chiamata ricorsiva.

Regola di tipo per funzioni ricorsive (include l'associazione tra il nome della funzione e il suo tipo nell'ambiente):

#align(center)[
  #box(stroke: (bottom: 1pt), inset: 3pt)[$Gamma union {"Id" : (T_1, ..., T_n) arrow.r T_R} union {"Id"_1 : T_1, ..., "Id"_n : T_n} tack C : Gamma'$] \
  $Gamma tack T_R space "Id"(T_1 space "Id"_1, ..., T_n space "Id"_n){C} : {"Id" : (T_1, ..., T_n) arrow.r T_R}$ #h(0.3cm) (T-RecFun)
]

#note[
  La differenza rispetto a (T-Fun) è che nell'ambiente del corpo della funzione è presente anche il binding $"Id" : (T_1, ..., T_n) arrow.r T_R$, permettendo chiamate ricorsive ben tipate.
]
