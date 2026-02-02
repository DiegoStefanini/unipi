#import "../template.typ": *

=== Divide et Impera

Il #underline[Divide et Impera] è un paradigma di programmazione adottato da molti algoritmi ricorsivi:
- Si #underline[divide] il problema da risolvere in 2 o più sotto-problemi #underline[dello stesso tipo], ma che operano su un numero minore di dati (sottoinsieme di problema iniziale)
- Si #underline[risolvono] i sottoproblemi in modo ricorsivo, con la stessa tecnica, o direttamente se si sono raggiunti i casi limite di dimensione minima del problema.
- Si #underline[combinano] le soluzioni dei sottoproblemi per ottenere la soluzione del problema originale

#figure(
  image("../images/divide_et_impera.png", width: 50%),
)

=== Ricerca Binaria

=== Codice e complessità

#example(title: "ricerca binaria")[
  ```
  int binarySearch(int[] A, int p, int r, int k){
      if(p > r){
          return -1;
      }
      if(p == r){
          if(A[p] == k){
              return p;
          } else {
              return -1;
          }
      }
      int q = (p + r) / 2;
      if(A[q] == k){
          return q;
      }
      if(A[q] > k){
          return binarySearch(A, p, q - 1, k);
      } else {
          return binarySearch(A, q + 1, r, k);
      }
  }
  ```

  La relazione di ricorrenza è
  $ T(n) = cases(
    Theta(1) & n <= 1,
    T(n/2) + Theta(1) & n >= 2
  ) $

  $f(n) = C(n) + D(n)$ = combine + divide

  La complessità in tempo è $O(log n)$
]

=== Correttezza

Tipicamente si dimostra per induzione sulla dimensione $n$ del problema:
- *Caso base*: $n = 0, n = 1, ... n <= n_0$ si dimostra che l'algoritmo è corretto nelle condizioni dei casi base in modo diretto.
- *Caso induttivo*: Si assume, per ipotesi induttiva, che le soluzioni dei sottoproblemi siano corrette (ovvero che l'algoritmo è corretto $forall n'$ $n_0 < n' < n$ e si dimostra che di conseguenza è corretto per n

=== Merge Sort

#example(title: "Merge Sort")[
  ```
  mergeSort(int[] A, int p, int r){        // -- T(n)
      if(p < r){                           // -- θ(1)
          int q = (p + r) / 2;             // divide -- θ(1)
          mergeSort(A, p, q);              // impera -- T(n/2)
          mergeSort(A, q + 1, r);          // impera -- T(n/2)
          merge(A, p, q, r);               // combine -- θ(n)
      }
  }
  ```

  La relazione di ricorrenza dell'algoritmo è definita nel seguente modo:
  $ T(n) = cases(
    theta(1) & n = 1,
    2T(n/2) + theta(n) & n > 2
  ) $

  La complessità in tempo in ogni caso è $O(n log n)$
]

#figure(
  image("../images/merge_sort.png", width: 30%),
)

#note[
  La relazione di ricorrenza è la definizione matematica di un processo, descrive il numero di operazioni di un algoritmo ricorsivo in funzione del suo input. La complessità in tempo invece è la misurazione asintotica di tale relazione

  #figure(
    image("../images/albero_ricorsione_merge_sort.png", width: 25%),
  )
]

#figure(
  image("../images/chiamate_ricorsive_albero_ms.png", width: 30%),
)

```
merge(int[] A, int p, int q, int r){
    int n1 = q - p + 1;
    int n2 = r - q;
    int[] L = new int[n1 + 1];
    int[] R = new int[n2 + 1];

    int i = 1;
    while(i <= n1){
        L[i] := A[p + i - 1];
        i := i + 1;
    }
    int j = 1;
    while(j <= n2){
        R[j] := A[q + j];
        j := j + 1;
    }
    L[n1 + 1] := +∞;
    R[n2 + 1] := +∞;

    i := 1;
    j := 1;
    int k = p;
    while(k <= r){
        if(L[i] <= R[j]){
            A[k] := L[i];
            i := i + 1;
        } else {
            A[k] := R[j];
            j := j + 1;
        }
        k := k + 1;
    }
}
```

