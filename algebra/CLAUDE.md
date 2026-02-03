# Algebra Lineare - Dispense Universitarie

Progetto per la raccolta di dispense professionali del corso di Algebra Lineare.
Stile ottimizzato per lo studio approfondito e la comprensione dei concetti.

## Stile e Struttura del Documento

### 1. Organizzazione per Argomenti
- Il contenuto è organizzato per *argomenti tematici*, non per lezioni
- Ogni capitolo si apre con una breve introduzione che delinea gli obiettivi e gli argomenti trattati
- Il contenuto è suddiviso in blocchi logici numerati (definizioni, teoremi, esempi, ecc.)
- Il documento adotta una progressione che va dal semplice al complesso

### 2. Stile di Esposizione
Lo stile è quello di un *professore* che scrive un testo universitario:
- **Rigore Matematico:** notazione simbolica precisa alternata al linguaggio naturale
- **Chiarezza Espositiva:** passaggi logici espliciti, significato intuitivo prima di quello formale
- **Approccio Multimodale alle Dimostrazioni:** approcci distinti per provare gli enunciati

### 3. Elementi Grafici e Formattazione
- **Tabelle Riassuntive:** per leggi algebriche o confronto proprietà
- **Formattazione del Testo:** grassetto per termini chiave, italico per enfasi

## Aggiungere Nuovo Contenuto

1. L'utente fornisce le foto degli appunti
2. Trascrivere il contenuto nel file `.typ` appropriato in `dispense/capitoli/`, organizzandolo per argomento
3. Ogni file deve importare il template: `#import "../template.typ": *`
4. Se nuovo file, aggiungere l'include in `dispense/main.typ`

## Ambienti Disponibili

### Ambienti Teorici (numerati automaticamente)

| Ambiente | Colore | Uso |
|---|---|---|
| `#definizione("titolo")[...]` | Blu | Concetti fondamentali |
| `#teorema("titolo")[...]` | Rosso | Risultati principali |
| `#lemma("titolo")[...]` | Viola | Risultati ausiliari |
| `#corollario("titolo")[...]` | Azzurro | Conseguenze dirette |
| `#proposizione("titolo")[...]` | Verde acqua | Risultati intermedi |

### Ambienti di Supporto

| Ambiente | Colore | Uso |
|---|---|---|
| `#dimostrazione[...]` | Grigio | Con simbolo QED finale |
| `#esempio[...]` | Verde | Numerato |
| `#nota[...]` | Arancione | Informazioni aggiuntive |
| `#osservazione[...]` | Grigio chiaro | Numerata |
| `#attenzione[...]` | Rosso | Errori comuni |
| `#ricorda[...]` | Blu evidenziato | Concetti chiave per l'esame |

## Formule Matematiche

- **Inline:** `$x + y$`
- **Display (centrata):** `$ sum_(i=1)^n a_i $`
- **Simboli comuni:** `$NN$`, `$ZZ$`, `$QQ$`, `$RR$`, `$CC$`
- **Vettori:** `$arrow(v)$` o `$bold(v)$`
- **Matrici:** `$mat(a, b; c, d)$`

## Compilazione

```bash
typst compile dispense/main.typ dispense/main.pdf
```

## Note Tecniche

- Prof: Patrizio Frosini
- Università di Pisa - Corso di Laurea in Informatica
- I contatori (definizioni, teoremi, etc.) sono globali nel documento
