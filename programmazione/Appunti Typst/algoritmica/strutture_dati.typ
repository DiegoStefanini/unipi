#import "../template.typ": *

=== Strutture Dati Lineari

Le strutture dati lineari sono collezioni di elementi organizzati in sequenza, dove ogni elemento (tranne il primo e l'ultimo) ha un predecessore e un successore.

=== Array

#definition(title: "Array")[
  Un *array* è una struttura dati che memorizza elementi dello stesso tipo in locazioni di memoria *contigue*. Ogni elemento è identificato da un *indice*.
]

=== Proprietà

- Accesso diretto in $O(1)$ tramite indice
- Dimensione fissa (in molti linguaggi)
- Elementi contigui in memoria (cache-friendly)

=== Operazioni e complessità

#figure(
  table(
    columns: 3,
    [*Operazione*], [*Descrizione*], [*Complessità*],
    [`Access(A, i)`], [Accedi all'elemento in posizione $i$], [$O(1)$],
    [`Search(A, x)`], [Cerca l'elemento $x$], [$O(n)$],
    [`Insert(A, i, x)`], [Inserisci $x$ in posizione $i$], [$O(n)$],
    [`Delete(A, i)`], [Elimina l'elemento in posizione $i$], [$O(n)$],
  ),
  caption: [Operazioni su array]
)

#note[
  L'inserimento e la cancellazione richiedono lo spostamento degli elementi successivi, da cui la complessità lineare.
]

=== Liste

#definition(title: "Lista concatenata")[
  Una *lista concatenata* è una struttura dati in cui gli elementi (nodi) sono collegati tramite *puntatori*. Ogni nodo contiene:
  - Un *dato* (o chiave)
  - Uno o più *puntatori* ad altri nodi
]

=== Lista semplicemente concatenata

Ogni nodo contiene un puntatore al nodo successivo.

```
// Struttura Nodo (lista semplice)
// key  : dato
// next : puntatore al nodo successivo
```

=== Lista doppiamente concatenata

Ogni nodo contiene puntatori sia al successore che al predecessore.

```
// Struttura Nodo (lista doppia)
// key  : dato
// next : puntatore al nodo successivo
// prev : puntatore al nodo precedente
```

#note[
  La lista doppiamente concatenata facilita la navigazione in entrambe le direzioni e semplifica alcune operazioni (come la cancellazione).
]

=== Operazioni su liste doppiamente concatenate

==== Ricerca

```
Node listSearch(List L, int k){
    Node x = L.head;
    while((x != NIL) && (x.key != k)){
        x := x.next;
    }
    return x;
}
```
Complessità: $O(n)$

==== Inserimento in testa

```
listInsert(List L, Node x){
    x.next := L.head;
    if(L.head != NIL){
        L.head.prev := x;
    }
    L.head := x;
    x.prev := NIL;
}
```
Complessità: $O(1)$

==== Cancellazione

```
listDelete(List L, Node x){
    if(x.prev != NIL){
        x.prev.next := x.next;
    } else {
        L.head := x.next;
    }

    if(x.next != NIL){
        x.next.prev := x.prev;
    }
}
```
Complessità: $O(1)$ (se abbiamo già il puntatore a $x$)

#note[
  Se dobbiamo prima cercare l'elemento, la cancellazione diventa $O(n)$.
]

=== Varianti

- *Lista circolare*: l'ultimo elemento punta al primo
- *Lista con sentinella*: un nodo fittizio semplifica la gestione dei casi limite (lista vuota, inserimento in testa/coda)

=== Confronto Array vs Liste

#figure(
  table(
    columns: 3,
    [*Operazione*], [*Array*], [*Lista*],
    [Accesso per indice], [$O(1)$], [$O(n)$],
    [Ricerca], [$O(n)$], [$O(n)$],
    [Inserimento in testa], [$O(n)$], [$O(1)$],
    [Inserimento in coda], [$O(1)$#super[\*]], [$O(1)$#super[\*\*]],
    [Cancellazione], [$O(n)$], [$O(1)$#super[\*\*\*]],
  ),
  caption: [#super[\*] se c'è spazio, #super[\*\*] se manteniamo un puntatore alla coda, #super[\*\*\*] se abbiamo il puntatore al nodo]
)

=== Pile (Stack)

#definition(title: "Pila")[
  Una *pila* (stack) è una struttura dati con politica *LIFO* (Last In, First Out): l'ultimo elemento inserito è il primo ad essere rimosso.
]

=== Operazioni

- `Push(S, x)`: inserisce $x$ in cima alla pila
- `Pop(S)`: rimuove e restituisce l'elemento in cima
- `Top(S)` o `Peek(S)`: restituisce l'elemento in cima senza rimuoverlo
- `IsEmpty(S)`: verifica se la pila è vuota

=== Implementazione su Array

```
// Pila implementata con array A[1..n]
// top = indice dell'elemento in cima (0 se vuota)

bool stackEmpty(Stack S){
    return S.top == 0;
}

push(Stack S, int x){
    S.top := S.top + 1;
    S[S.top] := x;
}

int pop(Stack S){
    if(stackEmpty(S)){
        // error "underflow"
        return -1;
    }
    S.top := S.top - 1;
    return S[S.top + 1];
}
```

=== Implementazione su Lista

```
// Pila implementata con lista concatenata
// head = puntatore all'elemento in cima

push(Stack S, Node x){
    x.next := S.head;
    S.head := x;
}

Node pop(Stack S){
    if(S.head == NIL){
        // error "underflow"
        return NIL;
    }
    Node x = S.head;
    S.head := S.head.next;
    return x;
}
```

=== Complessità

Tutte le operazioni hanno complessità $O(1)$.

=== Applicazioni

- Gestione delle chiamate di funzione (call stack)
- Valutazione di espressioni (notazione polacca inversa)
- Algoritmi di backtracking
- Undo/Redo in editor
- Bilanciamento delle parentesi

#example(title: "Bilanciamento parentesi")[
  Per verificare se una stringa di parentesi è bilanciata:
  ```
  bool isBalanced(char[] s, int n){
      Stack S = new Stack();
      int i = 0;
      while(i < n){
          char c = s[i];
          if((c == '(') || (c == '[') || (c == '{')){
              push(S, c);
          } else {
              if((c == ')') || (c == ']') || (c == '}')){
                  if(stackEmpty(S)){
                      return false;
                  }
                  char open = pop(S);
                  if(!match(open, c)){
                      return false;
                  }
              }
          }
          i := i + 1;
      }
      return stackEmpty(S);
  }
  ```
]

