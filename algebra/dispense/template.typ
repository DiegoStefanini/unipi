// ============================================================
// TEMPLATE DISPENSE UNIVERSITARIE - ALGEBRA LINEARE
// Numerazione unificata: Capitolo.Sezione.Numero
// ============================================================

// Colori (sobri e leggibili)
#let blu-def = rgb("#1a5276")
#let rosso-teo = rgb("#922b21")
#let verde-es = rgb("#196f3d")
#let arancio-nota = rgb("#b9770e")
#let grigio-dim = rgb("#5d6d7e")
#let viola-lem = rgb("#6c3483")
#let azzurro-cor = rgb("#2874a6")
#let teal-prop = rgb("#117a65")

// Contatore unico per tutti i blocchi numerati (Cap.Sez.Num)
#let contatore-blocco = counter("blocco")

// Helper: incrementa il contatore e restituisce il numero formattato
#let _prossimo-numero() = {
  contatore-blocco.step()
  context {
    let h = counter(heading).get()
    let b = contatore-blocco.get().first()
    let ch = h.at(0, default: 0)
    let sec = h.at(1, default: 0)
    [#ch.#sec.#b]
  }
}

// Configurazione documento
#let conf(doc) = {
  set document(title: "Algebra Lineare - Dispense", author: "Diego Stefanini")

  set page(
    paper: "a4",
    margin: (top: 2.5cm, bottom: 2.5cm, left: 2.5cm, right: 2cm),
    numbering: "1",
    header: context {
      if counter(page).get().first() > 1 {
        set text(size: 9pt, fill: gray)
        [Algebra Lineare — Dispense #h(1fr) #counter(page).display()]
      }
    },
  )

  set text(font: "New Computer Modern", size: 11pt, lang: "it")
  set par(justify: true, leading: 0.65em, first-line-indent: 1em)
  set heading(numbering: "1.1.")
  set math.equation(numbering: "(1)")
  set list(indent: 1em, body-indent: 0.5em)
  set enum(indent: 1em, body-indent: 0.5em)

  // Capitoli: stile "CAPITOLO N" con linee
  show heading.where(level: 1): it => {
    contatore-blocco.update(0)
    pagebreak()
    v(2cm)
    align(center)[
      #line(length: 70%, stroke: 0.5pt + black)
      #v(0.8cm)
      #text(size: 12pt, tracking: 0.15em)[CAPITOLO #context counter(heading).display("1")]
      #v(0.4cm)
      #text(size: 22pt, weight: "bold")[#it.body]
      #v(0.8cm)
      #line(length: 70%, stroke: 0.5pt + black)
    ]
    v(1cm)
  }

  // Sezioni: reset contatore blocchi
  show heading.where(level: 2): it => {
    contatore-blocco.update(0)
    v(0.5cm)
    block(breakable: false)[
      #set text(size: 12pt, weight: "bold")
      #it
      #v(0.2cm)
    ]
  }

  // Sotto-sezioni
  show heading.where(level: 3): it => {
    v(0.3cm)
    block(breakable: false)[
      #set text(size: 11pt, weight: "bold")
      #it
      #v(0.1cm)
    ]
  }

  // Indice: capitoli in grassetto
  show outline.entry.where(level: 1): it => {
    v(0.3em, weak: true)
    strong(it)
  }

  doc
}

// ============================================================
// AMBIENTI TEORICI (numerazione unificata Cap.Sez.Num)
// ============================================================

// Definizione - concetti fondamentali
#let definizione(titolo, corpo) = block(
  width: 100%,
  breakable: false,
  inset: (x: 12pt, y: 10pt),
  radius: 2pt,
  stroke: (left: 3pt + blu-def, rest: 0.5pt + blu-def.lighten(50%)),
  fill: blu-def.lighten(95%),
)[
  #text(weight: "bold", fill: blu-def)[
    Definizione #_prossimo-numero()#if titolo != none and titolo != "" [ (#titolo)].
  ]
  #v(4pt)
  #corpo
]

// Teorema - risultato principale
#let teorema(titolo, corpo) = block(
  width: 100%,
  breakable: false,
  inset: (x: 12pt, y: 10pt),
  radius: 2pt,
  stroke: (left: 3pt + rosso-teo, rest: 0.5pt + rosso-teo.lighten(50%)),
  fill: rosso-teo.lighten(95%),
)[
  #text(weight: "bold", fill: rosso-teo)[
    Teorema #_prossimo-numero()#if titolo != none and titolo != "" [ (#titolo)].
  ]
  #v(4pt)
  #emph(corpo)
]

