#import "../template.typ": *

=== MiniMao

=== Ambiente e memoria, dichiarazioni, assegnamenti e composizione sequenziale

La programmazione consiste nell'ideare uno o più algoritmi che risolvano un problema (problem solving), valutarne l'efficacia e codificarli in un linguaggio eseguibile da un calcolatore. Un programma è una sequenza di istruzioni che indicano al calcolatore le operazioni da eseguire. Come istruzione elementare consideriamo la possibilità di memorizzare un risultato di un dato. Per riferire questi valori si utilizzano nomi simbolici detti #underline[nomi di variabile].

#note[
  Equazioni matematiche e assegnamenti sono due concetti diversi. Prendendo in esempio $n = n^2 - 2$, se considerato un'equazione il calcolo da eseguire è cercare il valore di $n$ che verifica l'uguaglianza $n in {2, -1}$. Invece se esso viene considerato un assegnamento, se per esempio $n$ vale 5, dopo il calcolo $n$ vale 23.
]

=== Concetto di variabile

Una variabile è come una scatola con nome e tipo.

```
int età;
int età = 15;
```

Nel tempo può cambiare valore:

```
età := 16;
```

=== Stato del programma

Possiamo avere molte variabili nel nostro programma, ognuna con il suo valore. Lo #underline[stato] è l'insieme di tutte le variabili e i loro valori.

#example[
  ```
  {età=16, studente=true, nome="Jacob"}
  ```
]

=== Sintassi di MiniMao

Introduzione del linguaggio Mao, in versione ristretta. Per prima cosa verrà definita la sintassi usando grammatiche formali, in un secondo momento verrà definita la semantica utilizzando sistemi logici.

Le categorie sintattiche di MiniMao sono:
- Valori (V): dati elementari come numeri interi o booleani
- Identificatori (Id): simboli per riferirsi a variabili, procedure ecc
- Espressione (E): combinano V, Id ed operatori per produrre altri valori
- Tipi (T): indicano l'insieme dei valori ammissibili
- Comandi (C): descrivono le azioni da eseguire

#definition(title: "Valori V")[
  Inizialmente consideriamo solo programmi che manipolano valori interi ($bb(Z)$) e booleani ($bb(B)$)

  #example[
    $V ::= n | "true" | "false"$
  ]
]

#definition(title: "Identificatori Id")[
  Nomi simbolici che permettono al programmatore di riferirsi in modo chiaro e univoco a valori, procedure, funzioni ecc. In Mao sono stringhe alfanumeriche e possono contenere l'underscore (\_)

  #example[
    `mio_id1`
  ]
]

#note[
  Alcune parole chiave sono riservate e non sono identificatori validi
]

#definition(title: "Espressioni E")[
  Sono combinazioni di valori, identificatori e operatori che producono un nuovo valore booleano o intero. \
  $E ::= V | "Id" | E space "bop" space E | "uop" space E | (E)$
]

#definition(title: "Operatori binari")[
  Gli operatori binari prendono due operandi e producono un risultato.
]

#figure(
  table(
    columns: 4,
    [*Simbolo*], [*Nome*], [*Tipo operandi*], [*Tipo risultato*],
    [$+$], [addizione], [$bb(Z) times bb(Z)$], [$bb(Z)$],
    [$-$], [sottrazione], [$bb(Z) times bb(Z)$], [$bb(Z)$],
    [$times$], [moltiplicazione], [$bb(Z) times bb(Z)$], [$bb(Z)$],
    [$div$], [divisione intera], [$bb(Z) times bb(Z)_(eq.not 0)$], [$bb(Z)$],
    [$mod$], [resto (modulo)], [$bb(Z) times bb(Z)_(eq.not 0)$], [$bb(Z)$],
    [$<$], [minore], [$bb(Z) times bb(Z)$], [$bb(B)$],
    [$<=$], [minore o uguale], [$bb(Z) times bb(Z)$], [$bb(B)$],
    [$>$], [maggiore], [$bb(Z) times bb(Z)$], [$bb(B)$],
    [$>=$], [maggiore o uguale], [$bb(Z) times bb(Z)$], [$bb(B)$],
    [$==$], [uguaglianza], [$bb(Z) times bb(Z)$ o $bb(B) times bb(B)$], [$bb(B)$],
    [$!=$], [disuguaglianza], [$bb(Z) times bb(Z)$ o $bb(B) times bb(B)$], [$bb(B)$],
    [$and$], [and logico], [$bb(B) times bb(B)$], [$bb(B)$],
    [$or$], [or logico], [$bb(B) times bb(B)$], [$bb(B)$],
  ),
  caption: [Operatori binari in MiniMao]
)

#note[
  La divisione intera $div$ e il modulo $mod$ richiedono che il secondo operando sia diverso da zero.
]

#definition(title: "Operatori unari")[
  Gli operatori unari prendono un solo operando.
]

#figure(
  table(
    columns: 4,
    [*Simbolo*], [*Nome*], [*Tipo operando*], [*Tipo risultato*],
    [$-$], [negazione aritmetica], [$bb(Z)$], [$bb(Z)$],
    [$not$], [negazione logica], [$bb(B)$], [$bb(B)$],
  ),
  caption: [Operatori unari in MiniMao]
)

