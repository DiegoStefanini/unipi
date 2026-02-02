#import "../template.typ": *

=== Complessità in tempo

#definition(title: "Algoritmo")[
  Sequenza finita di operazioni elementari (passi) univocamente determinati (non ambiguo, né operazione né la sequenza) che, se eseguita su un calcolatore, porta alla risoluzione di un problema.
]

#definition(title: "Modello \"RAM\"")[
  hanno costo unitario (costante):
  - operazioni aritmetiche: $+, -, times, div, %$
  - operazioni di confronto: $<, >, ==, !=, ...$
  - operazioni logiche: $and, or, not, ...$
  - operazioni di trasferimento: load, store, read, assegnamento
  - operazioni di controllo: Return, chiamata di funzione
]

=== Esempi

=== Minimo in vettore

Input: array $A[1..n]$ di interi \
Output: $i : 1 <= i <= n$ con $A[i]$ che è il valore più piccolo di $A$.

```
int min(int[] A, int n){
    int min = A[1];
    int i = 2;
    while(i <= n){
        if(A[i] < min){
            min := A[i];
        }
        i := i + 1;
    }
    return min;
}
```

Nel codice tutte le operazioni eseguite rientrano nei tipi di tempo di esecuzione costante. L'unica cosa che determina il tempo di esecuzione è il ciclo for, che è determinato dalla lunghezza dell'input. Il costo in tempo viene così definito: costante + (n-1) \* costante + costante. Si dice allora che la complessità è asintotica in tempo in funzione della dimensione dell'input ($n = |A|$)

=== Cerca-K

Input: $A[1..n]$ di interi, $k$ intero. \
Output: min $i : A[i] = k$ oppure $-1$ se $k in.not A$

```
int cercaK(int[] A, int n, int k){
    int i = 1;
    bool trovato = false;
    while((!trovato) && (i <= n)){
        if(A[i] == k){
            trovato := true;
        } else {
            i := i + 1;
        }
    }
    if(trovato){
        return i;
    } else {
        return -1;
    }
}
```

La complessità in tempo dipende da dove si trova $k$ all'interno dell'input. Nel migliore dei casi è costante ($A[1] = k$), nel peggiore dei casi invece è lineare in $n$ ($exists.not k$)

=== Costo computazionale di un algoritmo A

- *Tempo* $T_A (n)$: numero di operazioni elementari (passi) che esegue $A$, dipende dall'istanza di $I$:
  - Caso pessimo
  - Caso ottimo
- *Spazio*: numero di celle di memoria utilizzate durante l'esecuzione di $A$ (anche quelle occupate dall'input)
- in funzione della *dimensione dell'input*

Ci concentreremo sulla complessità in tempo cercando di minimizzarla e, a parità di costo in tempo, cerchiamo di ridurre anche lo spazio.

Ci interessiamo al caso pessimo perché è un limite superiore al costo.

Ci interessiamo all'ordine di grandezza della funzione $T_A (n)$

#example[
  $ T(n) = 3n + 2 $
  costante moltiplicativa + termine di ordine inferiore \
  $arrow.b$ \
  $T(n)$ ha ordine di grandezza lineare
]

#example[
  $ T(n) = 8n^2 + log n + 4 $
  termine quadratico + termini di ordine inferiore \
  $arrow.b$ \
  $T(n)$ ha complessità quadratica
]

=== Insertion Sort

L'insertion sort è un algoritmo di ordinamento con risoluzione con metodo iterativo.

Input: Array $A$ di $n$ numeri interi. \
Output: $A$ ordinato: $A[1] <= A[2] <= ... <= A[n]$

```
insertionSort(int[] A, int n){
    int j = 2;
    while(j <= n){
        int k = A[j];
        int i = j - 1;
        while((i > 0) && (A[i] > k)){
            A[i + 1] := A[i];
            i := i - 1;
        }
        A[i + 1] := k;
        j := j + 1;
    }
}
```

=== Dimostrazione di correttezza con invariante di ciclo

