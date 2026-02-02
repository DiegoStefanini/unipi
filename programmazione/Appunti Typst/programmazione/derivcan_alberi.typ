#import "../template.typ": *

=== Alberi di Derivazione

=== Derivazione Canonica

#definition(title: "Derivazione canonica sinistra")[
  Una derivazione è *canonica sinistra* se, ad ogni passo, il simbolo non terminale sostituito è sempre quello più a *sinistra* nella stringa.
]

#definition(title: "Derivazione canonica destra")[
  Una derivazione è *canonica destra* se, ad ogni passo, il simbolo non terminale sostituito è sempre quello più a *destra* nella stringa.
]

#example(title: "Derivazioni canoniche a confronto")[
  Data la grammatica:
  - Exp $::=$ Num $|$ Exp $+$ Exp
  - Num $::=$ 0 $|$ 1 $|$ 2 $|$ ... $|$ 9

  Deriviamo la stringa `3 + 5 + 2`:

  *Derivazione canonica sinistra* (sostituiamo sempre il non-terminale più a sinistra):
  $
  & "Exp" \
  arrow.r & "Exp" + "Exp" \
  arrow.r & "Exp" + "Exp" + "Exp" \
  arrow.r & "Num" + "Exp" + "Exp" \
  arrow.r & 3 + "Exp" + "Exp" \
  arrow.r & 3 + "Num" + "Exp" \
  arrow.r & 3 + 5 + "Exp" \
  arrow.r & 3 + 5 + "Num" \
  arrow.r & 3 + 5 + 2
  $

  *Derivazione canonica destra* (sostituiamo sempre il non-terminale più a destra):
  $
  & "Exp" \
  arrow.r & "Exp" + "Exp" \
  arrow.r & "Exp" + "Num" \
  arrow.r & "Exp" + 2 \
  arrow.r & "Exp" + "Exp" + 2 \
  arrow.r & "Exp" + "Num" + 2 \
  arrow.r & "Exp" + 5 + 2 \
  arrow.r & "Num" + 5 + 2 \
  arrow.r & 3 + 5 + 2
  $
]

#note[
  Entrambe le derivazioni producono la stessa stringa, ma con ordini di sostituzione diversi.
]

=== Alberi di derivazione

#definition(title: "Albero di derivazione (Parse Tree)")[
  Un *albero di derivazione* è una rappresentazione grafica della derivazione di una stringa che astrae dall'ordine di applicazione delle produzioni:
  - La *radice* è il simbolo iniziale
  - I *nodi interni* sono non-terminali
  - Le *foglie* sono terminali
  - I figli di un nodo corrispondono alla parte destra di una produzione
]

#example(title: "Costruzione dell'albero di derivazione")[
  Per la stringa `3 + 5` con la grammatica Exp $::=$ Num $|$ Exp $+$ Exp:

  ```
            Exp
           / | \
         Exp + Exp
          |     |
         Num   Num
          |     |
          3     5
  ```

  L'albero si legge così:
  - Exp si espande in Exp + Exp
  - Il primo Exp diventa Num, che diventa 3
  - Il secondo Exp diventa Num, che diventa 5
]

#note[
  Derivazioni canoniche diverse (sinistra e destra) possono produrre lo *stesso albero* di derivazione. L'albero cattura la *struttura* della derivazione, non l'*ordine* delle sostituzioni.
]

=== Valutazione degli alberi

La valutazione di un'espressione segue la struttura dell'albero:
- Si valutano prima i *sottoalberi* (ricorsivamente)
- Poi si applica l'operatore alla radice

#example(title: "Valutazione")[
  Per l'albero di `3 + 5`:
  + Valuta il sottoalbero sinistro: 3
  + Valuta il sottoalbero destro: 5
  + Applica l'operatore +: $3 + 5 = 8$
]

=== Ambiguità

#definition(title: "Grammatica ambigua")[
  Una grammatica è *ambigua* se esiste almeno una stringa del linguaggio che ammette *due o più alberi di derivazione* distinti.
]

#example(title: "Ambiguità: 3 + 5 × 2")[
  Con la grammatica Exp $::=$ Num $|$ Exp $+$ Exp $|$ Exp $times$ Exp, la stringa `3 + 5 × 2` ha due alberi possibili:

  *Albero 1* (interpreta come $(3 + 5) times 2$):
  ```
            Exp
           / | \
         Exp × Exp
        / | \   |
      Exp + Exp Num
       |     |   |
      Num   Num  2
       |     |
       3     5
  ```
  Valore: $(3 + 5) times 2 = 16$

  *Albero 2* (interpreta come $3 + (5 times 2)$):
  ```
            Exp
           / | \
         Exp + Exp
          |   / | \
         Num Exp × Exp
          |   |     |
          3  Num   Num
              |     |
              5     2
  ```
  Valore: $3 + (5 times 2) = 13$
]

#note(title: "Conseguenza dell'ambiguità")[
  La stessa stringa può avere *significati diversi*! Questo è un problema grave per un linguaggio di programmazione.
]

=== Risoluzione dell'ambiguità

Per eliminare l'ambiguità si può:
+ *Modificare la grammatica* introducendo livelli di precedenza
+ *Usare parentesi* per forzare l'ordine di valutazione

#example(title: "Grammatica non ambigua con precedenza")[
  Exp $::=$ Term $|$ Exp $+$ Term \
  Term $::=$ Factor $|$ Term $times$ Factor \
  Factor $::=$ Num $|$ $($ Exp $)$ \
  Num $::=$ 0 $|$ 1 $|$ ... $|$ 9

  Con questa grammatica, `3 + 5 × 2` ha un solo albero possibile che rispetta la precedenza: $times$ prima di $+$.
]

#note[
  Non sempre è possibile eliminare l'ambiguità: esistono *linguaggi inerentemente ambigui* per cui ogni grammatica che li genera è ambigua.
]