// Lemma - risultato ausiliario
#let lemma(titolo, corpo) = block(
  width: 100%,
  breakable: false,
  inset: (x: 12pt, y: 10pt),
  radius: 2pt,
  stroke: (left: 3pt + viola-lem, rest: 0.5pt + viola-lem.lighten(50%)),
  fill: viola-lem.lighten(95%),
)[
  #text(weight: "bold", fill: viola-lem)[
    Lemma #_prossimo-numero()#if titolo != none and titolo != "" [ (#titolo)].
  ]
  #v(4pt)
  #emph(corpo)
]

// Corollario - conseguenza diretta
#let corollario(titolo, corpo) = block(
  width: 100%,
  breakable: false,
  inset: (x: 12pt, y: 10pt),
  radius: 2pt,
  stroke: (left: 3pt + azzurro-cor, rest: 0.5pt + azzurro-cor.lighten(50%)),
  fill: azzurro-cor.lighten(95%),
)[
  #text(weight: "bold", fill: azzurro-cor)[
    Corollario #_prossimo-numero()#if titolo != none and titolo != "" [ (#titolo)].
  ]
  #v(4pt)
  #emph(corpo)
]

// Proposizione - risultato intermedio
#let proposizione(titolo, corpo) = block(
  width: 100%,
  breakable: false,
  inset: (x: 12pt, y: 10pt),
  radius: 2pt,
  stroke: (left: 3pt + teal-prop, rest: 0.5pt + teal-prop.lighten(50%)),
  fill: teal-prop.lighten(95%),
)[
  #text(weight: "bold", fill: teal-prop)[
    Proposizione #_prossimo-numero()#if titolo != none and titolo != "" [ (#titolo)].
  ]
  #v(4pt)
  #emph(corpo)
]

// Esempio - numerato
#let esempio(corpo) = block(
  width: 100%,
  breakable: false,
  inset: (x: 12pt, y: 10pt),
  radius: 2pt,
  stroke: (left: 3pt + verde-es, rest: 0.5pt + verde-es.lighten(50%)),
  fill: verde-es.lighten(95%),
)[
  #text(weight: "bold", fill: verde-es)[
    Esempio #_prossimo-numero().
  ]
  #v(4pt)
  #corpo
]

// Osservazione - numerata
#let osservazione(corpo) = block(
  width: 100%,
  breakable: false,
  inset: (x: 12pt, y: 8pt),
  radius: 2pt,
  stroke: 0.5pt + gray,
  fill: gray.lighten(97%),
)[
  #text(weight: "bold", fill: gray.darken(20%))[
    Osservazione #_prossimo-numero().
  ]
  #h(0.3em)
  #corpo
]

// ============================================================
// AMBIENTI DI SUPPORTO (non numerati)
// ============================================================

// Dimostrazione - con QED finale
#let dimostrazione(corpo) = block(
  width: 100%,
  breakable: false,
  inset: (x: 12pt, y: 10pt),
  radius: 2pt,
  stroke: (left: 2pt + grigio-dim),
  fill: grigio-dim.lighten(97%),
)[
  #text(weight: "bold", fill: grigio-dim, style: "italic")[Dimostrazione.]
  #h(0.3em)
  #corpo
  #h(1fr) $square.stroked$
]

// Nota - informazioni aggiuntive
#let nota(corpo) = block(
  width: 100%,
  breakable: false,
  inset: (x: 12pt, y: 8pt),
  radius: 2pt,
  stroke: (left: 2pt + arancio-nota),
  fill: arancio-nota.lighten(95%),
)[
  #text(weight: "bold", fill: arancio-nota)[Nota.]
  #h(0.3em)
  #corpo
]

// Attenzione - errori comuni
#let attenzione(corpo) = block(
  width: 100%,
  breakable: false,
  inset: (x: 12pt, y: 8pt),
  radius: 2pt,
  stroke: 1pt + red,
  fill: red.lighten(95%),
)[
  #text(weight: "bold", fill: red)[Attenzione:]
  #h(0.3em)
  #corpo
]

// Ricorda - concetti chiave
#let ricorda(corpo) = block(
  width: 100%,
  breakable: false,
  inset: (x: 12pt, y: 10pt),
  radius: 4pt,
  stroke: 1.5pt + blue.darken(20%),
  fill: blue.lighten(90%),
)[
  #text(weight: "bold", fill: blue.darken(30%))[Da ricordare:]
  #v(4pt)
  #corpo
]
