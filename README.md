# Appunti Informatica - Universita di Pisa

Repository collaborativa contenente dispense e appunti per il corso di laurea in Informatica presso l'Universita di Pisa.

## Contenuti

| Corso | Stato | Descrizione |
|-------|-------|-------------|
| **Algebra Lineare** | In corso | Dispense in Typst — Prof. Patrizio Frosini |
| **Programmazione ed Algoritmica** | In corso | Appunti completi con algoritmi, grammatiche, semantica operazionale e type checking |
| **Analisi** | Da iniziare | Esercitazioni e programma del corso |
| **Laboratorio** | Da iniziare | — |

## Struttura del progetto

```
universita/
├── algebra/
│   └── dispense/          # Dispense in Typst
├── analisi/
│   └── esercitazioniprof/ # Esercizi del professore
├── programmazione/
│   ├── Appunti Typst/     # Appunti completi in Typst
│   ├── Esercitazioni/     # Esercizi
│   └── Slide/             # Slide delle lezioni
└── laboratorio/
```

## Tecnologie usate

Le dispense sono scritte in [Typst](https://typst.app/), un linguaggio di markup moderno per la composizione di documenti.

### Compilare le dispense

Per compilare un documento Typst in PDF:

```bash
typst compile dispense/main.typ dispense/main.pdf
```

Oppure per la compilazione automatica ad ogni modifica:

```bash
typst watch dispense/main.typ dispense/main.pdf
```

### Installare Typst

- **Con cargo**: `cargo install --git https://github.com/typst/typst --locked typst-cli`
- **Homebrew (macOS)**: `brew install typst`
- **Pacman (Arch)**: `pacman -S typst`
- **Online**: [typst.app](https://typst.app/)

## Contribuire

Le contribuzioni sono benvenute! Puoi contribuire in diversi modi:

- Correggere errori nelle dispense esistenti
- Aggiungere nuove lezioni o appunti
- Migliorare la formattazione o la chiarezza del testo
- Aggiungere esercizi svolti

Leggi [CONTRIBUTING.md](CONTRIBUTING.md) per le linee guida su come contribuire.

## Licenza

Questi appunti sono condivisi liberamente a scopo didattico. Se utilizzi questo materiale, una menzione e apprezzata.