#definition(title: "Tipi T")[
  Può essere tipo base o tipo composto. Per ogni tipo assumiamo un valore di default (0 per interi e false per bool). \
  $T ::= T_b | T_c$
]

#definition(title: "Comandi C")[
  $C ::= "skip"; | T space "Id" = E; | "Id" := E; | C C | {C} | "if"(E){C} "else" {C} | "while"(E){C}$
]

#example(title: "sintassi di MiniMao")[
  ```
  int x = 1;
  int n = 0;
  while(x <= y) {
      x:= x * 2;
      n := n+ 1;
  }
  ```
]

=== Semantica di MiniMao

La semantica è uno strumento che ci permette di ragionare formalmente sul comportamento di un programma e quindi di studiare proprietà di programmi come correttezza, equivalenza, terminazione, divergenza ecc...

#definition(title: "Semantica operazionale")[
  La semantica operazionale descrive il comportamento di un programma in termini dei passi che compie per eseguirlo un'opportuna #underline[macchina astratta]
]

#definition(title: "Macchina astratta")[
  Una macchina astratta è una macchina semplificata ideale, il cui stato è dato dagli oggetti ambiente $rho$ e la memoria $sigma$
]

=== Ambiente e memoria

L'ambiente $rho: bb(I) arrow.r.hook bb(L)$ è una funzione parziale da identificatori a locazioni.

La memoria $sigma: bb(L) arrow.r.hook bb(V)$ è una funzione parziale da locazioni a valori.

#example[
  $rho("eta") = 0, rho("studente") = 1 arrow.r sigma(0) = 15, sigma(1) = "true"$
]

#note[
  Una funzione parziale significa che potrebbe non essere definita su tutti gli argomenti.
]

=== Stato

Uno stato della macchina astratta è quindi una coppia ambiente-memoria. $s = (rho, sigma)$.

Se le funzioni parziali sono definite su un numero finito di argomenti, le possiamo rappresentare elencando tutte le possibili associazioni argomento-valore $rho = [x |-> l_1, y |-> l_2], sigma = [l_1 |-> 15, l_2 |-> "true"]$

=== Predicati semantici

Per definire la semantica dei programmi abbiamo bisogno di definire come valutare espressioni ed eseguire comandi. A tal fine introduciamo:
- $chevron.l E, rho, sigma chevron.r arrow.b.double v$ che si legge "l'espressione $E$ nello stato $(rho, sigma)$ ha valore $v$"
- $chevron.l C, rho, sigma chevron.r arrow.r chevron.l rho', sigma' chevron.r$ che si legge "l'esecuzione del comando C nello stato iniziale $(rho, sigma)$ termina producendo lo stato finale $(rho', sigma')$"

=== Espressioni pure o con effetti collaterali

Le espressioni #underline[con effetti collaterali] sono espressioni la cui valutazione può comportare modifiche di memoria, come allocazione o modifica di celle già presenti. La valutazione in questo caso si esprime come $chevron.l E, rho, sigma chevron.r arrow.b.double chevron.l v, sigma' chevron.r$

Le espressioni pure non alterano lo stato. MiniMao ammette solo espressioni pure.

=== Semantica operazionale (prima parte)

Le regole semantiche definiscono formalmente come si valutano espressioni e si eseguono comandi.

==== Regole per le espressioni

#align(center)[
  #box(stroke: (bottom: 1pt), inset: 3pt)[$ $] \
  $chevron.l n, rho, sigma chevron.r arrow.b.double n$ #h(1cm) (Val-Int)
]

#align(center)[
  #box(stroke: (bottom: 1pt), inset: 3pt)[$ $] \
  $chevron.l "true", rho, sigma chevron.r arrow.b.double "true"$ #h(1cm) (Val-True)
]

#align(center)[
  #box(stroke: (bottom: 1pt), inset: 3pt)[$ $] \
  $chevron.l "false", rho, sigma chevron.r arrow.b.double "false"$ #h(1cm) (Val-False)
]

#align(center)[
  #box(stroke: (bottom: 1pt), inset: 3pt)[$rho("Id") = l$ #h(0.5cm) $sigma(l) = v$] \
  $chevron.l "Id", rho, sigma chevron.r arrow.b.double v$ #h(1cm) (Val-Var)
]

#align(center)[
  #box(stroke: (bottom: 1pt), inset: 3pt)[$chevron.l E_1, rho, sigma chevron.r arrow.b.double v_1$ #h(0.3cm) $chevron.l E_2, rho, sigma chevron.r arrow.b.double v_2$ #h(0.3cm) $v = v_1 "bop" v_2$] \
  $chevron.l E_1 "bop" E_2, rho, sigma chevron.r arrow.b.double v$ #h(1cm) (Val-Bop)
]

#align(center)[
  #box(stroke: (bottom: 1pt), inset: 3pt)[$chevron.l E, rho, sigma chevron.r arrow.b.double v'$ #h(0.5cm) $v = "uop" v'$] \
  $chevron.l "uop" E, rho, sigma chevron.r arrow.b.double v$ #h(1cm) (Val-Uop)
]