L'invariante di ciclo è una proprietà conservata ad ogni iterazione di algoritmo. Ad ogni iterazione $j^("esima")$ del `for`:
- il sottoarray $A[1..j-1]$ è ordinato
- il sottoarray (ordinato) $A[1..j-1]$ contiene gli stessi elementi che stavano in $A[1...j-1]$ iniziale.

Con queste due affermazioni possiamo dire che l'insertion sort è corretto.

=== Complessità

$T(n) = (n-1) (C_1 times "numero esecuzioni while con guardia vera + while con guardia falsa" + C_5)$

- *Caso ottimo*: $d_j = 1$ $forall j = 2..n arrow.double c(n) = sum_(j=2)^n 1 = n - 1$ \
  Array in input già ordinato, il corpo del while non viene mai eseguito, quindi $c(n) = n - 1 arrow.double \#$ confronti lineari.

- *Caso pessimo*: $d_j = j - 1$ $forall j = 2..n arrow.double c(n) = sum_(j=2)^n j - 1 = sum_(j'=1)^(n-1) j' = frac(n(n-1), 2)$ \
  Array in input ordinato in ordine inverso. $C(n) = frac(n(n-1), 2) = binom(n, 2) arrow.double \#$ confronti quadratico in $n$

Per riassumere:
- lineare in caso ottimo
- quadratico in caso pessimo

=== Selection Sort

Il selection sort è un altro algoritmo di ordinamento iterativo al passo $i^("esimo")$ $forall i = 1...n-1$.

```
selectionSort(int[] A, int n){
    int i = 1;
    while(i <= n - 1){
        int min = i;
        int j = i + 1;
        while(j <= n){
            if(A[j] < A[min]){
                min := j;
            }
            j := j + 1;
        }
        // swap(A[i], A[min])
        int temp = A[i];
        A[i] := A[min];
        A[min] := temp;
        i := i + 1;
    }
}
```

=== Complessità

$T(n) = (n-1)(c_1 + (n-1)c_2)$

$\# "confronti" = c(n) = sum_(i=1)^(n-1) times sum_(j=i+1)^n 1 = sum_(i=1)^(n-1) (n-i) = (n-1) + (n-2) + ... + frac(n(n-1), 2) =$ complessità quadratica.

=== Invariante di ciclo

#definition(title: "Invariante di ciclo")[
  Un *invariante di ciclo* è una proprietà che:
  + È vera *prima* della prima iterazione (*inizializzazione*)
  + Se è vera prima di un'iterazione, rimane vera dopo (*mantenimento*)
  + Quando il ciclo termina, l'invariante fornisce una proprietà utile (*terminazione*)
]

==== Dimostrazione completa: Selection Sort

*Invariante*: All'inizio della $i$-esima iterazione:
- I primi $i - 1$ elementi di $A$ sono ordinati
- Questi $i - 1$ elementi sono i più piccoli dell'array originale

#demonstration[
  *Inizializzazione* ($i = 1$):
  - I "primi $0$ elementi" sono banalmente ordinati (insieme vuoto)
  - L'invariante è verificato

  *Mantenimento*: Supponiamo l'invariante vero per $i$. Dimostriamo che vale per $i + 1$.
  - Il ciclo interno trova il minimo tra $A[i], A[i+1], ..., A[n]$
  - Questo minimo viene scambiato con $A[i]$
  - Ora $A[1..i]$ contiene gli $i$ elementi più piccoli, ordinati
  - L'invariante vale per $i + 1$

  *Terminazione* ($i = n$):
  - I primi $n - 1$ elementi sono i più piccoli e sono ordinati
  - L'elemento in $A[n]$ è quindi il più grande
  - L'intero array è ordinato $square$
]

==== Dimostrazione completa: Insertion Sort

*Invariante*: All'inizio dell'iterazione $j$-esima, il sottoarray $A[1..j-1]$ contiene gli elementi originali di $A[1..j-1]$, in ordine crescente.

