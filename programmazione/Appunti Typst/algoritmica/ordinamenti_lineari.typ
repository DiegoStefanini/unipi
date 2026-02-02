#import "../template.typ": *

=== Ordinamento in tempo lineare

=== Limite inferiore per l'ordinamento per confronti

#theorem(title: "Limite inferiore")[
  Qualsiasi algoritmo di ordinamento basato su confronti richiede $Omega(n log n)$ confronti nel caso pessimo.
]

=== Dimostrazione con albero di decisione

#definition(title: "Albero di decisione")[
  Un *albero di decisione* è un albero binario che rappresenta i confronti effettuati da un algoritmo di ordinamento su un input di dimensione $n$:
  - Ogni nodo interno rappresenta un confronto $a_i <= a_j$
  - Il sottoalbero sinistro corrisponde al caso "sì"
  - Il sottoalbero destro corrisponde al caso "no"
  - Ogni foglia rappresenta una permutazione dell'output
]

#demonstration[
  - Un array di $n$ elementi può avere $n!$ permutazioni
  - L'albero di decisione deve avere almeno $n!$ foglie (una per ogni possibile output)
  - Un albero binario di altezza $h$ ha al massimo $2^h$ foglie
  - Quindi: $2^h >= n! arrow.double h >= log(n!)$

  Usando l'approssimazione di Stirling: $log(n!) = Theta(n log n)$

  Quindi: $h = Omega(n log n)$
]

#note[
  Questo limite inferiore ci dice che *non possiamo fare meglio* di $O(n log n)$ usando solo confronti. MergeSort e HeapSort sono quindi *ottimi* tra gli algoritmi basati su confronti.
]

=== Ordinamento in tempo lineare

Per superare il limite $Omega(n log n)$, dobbiamo usare algoritmi che *non* si basano esclusivamente su confronti. Questi algoritmi sfruttano informazioni aggiuntive sui dati.

=== Counting Sort

Il Counting Sort funziona quando gli elementi da ordinare sono interi in un intervallo noto $[0, k]$.

=== Idea

+ Conta quante volte appare ogni valore
+ Usa questi conteggi per determinare la posizione finale di ogni elemento

=== Algoritmo

```
countingSort(int[] A, int[] B, int n, int k){
    // C[i] conterrà il numero di elementi <= i
    int[] C = new int[k + 1];

    // Inizializza C a 0
    int i = 0;
    while(i <= k){
        C[i] := 0;
        i := i + 1;
    }

    // C[i] = numero di elementi uguali a i
    int j = 1;
    while(j <= n){
        C[A[j]] := C[A[j]] + 1;
        j := j + 1;
    }

    // C[i] = numero di elementi <= i
    i := 1;
    while(i <= k){
        C[i] := C[i] + C[i - 1];
        i := i + 1;
    }

    // Costruisci l'array ordinato B
    j := n;
    while(j >= 1){
        B[C[A[j]]] := A[j];
        C[A[j]] := C[A[j]] - 1;
        j := j - 1;
    }
}
```

#example(title: "Counting Sort passo-passo")[
  Input: $A = [2, 5, 3, 0, 2, 3, 0, 3]$ con $n = 8$, $k = 5$

  *Fase 1: Inizializzazione* di $C$ (array di conteggio)
  $ C = [0, 0, 0, 0, 0, 0] quad "(indici 0..5)" $

  *Fase 2: Conteggio* delle occorrenze di ogni valore
  #figure(
    table(
      columns: 3,
      [*j*], [*A[j]*], [*C dopo l'aggiornamento*],
      [1], [2], [$[0, 0, 1, 0, 0, 0]$],
      [2], [5], [$[0, 0, 1, 0, 0, 1]$],
      [3], [3], [$[0, 0, 1, 1, 0, 1]$],
      [4], [0], [$[1, 0, 1, 1, 0, 1]$],
      [5], [2], [$[1, 0, 2, 1, 0, 1]$],
      [6], [3], [$[1, 0, 2, 2, 0, 1]$],
      [7], [0], [$[2, 0, 2, 2, 0, 1]$],
      [8], [3], [$[2, 0, 2, 3, 0, 1]$],
    )
  )
  Interpretazione: 2 zeri, 0 uni, 2 due, 3 tre, 0 quattro, 1 cinque

  *Fase 3: Somme prefisse* ($C[i]$ = quanti elementi $<= i$)
  #figure(
    table(
      columns: 3,
      [*i*], [*Calcolo*], [*C*],
      [0], [già ok], [$[2, 0, 2, 3, 0, 1]$],
      [1], [$C[1] := 0 + 2 = 2$], [$[2, 2, 2, 3, 0, 1]$],
      [2], [$C[2] := 2 + 2 = 4$], [$[2, 2, 4, 3, 0, 1]$],
      [3], [$C[3] := 3 + 4 = 7$], [$[2, 2, 4, 7, 0, 1]$],
      [4], [$C[4] := 0 + 7 = 7$], [$[2, 2, 4, 7, 7, 1]$],
      [5], [$C[5] := 1 + 7 = 8$], [$[2, 2, 4, 7, 7, 8]$],
    )
  )

  *Fase 4: Costruzione output* (da destra a sinistra per stabilità)
  #figure(
    table(
      columns: 5,
      [*j*], [*A[j]*], [*C[A[j]]*], [*B[C[A[j]]] := A[j]*], [*B*],
      [8], [3], [7], [$B[7] := 3$], [$[-, -, -, -, -, -, 3, -]$],
      [7], [0], [2], [$B[2] := 0$], [$[-, 0, -, -, -, -, 3, -]$],
      [6], [3], [6], [$B[6] := 3$], [$[-, 0, -, -, -, 3, 3, -]$],
      [5], [2], [4], [$B[4] := 2$], [$[-, 0, -, 2, -, 3, 3, -]$],
      [4], [0], [1], [$B[1] := 0$], [$[0, 0, -, 2, -, 3, 3, -]$],
      [3], [3], [5], [$B[5] := 3$], [$[0, 0, -, 2, 3, 3, 3, -]$],
      [2], [5], [8], [$B[8] := 5$], [$[0, 0, -, 2, 3, 3, 3, 5]$],
      [1], [2], [3], [$B[3] := 2$], [$[0, 0, 2, 2, 3, 3, 3, 5]$],
    )
  )

  *Output finale*: $B = [0, 0, 2, 2, 3, 3, 3, 5]$ ✓
]