Per eseguire una dichiarazione nello stato $(rho, sigma)$ si deve:
- valutare il valore $v$ di E nello stato.
- preparare una cella di memoria $l in.not sigma$
- estendere la memoria $sigma$ con l'associazione $l |-> v$
- estendere l'ambiente $rho$ con l'associazione $"Id" |-> l$
- per essere sicuri controllare che il valore v sia di tipo T

Per eseguire un assegnamento nello stato $(rho, sigma)$ dobbiamo:
- valutare $v$ di E nello stato
- individuare la cella di memoria $l$ che l'ambiente $rho$ associa a $"Id"$
- aggiornare la memoria $sigma$ con l'associazione $l |-> v$
- essere sicuri che $v$ sia di tipo $T$ di $"Id"$

Per eseguire una sequenza di comandi nello stato:
- eseguire $C_1$ nello stato $(rho, sigma)$ ottenendo $(rho_1, sigma_1)$
- eseguire $C_2$ nello stato $(rho_1, sigma_1)$ ottenendo $(rho_2, sigma_2)$, chiamato stato finale di $C_1 C_2$

=== Semantica operazionale dei comandi (base)

==== Skip

#align(center)[
  #box(stroke: (bottom: 1pt), inset: 3pt)[$ $] \
  $chevron.l "skip";, rho, sigma chevron.r arrow.r chevron.l rho, sigma chevron.r$ #h(1cm) (Cmd-Skip)
]

==== Dichiarazione

#align(center)[
  #box(stroke: (bottom: 1pt), inset: 3pt)[$chevron.l E, rho, sigma chevron.r arrow.b.double v$ #h(0.3cm) $l in.not "dom"(sigma)$] \
  $chevron.l T space "Id" = E;, rho, sigma chevron.r arrow.r chevron.l rho["Id" |-> l], sigma[l |-> v] chevron.r$ #h(0.5cm) (Cmd-Decl)
]

==== Assegnamento

#align(center)[
  #box(stroke: (bottom: 1pt), inset: 3pt)[$chevron.l E, rho, sigma chevron.r arrow.b.double v$ #h(0.3cm) $rho("Id") = l$] \
  $chevron.l "Id" := E;, rho, sigma chevron.r arrow.r chevron.l rho, sigma[l |-> v] chevron.r$ #h(0.5cm) (Cmd-Assign)
]

==== Sequenza

#align(center)[
  #box(stroke: (bottom: 1pt), inset: 3pt)[$chevron.l C_1, rho, sigma chevron.r arrow.r chevron.l rho_1, sigma_1 chevron.r$ #h(0.3cm) $chevron.l C_2, rho_1, sigma_1 chevron.r arrow.r chevron.l rho_2, sigma_2 chevron.r$] \
  $chevron.l C_1 C_2, rho, sigma chevron.r arrow.r chevron.l rho_2, sigma_2 chevron.r$ #h(0.5cm) (Cmd-Seq)
]

=== Sviluppo sequenziale

Lo sviluppo sequenziale ci permette di eseguire i calcoli in uno stile più leggibile, rispetto alle derivazioni.

#example(title: "Derivazione vs Sviluppo sequenziale")[
  Consideriamo `C1 = y:=x;` e `C2 = x:=y;` con stato iniziale $rho = [x |-> l_1, y |-> l_2]$, $sigma = [l_1 |-> 5, l_2 |-> 3]$

  *Come derivazione* (albero):
  #align(center)[
    #box(stroke: (bottom: 1pt), inset: 3pt)[
      #box(stroke: (bottom: 1pt), inset: 3pt)[$chevron.l x, rho, sigma chevron.r arrow.b.double 5$] \
      $chevron.l y := x;, rho, sigma chevron.r arrow.r chevron.l rho, sigma[l_2 |-> 5] chevron.r$
      #h(0.5cm)
      #box(stroke: (bottom: 1pt), inset: 3pt)[$chevron.l y, rho, sigma' chevron.r arrow.b.double 5$] \
      $chevron.l x := y;, rho, sigma' chevron.r arrow.r chevron.l rho, sigma'[l_1 |-> 5] chevron.r$
    ] \
    $chevron.l "y:=x; x:=y;", rho, sigma chevron.r arrow.r chevron.l rho, sigma'' chevron.r$
  ]

  *Come sviluppo sequenziale* (lineare):
  #align(center)[
    ${x |-> 5, y |-> 3}$ \
    $arrow.b$ `y := x;` \
    ${x |-> 5, y |-> 5}$ \
    $arrow.b$ `x := y;` \
    ${x |-> 5, y |-> 5}$
  ]
]

In sviluppo sequenziale descriviamo l'esecuzione come sequenza di stati:

#align(center)[
  $chevron.l C, rho_0, sigma_0 chevron.r$ \
  $arrow.b$ \
  $chevron.l rho_1, sigma_1 chevron.r$ (dopo primo comando) \
  $arrow.b$ \
  $chevron.l rho_2, sigma_2 chevron.r$ (dopo secondo comando) \
  $...$ \
  $arrow.b$ \
  $chevron.l rho_n, sigma_n chevron.r$ (stato finale)
]

*Notazione semplificata*: invece di scrivere la configurazione completa, scriviamo solo lo stato come insieme di associazioni variabile $|->$ valore:

#align(center)[
  ${x |-> v_1, y |-> v_2, ...}$
]

Questa notazione "fonde" ambiente e memoria: $x |-> v$ significa che la variabile $x$ ha valore $v$.

#example(title: "Sviluppo sequenziale completo")[
  Consideriamo il programma:
  ```
  int x = 3;
  int y = 0;
  y := x + 1;
  x := y * 2;
  ```

  Stato iniziale: $rho_0 = emptyset$, $sigma_0 = emptyset$

  *Passo 1*: `int x = 3;`
  - Valuto l'espressione: $chevron.l 3, rho_0, sigma_0 chevron.r arrow.b.double 3$
  - Alloco una nuova locazione: $l_1 in.not "dom"(sigma_0)$
  - Estendo ambiente: $rho_1 = rho_0[x |-> l_1] = [x |-> l_1]$
  - Estendo memoria: $sigma_1 = sigma_0[l_1 |-> 3] = [l_1 |-> 3]$

  *Passo 2*: `int y = 0;`
  - Valuto: $chevron.l 0, rho_1, sigma_1 chevron.r arrow.b.double 0$
  - Alloco: $l_2 in.not "dom"(sigma_1)$
  - $rho_2 = rho_1[y |-> l_2] = [x |-> l_1, y |-> l_2]$
  - $sigma_2 = sigma_1[l_2 |-> 0] = [l_1 |-> 3, l_2 |-> 0]$

  *Passo 3*: `y := x + 1;`
  - Valuto $x + 1$: $chevron.l x + 1, rho_2, sigma_2 chevron.r arrow.b.double 3 + 1 = 4$
  - Trovo la locazione di $y$: $rho_2(y) = l_2$
  - Aggiorno memoria: $sigma_3 = sigma_2[l_2 |-> 4] = [l_1 |-> 3, l_2 |-> 4]$
  - L'ambiente resta: $rho_3 = rho_2$

  *Passo 4*: `x := y * 2;`
  - Valuto $y * 2$: $chevron.l y * 2, rho_3, sigma_3 chevron.r arrow.b.double 4 * 2 = 8$
  - Trovo la locazione di $x$: $rho_3(x) = l_1$
  - Aggiorno memoria: $sigma_4 = sigma_3[l_1 |-> 8] = [l_1 |-> 8, l_2 |-> 4]$

  *Stato finale*: $rho_4 = [x |-> l_1, y |-> l_2]$, $sigma_4 = [l_1 |-> 8, l_2 |-> 4]$

  Quindi $x = 8$ e $y = 4$.
]

#example(title: "Sviluppo sequenziale con condizionale")[
  Consideriamo:
  ```
  int a = 5;
  int b = 3;
  int max = 0;
  if(a > b){
      max := a;
  } else {
      max := b;
  }
  ```

  Dopo le dichiarazioni: $rho = [a |-> l_1, b |-> l_2, "max" |-> l_3]$, $sigma = [l_1 |-> 5, l_2 |-> 3, l_3 |-> 0]$

  *Valutazione della guardia*:
  $chevron.l a > b, rho, sigma chevron.r arrow.b.double chevron.l 5 > 3 chevron.r arrow.b.double "true"$

  Poiché la guardia è vera, eseguiamo il ramo `then`:

  *Esecuzione* `max := a;`:
  - Valuto $a$: $sigma(rho(a)) = sigma(l_1) = 5$
  - Aggiorno: $sigma' = sigma[l_3 |-> 5] = [l_1 |-> 5, l_2 |-> 3, l_3 |-> 5]$

  *Stato finale*: $"max" = 5$ ✓
]

=== Blocchi e comandi condizionali

=== Comando condizionale

I comandi condizionali servono per prendere decisioni all'interno dei programmi.

#align(center)[
  ```
       ┌─────────┐
       │ E vera? │
       └────┬────┘
            │
      ┌─────┴─────┐
      │           │
     Sì          No
      │           │
      ▼           ▼
   ┌─────┐    ┌─────┐
   │ C1  │    │ C2  │
   └──┬──┘    └──┬──┘
      │          │
      └────┬─────┘
           │
           ▼
       (continua)
  ```
]

=== Comando condizionale in Mao

```
if (E){C1} else {C2}
```

$E$ è espressione booleana, se vera si esegue $C_1$, altrimenti si esegue $C_2$.

#example(title: "comando condizionale in Mao")[
  ```
  if (piove) {
      ombrello := true;
  } else {
      ombrello := false;
  }
  ```
]

=== Comando if-then

Sostanzialmente è un comando if-else ma dove eseguiamo un comando solamente se la guardia (E) è vera.

```
if (E){C1} else {skip;}
```

#example(title: "comando condizionale if-then")[
  ```
  if (piove) {
      ombrello := true;
  }
  ```
]

#note[
  Le parentesi tonde e graffe svolgono due compiti distinti all'interno del linguaggio. Le parentesi tonde vengono utilizzate per fissare un ordine di valutazione.
]

=== Il blocco {C}

Tutte le variabili dichiarate all'interno del blocco sono visibili solo al suo interno. Lo #underline[scope] di una variabile definisce la porzione di codice nella quale la variabile può essere dichiarata, letta o modificata.