#note[
  La complessità di Merge è lineare
]

#note[
  In merge vengono utilizzati array di appoggio.
]

Per concludere la complessità in tempo del MergeSort è $theta(n log n)$ e la complessità in spazio è $O(n)$

=== Relazioni di ricorrenza

Le relazioni di ricorrenza servono a descrivere la complessità $T(n)$ di algoritmi ricorsivi.

- *Relazioni bilanciate*:
  $ T(n) = cases(
    theta(1) & n <= n_0,
    underbrace(a T(n/b), a in bb(N)^+ and b > 1\, b in bb(Q)) + underbrace(f(n), "forzante") & n > n_0
  ) $

- *Relazioni di ordine k*:
  $ T(n) = cases(
    theta(1) & n <= n_0,
    alpha_1 T(n-1) + ... + alpha_k T(n-k) & n > n_0
  ) $

Il caso generale è:
$ T(n) = cases(
  theta(1) & n <= n_0,
  alpha_1 T(n_1) + ... + alpha_k T(n-k) + f(n) & n > n_0
) $

#note[
  Merge Sort e ricerca binaria sono relazioni bilanciate
]

=== Risoluzione relazioni di equivalenza

+ Metodo iterativo: si sviluppa la ricorrenza fino ai casi base
+ Metodo di sostituzione: si ipotizza una soluzione e la si dimostra per induzione
+ Albero di ricorsione: ausilio grafico che rappresenta i costi ai vari livelli della ricorsione
+ Teorema principale per le relazioni di ricorrenza bilanciate

=== Master Theorem

Con
$ T(n) = cases(
  theta(1) & n <= n_0,
  a T(n/b) + f(n) & n > n_0
) $

Assumiamo che $a >= 1$ e $b > 1$ e $f(n) > 0$, allora abbiamo che se:

+ $exists epsilon > 0 : f(n) = O(n^(log_b a - epsilon)) arrow.double T(n) = theta(n^(log_b a))$

+ $f(n) = theta(n^(log_b a)) arrow.double T(n) = theta(n^(log_b a) times log n)$

+ $exists epsilon > 0 : f(n) = Omega(n^(log_b a + epsilon)), exists c < 1 : a f(n/b) <= c f(n) arrow.double T(n) = theta(f(n))$

Il secondo caso possiamo enunciarlo più generalmente nel seguente modo:
$ exists k >= 0 : f(n) = theta(n^(log_b a) times log^k n) arrow.double T(n) = theta(n^(log_b a) times log^(k+1) n) $

==== Esempi di applicazione del Master Theorem

#example(title: "Caso 1: Ricerca binaria")[
  $T(n) = T(n/2) + Theta(1)$

  Parametri: $a = 1$, $b = 2$, $f(n) = Theta(1)$

  Calcoliamo $n^(log_b a) = n^(log_2 1) = n^0 = 1$

  Confronto: $f(n) = Theta(1) = Theta(n^0)$

  $arrow.double$ *Caso 2*: $f(n) = Theta(n^(log_b a))$

  *Soluzione*: $T(n) = Theta(n^0 dot log n) = Theta(log n)$
]

#example(title: "Caso 2: Merge Sort")[
  $T(n) = 2T(n/2) + Theta(n)$

  Parametri: $a = 2$, $b = 2$, $f(n) = Theta(n)$

  Calcoliamo $n^(log_b a) = n^(log_2 2) = n^1 = n$

  Confronto: $f(n) = Theta(n) = Theta(n^(log_b a))$

  $arrow.double$ *Caso 2*: $f(n) = Theta(n^(log_b a))$

  *Soluzione*: $T(n) = Theta(n dot log n) = Theta(n log n)$
]

#example(title: "Caso 1: Algoritmo ipotetico")[
  $T(n) = 4T(n/2) + n$

  Parametri: $a = 4$, $b = 2$, $f(n) = n$

  Calcoliamo $n^(log_b a) = n^(log_2 4) = n^2$

  Confronto: $f(n) = n = O(n^(2 - epsilon))$ con $epsilon = 1$

  $arrow.double$ *Caso 1*: $f(n) = O(n^(log_b a - epsilon))$

  *Soluzione*: $T(n) = Theta(n^2)$
]

