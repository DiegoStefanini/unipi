#import "../template.typ": *

=== QuickSort

Il QuickSort è un algoritmo di ordinamento basato sul paradigma Divide et Impera, inventato da Tony Hoare nel 1960. È uno degli algoritmi di ordinamento più utilizzati nella pratica.

=== Idea dell'algoritmo

L'idea chiave è quella di scegliere un elemento detto *pivot* e partizionare l'array in modo che:
- tutti gli elementi minori o uguali al pivot siano a sinistra
- tutti gli elementi maggiori del pivot siano a destra

Successivamente si applica ricorsivamente lo stesso procedimento alle due partizioni.

=== Algoritmo QuickSort

```
quickSort(int[] A, int p, int r){
    if(p < r){
        int q = partition(A, p, r);   // divide
        quickSort(A, p, q - 1);       // impera
        quickSort(A, q + 1, r);       // impera
    }
}
```

#note[
  A differenza del MergeSort, nel QuickSort:
  - Il lavoro principale è nella fase di *divide* (Partition)
  - La fase di *combine* è banale (non serve fare nulla)
]

=== Procedura Partition

La procedura Partition riorganizza l'array $A[p..r]$ in loco, restituendo l'indice $q$ tale che:
- $A[q]$ contiene il pivot
- $A[p..q-1]$ contiene elementi $<= A[q]$
- $A[q+1..r]$ contiene elementi $> A[q]$

```
int partition(int[] A, int p, int r){
    int x = A[r];              // pivot (ultimo elemento)
    int i = p - 1;             // indice "bordo" partizione sinistra
    int j = p;
    while(j <= r - 1){
        if(A[j] <= x){
            i := i + 1;
            // swap(A[i], A[j])
            int temp = A[i];
            A[i] := A[j];
            A[j] := temp;
        }
        j := j + 1;
    }
    // swap(A[i+1], A[r]) - metti pivot in posizione finale
    int temp = A[i + 1];
    A[i + 1] := A[r];
    A[r] := temp;
    return i + 1;
}
```

=== Invariante di Partition

All'inizio di ogni iterazione del ciclo `for`:
+ Per ogni $k in [p, i]$: $A[k] <= x$ (pivot)
+ Per ogni $k in [i+1, j-1]$: $A[k] > x$
+ $A[r] = x$ (il pivot)

=== Correttezza di Partition

#demonstration[
  Si dimostra per induzione sul numero di iterazioni:
  - *Caso base* ($j = p$): le regioni $[p,i]$ e $[i+1, j-1]$ sono vuote, l'invariante è banalmente vero.
  - *Passo induttivo*: assumiamo l'invariante vero prima dell'iterazione $j$-esima.
    - Se $A[j] > x$: incrementiamo solo $j$, la regione degli elementi $> x$ si estende
    - Se $A[j] <= x$: incrementiamo $i$, scambiamo $A[i]$ con $A[j]$, la regione degli elementi $<= x$ si estende
]

=== Complessità di Partition

La procedura Partition ha complessità $Theta(n)$ dove $n = r - p + 1$ è il numero di elementi da partizionare.

=== Analisi di QuickSort

La complessità di QuickSort dipende dal bilanciamento delle partizioni.

=== Caso Pessimo

Il caso pessimo si verifica quando le partizioni sono sempre massimamente sbilanciate:
- Una partizione ha $n-1$ elementi
- L'altra ha $0$ elementi

Questo accade quando l'array è già ordinato (o inversamente ordinato) e scegliamo sempre il primo o l'ultimo elemento come pivot.

$ T(n) = T(n-1) + T(0) + Theta(n) = T(n-1) + Theta(n) $

Risolvendo la ricorrenza:
$ T(n) = sum_(k=1)^n Theta(k) = Theta(n^2) $

#note[
  Nel caso pessimo QuickSort ha la stessa complessità degli algoritmi quadratici come Insertion Sort!
]

=== Caso Ottimo

Il caso ottimo si verifica quando le partizioni sono sempre perfettamente bilanciate:
- Ogni partizione ha circa $n/2$ elementi

$ T(n) = 2T(n/2) + Theta(n) $

Per il Master Theorem (caso 2 con $a=2$, $b=2$, $f(n)=Theta(n)$):
$ T(n) = Theta(n log n) $

=== Caso Medio

#theorem(title: "Complessità media di QuickSort")[
  Se tutte le permutazioni dell'input sono equiprobabili, la complessità attesa di QuickSort è $Theta(n log n)$.
]

L'intuizione è che anche partizioni moderatamente sbilanciate (es. 9:1) producono alberi di ricorsione con altezza $O(log n)$.

=== QuickSort Randomizzato

Per evitare il caso pessimo su input "cattivi", si può randomizzare la scelta del pivot.

