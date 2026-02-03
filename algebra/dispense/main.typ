// ============================================================
// ALGEBRA LINEARE - DISPENSE COMPLETE
// ============================================================
// Dispense universitarie per il corso di Algebra Lineare
// Università di Pisa - Corso di Laurea in Informatica
// ============================================================

#import "template.typ": *

#show: conf

// ============================================================
// COPERTINA
// ============================================================
#set page(numbering: none)

#v(2cm)

// Opzionale: decommentare se si aggiunge il logo
// #align(center)[
//   #image("unipi-logo.png", width: 3cm)
// ]

#align(center)[
  #text(size: 14pt, tracking: 0.3em)[UNIVERSITÀ DI PISA]

  #v(0.3cm)

  #text(size: 11pt)[Dipartimento di Informatica]

  #v(0.2cm)

  #text(size: 11pt)[Corso di Laurea in Informatica]
]

#v(2cm)

#align(center)[
  #block(
    width: 80%,
    stroke: (y: 1pt + black),
    inset: (y: 15pt),
  )[
    #text(size: 28pt, weight: "bold")[Algebra Lineare]

    #v(0.5cm)

    #text(size: 14pt)[Dispense del Corso]
  ]
]

#v(2cm)

#align(center)[
  #grid(
    columns: 2,
    column-gutter: 3cm,
    row-gutter: 0.8cm,
    align: (right, left),
    [#text(weight: "bold")[Docente:]], [Prof. Patrizio Frosini],
    [#text(weight: "bold")[Autore:]], [Diego Stefanini],
  )
]

#v(1fr)

#align(center)[
  #text(size: 9pt, fill: gray)[
    Per contribuire: #link("https://github.com/DiegoStefanini/unipi/algebra")
  ]

  #v(0.5cm)

  #line(length: 30%, stroke: 0.5pt + gray)

  #v(0.5cm)

  #text(size: 11pt)[Anno Accademico 2025/2026]

  #v(0.3cm)

  #text(size: 9pt, fill: gray)[
    Ultima revisione: #datetime.today().display("[day]/[month]/[year]")
  ]
]

#v(1cm)

// ============================================================
// PREFAZIONE
// ============================================================
#pagebreak()
#set page(numbering: "i")

#align(center)[
  #text(size: 16pt, weight: "bold")[Prefazione]
]

#v(0.5cm)

Queste dispense raccolgono i principali argomenti del corso di Algebra Lineare, presentati in modo rigoroso ma accessibile. Il testo è strutturato per capitoli tematici, ciascuno dei quali sviluppa gli argomenti in modo progressivo.

#v(0.3cm)

*Struttura del testo:*
- Le #text(fill: rgb("#1a5276"), weight: "bold")[definizioni] introducono i concetti fondamentali
- I #text(fill: rgb("#922b21"), weight: "bold")[teoremi] enunciano i risultati principali
- Le #text(fill: rgb("#5d6d7e"), weight: "bold")[dimostrazioni] sviluppano il ragionamento formale
- Gli #text(fill: rgb("#196f3d"), weight: "bold")[esempi] illustrano i concetti con casi concreti
- Le #text(fill: rgb("#b9770e"), weight: "bold")[note] forniscono chiarimenti e osservazioni utili

#v(0.3cm)

Si consiglia di procedere in ordine, assicurandosi di aver compreso le definizioni prima di affrontare i teoremi e le relative dimostrazioni.

// ============================================================
// INDICE
// ============================================================
#pagebreak()

#v(2cm)
#align(center)[
  #line(length: 70%, stroke: 0.5pt + black)
  #v(0.5cm)
  #text(size: 22pt, weight: "bold")[Indice]
  #v(0.5cm)
]
#v(0.5cm)
#outline(title: none, indent: 1.5em, depth: 2)

// ============================================================
// CONTENUTO
// ============================================================
#pagebreak()
#set page(numbering: "1")
#counter(page).update(1)

#include "capitoli/capitolo01.typ"

// Prossimi capitoli:
// #include "capitoli/capitolo02.typ"
