// =========================================
// ALGEBRA LINEARE - DISPENSE COMPLETE
// =========================================
// Per aggiungere una nuova lezione:
// 1. Crea il file lezioneXX.typ nella cartella lezioni/
// 2. Aggiungi #include "lezioni/lezioneXX.typ" in fondo a questo file
// =========================================

#import "template.typ": *

#show: conf

// Copertina
#align(center + horizon)[
  #text(size: 28pt, weight: "bold")[Algebra Lineare]

  #text(size: 12pt)[
    Autore: Diego Stefanini
    Prof: Patrizio Frosini 
  ]
  #v(1cm)

  #text(size: 16pt)[Dispense del Corso]

  #v(2cm)

  #line(length: 40%)

  #v(2cm)

  #text(size: 12pt)[
    Università di Pisa - Informatica \
    Anno Accademico 2025/2026
  ]
]

// Indice
#pagebreak()
#outline(title: "Indice", indent: auto, depth: 1)

// =========================================
// LEZIONI
// =========================================

#include "lezioni/lezione01.typ"

// Aggiungi qui le prossime lezioni:
// #include "lezioni/lezione02.typ"
// #include "lezioni/lezione03.typ"
// ...
