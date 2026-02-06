# Appunti Programmazione ed Algoritmica - Typst

## Panoramica del progetto
Dispensa universitaria per il corso di **Programmazione ed Algoritmica** scritta in Typst. Il documento copre sia la parte algoritmica che la parte di linguaggi di programmazione.

## Struttura dei file

```
Appunti Typst/
├── main.typ                    # File principale che include tutti i capitoli
├── template.typ                # Template con stili e ambienti personalizzati
├── algoritmica/
│   ├── introduzione.typ        # Definizione di algoritmo, problema, programma
│   ├── complessita_in_tempo.typ # Modello RAM, notazione asintotica, limiti inferiori
│   ├── divide_et_impera.typ    # Divide et Impera, Master Theorem, MergeSort
│   ├── ordinamenti_elementari.typ # Insertion Sort, Selection Sort, invarianti di ciclo
│   ├── quicksort.typ           # QuickSort e analisi
│   ├── heap.typ                # Heap, HeapSort, code di priorità
│   ├── ordinamenti_lineari.typ # Counting Sort, Radix Sort, Bucket Sort
│   ├── strutture_dati.typ      # Liste, pile, code, deque
│   └── alberi_binari.typ       # Alberi binari, BST, operazioni
└── programmazione/
    ├── introduzione.typ        # Introduzione ai linguaggi di programmazione
    ├── alfabeti_stringhe_linguaggi.typ # Teoria dei linguaggi formali
    ├── ling_gen_derivazioni.typ # Grammatiche e derivazioni
    ├── derivcan_alberi.typ     # Alberi di derivazione, ambiguità
    ├── inferenza_sislogici.typ # Regole di inferenza, sistemi logici, induzione
    ├── MiniMao.typ             # Semantica operazionale base
    └── Mao.typ                 # MAO completo: array, funzioni, type checking
```

## Linguaggio MAO

Il corso usa **MAO (Modello Astratto Operazionale)**, un linguaggio didattico con queste caratteristiche:
- `=` per dichiarazione: `int x = 5;`
- `:=` per assegnamento: `x := x + 1;`
- Solo cicli `while` (niente `for`)
- Sintassi C-like ma semplificata

## Ambienti Typst disponibili

Il template definisce questi ambienti:
- `#definition(title: "...")[]` - Definizioni
- `#theorem(title: "...")[]` - Teoremi
- `#example(title: "...")[]` - Esempi
- `#note(title: "...")[]` - Note
- `#demonstration[]` - Dimostrazioni

## Convenzioni di stile

- **Codice**: sempre in sintassi MAO con `:=` per assegnamenti, wrappato in `#algorithm(title: "NomeAlgoritmo")[]`
- **Formule matematiche**: usare `$...$` per inline e `$ ... $` su riga separata
- **Chevron**: usare `chevron.l` e `chevron.r` (NON `angle.l`/`angle.r` deprecati)
- **Regole di inferenza**: usare `#box(stroke: (bottom: 1pt), inset: 3pt)[premesse]` seguito da `\` e conclusione. NON usare `frac()` perché le virgole nel contenuto vengono interpretate come separatori di argomenti
- **Accenti**: usare accenti Unicode reali (`è`, `più`, `può`, `cioè`, `perché`) NON apostrofi (`e'`, `piu'`, `puo'`)
- **Heading**: ogni file incluso ha un singolo `==` per argomento principale, `===` per sotto-sezioni, `====` per sotto-sotto-sezioni. L'indice in main.typ è a `depth: 2`
- **Immagini**: nella cartella `images/`, alcune sono state sostituite con codice Typst

## Task completati in sessioni precedenti

1. Espanso esempi Counting Sort e Radix Sort con esecuzioni passo-passo
2. Aggiunto esempi completi di sviluppo sequenziale (semantica operazionale)
3. Aggiunto esempi di type checking con derivazioni complete
4. **Convertite 30 immagini in codice Typst** (da 43 a 13):
   - MiniMao.typ: operatori, tutte le regole semantiche (espressioni, comandi, while, blocchi, condizionali)
   - Mao.typ: **100% convertito** - type checking, semantica array, funzioni, assegnamento multiplo
5. Corretto warning deprecazione `angle.l/r` → `chevron.l/r`
6. Corretto errore sintassi `frac()` → usare `#box(stroke: (bottom: 1pt))`
7. **Ristrutturazione capitoli**: spostato Insertion Sort/Selection Sort/invarianti da "Complessità" a "Ordinamento", spostato limiti inferiori da "Divide et Impera" a "Complessità", rimossa immagine placeholder `oss_da_sistemare.png`
8. **Audit completo e correzioni qualità su tutti i file**:
   - alberi_binari.typ: 12 code blocks wrappati in `#algorithm()`, definizione BST corretta
   - heap.typ: gerarchia heading corretta (da piatta a gerarchica), complessità HeapSort → Θ(n log n)
   - complessita_in_tempo.typ: heading ridondante rinominato, spec minimo corretta, proprietà da `#definition` a `#theorem`, definizione albero bilanciato corretta
   - ordinamenti_elementari.typ: aggiunti esempi passo-passo, invariante ciclo interno, nota stabilità
   - divide_et_impera.typ: espanso ricorrenze ordine k, aggiunto metodo iterativo, complessità ricerca binaria
   - quicksort.typ: tabella confronto corretta con colonna "Atteso"
   - Mao.typ: aggiunte regole T-Eop (==,!= su bool), T-ArrayLit, corretto T-MultiAssign, propagazione return, semantica ricorsione
   - MiniMao.typ: aggiunta nota espressioni parentesizzate
   - inferenza_sislogici.typ: aggiunta nota anticipatoria T-Cop per booleani
   - strutture_dati.typ + ordinamenti_lineari.typ: gerarchie heading corrette, riferimento incrociato heap
9. **Ristrutturazione heading per ridurre frammentazione**:
   - MiniMao.typ: da 14 a 5 sezioni `==`
   - Mao.typ: da 25 a 5 sezioni `==`
   - introduzione files: sezioni corte accorpate
   - inferenza_sislogici.typ: heading ridondante rimosso
10. **Normalizzazione accenti**: tutti i file convertiti da apostrofi (`e'`) ad accenti Unicode (`è`)

## Note per future modifiche

- Il file `Mao.typ` contiene ancora alcune immagini per regole semantiche complesse
- Le immagini sono in `../images/` relativo ai file .typ
- La compilazione avviene con `typst compile main.typ`
- Font più piccolo (10pt) negli ambienti per stile accademico

## Argomenti coperti

### Algoritmica
- Complessità in tempo (Big-O, Theta, Omega), limiti inferiori (albero di decisione, eventi contabili)
- Algoritmi di ordinamento (Insertion, Selection, Merge, Quick, Heap, Counting, Radix, Bucket)
- Master Theorem e metodi di risoluzione ricorrenze (iterativo, equazione caratteristica)
- Invarianti di ciclo e dimostrazioni di correttezza
- Strutture dati lineari (array, liste, pile, code, deque)
- Alberi binari e BST (ricerca, inserimento, cancellazione, analisi complessità)

### Programmazione
- Grammatiche formali e linguaggi, gerarchia di Chomsky
- Derivazioni, alberi di derivazione, ambiguità
- Regole di inferenza, sistemi logici, induzione (matematica, strutturale, sulle derivazioni)
- Semantica operazionale big-step (MiniMao)
- Sistema di tipi e type checking (T-Cop, T-Eop, T-ArrayLit)
- Array, aliasing, funzioni, ricorsione in MAO