In Mao una variabile dichiarata all'interno del blocco è visibile in tutti i comandi successivi nello stesso blocco e all'interno dei blocchi annidati.

=== Shadowing

È possibile dichiarare una variabile all'interno di un blocco con il nome di una variabile dichiarata in precedenza. In questo caso la variabile dichiarata all'interno del blocco nasconde quella dichiarata all'esterno.

=== Semantica operazionale (seconda parte)

==== Blocco

#align(center)[
  #box(stroke: (bottom: 1pt), inset: 3pt)[$chevron.l C, rho, sigma chevron.r arrow.r chevron.l rho', sigma' chevron.r$] \
  $chevron.l {C}, rho, sigma chevron.r arrow.r chevron.l rho, sigma' chevron.r$ #h(0.5cm) (Cmd-Block)
]

#note[
  Il blocco "dimentica" le variabili dichiarate al suo interno: l'ambiente finale è quello iniziale $rho$, ma la memoria $sigma'$ mantiene le modifiche.
]

==== Condizionale (if-then-else)

#align(center)[
  #box(stroke: (bottom: 1pt), inset: 3pt)[$chevron.l E, rho, sigma chevron.r arrow.b.double "true"$ #h(0.3cm) $chevron.l C_1, rho, sigma chevron.r arrow.r chevron.l rho', sigma' chevron.r$] \
  $chevron.l "if"(E){C_1}"else"{C_2}, rho, sigma chevron.r arrow.r chevron.l rho', sigma' chevron.r$ #h(0.3cm) (Cmd-IfTrue)
]

#align(center)[
  #box(stroke: (bottom: 1pt), inset: 3pt)[$chevron.l E, rho, sigma chevron.r arrow.b.double "false"$ #h(0.3cm) $chevron.l C_2, rho, sigma chevron.r arrow.r chevron.l rho', sigma' chevron.r$] \
  $chevron.l "if"(E){C_1}"else"{C_2}, rho, sigma chevron.r arrow.r chevron.l rho', sigma' chevron.r$ #h(0.3cm) (Cmd-IfFalse)
]

=== Cicli

==== Comando iterativo (while)

Il ciclo `while` ripete l'esecuzione del corpo finché la guardia è vera.

=== Comando iterativo in Mao

```
while (E) {C}
```

$E$ è un'espressione booleana, se vera viene eseguito $C$ e si controlla la condizione, se falsa termina.

#example(title: "comando iterativo in Mao")[
  ```
  while( cioccolatini > 0) {
      cioccolatini := cioccolatini -1
  }
  ```
]

=== Semantica del while

#align(center)[
  #box(stroke: (bottom: 1pt), inset: 3pt)[$chevron.l E, rho, sigma chevron.r arrow.b.double "false"$] \
  $chevron.l "while"(E){C}, rho, sigma chevron.r arrow.r chevron.l rho, sigma chevron.r$ #h(0.5cm) (Cmd-WhileFalse)
]

#align(center)[
  #box(stroke: (bottom: 1pt), inset: 3pt)[$chevron.l E, rho, sigma chevron.r arrow.b.double "true"$ #h(0.2cm) $chevron.l C, rho, sigma chevron.r arrow.r chevron.l rho', sigma' chevron.r$ #h(0.2cm) $chevron.l "while"(E){C}, rho', sigma' chevron.r arrow.r chevron.l rho'', sigma'' chevron.r$] \
  $chevron.l "while"(E){C}, rho, sigma chevron.r arrow.r chevron.l rho'', sigma'' chevron.r$ #h(0.3cm) (Cmd-WhileTrue)
]

#note[
  La regola (Cmd-WhileTrue) è *ricorsiva*: dopo aver eseguito il corpo, si esegue di nuovo il while sullo stato risultante.
]

=== Riepilogo regole semantiche

#figure(
  table(
    columns: 2,
    [*Comando*], [*Regole*],
    [`skip;`], [(Cmd-Skip)],
    [`T Id = E;`], [(Cmd-Decl)],
    [`Id := E;`], [(Cmd-Assign)],
    [`C1 C2`], [(Cmd-Seq)],
    [`{C}`], [(Cmd-Block)],
    [`if(E){C1}else{C2}`], [(Cmd-IfTrue), (Cmd-IfFalse)],
    [`while(E){C}`], [(Cmd-WhileFalse), (Cmd-WhileTrue)],
  ),
  caption: [Riepilogo delle regole semantiche di MiniMao]
)

