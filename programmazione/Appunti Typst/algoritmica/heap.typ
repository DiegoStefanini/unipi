#import "../template.typ": *

=== Heap e Heapsort

=== Definizione di Heap

#definition(title: "Heap")[
  Un *heap* (binario) è un albero binario quasi completo che soddisfa la *proprietà di heap*:
  - *Max-Heap*: per ogni nodo $i$ diverso dalla radice: $A["Parent"(i)] >= A[i]$
  - *Min-Heap*: per ogni nodo $i$ diverso dalla radice: $A["Parent"(i)] <= A[i]$
]

#definition(title: "Albero binario quasi completo")[
  Un albero binario è *quasi completo* se tutti i livelli sono completamente riempiti, eccetto eventualmente l'ultimo che è riempito da sinistra a destra.
]

=== Proprietà

- L'elemento massimo (in un max-heap) è sempre nella radice
- L'altezza di un heap con $n$ elementi è $Theta(log n)$
- Un heap con $n$ elementi ha al massimo $ceil(n / 2^(h+1))$ nodi a altezza $h$

=== Realizzazione implicita come Array

Un heap può essere rappresentato efficientemente come un array $A$ dove:
- $A[1]$ è la radice
- Per un nodo in posizione $i$:
  - *Parent*: $floor(i / 2)$
  - *Left child*: $2i$
  - *Right child*: $2i + 1$

```
int parent(int i){ return i / 2; }
int left(int i)  { return 2 * i; }
int right(int i) { return 2 * i + 1; }
```

#note[
  Questa rappresentazione è molto efficiente:
  - Non servono puntatori (risparmio di spazio)
  - Navigazione padre/figli in $O(1)$
  - Cache-friendly (elementi consecutivi in memoria)
]

#example[
  Array: $[16, 14, 10, 8, 7, 9, 3, 2, 4, 1]$

  Rappresenta un max-heap dove:
  - Radice = 16
  - Figli di 16: 14 (sinistro), 10 (destro)
  - Figli di 14: 8, 7
  - Figli di 10: 9, 3
  - ...
]

=== Max-Heapify

La procedura `Max-Heapify` ripristina la proprietà di max-heap su un sottoalbero, assumendo che i sottoalberi sinistro e destro siano già max-heap.

```
maxHeapify(int[] A, int i, int heapsize){
    int l = left(i);
    int r = right(i);
    int largest = i;

    // Trova il massimo tra A[i], A[l], A[r]
    if((l <= heapsize) && (A[l] > A[i])){
        largest := l;
    }

    if((r <= heapsize) && (A[r] > A[largest])){
        largest := r;
    }

    // Se il massimo non è il nodo corrente, scambia e ricorri
    if(largest != i){
        int temp = A[i];
        A[i] := A[largest];
        A[largest] := temp;
        maxHeapify(A, largest, heapsize);
    }
}
```

=== Correttezza

#demonstration[
  Per induzione sull'altezza del nodo $i$:
  - *Caso base* (altezza 0, foglia): non c'è nulla da fare
  - *Passo induttivo*: se $A[i]$ viola la proprietà, lo scambiamo con il figlio maggiore. Dopo lo scambio, il sottoalbero radicato in quel figlio potrebbe violare la proprietà, ma ha altezza minore.
]

=== Complessità

$ T(n) = O(h) = O(log n) $

dove $h$ è l'altezza del nodo $i$. Nel caso pessimo, l'elemento "scende" fino alle foglie.

=== Build-Max-Heap

Costruisce un max-heap a partire da un array non ordinato.

```
buildMaxHeap(int[] A, int n){
    int heapsize = n;
    int i = n / 2;
    while(i >= 1){
        maxHeapify(A, i, heapsize);
        i := i - 1;
    }
}
```

#note[
  Partiamo da $floor(n/2)$ perché i nodi da $floor(n/2)+1$ a $n$ sono foglie e sono già heap (banalmente).
]

=== Correttezza

#definition(title: "Invariante di ciclo")[
  All'inizio di ogni iterazione del ciclo `for`, ogni nodo $i+1, i+2, ..., n$ è radice di un max-heap.
]

#demonstration[
  - *Inizializzazione*: Prima della prima iterazione ($i = floor(n/2)$), i nodi $floor(n/2)+1, ..., n$ sono foglie, quindi banalmente radici di max-heap.
  - *Mantenimento*: `Max-Heapify(A, i)` rende $i$ radice di un max-heap (i figli sono già radici di max-heap per l'invariante)
  - *Terminazione*: Quando $i = 0$, ogni nodo $1, 2, ..., n$ è radice di un max-heap. In particolare il nodo 1 (radice).
]

=== Complessità

==== Analisi naive

$O(n)$ chiamate a `Max-Heapify`, ognuna costa $O(log n)$, quindi $O(n log n)$.

==== Analisi più stretta

#theorem(title: "Complessità di Build-Max-Heap")[
  `Build-Max-Heap` ha complessità $Theta(n)$.
]

