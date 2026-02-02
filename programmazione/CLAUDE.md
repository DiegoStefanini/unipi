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
│   ├── complessita_in_tempo.typ # Complessità, notazione asintotica, invarianti
│   ├── divide_et_impera.typ    # Divide et Impera, Master Theorem, MergeSort
│   ├── quicksort.typ           # QuickSort e analisi
│   ├── heap.typ                # Heap, HeapSort, code di priorità
│   ├── ordinamenti_lineari.typ # Counting Sort, Radix Sort, Bucket Sort
│   └── strutture_dati.typ      # Liste, pile, code
└── programmazione/
    ├── introduzione_bruni.typ  # Introduzione ai linguaggi di programmazione
    ├── alfabeti_stringhe_linguaggi.typ # Teoria dei linguaggi formali
    ├── ling_gen_derivazioni.typ # Grammatiche e derivazioni
    ├── derivcan_alberi.typ     # Alberi di derivazione, ambiguità
    ├── inferenza_sislogici.typ # Regole di inferenza, sistemi logici
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

- **Codice**: sempre in sintassi MAO con `:=` per assegnamenti
- **Formule matematiche**: usare `$...$` per inline e `$ ... $` su riga separata
- **Chevron**: usare `chevron.l` e `chevron.r` (NON `angle.l`/`angle.r` deprecati)
- **Regole di inferenza**: usare `#box(stroke: (bottom: 1pt), inset: 3pt)[premesse]` seguito da `\` e conclusione. NON usare `frac()` perché le virgole nel contenuto vengono interpretate come separatori di argomenti
- **Immagini**: nella cartella `images/`, alcune sono state sostituite con codice Typst

## Task completati in questa sessione

1. Espanso esempi Counting Sort e Radix Sort con esecuzioni passo-passo
2. Aggiunto esempi completi di sviluppo sequenziale (semantica operazionale)
3. Aggiunto esempi di type checking con derivazioni complete
4. **Convertite 30 immagini in codice Typst** (da 43 a 13):
   - MiniMao.typ: operatori, tutte le regole semantiche (espressioni, comandi, while, blocchi, condizionali)
   - Mao.typ: **100% convertito** - type checking, semantica array, funzioni, assegnamento multiplo
5. Corretto warning deprecazione `angle.l/r` → `chevron.l/r`
6. Corretto errore sintassi `frac()` → usare `#box(stroke: (bottom: 1pt))`

## Note per future modifiche

- Il file `Mao.typ` contiene ancora alcune immagini per regole semantiche complesse
- Le immagini sono in `../images/` relativo ai file .typ
- La compilazione avviene con `typst compile main.typ`
- Font più piccolo (10pt) negli ambienti per stile accademico

## Argomenti coperti

### Algoritmica
- Complessità in tempo (Big-O, Theta, Omega)
- Algoritmi di ordinamento (Insertion, Selection, Merge, Quick, Heap, Counting, Radix, Bucket)
- Master Theorem per relazioni di ricorrenza
- Invarianti di ciclo e dimostrazioni di correttezza
- Strutture dati (heap, liste, pile, code)

### Programmazione
- Grammatiche formali e linguaggi
- Derivazioni e alberi di derivazione
- Semantica operazionale (big-step)
- Sistema di tipi e type checking
- Array, funzioni, ricorsione in MAO