#example(title: "Sviluppo sequenziale con ciclo while")[
  Consideriamo:
  ```
  int n = 3;
  int s = 0;
  while(n > 0){
      s := s + n;
      n := n - 1;
  }
  ```

  Stato iniziale dopo le dichiarazioni: $rho = [n |-> l_1, s |-> l_2]$, $sigma_0 = [l_1 |-> 3, l_2 |-> 0]$

  *Iterazione 1*:
  - Guardia: $chevron.l n > 0, rho, sigma_0 chevron.r arrow.b.double 3 > 0 = "true"$ ✓
  - `s := s + n`: $s = 0 + 3 = 3$ → $sigma_1 = [l_1 |-> 3, l_2 |-> 3]$
  - `n := n - 1`: $n = 3 - 1 = 2$ → $sigma_1' = [l_1 |-> 2, l_2 |-> 3]$

  *Iterazione 2*:
  - Guardia: $2 > 0 = "true"$ ✓
  - `s := s + n`: $s = 3 + 2 = 5$ → $sigma_2 = [l_1 |-> 2, l_2 |-> 5]$
  - `n := n - 1`: $n = 2 - 1 = 1$ → $sigma_2' = [l_1 |-> 1, l_2 |-> 5]$

  *Iterazione 3*:
  - Guardia: $1 > 0 = "true"$ ✓
  - `s := s + n`: $s = 5 + 1 = 6$ → $sigma_3 = [l_1 |-> 1, l_2 |-> 6]$
  - `n := n - 1`: $n = 1 - 1 = 0$ → $sigma_3' = [l_1 |-> 0, l_2 |-> 6]$

  *Iterazione 4*:
  - Guardia: $0 > 0 = "false"$ ✗ → ciclo termina

  *Stato finale*: $n = 0$, $s = 6$ (somma dei primi 3 naturali: $3 + 2 + 1 = 6$) ✓
]

#example(title: "Sviluppo sequenziale: calcolo del fattoriale")[
  Consideriamo il programma che calcola il fattoriale di 4:
  ```
  int n = 4;
  int f = 1;
  while (n > 0) {
    f := f * n;
    n := n - 1;
  }
  ```

  *Stato iniziale* dopo le dichiarazioni:
  - $rho = [n |-> l_n, f |-> l_f]$
  - $sigma_0 = [l_n |-> 4, l_f |-> 1]$

  *Iterazione 1*:
  - Guardia: $chevron.l n > 0, rho, sigma_0 chevron.r arrow.b.double 4 > 0 = "true"$ ✓
  - `f := f * n`: $chevron.l f * n, rho, sigma_0 chevron.r arrow.b.double 1 times 4 = 4$
    - $sigma_0' = sigma_0[l_f |-> 4] = [l_n |-> 4, l_f |-> 4]$
  - `n := n - 1`: $chevron.l n - 1, rho, sigma_0' chevron.r arrow.b.double 4 - 1 = 3$
    - $sigma_1 = sigma_0'[l_n |-> 3] = [l_n |-> 3, l_f |-> 4]$

  *Iterazione 2*:
  - Guardia: $chevron.l n > 0, rho, sigma_1 chevron.r arrow.b.double 3 > 0 = "true"$ ✓
  - `f := f * n`: $chevron.l f * n, rho, sigma_1 chevron.r arrow.b.double 4 times 3 = 12$
    - $sigma_1' = sigma_1[l_f |-> 12] = [l_n |-> 3, l_f |-> 12]$
  - `n := n - 1`: $chevron.l n - 1, rho, sigma_1' chevron.r arrow.b.double 3 - 1 = 2$
    - $sigma_2 = sigma_1'[l_n |-> 2] = [l_n |-> 2, l_f |-> 12]$

  *Iterazione 3*:
  - Guardia: $chevron.l n > 0, rho, sigma_2 chevron.r arrow.b.double 2 > 0 = "true"$ ✓
  - `f := f * n`: $chevron.l f * n, rho, sigma_2 chevron.r arrow.b.double 12 times 2 = 24$
    - $sigma_2' = sigma_2[l_f |-> 24] = [l_n |-> 2, l_f |-> 24]$
  - `n := n - 1`: $chevron.l n - 1, rho, sigma_2' chevron.r arrow.b.double 2 - 1 = 1$
    - $sigma_3 = sigma_2'[l_n |-> 1] = [l_n |-> 1, l_f |-> 24]$

  *Iterazione 4*:
  - Guardia: $chevron.l n > 0, rho, sigma_3 chevron.r arrow.b.double 1 > 0 = "true"$ ✓
  - `f := f * n`: $chevron.l f * n, rho, sigma_3 chevron.r arrow.b.double 24 times 1 = 24$
    - $sigma_3' = sigma_3[l_f |-> 24] = [l_n |-> 1, l_f |-> 24]$
  - `n := n - 1`: $chevron.l n - 1, rho, sigma_3' chevron.r arrow.b.double 1 - 1 = 0$
    - $sigma_4 = sigma_3'[l_n |-> 0] = [l_n |-> 0, l_f |-> 24]$

  *Iterazione 5*:
  - Guardia: $chevron.l n > 0, rho, sigma_4 chevron.r arrow.b.double 0 > 0 = "false"$ ✗ → ciclo termina

  *Riepilogo delle iterazioni*:
  #figure(
    table(
      columns: 4,
      [*Iterazione*], [*n*], [*f*], [*Guardia*],
      [Inizio], [4], [1], [-],
      [1], [3], [4], [true],
      [2], [2], [12], [true],
      [3], [1], [24], [true],
      [4], [0], [24], [true],
      [Fine], [0], [24], [false],
    ),
    caption: [Evoluzione dello stato nel calcolo di 4!]
  )

  *Stato finale*: $n = 0$, $f = 24$ (infatti $4! = 4 times 3 times 2 times 1 = 24$) ✓
]

