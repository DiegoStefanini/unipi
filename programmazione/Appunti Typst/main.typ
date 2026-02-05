// ========================================
// Programmazione ed Algoritmica
// ========================================

#import "template.typ": *

#set document(
  title: "Programmazione ed Algoritmica",
  author: "Diego Stefanini",
)

#set page(
  paper: "a4",
  margin: (top: 2.5cm, bottom: 2.5cm, left: 2.5cm, right: 2.5cm),
  header: context {
    if counter(page).get().first() > 1 [
      #set text(size: 9pt, style: "italic")
      Programmazione ed Algoritmica #h(1fr) A.A 2025-2026
      #v(-3pt)
      #line(length: 100%, stroke: 0.4pt)
    ]
  },
  footer: context {
    set text(size: 9pt)
    h(1fr)
    counter(page).display("1")
    h(1fr)
  },
)

#set text(font: "New Computer Modern", size: 11pt, lang: "it")
#set par(justify: true, leading: 0.65em)
#set heading(numbering: "1.1")

// Pagebreak e reset contatori per capitoli principali (level 1)
#show heading.where(level: 1): it => {
  pagebreak(weak: true)
  reset-counters()
  v(0.5em)
  text(size: 16pt, weight: "bold")[#it]
  v(0.3em)
}

// Sezioni (level 2) senza pagebreak
#show heading.where(level: 2): it => {
  v(0.8em)
  it
  v(0.3em)
}

// ========================================
// Pagina titolo (design migliorato)
// ========================================

#page(
  margin: (top: 0cm, bottom: 0cm, left: 0cm, right: 0cm),
  header: none,
  footer: none,
)[
  // Banda superiore colorata
  #place(top + left)[
    #rect(width: 100%, height: 4cm, fill: rgb("#1e3a5f"))
  ]

  // Contenuto centrato
  #align(center)[
    #v(5cm)

    // Titolo principale
    #block(
      width: 80%,
      inset: 1.5em,
    )[
      #text(size: 32pt, weight: "bold", fill: rgb("#1e3a5f"))[
        Programmazione ed Algoritmica
      ]
    ]

    #v(0.5cm)

    // Linea decorativa
    #line(length: 40%, stroke: 2pt + rgb("#1a5c3a"))

    #v(1cm)

    // Sottotitolo
    #text(size: 14pt, fill: luma(80))[
      Appunti del corso di Laurea in Informatica
    ]

    #v(3cm)

    // Autore
    #text(size: 14pt, weight: "medium")[Diego Stefanini]

    #v(0.8cm)

    // Anno accademico
    #block(
      inset: (x: 1.5em, y: 0.8em),
      radius: 4pt,
      stroke: 1pt + luma(200),
    )[
      #text(size: 11pt)[Anno Accademico 2025-2026]
    ]

    #v(1fr)

    // Footer con universita
    #text(size: 10pt, fill: luma(120))[
      Universita degli Studi di Firenze
    ]

    #v(2cm)
  ]

  // Banda inferiore
  #place(bottom + left)[
    #rect(width: 100%, height: 1cm, fill: rgb("#1a5c3a"))
  ]
]

// ========================================
// Indice
// ========================================

#{
  set text(size: 10pt)
  set par(leading: 0.5em)

  outline(
    title: [#text(size: 14pt, weight: "bold")[Indice]],
    indent: 1em,
    depth: 2,
  )
}

// ========================================
// PARTE I - INTRODUZIONE
// ========================================

= Introduzione

#include "algoritmica/introduzione.typ"
#include "programmazione/introduzione.typ"

// ========================================
// PARTE II - LINGUAGGI FORMALI E GRAMMATICHE
// ========================================

= Linguaggi Formali e Grammatiche

#include "programmazione/alfabeti_stringhe_linguaggi.typ"
#include "programmazione/ling_gen_derivazioni.typ"
#include "programmazione/derivcan_alberi.typ"

// ========================================
// PARTE III - SEMANTICA E LINGUAGGIO MAO
// ========================================

= Semantica e Linguaggio MAO

#include "programmazione/inferenza_sislogici.typ"
#include "programmazione/MiniMao.typ"
#include "programmazione/Mao.typ"

// ========================================
// PARTE IV - COMPLESSITA COMPUTAZIONALE
// ========================================

= Complessita Computazionale

#include "algoritmica/complessita_in_tempo.typ"

// ========================================
// PARTE V - ALGORITMI DI ORDINAMENTO
// ========================================

= Algoritmi di Ordinamento

#include "algoritmica/divide_et_impera.typ"
#include "algoritmica/quicksort.typ"
#include "algoritmica/heap.typ"
#include "algoritmica/ordinamenti_lineari.typ"

// ========================================
// PARTE VI - STRUTTURE DATI
// ========================================

= Strutture Dati

#include "algoritmica/strutture_dati.typ"