=== Code (Queue)

#definition(title: "Coda")[
  Una *coda* (queue) è una struttura dati con politica *FIFO* (First In, First Out): il primo elemento inserito è il primo ad essere rimosso.
]

=== Operazioni

- `Enqueue(Q, x)`: inserisce $x$ alla fine della coda
- `Dequeue(Q)`: rimuove e restituisce l'elemento all'inizio
- `Front(Q)`: restituisce l'elemento all'inizio senza rimuoverlo
- `IsEmpty(Q)`: verifica se la coda è vuota

=== Implementazione su Array circolare

Per evitare lo spostamento degli elementi, usiamo un array "circolare":

```
// Coda implementata con array Q[1..n]
// head = indice del primo elemento
// tail = indice della prossima posizione libera

enqueue(Queue Q, int x){
    Q[Q.tail] := x;
    if(Q.tail == Q.length){
        Q.tail := 1;
    } else {
        Q.tail := Q.tail + 1;
    }
}

int dequeue(Queue Q){
    int x = Q[Q.head];
    if(Q.head == Q.length){
        Q.head := 1;
    } else {
        Q.head := Q.head + 1;
    }
    return x;
}
```

#note[
  Con l'array circolare, quando arriviamo alla fine dell'array, "torniamo all'inizio". Bisogna gestire i casi di overflow (coda piena) e underflow (coda vuota).
]

=== Implementazione su Lista

```
// Coda implementata con lista concatenata
// head = puntatore al primo elemento
// tail = puntatore all'ultimo elemento

enqueue(Queue Q, Node x){
    x.next := NIL;
    if(Q.tail != NIL){
        Q.tail.next := x;
    }
    Q.tail := x;
    if(Q.head == NIL){
        Q.head := x;
    }
}

Node dequeue(Queue Q){
    if(Q.head == NIL){
        // error "underflow"
        return NIL;
    }
    Node x = Q.head;
    Q.head := Q.head.next;
    if(Q.head == NIL){
        Q.tail := NIL;
    }
    return x;
}
```

=== Complessità

Tutte le operazioni hanno complessità $O(1)$.

=== Applicazioni

- Scheduling di processi (CPU scheduling)
- Buffer di I/O
- Gestione delle richieste (web server)
- BFS (Breadth-First Search) nei grafi
- Simulazione di sistemi con attese

=== Varianti delle Code

=== Deque (Double-Ended Queue)

#definition(title: "Deque")[
  Una *deque* permette inserimenti e rimozioni da entrambe le estremità:
  - `InsertFront(D, x)`, `InsertBack(D, x)`
  - `RemoveFront(D)`, `RemoveBack(D)`
]

=== Coda con priorità

Già vista nel capitolo sugli Heap: gli elementi escono in base alla loro priorità, non all'ordine di arrivo.

=== Riepilogo

#figure(
  table(
    columns: 5,
    [*Struttura*], [*Politica*], [*Inserimento*], [*Rimozione*], [*Accesso*],
    [Array], [Indice], [$O(n)$], [$O(n)$], [$O(1)$],
    [Lista], [Posizione], [$O(1)$#super[\*]], [$O(1)$#super[\*]], [$O(n)$],
    [Pila], [LIFO], [$O(1)$], [$O(1)$], [$O(1)$#super[\*\*]],
    [Coda], [FIFO], [$O(1)$], [$O(1)$], [$O(1)$#super[\*\*]],
  ),
  caption: [#super[\*] in testa/coda con puntatore, #super[\*\*] solo all'elemento accessibile]
)

#note[
  La scelta della struttura dati dipende dalle operazioni più frequenti:
  - Accesso casuale frequente → *Array*
  - Inserimenti/cancellazioni frequenti → *Lista*
  - Elaborazione LIFO → *Pila*
  - Elaborazione FIFO → *Coda*
]
