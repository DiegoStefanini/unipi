# Algebra Lineare - Dispense

Progetto per la raccolta di appunti del corso di Algebra Lineare.

## Struttura

```
algebra/
├── CLAUDE.md
├── dispense/
│   ├── main.typ          # File principale - compila questo per il PDF completo
│   ├── template.typ      # Stili condivisi (definizione, teorema, esempio, nota, dimostrazione)
│   └── lezioni/
│       ├── lezione01.typ
│       ├── lezione02.typ
│       └── ...
└── [immagini appunti]    # Foto temporanee degli appunti da convertire
```

## Aggiungere una nuova lezione

1. L'utente fornisce le foto degli appunti
2. Creare `dispense/lezioni/lezioneXX.typ` con questo formato:
   ```typst
   #import "../template.typ": *

   #nuova-lezione(XX, "Titolo della Lezione")

   = Primo Argomento
   // contenuto...
   ```
3. Aggiungere in `dispense/main.typ`:
   ```typst
   #include "lezioni/lezioneXX.typ"
   ```

## Stili disponibili (da template.typ)

- `#definizione("Titolo")[Contenuto]` - box blu
- `#teorema("Titolo")[Contenuto]` - box rosso
- `#esempio[Contenuto]` - box verde
- `#nota[Contenuto]` - box arancione
- `#dimostrazione[Contenuto]` - box grigio con QED
- `#nuova-lezione(numero, "titolo")` - intestazione lezione con page break

## Compilazione

```bash
typst compile dispense/main.typ
```

## Note

- L'indice mostra solo i titoli delle lezioni (depth: 1)
- Ogni lezione inizia su una nuova pagina
- Formule matematiche: usare `$ ... $` per inline, `$ ... $` su riga separata per display
- Prof: Patrizio Frosini
- Università di Pisa - Informatica