#example(title: "Sviluppo sequenziale: blocchi e shadowing")[
  Consideriamo il programma che illustra lo shadowing delle variabili:
  ```
  int x = 10;
  {
    int x = 5;
    x := x + 1;
  }
  x := x * 2;
  ```

  *Stato iniziale*: $rho_0 = emptyset$, $sigma_0 = emptyset$

  *Passo 1*: `int x = 10;` (dichiarazione esterna)
  - Valuto: $chevron.l 10, rho_0, sigma_0 chevron.r arrow.b.double 10$
  - Alloco nuova locazione: $l_1 in.not "dom"(sigma_0)$
  - $rho_1 = [x |-> l_1]$
  - $sigma_1 = [l_1 |-> 10]$

  *Passo 2*: Ingresso nel blocco `{ ... }`
  - L'ambiente corrente e: $rho_1 = [x |-> l_1]$
  - La memoria corrente e: $sigma_1 = [l_1 |-> 10]$

  *Passo 2a*: `int x = 5;` (dichiarazione interna - shadowing)
  - Valuto: $chevron.l 5, rho_1, sigma_1 chevron.r arrow.b.double 5$
  - Alloco *nuova* locazione: $l_2 in.not "dom"(sigma_1)$
  - $rho_2 = rho_1[x |-> l_2] = [x |-> l_2]$ (la nuova $x$ *nasconde* quella esterna)
  - $sigma_2 = sigma_1[l_2 |-> 5] = [l_1 |-> 10, l_2 |-> 5]$

  #note[
    Ora esistono *due* locazioni: $l_1$ (la $x$ esterna, valore 10) e $l_2$ (la $x$ interna, valore 5). L'ambiente $rho_2$ "vede" solo $l_2$ perche il binding $x |-> l_2$ ha sostituito $x |-> l_1$.
  ]

  *Passo 2b*: `x := x + 1;` (assegnamento alla $x$ interna)
  - Valuto $x + 1$: $chevron.l x + 1, rho_2, sigma_2 chevron.r$
    - $rho_2(x) = l_2$, $sigma_2(l_2) = 5$
    - $5 + 1 = 6$
  - Aggiorno: $sigma_3 = sigma_2[l_2 |-> 6] = [l_1 |-> 10, l_2 |-> 6]$

  *Passo 3*: Uscita dal blocco
  - Applichiamo la regola (Cmd-Block): l'ambiente torna a $rho_1 = [x |-> l_1]$
  - La memoria *rimane* $sigma_3 = [l_1 |-> 10, l_2 |-> 6]$

  #note[
    Dopo l'uscita dal blocco, la variabile $x$ si riferisce di nuovo a $l_1$ (che contiene ancora 10). La locazione $l_2$ esiste ancora in memoria ma non e piu accessibile.
  ]

  *Passo 4*: `x := x * 2;` (assegnamento alla $x$ esterna)
  - Valuto $x * 2$: $chevron.l x * 2, rho_1, sigma_3 chevron.r$
    - $rho_1(x) = l_1$, $sigma_3(l_1) = 10$
    - $10 times 2 = 20$
  - Aggiorno: $sigma_4 = sigma_3[l_1 |-> 20] = [l_1 |-> 20, l_2 |-> 6]$

  *Stato finale*:
  - $rho_"fin" = [x |-> l_1]$
  - $sigma_"fin" = [l_1 |-> 20, l_2 |-> 6]$
  - La variabile $x$ (esterna) vale 20

  *Riepilogo dell'evoluzione degli ambienti*:
  #figure(
    table(
      columns: 3,
      [*Punto*], [*Ambiente* $rho$], [*$x$ punta a*],
      [Dopo `int x = 10;`], [$[x |-> l_1]$], [$l_1$ (valore 10)],
      [Dentro blocco, dopo `int x = 5;`], [$[x |-> l_2]$], [$l_2$ (valore 5)],
      [Dentro blocco, dopo `x := x + 1;`], [$[x |-> l_2]$], [$l_2$ (valore 6)],
      [Dopo uscita dal blocco], [$[x |-> l_1]$], [$l_1$ (valore 10)],
      [Dopo `x := x * 2;`], [$[x |-> l_1]$], [$l_1$ (valore 20)],
    ),
    caption: [Evoluzione dell'ambiente con shadowing]
  )
]

