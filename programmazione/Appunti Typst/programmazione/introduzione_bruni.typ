#import "../template.typ": *

=== Linguaggi di Programmazione

==== Perché serve un linguaggio di programmazione

- I linguaggi di programmazione servono a tradurre idee in istruzioni eseguibili
- Sono formali, precisi e non ambigui
- Esistono molti linguaggi (Python, Java, C, JavaScript...), tutti condividono concetti di base

#note[
  Un linguaggio di programmazione è un *ponte* tra il pensiero umano e l'esecuzione della macchina.
]

==== Il nostro linguaggio: MAO

#definition(title: "MAO")[
  *Modello Astratto Operazionale*: linguaggio di programmazione semplificato, leggibile e didattico.
]

MAO è simile a linguaggi reali come JavaScript o C, ma senza complicazioni tecniche. Serve a studiare i *concetti fondamentali* della programmazione.

#example(title: "Primo programma in MAO")[
  ```
  int x = 5;
  int y = 3;
  int somma = x + y;
  ```
  Questo programma dichiara due variabili intere e calcola la loro somma.
]

==== Sintassi vs Semantica

Lo studio di un linguaggio comprende due aspetti distinti:

#figure(
  table(
    columns: 3,
    [*Aspetto*], [*Domanda*], [*Esempio*],
    [*Sintassi*], [Come si scrive?], [`if(x > 0){ ... }`],
    [*Semantica*], [Cosa significa?], [Se $x > 0$, esegui il blocco],
  ),
  caption: [Sintassi vs Semantica]
)

#definition(title: "Sintassi")[
  L'insieme di regole che definiscono la *struttura grammaticale* delle frasi valide del linguaggio.
]

#definition(title: "Semantica")[
  Il *significato* delle frasi sintatticamente corrette: cosa fa il programma quando viene eseguito.
]

#example(title: "Stesso significato, sintassi diversa")[
  In MAO: `x := x + 1;` \
  In Python: `x = x + 1` \
  In C++: `x++;`

  Tutte queste istruzioni hanno la stessa semantica: incrementano $x$ di 1.
]

==== Obiettivi della programmazione

- *Correttezza*: il programma fa quello che deve fare
- *Efficienza*: usa poche risorse (tempo, memoria)
- *Leggibilità*: altri programmatori possono capirlo
- *Manutenibilità*: facile da modificare e aggiornare

==== Sintassi formale: perché?

Nel linguaggio naturale possiamo capire frasi con errori:
- "Dmoani vado al mrae" → "Domani vado al mare"

Un computer invece ha bisogno di *regole precise*. Non può "intuire" cosa intendevamo.

#example(title: "Errore sintattico")[
  ```
  int x = ;    // ERRORE: manca il valore
  if x > 0     // ERRORE: mancano le parentesi
  ```
]

==== Come definire formalmente un linguaggio?

Un linguaggio può essere visto come un *insieme di frasi ben formate*. Per descrivere questo insieme si usano le *grammatiche formali*.

#note[
  Le grammatiche formali non riguardano solo la programmazione: anche l'italiano ha una grammatica (soggetto + verbo + complemento).
]

==== Elementi base di MAO

#figure(
  table(
    columns: 2,
    [*Elemento*], [*Esempio*],
    [Dichiarazione], [`int x = 5;`],
    [Assegnamento], [`x := x + 1;`],
    [Condizionale], [`if(x > 0){ ... } else { ... }`],
    [Ciclo], [`while(x > 0){ ... }`],
    [Funzione], [`int f(int a){ return a * 2; }`],
  ),
  caption: [Costrutti base di MAO]
)

#note(title: "Attenzione")[
  In MAO usiamo `=` per la *dichiarazione* e `:=` per l'*assegnamento*. Questa distinzione è importante!
]