#example(title: "Caso 3: Algoritmo ipotetico")[
  $T(n) = T(n/2) + n$

  Parametri: $a = 1$, $b = 2$, $f(n) = n$

  Calcoliamo $n^(log_b a) = n^(log_2 1) = n^0 = 1$

  Confronto: $f(n) = n = Omega(n^(0 + epsilon))$ con $epsilon = 1$

  Verifica condizione regolarità: $a dot f(n/b) = 1 dot n/2 = n/2 <= c dot n$ per $c = 1/2$

  $arrow.double$ *Caso 3*: $f(n) = Omega(n^(log_b a + epsilon))$

  *Soluzione*: $T(n) = Theta(n)$
]

#note(title: "Come scegliere il caso")[
  + Calcola $n^(log_b a)$
  + Confronta $f(n)$ con $n^(log_b a)$:
    - $f(n)$ cresce *più lentamente* → Caso 1
    - $f(n)$ cresce *allo stesso modo* → Caso 2
    - $f(n)$ cresce *più velocemente* → Caso 3 (verifica regolarità!)
]

=== Limiti inferiori alla difficoltà di un problema

Dato un problema $pi$, la complessità al caso pessimo (in funzione della dimensione dell'input e asintotica) del miglior algoritmo che risolve $pi$ misura la difficoltà di $pi$. Un algoritmo che risolve $pi$ fornisce un limite superiore alla difficoltà di $pi$.

#definition(title: "Limite inferiore per " + $pi$)[
  $L(n) arrow.double forall$ algoritmo $A$ che risolve $pi$ con $T_A (n) in Omega(L(n))$ (al caso pessimo).
  $L(n)$ è il numero minimo di operazioni che sono necessarie per risolvere $pi$ al caso peggiore
]

=== Criteri

==== Dimensione dell'input

Se la soluzione di un problema richiede l'esame di tutti i dati, allora la dimensione dell'input $n$ è un limite inferiore: $L(n) = Omega(n)$

#example[
  La ricerca max in un vettore non ordinato deve necessariamente analizzare tutti gli $n$ elementi. ($L(n) = n$) (limite inferiore n).
]

#note[
  La scansione lineare è un algoritmo che ha complessità lineare (limite superiore n). Un algoritmo di questo tipo è ottimo, e il limite inferiore lineare è significativo.
]

==== Albero di decisione

Criterio per stabilire un limite inferiore alla difficoltà di un problema $pi$ che si applica a problemi risolvibili attraverso una sequenza di "decisioni" (es. confronti tra valori) che via via riducono lo spazio delle soluzioni

#note[
  Il caso pessimo di un algoritmo è la lunghezza max di radice-foglia (altezza dell'albero).
]

#note[
  Se $"SOL"(n)$ è il numero di possibili soluzioni di $pi$, allora $log("SOL"(n))$ è un limite inferiore per $pi$
]

Il percorso radice-foglia è una possibile esecuzione: il percorso più breve è il caso ottimo; il percorso più lungo è il caso pessimo.

#note[
  Un albero bilanciato è un albero che ha caso ottimo coincidente con il caso pessimo.
]

#definition(title: "altezza albero")[
  Altezza di un albero è la lunghezza del più lungo percorso dalla radice ad una foglia.
]

#note[
  In un albero binario l'altezza minima $>= log_2 (\#"foglie")$
]

#definition(title: "Albero bilanciato")[
  albero bilanciato $arrow.l.r.double$ altezza $in theta(log n)$, $theta(n)$ nodi e foglie
]

#note[
  $log("SOL"(n)) = log(\#"foglie")$ è l'altezza minore che ci possa essere, ovvero è la complessità al caso pessimo del miglior algoritmo. L'algoritmo migliore al caso pessimo è quello che minimizza l'altezza dell'albero di decisione $arrow.double$ è quello che ha altezza logaritmica rispetto al numero di foglie
]

==== Eventi Contabili

Se la ripetizione di un certo evento è indispensabile per risolvere $pi$, allora (\# volte che si deve ripetere $times$ costo evento) è un limite inferiore.

#figure(
  image("../images/oss_da_sistemare.png", width: 100%),
)
