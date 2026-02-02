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

// Pagebreak solo per capitoli principali (level 1)
#show heading.where(level: 1): it => {
  pagebreak(weak: true)
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
// Pagina titolo
// ========================================

#align(center)[
  #v(4cm)
  #text(size: 24pt, weight: "bold")[Programmazione ed Algoritmica]
  #v(2cm)
  #text(size: 12pt)[Diego Stefanini]
  #v(0.5cm)
  #text(size: 11pt)[A.A 2025-2026]
]

#pagebreak()

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
#include "programmazione/introduzione_bruni.typ"

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
// PARTE IV - COMPLESSITÀ COMPUTAZIONALE
// ========================================

= Complessità Computazionale

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