#example(title: "Sviluppo sequenziale: condizionali annidati (calcolo del massimo)")[
  Consideriamo il programma che trova il massimo tra tre numeri:
  ```
  int a = 7;
  int b = 3;
  int c = 5;
  int max = a;
  if (b > max) { max := b; }
  if (c > max) { max := c; }
  ```

  *Stato iniziale*: $rho_0 = emptyset$, $sigma_0 = emptyset$

  *Passo 1-4*: Dichiarazioni
  - `int a = 7;`: alloco $l_a$, $rho_1 = [a |-> l_a]$, $sigma_1 = [l_a |-> 7]$
  - `int b = 3;`: alloco $l_b$, $rho_2 = [a |-> l_a, b |-> l_b]$, $sigma_2 = [l_a |-> 7, l_b |-> 3]$
  - `int c = 5;`: alloco $l_c$, $rho_3 = [a |-> l_a, b |-> l_b, c |-> l_c]$, $sigma_3 = [l_a |-> 7, l_b |-> 3, l_c |-> 5]$
  - `int max = a;`: valuto $a$ (= 7), alloco $l_m$
    - $rho_4 = [a |-> l_a, b |-> l_b, c |-> l_c, "max" |-> l_m]$
    - $sigma_4 = [l_a |-> 7, l_b |-> 3, l_c |-> 5, l_m |-> 7]$

  *Stato dopo le dichiarazioni*:
  #align(center)[
    ${a |-> 7, b |-> 3, c |-> 5, "max" |-> 7}$
  ]

  *Passo 5*: Primo condizionale `if (b > max) { max := b; }`
  - Valuto la guardia: $chevron.l b > "max", rho_4, sigma_4 chevron.r$
    - $sigma_4(rho_4(b)) = sigma_4(l_b) = 3$
    - $sigma_4(rho_4("max")) = sigma_4(l_m) = 7$
    - $3 > 7 = "false"$
  - Poiche la guardia e falsa, applichiamo (Cmd-IfFalse) con il ramo else implicito `skip;`
  - Lo stato *non cambia*: $sigma_5 = sigma_4$

  #align(center)[
    ${a |-> 7, b |-> 3, c |-> 5, "max" |-> 7}$ (invariato)
  ]

  *Passo 6*: Secondo condizionale `if (c > max) { max := c; }`
  - Valuto la guardia: $chevron.l c > "max", rho_4, sigma_5 chevron.r$
    - $sigma_5(rho_4(c)) = sigma_5(l_c) = 5$
    - $sigma_5(rho_4("max")) = sigma_5(l_m) = 7$
    - $5 > 7 = "false"$
  - Poiche la guardia e falsa, applichiamo (Cmd-IfFalse)
  - Lo stato *non cambia*: $sigma_6 = sigma_5$

  *Stato finale*:
  #align(center)[
    ${a |-> 7, b |-> 3, c |-> 5, "max" |-> 7}$
  ]

  Il risultato e corretto: $"max" = 7 = max(7, 3, 5)$ ✓

  ---

  *Variante*: Consideriamo lo stesso programma con valori diversi: $a = 2$, $b = 8$, $c = 5$

  Dopo le dichiarazioni: ${a |-> 2, b |-> 8, c |-> 5, "max" |-> 2}$

  *Primo condizionale* `if (b > max) { max := b; }`:
  - Guardia: $8 > 2 = "true"$ ✓
  - Eseguo `max := b;`: $"max" = 8$
  - Stato: ${a |-> 2, b |-> 8, c |-> 5, "max" |-> 8}$

  *Secondo condizionale* `if (c > max) { max := c; }`:
  - Guardia: $5 > 8 = "false"$
  - Stato invariato: ${a |-> 2, b |-> 8, c |-> 5, "max" |-> 8}$

  Risultato: $"max" = 8 = max(2, 8, 5)$ ✓

  ---

  *Altra variante*: $a = 2$, $b = 3$, $c = 9$

  Dopo le dichiarazioni: ${a |-> 2, b |-> 3, c |-> 9, "max" |-> 2}$

  *Primo condizionale*:
  - Guardia: $3 > 2 = "true"$ ✓
  - Eseguo `max := b;`: $"max" = 3$
  - Stato: ${a |-> 2, b |-> 3, c |-> 9, "max" |-> 3}$

  *Secondo condizionale*:
  - Guardia: $9 > 3 = "true"$ ✓
  - Eseguo `max := c;`: $"max" = 9$
  - Stato: ${a |-> 2, b |-> 3, c |-> 9, "max" |-> 9}$

  Risultato: $"max" = 9 = max(2, 3, 9)$ ✓
]

=== Terminazione vs Divergenza

Con l'introduzione dei cicli adesso i programmi possono divergere, senza che essi producano un risultato finale.

#definition(title: "Divergenza")[
  La #underline[divergenza] si riferisce alla situazione in cui un programma o un ciclo non terminano mai, continuando a eseguire istruzioni indefinitamente
]

#definition(title: "Terminazione")[
  La #underline[terminazione] è una proprietà desiderabile nei programmi, infatti essa garantisce che il programma completi la sua esecuzione e produca un risultato in tempo finito.
  La terminazione è possibile solo se la guardia di un'iterazione contiene almeno una variabile e il corpo contenga almeno un assegnamento su quella variabile.
]

#note[
  Non esiste un algoritmo che per ogni programma sia in grado di decidere se termina o no
]

=== Costrutti iterativi alternativi

In Mao si vede solamente il costrutto iterativo while ma ci sono diversi costrutti iterativi che i linguaggi di programmazione comuni mettono a disposizione. Ognuno di questi costrutti possono essere espressi usando un ciclo while.

=== Ciclo for

Costrutto particolarmente compatto, in una riga è possibile leggere quante iterazioni eseguirà.

#example(title: "for in JavaScript")[
  ```javascript
  let somma=0
  for (let i =1; i<n; i=i+1) {
      somma = somma + 1
  }
  ```
]

=== Ciclo do-while

Si utilizza per eseguire il corpo una volta senza controllare la condizione.

#example(title: "do-while in JavaScript")[
  ```javascript
  let eta;
  do {
      eta = parseInt(prompt("Anni?"));
  } while(eta < 0)
  ```
]
