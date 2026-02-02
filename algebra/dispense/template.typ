// Template per le dispense di Algebra Lineare

// Configurazione pagina e testo
#let conf(doc) = {
  set document(title: "Algebra Lineare - Dispense", author: "Diego")
  set page(paper: "a4", margin: 2cm, numbering: "1")
  set text(font: "New Computer Modern", size: 11pt, lang: "it")
  set heading(numbering: "1.1")
  set math.equation(numbering: "(1)")

  doc
}

// Box definizione (blu)
#let definizione(titolo, corpo) = block(
  width: 100%,
  inset: 10pt,
  stroke: (left: 2pt + blue),
  fill: blue.lighten(95%),
)[
  *Definizione* (#titolo) \ #corpo
]

// Box teorema (rosso)
#let teorema(titolo, corpo) = block(
  width: 100%,
  inset: 10pt,
  stroke: (left: 2pt + red),
  fill: red.lighten(95%),
)[
  *Teorema* (#titolo) \ #corpo
]

// Box esempio (verde)
#let esempio(corpo) = block(
  width: 100%,
  inset: 10pt,
  stroke: (left: 2pt + green),
  fill: green.lighten(95%),
)[
  *Esempio:* \ #corpo
]

// Box nota (arancione)
#let nota(corpo) = block(
  width: 100%,
  inset: 8pt,
  stroke: (left: 2pt + orange),
  fill: orange.lighten(95%),
)[
  *Nota:* #corpo
]

// Box dimostrazione (grigio)
#let dimostrazione(corpo) = block(
  width: 100%,
  inset: 10pt,
  stroke: (left: 2pt + gray),
  fill: gray.lighten(95%),
)[
  *Dimostrazione:* \ #corpo
  #align(right)[$square.stroked$]
]

// Separatore tra lezioni
#let nuova-lezione(numero, titolo) = {
  pagebreak()
  align(center)[
    #text(size: 18pt, weight: "bold")[Lezione #numero]

    #text(size: 14pt)[#titolo]

    #v(0.3cm)
    #line(length: 50%)
    #v(0.5cm)
  ]
}
