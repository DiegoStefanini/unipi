// ========================================
// Template - Ambienti (stile accademico migliorato)
// ========================================

// Colori per gli ambienti
#let def-color = rgb("#1e3a5f")      // Blu scuro per definizioni
#let thm-color = rgb("#1a5c3a")      // Verde scuro per teoremi
#let ex-color = rgb("#b35900")       // Arancione per esempi
#let note-color = rgb("#4a4a4a")     // Grigio per note

#let def-bg = rgb("#e8f0f8")         // Sfondo blu chiaro
#let thm-bg = rgb("#e8f5ec")         // Sfondo verde chiaro
#let ex-bg = rgb("#fff8f0")          // Sfondo arancione chiaro
#let code-bg = rgb("#f5f5f5")        // Sfondo grigio per codice

// Contatori per numerazione automatica
#let definition-counter = counter("definition")
#let theorem-counter = counter("theorem")
#let lemma-counter = counter("lemma")
#let corollary-counter = counter("corollary")
#let example-counter = counter("example")

// ========================================
// Definizione (box blu con numerazione)
// ========================================
#let definition(title: none, body) = {
  v(0.5em)
  definition-counter.step()
  block(
    width: 100%,
    inset: (left: 1em, top: 0.7em, bottom: 0.7em, right: 0.8em),
    fill: def-bg,
    stroke: (left: 3pt + def-color),
    radius: (right: 4pt),
  )[
    #set text(size: 10pt)
    #set par(justify: true)
    #text(fill: def-color, weight: "bold")[Definizione #context definition-counter.display()#if title != none [ (#title)].] #body
  ]
  v(0.5em)
}

// ========================================
// Teorema (box verde con numerazione)
// ========================================
#let theorem(title: none, body) = {
  v(0.5em)
  theorem-counter.step()
  block(
    width: 100%,
    inset: (left: 1em, top: 0.7em, bottom: 0.7em, right: 0.8em),
    fill: thm-bg,
    stroke: (left: 3pt + thm-color),
    radius: (right: 4pt),
  )[
    #set text(size: 10pt)
    #set par(justify: true)
    #text(fill: thm-color, weight: "bold")[Teorema #context theorem-counter.display()#if title != none [ (#title)].] #body
  ]
  v(0.5em)
}

// ========================================
// Lemma (box verde chiaro con numerazione)
// ========================================
#let lemma(title: none, body) = {
  v(0.5em)
  lemma-counter.step()
  block(
    width: 100%,
    inset: (left: 1em, top: 0.7em, bottom: 0.7em, right: 0.8em),
    fill: thm-bg.lighten(30%),
    stroke: (left: 3pt + thm-color.lighten(20%)),
    radius: (right: 4pt),
  )[
    #set text(size: 10pt)
    #set par(justify: true)
    #text(fill: thm-color, weight: "bold")[Lemma #context lemma-counter.display()#if title != none [ (#title)].] #body
  ]
  v(0.5em)
}

// ========================================
// Corollario (box verde chiaro con numerazione)
// ========================================
#let corollary(title: none, body) = {
  v(0.5em)
  corollary-counter.step()
  block(
    width: 100%,
    inset: (left: 1em, top: 0.7em, bottom: 0.7em, right: 0.8em),
    fill: thm-bg.lighten(30%),
    stroke: (left: 3pt + thm-color.lighten(20%)),
    radius: (right: 4pt),
  )[
    #set text(size: 10pt)
    #set par(justify: true)
    #text(fill: thm-color, weight: "bold")[Corollario #context corollary-counter.display()#if title != none [ (#title)].] #body
  ]
  v(0.5em)
}