#note(title: "Perché si scorre da destra a sinistra?")[
  Scorrendo $A$ da destra a sinistra, gli elementi con lo stesso valore vengono inseriti in $B$ mantenendo l'ordine relativo originale. Questo rende Counting Sort *stabile*, proprietà essenziale per Radix Sort.
]

=== Complessità

- Inizializzazione di C: $Theta(k)$
- Conteggio elementi: $Theta(n)$
- Somme prefisse: $Theta(k)$
- Costruzione output: $Theta(n)$

$ T(n, k) = Theta(n + k) $

#note[
  Se $k = O(n)$, allora $T(n) = Theta(n)$ - ordinamento lineare!
]

=== Stabilità

#definition(title: "Algoritmo stabile")[
  Un algoritmo di ordinamento è *stabile* se elementi con la stessa chiave mantengono l'ordine relativo che avevano nell'input.
]

#note[
  Counting Sort è *stabile* (grazie al ciclo finale che scorre da destra a sinistra). Questa proprietà è fondamentale per Radix Sort.
]

=== Limitazioni

- Richiede che gli elementi siano interi non negativi
- Richiede di conoscere il range $[0, k]$
- Se $k >> n$, lo spazio e il tempo diventano proibitivi

=== Radix Sort

Il Radix Sort ordina numeri interi cifra per cifra, dalla meno significativa alla più significativa.

=== Idea

Ordina ripetutamente usando un algoritmo stabile (come Counting Sort) su ogni cifra, partendo dalla cifra meno significativa.

=== Algoritmo

```
radixSort(int[] A, int d){
    // d = numero di cifre
    int i = 1;
    while(i <= d){
        // Usa un ordinamento stabile sulla cifra i-esima
        stableSort(A, i);
        i := i + 1;
    }
}
```

#example(title: "Radix Sort passo-passo")[
  Input: $A = [329, 457, 657, 839, 436, 720, 355]$, $d = 3$ cifre

  *Passo 1: Ordinamento per UNITÀ* (cifra meno significativa)
  #figure(
    table(
      columns: 3,
      [*Numero*], [*Cifra unità*], [*Gruppo*],
      [329], [9], [9],
      [457], [7], [7],
      [657], [7], [7],
      [839], [9], [9],
      [436], [6], [6],
      [720], [0], [0],
      [355], [5], [5],
    )
  )
  Ordinando stabilmente per unità: $[720, 355, 436, 457, 657, 329, 839]$

  *Passo 2: Ordinamento per DECINE*
  #figure(
    table(
      columns: 3,
      [*Numero*], [*Cifra decine*], [*Gruppo*],
      [720], [2], [2],
      [355], [5], [5],
      [436], [3], [3],
      [457], [5], [5],
      [657], [5], [5],
      [329], [2], [2],
      [839], [3], [3],
    )
  )
  Ordinando stabilmente per decine: $[720, 329, 436, 839, 355, 457, 657]$

  Nota: 720 viene prima di 329 (entrambi hanno decine=2), perché 720 era prima nell'array precedente → *stabilità*!

  *Passo 3: Ordinamento per CENTINAIA*
  #figure(
    table(
      columns: 3,
      [*Numero*], [*Cifra centinaia*], [*Gruppo*],
      [720], [7], [7],
      [329], [3], [3],
      [436], [4], [4],
      [839], [8], [8],
      [355], [3], [3],
      [457], [4], [4],
      [657], [6], [6],
    )
  )
  Ordinando stabilmente per centinaia: $[329, 355, 436, 457, 657, 720, 839]$ ✓

  Nota: 329 viene prima di 355 (entrambi hanno centinaia=3), perché 329 era prima dopo il passo 2 → *stabilità*!
]

