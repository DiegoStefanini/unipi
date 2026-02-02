#import "../template.typ": *

=== Cos'è l'Informatica

#definition(title: "Informatica")[
  Lo studio sistematico dei processi *algoritmici* che descrivono e trasformano le *informazioni*: la loro teoria, analisi, progettazione, efficienza, implementazione e applicazione (ACM)
]

#note(title: "ACM")[
  Association for Computing Machinery è l'associazione accademica internazionale di scienziati ed educatori dell'informatica.
]

=== Algoritmo

#definition(title: "Algoritmo")[
  Sequenza *finita* di *passi univocamente determinati* che se eseguiti da un *esecutore* portano alla risoluzione di un *problema*
]

*passi* $arrow.squiggly$ istruzioni, operazioni elementari \
*esecutore* $arrow.squiggly$ calcolatore

Le tre componenti fondamentali:
+ *Problema* da risolvere
+ *Procedimento* da seguire
+ *Esecutore* che esegue le istruzioni

#note[
  La descrizione dell'algoritmo deve essere comprensibile dall'esecutore
]

==== Proprietà degli algoritmi

- *Finitezza*: un algoritmo è costituito da un numero finito di passi e deve terminare in tempo finito
- *Non ambiguità*: i passi sono univocamente determinati, senza ambiguità o scelte arbitrarie
- *Determinismo*: ogni istruzione ha un solo passo successivo possibile, date le condizioni attuali
- *Generalità*: risolve una classe di problemi, non una singola istanza

#example(title: "Algoritmo: trovare il massimo")[
  *Problema*: dato un insieme di $n$ numeri, trovare il più grande.

  *Algoritmo* (in linguaggio naturale):
  + Considera il primo numero come "massimo corrente"
  + Per ogni numero successivo:
    - Se è maggiore del massimo corrente, diventa il nuovo massimo
  + Alla fine, restituisci il massimo corrente

  *In MAO*:
  ```
  int max(int[] A, int n){
      int m = A[1];
      int i = 2;
      while(i <= n){
          if(A[i] > m){
              m := A[i];
          }
          i := i + 1;
      }
      return m;
  }
  ```
]

=== Programma e programmazione

#definition(title: "Programma")[
  Formulazione di un algoritmo in un #underline[linguaggio di programmazione], indica al calcolatore quali operazioni eseguire, in quale ordine, con quali dati e sotto quali condizioni.
]

#definition(title: "Programmare")[
  Scrivere istruzioni che un computer può eseguire per risolvere problemi o svolgere compiti specifici.
]

==== Differenza tra algoritmo e programma

#figure(
  table(
    columns: 3,
    [*Aspetto*], [*Algoritmo*], [*Programma*],
    [Livello], [Astratto], [Concreto],
    [Linguaggio], [Naturale/pseudo-codice], [Linguaggio di programmazione],
    [Esecutore], [Umano o macchina], [Solo macchina],
    [Dettagli], [Omessi], [Tutti specificati],
  ),
  caption: [Confronto algoritmo vs programma]
)

=== Computer

#definition(title: "Computer")[
  Macchine che eseguono semplici operazioni, *rapidamente* e con grande *precisione*.
]

Un computer riceve in *input* un programma (testo) e un insieme di dati e produce in *output* il risultato dell'esecuzione del programma. A differenza di altre macchine automatiche, essi sono *programmabili*: il compito dipende dal programma.

=== Problem solving

#definition(title: "Problem Solving")[
  Attività finalizzata all'analisi e alla risoluzione dei _problemi computazionali_
]

Le fasi del problem solving:
+ *Specifica*: definizione del problema (input/output)
+ *Progettazione*: ideazione dell'algoritmo
+ *Codifica*: traduzione in linguaggio di programmazione
+ *Testing*: verifica della correttezza
+ *Esecuzione*: run del programma

#note[
  Ci sono problemi che non hanno algoritmi che li risolvano! (es. Problema della fermata)
]

=== Problemi computazionali

#definition(title: "Problema computazionale")[
  Un problema formulato matematicamente di cui cerchiamo una soluzione algoritmica. È definito da:
  - *Input*: i dati in ingresso (istanza del problema)
  - *Output*: il risultato atteso
  - *Relazione*: vincolo tra input e output
]

#example(title: "Problema: ordinamento")[
  - *Input*: sequenza di $n$ numeri $chevron.l a_1, a_2, ..., a_n chevron.r$
  - *Output*: permutazione $chevron.l a'_1, a'_2, ..., a'_n chevron.r$ tale che $a'_1 <= a'_2 <= ... <= a'_n$
]

#example(title: "Problema: ricerca")[
  - *Input*: sequenza di $n$ numeri e un valore $k$
  - *Output*: indice $i$ tale che $A[i] = k$, oppure $-1$ se $k$ non è presente
]