#demonstration[
  Un heap di $n$ elementi ha altezza $h = floor(log n)$.

  A ogni altezza $i$, ci sono al massimo $ceil(n / 2^(i+1))$ nodi.

  Il costo di `Max-Heapify` su un nodo a altezza $i$ è $O(i)$.

  Costo totale:
  $ sum_(i=0)^(floor(log n)) ceil(n / 2^(i+1)) dot O(i) = O(n sum_(i=0)^(floor(log n)) i / 2^i) $

  Usando $sum_(i=0)^infinity i / 2^i = 2$ (serie convergente):
  $ O(n dot 2) = O(n) $
]

=== Heapsort

L'algoritmo Heapsort sfrutta la struttura heap per ordinare un array.

```
heapsort(int[] A, int n){
    buildMaxHeap(A, n);
    int heapsize = n;
    int i = n;
    while(i >= 2){
        // swap(A[1], A[i]) - metti il max in fondo
        int temp = A[1];
        A[1] := A[i];
        A[i] := temp;

        heapsize := heapsize - 1;
        maxHeapify(A, 1, heapsize);  // ripristina heap
        i := i - 1;
    }
}
```

=== Idea

+ Costruisci un max-heap dall'array
+ Il massimo è in $A[1]$: scambialo con l'ultimo elemento
+ Riduci la dimensione dell'heap di 1
+ Ripristina la proprietà di max-heap sulla radice
+ Ripeti finché l'heap ha un solo elemento

=== Correttezza

#definition(title: "Invariante di ciclo")[
  All'inizio di ogni iterazione:
  - $A[1..i]$ è un max-heap contenente gli $i$ elementi più piccoli
  - $A[i+1..n]$ contiene gli $n-i$ elementi più grandi, ordinati
]

=== Complessità

$ T(n) = underbrace(O(n), "Build-Max-Heap") + underbrace((n-1) dot O(log n), "ciclo for") = O(n log n) $

#note[
  Heapsort:
  - Ha complessità $O(n log n)$ in *tutti* i casi
  - È *in-place* (non richiede memoria aggiuntiva)
  - Non è stabile (può cambiare l'ordine relativo di elementi uguali)
]

=== Code di Priorità

#definition(title: "Coda di priorità")[
  Una *coda di priorità* è una struttura dati che mantiene un insieme $S$ di elementi, ognuno con una *chiave* (priorità) associata, e supporta le seguenti operazioni:
  - `Insert(S, x)`: inserisce $x$ in $S$
  - `Maximum(S)`: restituisce l'elemento con chiave massima
  - `Extract-Max(S)`: rimuove e restituisce l'elemento con chiave massima
  - `Increase-Key(S, x, k)`: aumenta la chiave di $x$ al nuovo valore $k$
]

=== Applicazioni

- Scheduling di processi (priorità = importanza del processo)
- Simulazione di eventi discreti (priorità = tempo dell'evento)
- Algoritmo di Dijkstra (priorità = distanza stimata)
- Algoritmo di Prim per MST

=== Implementazione con Max-Heap

==== Maximum

```
int heapMaximum(int[] A){
    return A[1];
}
```
Complessità: $O(1)$

==== Extract-Max

```
int heapExtractMax(int[] A, int heapsize){
    if(heapsize < 1){
        // error "heap underflow"
        return -1;
    }
    int max = A[1];
    A[1] := A[heapsize];
    heapsize := heapsize - 1;
    maxHeapify(A, 1, heapsize);
    return max;
}
```
Complessità: $O(log n)$

==== Increase-Key

```
heapIncreaseKey(int[] A, int i, int key){
    if(key < A[i]){
        // error "nuova chiave minore della precedente"
        return;
    }
    A[i] := key;
    // Risali verso la radice finché necessario
    while((i > 1) && (A[parent(i)] < A[i])){
        int temp = A[i];
        A[i] := A[parent(i)];
        A[parent(i)] := temp;
        i := parent(i);
    }
}
```
Complessità: $O(log n)$

==== Insert

```
heapInsert(int[] A, int key, int heapsize){
    heapsize := heapsize + 1;
    A[heapsize] := -∞;
    heapIncreaseKey(A, heapsize, key);
}
```
Complessità: $O(log n)$

=== Riepilogo complessità

#figure(
  table(
    columns: 3,
    [*Operazione*], [*Heap*], [*Array non ordinato*],
    [`Maximum`], [$O(1)$], [$O(n)$],
    [`Extract-Max`], [$O(log n)$], [$O(n)$],
    [`Insert`], [$O(log n)$], [$O(1)$],
    [`Increase-Key`], [$O(log n)$], [$O(1)$],
  ),
  caption: [Confronto implementazioni code di priorità]
)

#note[
  Lo heap offre un buon compromesso: tutte le operazioni hanno costo logaritmico, mentre con un array non ordinato alcune operazioni sono costanti ma `Maximum` ed `Extract-Max` richiedono tempo lineare.
]