#demonstration[
  *Inizializzazione* ($j = 2$):
  - $A[1..1]$ contiene un solo elemento
  - Un singolo elemento è banalmente ordinato $checkmark$

  *Mantenimento*: Supponiamo vero per $j$. Il ciclo interno:
  - Prende $A[j]$ come chiave
  - Sposta a destra gli elementi di $A[1..j-1]$ maggiori della chiave
  - Inserisce la chiave nella posizione corretta
  - Ora $A[1..j]$ è ordinato, quindi l'invariante vale per $j + 1$

  *Terminazione* ($j = n + 1$):
  - L'invariante dice che $A[1..n]$ è ordinato
  - Questo è esattamente quello che volevamo dimostrare $square$
]

#note(title: "Struttura di una dimostrazione con invariante")[
  + Identificare l'invariante (cosa rimane vero ad ogni iterazione)
  + *Inizializzazione*: verificare prima del ciclo
  + *Mantenimento*: assumere vero all'iterazione $k$, dimostrare per $k+1$
  + *Terminazione*: usare l'invariante + condizione di uscita per dimostrare la correttezza
]

=== Notazione Asintotica

La notazione asintotica serve per descrivere come cresce il tempo di esecuzione di un algoritmo quando l'input diventa molto grande.

$T(n)$: la #underline[complessità asintotica] di un algoritmo:
- per $n$ molto grandi
- a meno di costanti moltiplicative
- a meno di termini di ordine inferiore

Il costo sia in tempo che in spazio si descrivono in un ordine di grandezza.

#example[
  $ T(n) = 3n^2 + 2n + 5 + log n $
  $T(n)$ è una funzione quadratica in $n$, i termini di ordine inferiore vengono ignorati.
]

#example[
  $T(n) = 7n + 24$ è lineare in $n$
]

#example[
  $T(n) = 5$ è costante
]

#example[
  $T(n) = log_3 n + 2$ è logaritmica in $n$
]

#note[
  Gli ordini di grandezza sono insiemi infiniti che includono tutte le funzioni che, rispetto ad una data funzione $g(n)$, hanno un certo comportamento asintotico.
  $ mat(delim: "[", f(n), "la \"nostra\" funzione"; g(n), "la funzione di riferimento") $
]

=== Notazione $Theta$ - limite asintotico stretto

$ Theta(g(n)) = {f(n) | exists c_1, c_2, n_0 > 0 : forall n >= n_0, 0 <= c_1 g(n) <= f(n) <= c_2 g(n)} $

Si dice che $g(n)$ è un #underline[limite asintotico stretto] per $f(n)$

Si scrive $f(n) in Theta(g(n))$ oppure $f(n) = Theta(g(n))$

Si legge "$f(n)$ è in theta di $g(n)$"

#figure(
  image("../images/big_theta.jpg", width: 25%),
)

#note[
  Al crescere di $n$, da un certo punto in poi ($n_0$), la funzione $f(n)$ è compresa in una fascia delimitata da $c_1 g(n)$ e $c_2 g(n)$
]

=== Notazione $O$ - limite asintotico superiore

$ O(g(n)) = {f(n) | exists c, n_0 > 0 : forall n >= n_0, 0 <= f(n) <= c g(n)} $

Si dice $g(n)$ è un #underline[limite asintotico superiore] per $f(n)$

Si scrive $f(n) in O(g(n))$ o $f(n) = O(g(n))$

Si legge "$f(n)$ è in O grande di $g(n)$"

#figure(
  image("../images/big_o.jpg", width: 25%),
)

#note[
  Al crescere di $n$, la funzione $f(n)$ non supera mai $c g(n)$
]

=== Notazione $Omega$ - limite asintotico inferiore

$ Omega(g(n)) = {f(n) | exists c, n_0 > 0 : forall n >= n_0, 0 <= c g(n) <= f(n)} $

Si dice $g(n)$ è un #underline[limite asintotico inferiore] di $f(n)$

Si scrive $f(n) in Omega(g(n))$ o $f(n) = Omega(g(n))$

Si legge "$f(n)$ è in Omega Grande di $g(n)$"

#figure(
  image("../images/big_omega.jpg", width: 25%),
)
