// ========================================
// Template - Ambienti (stile accademico)
// ========================================

#let definition(title: none, body) = {
  v(0.4em)
  block(
    width: 100%,
    inset: (left: 1em, top: 0.5em, bottom: 0.5em, right: 0.5em),
    stroke: (left: 2pt + black),
  )[
    #set text(size: 10pt)
    #set par(justify: true)
    *Definizione#if title != none [ (#title)].* #body
  ]
  v(0.4em)
}

#let theorem(title: none, body) = {
  v(0.4em)
  block(
    width: 100%,
    inset: (left: 1em, top: 0.5em, bottom: 0.5em, right: 0.5em),
    stroke: (left: 2pt + black),
  )[
    #set text(size: 10pt)
    #set par(justify: true)
    *Teorema#if title != none [ (#title)].* #body
  ]
  v(0.4em)
}

#let lemma(title: none, body) = {
  v(0.4em)
  block(
    width: 100%,
    inset: (left: 1em, top: 0.5em, bottom: 0.5em, right: 0.5em),
    stroke: (left: 2pt + black),
  )[
    #set text(size: 10pt)
    #set par(justify: true)
    *Lemma#if title != none [ (#title)].* #body
  ]
  v(0.4em)
}

#let corollary(title: none, body) = {
  v(0.4em)
  block(
    width: 100%,
    inset: (left: 1em, top: 0.5em, bottom: 0.5em, right: 0.5em),
    stroke: (left: 2pt + black),
  )[
    #set text(size: 10pt)
    #set par(justify: true)
    *Corollario#if title != none [ (#title)].* #body
  ]
  v(0.4em)
}

#let example(title: none, body) = {
  v(0.4em)
  block(
    width: 100%,
    inset: (left: 1em, top: 0.5em, bottom: 0.5em, right: 0.5em),
    stroke: (left: 1pt + luma(120)),
  )[
    #set text(size: 10pt)
    #set par(justify: true)
    _Esempio#if title != none [ (#title)]._  #body
  ]
  v(0.4em)
}

#let note(title: none, body) = {
  v(0.4em)
  block(
    width: 100%,
    inset: (left: 1em, top: 0.5em, bottom: 0.5em, right: 0.5em),
    stroke: (left: 1pt + luma(120)),
  )[
    #set text(size: 10pt)
    #set par(justify: true)
    *Nota#if title != none [ (#title)].*  #body
  ]
  v(0.4em)
}

#let observation(body) = {
  v(0.4em)
  block(
    width: 100%,
    inset: (left: 1em, top: 0.5em, bottom: 0.5em, right: 0.5em),
    stroke: (left: 1pt + luma(120)),
  )[
    #set text(size: 10pt)
    #set par(justify: true)
    *Osservazione.*  #body
  ]
  v(0.4em)
}

#let demonstration(body) = {
  v(0.4em)
  block(
    width: 100%,
    inset: (left: 1em, top: 0.5em, bottom: 0.5em, right: 0.5em),
  )[
    #set text(size: 10pt)
    #set par(justify: true)
    _Dimostrazione._  #body #h(1fr) $square$
  ]
  v(0.4em)
}