```
int randomizedPartition(int[] A, int p, int r){
    int i = random(p, r);      // scegli pivot casuale
    // swap(A[i], A[r]) - mettilo in fondo
    int temp = A[i];
    A[i] := A[r];
    A[r] := temp;
    return partition(A, p, r);
}

randomizedQuickSort(int[] A, int p, int r){
    if(p < r){
        int q = randomizedPartition(A, p, r);
        randomizedQuickSort(A, p, q - 1);
        randomizedQuickSort(A, q + 1, r);
    }
}
```

#definition(title: "Complessità attesa")[
  Il numero atteso di confronti di RandomizedQuickSort è $O(n log n)$, indipendentemente dall'input.
]

=== Analisi del numero atteso di confronti

Siano $z_1, z_2, ..., z_n$ gli elementi di $A$ in ordine crescente.

Definiamo $X_(i j)$ come variabile indicatrice:
$ X_(i j) = cases(
  1 & "se" z_i "e" z_j "vengono confrontati",
  0 & "altrimenti"
) $

Il numero totale di confronti è:
$ X = sum_(i=1)^(n-1) sum_(j=i+1)^n X_(i j) $

#theorem(title: "Probabilità di confronto")[
  $ P(X_(i j) = 1) = frac(2, j - i + 1) $

  Questo perché $z_i$ e $z_j$ vengono confrontati se e solo se uno dei due è il primo elemento scelto come pivot nell'insieme ${z_i, z_(i+1), ..., z_j}$.
]

Quindi:
$ E[X] = sum_(i=1)^(n-1) sum_(j=i+1)^n frac(2, j-i+1) = O(n log n) $

=== Moltiplicazione veloce di interi

Un'applicazione importante del Divide et Impera è la moltiplicazione di interi di lunghezza arbitraria.

=== Metodo tradizionale

La moltiplicazione "delle elementari" di due numeri di $n$ cifre richiede $Theta(n^2)$ operazioni.

=== Algoritmo di Karatsuba

Siano $X$ e $Y$ due numeri di $n$ cifre (assumiamo $n$ potenza di 2). Scriviamo:
$ X = X_1 dot 10^(n/2) + X_0 $
$ Y = Y_1 dot 10^(n/2) + Y_0 $

dove $X_1, X_0, Y_1, Y_0$ hanno $n/2$ cifre.

Il prodotto $X dot Y$ è:
$ X dot Y = X_1 Y_1 dot 10^n + (X_1 Y_0 + X_0 Y_1) dot 10^(n/2) + X_0 Y_0 $

Questo richiede 4 moltiplicazioni di numeri di $n/2$ cifre.

#note[
  L'idea di Karatsuba è ridurre le moltiplicazioni da 4 a 3:
  $ X_1 Y_0 + X_0 Y_1 = (X_1 + X_0)(Y_1 + Y_0) - X_1 Y_1 - X_0 Y_0 $
]

=== Algoritmo

```
int karatsuba(int X, int Y, int n){
    if(n <= n0){
        return X * Y;  // moltiplicazione diretta
    }

    // Dividi
    int X1 = X / pow(10, n/2);
    int X0 = X % pow(10, n/2);
    int Y1 = Y / pow(10, n/2);
    int Y0 = Y % pow(10, n/2);

    // Impera (3 moltiplicazioni ricorsive)
    int P1 = karatsuba(X1, Y1, n/2);
    int P2 = karatsuba(X0, Y0, n/2);
    int P3 = karatsuba(X1 + X0, Y1 + Y0, n/2);

    // Combina
    return P1 * pow(10, n) + (P3 - P1 - P2) * pow(10, n/2) + P2;
}
```

=== Complessità

La relazione di ricorrenza è:
$ T(n) = 3T(n/2) + Theta(n) $

Per il Master Theorem (caso 1 con $a=3$, $b=2$, $log_2 3 approx 1.585$):
$ T(n) = Theta(n^(log_2 3)) approx Theta(n^1.585) $

#note[
  Il miglioramento da $n^2$ a $n^1.585$ è significativo per numeri molto grandi (es. crittografia RSA).
]

=== Confronto algoritmi di ordinamento

#figure(
  table(
    columns: 4,
    [*Algoritmo*], [*Caso Ottimo*], [*Caso Medio*], [*Caso Pessimo*],
    [Insertion Sort], [$Theta(n)$], [$Theta(n^2)$], [$Theta(n^2)$],
    [Selection Sort], [$Theta(n^2)$], [$Theta(n^2)$], [$Theta(n^2)$],
    [Merge Sort], [$Theta(n log n)$], [$Theta(n log n)$], [$Theta(n log n)$],
    [QuickSort], [$Theta(n log n)$], [$Theta(n log n)$], [$Theta(n^2)$],
    [QuickSort Rand.], [$Theta(n log n)$], [$Theta(n log n)$], [$Theta(n log n)$#super[\*]],
  ),
  caption: [#super[\*] atteso]
)