// ========================================
// Esempio (box arancione con numerazione)
// ========================================
#let example(title: none, body) = {
  v(0.5em)
  example-counter.step()
  block(
    width: 100%,
    inset: (left: 1em, top: 0.7em, bottom: 0.7em, right: 0.8em),
    fill: ex-bg,
    stroke: (left: 3pt + ex-color),
    radius: (right: 4pt),
  )[
    #set text(size: 10pt)
    #set par(justify: true)
    #text(fill: ex-color, weight: "bold")[Esempio #context example-counter.display()#if title != none [ (#title)].] #body
  ]
  v(0.5em)
}

// ========================================
// Nota (box grigio senza numerazione)
// ========================================
#let note(title: none, body) = {
  v(0.5em)
  block(
    width: 100%,
    inset: (left: 1em, top: 0.7em, bottom: 0.7em, right: 0.8em),
    fill: luma(245),
    stroke: (left: 2pt + note-color),
    radius: (right: 4pt),
  )[
    #set text(size: 10pt)
    #set par(justify: true)
    #text(fill: note-color, weight: "bold")[Nota#if title != none [ (#title)].] #body
  ]
  v(0.5em)
}

// ========================================
// Osservazione (box grigio senza numerazione)
// ========================================
#let observation(body) = {
  v(0.5em)
  block(
    width: 100%,
    inset: (left: 1em, top: 0.7em, bottom: 0.7em, right: 0.8em),
    fill: luma(245),
    stroke: (left: 2pt + note-color),
    radius: (right: 4pt),
  )[
    #set text(size: 10pt)
    #set par(justify: true)
    #text(fill: note-color, weight: "bold")[Osservazione.] #body
  ]
  v(0.5em)
}

// ========================================
// Dimostrazione (senza box, con QED)
// ========================================
#let demonstration(body) = {
  v(0.5em)
  block(
    width: 100%,
    inset: (left: 1em, top: 0.5em, bottom: 0.5em, right: 0.5em),
  )[
    #set text(size: 10pt)
    #set par(justify: true)
    #text(style: "italic")[Dimostrazione.] #body #h(1fr) $square.filled$
  ]
  v(0.5em)
}

// ========================================
// Ambiente Codice/Algoritmo (nuovo)
// ========================================
#let algorithm(title: none, body) = {
  v(0.5em)
  block(
    width: 100%,
    inset: (x: 1em, y: 0.8em),
    fill: code-bg,
    stroke: 1pt + luma(200),
    radius: 4pt,
  )[
    #if title != none [
      #text(size: 9pt, weight: "bold", fill: luma(80))[#title]
      #v(0.3em)
    ]
    #set text(size: 9.5pt, font: "Consolas")
    #set par(justify: false, leading: 0.6em)
    #body
  ]
  v(0.5em)
}

// ========================================
// Codice inline
// ========================================
#let code(body) = {
  box(
    fill: code-bg,
    inset: (x: 0.3em, y: 0.1em),
    radius: 2pt,
  )[#text(size: 9.5pt, font: "Consolas")[#body]]
}

// ========================================
// Nota a margine (per concetti chiave)
// ========================================
#let margin-note(body) = {
  place(
    right,
    dx: 2.8cm,
    block(
      width: 2.5cm,
      inset: 0.3em,
    )[
      #set text(size: 8pt, fill: luma(100))
      #set par(justify: false, leading: 0.5em)
      #body
    ]
  )
}

// ========================================
// Box concetto chiave (per ripasso)
// ========================================
#let keypoint(body) = {
  v(0.3em)
  block(
    width: 100%,
    inset: 0.6em,
    fill: rgb("#fff3cd"),
    stroke: 1pt + rgb("#ffc107"),
    radius: 4pt,
  )[
    #set text(size: 9.5pt)
    #set par(justify: true)
    #body
  ]
  v(0.3em)
}

// ========================================
// Funzione per resettare i contatori per capitolo
// ========================================
#let reset-counters() = {
  definition-counter.update(0)
  theorem-counter.update(0)
  lemma-counter.update(0)
  corollary-counter.update(0)
  example-counter.update(0)
}