#note(title: "Importanza della stabilità in Radix Sort")[
  Se l'ordinamento su ogni cifra non fosse stabile, il lavoro fatto sulle cifre precedenti andrebbe perso. Ad esempio, dopo aver ordinato per unità e decine, 329 e 355 sono correttamente in quest'ordine (perché $29 < 55$). L'ordinamento stabile per centinaia preserva questo ordine tra elementi con la stessa cifra delle centinaia.
]

#note[
  È fondamentale usare un ordinamento *stabile*! Altrimenti l'ordinamento sulle cifre più significative distruggerebbe il lavoro fatto sulle cifre meno significative.
]

=== Correttezza

#demonstration[
  Per induzione sul numero di cifre ordinate:
  - Dopo l'ordinamento sulla cifra 1, gli elementi sono ordinati rispetto a quella cifra
  - Assumiamo che dopo $i-1$ iterazioni, gli elementi siano ordinati rispetto alle ultime $i-1$ cifre
  - L'ordinamento stabile sulla cifra $i$ mantiene l'ordine relativo degli elementi con la stessa cifra $i$, che erano già ordinati rispetto alle cifre $1, ..., i-1$
]

=== Complessità

Se usiamo Counting Sort come algoritmo stabile, con numeri in base $b$:

- Ogni cifra è in $[0, b-1]$
- Counting Sort su ogni cifra: $Theta(n + b)$
- Numero di cifre: $d = log_b(max)$

$ T(n) = Theta(d(n + b)) $

#note[
  Se $b = n$ e $d$ è costante, allora $T(n) = Theta(n)$ - ordinamento lineare!
]

=== Come scegliere la base

Dato un numero massimo con $r$ bit, possiamo scegliere la base $b = 2^s$ dove $s$ divide $r$.

#theorem(title: "Scelta ottimale della base")[
  Per $n$ numeri a $r$ bit, con $r >= log n$, Radix Sort ordina in tempo $Theta(n)$ scegliendo $s = log n$ (quindi $b = n$).
]

=== Bucket Sort

Il Bucket Sort assume che l'input sia distribuito uniformemente in un intervallo.

=== Idea

+ Dividi l'intervallo in $n$ "bucket" (secchi) di uguale dimensione
+ Distribuisci gli elementi nei bucket
+ Ordina ogni bucket (con Insertion Sort)
+ Concatena i bucket

=== Algoritmo

```
bucketSort(int[] A, int n){
    // B = array di n liste vuote
    List[] B = new List[n];

    // Distribuisci gli elementi nei bucket
    int i = 1;
    while(i <= n){
        int idx = n * A[i];  // floor implicito
        insert(B[idx], A[i]);
        i := i + 1;
    }

    // Ordina ogni bucket
    i := 0;
    while(i <= n - 1){
        insertionSort(B[i]);
        i := i + 1;
    }

    // Concatena i bucket
    return concatenate(B[0], B[1], ..., B[n-1]);
}
```

#note[
  Assumiamo che gli elementi siano in $[0, 1)$. Per altri intervalli, si normalizza.
]

=== Complessità

- Caso pessimo: $Theta(n^2)$ (tutti gli elementi nello stesso bucket)
- Caso medio (distribuzione uniforme): $Theta(n)$

#theorem(title: "Complessità attesa")[
  Se l'input è distribuito uniformemente in $[0, 1)$, il tempo atteso di Bucket Sort è $Theta(n)$.
]

=== Riepilogo algoritmi di ordinamento

#figure(
  table(
    columns: 5,
    [*Algoritmo*], [*Caso Pessimo*], [*Caso Medio*], [*Stabile?*], [*In-place?*],
    [Insertion Sort], [$O(n^2)$], [$O(n^2)$], [Sì], [Sì],
    [Selection Sort], [$O(n^2)$], [$O(n^2)$], [No], [Sì],
    [Merge Sort], [$O(n log n)$], [$O(n log n)$], [Sì], [No],
    [QuickSort], [$O(n^2)$], [$O(n log n)$], [No], [Sì],
    [Heapsort], [$O(n log n)$], [$O(n log n)$], [No], [Sì],
    [Counting Sort], [$O(n + k)$], [$O(n + k)$], [Sì], [No],
    [Radix Sort], [$O(d(n + b))$], [$O(d(n + b))$], [Sì], [No],
    [Bucket Sort], [$O(n^2)$], [$O(n)$], [Sì], [No],
  ),
  caption: [Confronto algoritmi di ordinamento]
)

#note[
  - Gli algoritmi basati su confronti hanno limite inferiore $Omega(n log n)$
  - Counting Sort, Radix Sort e Bucket Sort possono essere lineari ma richiedono ipotesi aggiuntive sull'input
  - La scelta dell'algoritmo dipende dalle caratteristiche dei dati e dai vincoli di spazio
]
