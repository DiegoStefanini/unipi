#import "../template.typ": *

= Matrici e Sistemi Lineari

L'algebra lineare si occupa dello studio di strutture algebriche fondamentali --- spazi vettoriali, trasformazioni lineari, matrici --- e delle loro applicazioni. Il problema centrale che guida l'intera trattazione è la *risoluzione dei sistemi lineari*: gran parte della teoria che svilupperemo nasce dalla necessità di comprendere quando un sistema ha soluzioni, quante ne ha, e come calcolarle in modo sistematico.

In questo capitolo introduciamo gli strumenti essenziali: le matrici come oggetti algebrici, le operazioni che si possono compiere su di esse, e il metodo di eliminazione di Gauss che permette di risolvere qualsiasi sistema lineare. Lungo il percorso, incontreremo concetti chiave come il rango, la matrice inversa e il teorema di Rouché-Capelli, che fornisce il criterio definitivo per l'esistenza delle soluzioni.

== Matrici

#definizione("Matrice")[
  Una *matrice* $A$ di dimensione $m times n$ a coefficienti in un campo $KK$ è una tabella rettangolare di $m dot n$ elementi disposti su $m$ righe e $n$ colonne:
  $
  A = mat(
    a_(1 1), a_(1 2), dots, a_(1 n);
    a_(2 1), a_(2 2), dots, a_(2 n);
    dots.v, dots.v, dots.down, dots.v;
    a_(m 1), a_(m 2), dots, a_(m n)
  ) in M_(m times n)(KK)
  $
  L'elemento $a_(i j)$ si trova nella riga $i$ e nella colonna $j$. Si scrive anche $A(i, j) = a_(i j)$.
]

L'insieme di tutte le matrici $m times n$ a coefficienti in $KK$ si denota con $M_(m times n)(KK)$. Quando $m = n$, la matrice si dice *quadrata* di ordine $n$.

=== Operazioni tra Matrici

Le matrici non sono soltanto tabelle di numeri: su di esse si definiscono operazioni algebriche che le rendono oggetti con una struttura ricca. Introduciamo le tre operazioni fondamentali.

#definizione("Somma di Matrici")[
  Date due matrici $A = (a_(i j))$ e $B = (b_(i j))$ di dimensione $m times n$, la *somma* $A + B$ è la matrice di dimensione $m times n$ definita da:
  $
  (A + B)_(i j) = a_(i j) + b_(i j)
  $
]

#nota[
  La somma è definita solo per matrici delle *stesse dimensioni*: non ha senso sommare una matrice $2 times 3$ con una $3 times 2$.
]

#definizione("Prodotto per uno Scalare")[
  Data una matrice $A in M_(m times n)(KK)$ e uno scalare $lambda in KK$, il *prodotto per scalare* $lambda A$ è la matrice definita da:
  $
  (lambda A)_(i j) = lambda dot a_(i j)
  $
]

#esempio[
  $
  2 dot mat(1, 0; 0, 1; 1, 2) = mat(2, 0; 0, 2; 2, 4)
  $
]

#definizione("Prodotto Matriciale")[
  Date $A in M_(m times k)(KK)$ e $B in M_(k times n)(KK)$, il *prodotto* $C = A B$ è la matrice $C in M_(m times n)(KK)$ definita da:
  $
  c_(i j) = sum_(l=1)^k a_(i l) dot b_(l j)
  $
  In altre parole, l'elemento in posizione $(i, j)$ del prodotto si ottiene come *prodotto scalare* della riga $i$-esima di $A$ per la colonna $j$-esima di $B$.
]

#attenzione[
  Il prodotto $A B$ è definito solo quando il numero di *colonne* di $A$ è uguale al numero di *righe* di $B$.
]

#esempio[
  $
  A = mat(1, 4; 3, 0; 1, 2)_(3 times 2) quad B = mat(0, 3, 4; 1, 0, 7)_(2 times 3)
  $

  $
  A B = mat(
    1 dot 0 + 4 dot 1, 1 dot 3 + 4 dot 0, 1 dot 4 + 4 dot 7;
    3 dot 0 + 0 dot 1, 3 dot 3 + 0 dot 0, 3 dot 4 + 0 dot 7;
    1 dot 0 + 2 dot 1, 1 dot 3 + 2 dot 0, 1 dot 4 + 2 dot 7
  ) = mat(4, 3, 32; 0, 9, 12; 2, 3, 18)_(3 times 3)
  $
]

=== Proprietà delle Operazioni Matriciali

Le operazioni matriciali soddisfano molte delle proprietà algebriche familiari, con una differenza cruciale: il prodotto *non è commutativo*.

Date matrici $A, B in M_(m times k)(KK)$ e $C, D in M_(k times n)(KK)$, valgono le seguenti proprietà:

- *Distributiva:* $(A + B)(C + D) = A C + A D + B C + B D$
- *Distributiva a sinistra:* $A(B + C) = A B + A C$
- *Associatività del prodotto:* $(A B) C = A (B C)$
- *Associatività scalare:* $(lambda mu) A = lambda (mu A)$
- *Distributiva scalare:* $lambda (A + B) = lambda A + lambda B$

#attenzione[
  Il prodotto tra matrici *non è commutativo*: in generale $A B != B A$.

  Di conseguenza, $(A + B)^2 = A^2 + A B + B A + B^2 != A^2 + 2 A B + B^2$.
]

#esempio[
  $
  A = mat(1, 1; 2, 3) quad B = mat(-3, 4; 5, 2)
  $

  $
  A B = mat(2, 6; 9, 14) quad B A = mat(5, 9; 9, 11)
  $

  Si verifica immediatamente che $A B != B A$.
]

#definizione("Matrice Identità")[
  La *matrice identità* $I_n in M_(n times n)(KK)$ è la matrice quadrata con $1$ sulla diagonale principale e $0$ altrove:
  $
  I_n = mat(
    1, 0, dots, 0;
    0, 1, dots, 0;
    dots.v, dots.v, dots.down, dots.v;
    0, 0, dots, 1
  )
  $

  La matrice identità è l'*elemento neutro* del prodotto: per ogni $A in M_(m times n)(KK)$,
  $ I_m dot A = A = A dot I_n $
]

=== Matrice Trasposta

#definizione("Matrice Trasposta")[
  Data una matrice $A = (a_(i j)) in M_(m times n)(KK)$, la sua *trasposta* $""^t A in M_(n times m)(KK)$ è la matrice definita da:
  $
  (""^t A)_(i j) = a_(j i)
  $
  In altre parole, le righe di $A$ diventano le colonne di $""^t A$ e viceversa.
]

#esempio[
  $
  A = mat(1, 7, 3; -1, 4, 0) in M_(2 times 3)(RR)
  quad arrow.r.double quad
  ""^t A = mat(1, -1; 7, 4; 3, 0) in M_(3 times 2)(RR)
  $
]

La trasposizione soddisfa le seguenti proprietà:

#proposizione("Proprietà della Trasposizione")[
  Per ogni $A, B$ di dimensioni compatibili:
  + $""^t(A + B) = ""^t A + ""^t B$
  + $""^t(lambda A) = lambda dot ""^t A$
  + $""^t(A B) = ""^t B dot ""^t A$ #h(1em) _(si noti l'inversione dell'ordine)_
  + $""^t(""^t A) = A$
]

== Numeri Complessi

Prima di proseguire, è utile ricordare che i coefficienti delle nostre matrici appartengono a un *campo* $KK$, che nei casi concreti sarà $RR$ oppure $CC$. Richiamiamo brevemente la struttura dei numeri complessi.

#definizione("Insieme dei Numeri Complessi")[
  L'insieme dei *numeri complessi* è:
  $
  CC = {a + i b : a, b in RR}
  $
  dove $i$ è l'*unità immaginaria*, definita dalla proprietà $i^2 = -1$.

  Per $z = a + i b$, il numero $a$ si dice *parte reale* e $b$ *parte immaginaria*.
]

*Operazioni:*
- *Somma:* $(2 + 3i) + (4 - i) = 6 + 2i$
- *Prodotto:* $(2 + 3i)(4 - i) = 8 - 2i + 12i - 3i^2 = 11 + 10i$

#definizione("Complesso Coniugato")[
  Il *coniugato* di $z = a + b i$ è $overline(z) = a - b i$.

  *Proprietà fondamentale:* $z dot overline(z) = a^2 + b^2 in RR_(>= 0)$
]

Per dividere numeri complessi, si moltiplica numeratore e denominatore per il coniugato del denominatore:

#esempio[
  $
  (2 + 3i) / (4 - i) = ((2 + 3i)(4 + i)) / ((4 - i)(4 + i)) = (8 + 2i + 12i + 3i^2) / (16 + 1) = (5 + 14i) / 17
  $
]

#nota[
  Si può dimostrare che ogni polinomio di grado $n >= 1$ a coefficienti complessi ammette esattamente $n$ radici in $CC$, contate con la loro molteplicità (_Teorema Fondamentale dell'Algebra_). La dimostrazione esula dagli scopi di questo corso, ma il risultato garantisce che $CC$ è *algebricamente chiuso*: ogni equazione polinomiale ha sempre soluzione.
]

== Sistemi Lineari

Passiamo ora al problema centrale: la risoluzione dei sistemi di equazioni lineari.

#definizione("Sistema Lineare")[
  Un *sistema lineare* di $m$ equazioni in $n$ incognite a coefficienti in $KK$ è un sistema della forma:
  $
  cases(
    a_(1 1) x_1 + a_(1 2) x_2 + dots + a_(1 n) x_n = b_1,
    a_(2 1) x_1 + a_(2 2) x_2 + dots + a_(2 n) x_n = b_2,
    dots.v,
    a_(m 1) x_1 + a_(m 2) x_2 + dots + a_(m n) x_n = b_m
  )
  $
  dove $a_(i j), b_i in KK$ sono i *coefficienti* e i *termini noti*, mentre $x_1, dots, x_n$ sono le incognite.
]

A ogni sistema lineare si associano due matrici fondamentali:

#definizione("Matrice dei Coefficienti e Matrice Completa")[
  La *matrice dei coefficienti* (o matrice incompleta) è:
  $
  A = mat(
    a_(1 1), a_(1 2), dots, a_(1 n);
    a_(2 1), a_(2 2), dots, a_(2 n);
    dots.v, dots.v, dots.down, dots.v;
    a_(m 1), a_(m 2), dots, a_(m n)
  ) in M_(m times n)(KK)
  $

  La *matrice completa* (o matrice aumentata) include anche i termini noti:
  $
  C = (A | b) = mat(
    a_(1 1), a_(1 2), dots, a_(1 n), |, b_1;
    a_(2 1), a_(2 2), dots, a_(2 n), |, b_2;
    dots.v, dots.v, dots.down, dots.v, |, dots.v;
    a_(m 1), a_(m 2), dots, a_(m n), |, b_m
  )
  $
]

#esempio[
  Il sistema $cases(4x + 2y = 20, x + y = 7)$ ha matrice completa:
  $
  C = mat(4, 2, |, 20; 1, 1, |, 7)
  $
]

=== Forma matriciale $A x = b$

Ogni sistema lineare si può scrivere in modo compatto nella forma matriciale $A x = b$, dove $A$ è la matrice dei coefficienti, $x$ il vettore colonna delle incognite e $b$ il vettore dei termini noti:

#esempio[
  Il sistema $cases(x + y + z = 1, x - 2y + 3z = 2)$ si scrive:
  $
  underbrace(mat(1, 1, 1; 1, -2, 3), A) dot underbrace(mat(x; y; z), x) = underbrace(mat(1; 2), b)
  $
]

#definizione("Sistema Omogeneo")[
  Un sistema lineare si dice *omogeneo* quando $b = 0$, cioè tutti i termini noti sono nulli:
  $ A x = 0 $
  Un sistema omogeneo ammette sempre almeno la *soluzione banale* $x = 0$.
]

== Operazioni Elementari sulle Righe

Per risolvere un sistema lineare, operiamo sulla sua matrice completa attraverso trasformazioni che *non alterano l'insieme delle soluzioni*.

#definizione("Operazioni Elementari sulle Righe")[
  Le seguenti operazioni su una matrice si dicono *elementari per righe*:
  + *Combinazione:* sostituire una riga con la somma di sé stessa e un multiplo di un'altra riga ($R_i arrow.r R_i + lambda R_j$)
  + *Moltiplicazione:* moltiplicare una riga per uno scalare non nullo ($R_i arrow.r lambda R_i$, con $lambda != 0$)
  + *Scambio:* scambiare due righe tra loro ($R_i arrow.l.r R_j$)
]

#proposizione("Invarianza delle soluzioni")[
  Le operazioni elementari sulle righe della matrice completa di un sistema lineare *non modificano l'insieme delle soluzioni* del sistema.
]

== Forma Ridotta per Righe

L'idea centrale del metodo di Gauss è trasformare la matrice del sistema in una forma particolarmente semplice, detta *forma a scala* (o ridotta per righe), dalla quale le soluzioni si leggono immediatamente.

#definizione("Pivot")[
  Data una riga non nulla di una matrice, il *pivot* è il primo elemento non nullo della riga, procedendo da sinistra a destra.
]

#definizione("Forma Ridotta per Righe")[
  Una matrice è in *forma ridotta per righe* (o a scala, o a gradini) se:
  + Tutte le righe nulle si trovano in fondo alla matrice
  + Il pivot di ogni riga si trova in una colonna strettamente a destra del pivot della riga precedente

  In simboli: se $P_i$ e $P_j$ sono i pivot delle righe $i$ e $j$ con $i < j$, allora $P_i$ si trova in una colonna precedente a quella di $P_j$.
]

#esempio[
  Le seguenti matrici sono in forma ridotta per righe:
  $
  mat(1, 3, 2; 0, 0, 4; 0, 0, 0) quad quad
  mat(2, 1, 0, 5; 0, 3, 1, 2; 0, 0, 0, 7)
  $
  I pivot sono evidenziati dalla struttura a scala.
]

== Algoritmo di Gauss

L'algoritmo di Gauss (o eliminazione gaussiana) trasforma una matrice qualsiasi in forma ridotta per righe attraverso operazioni elementari. Descriviamo la procedura passo per passo.

#proposizione("Algoritmo di riduzione per righe")[
  Data una matrice $A in M_(m times n)(KK)$, la seguente procedura produce una matrice in forma ridotta per righe:

  + *Individuare la colonna:* scorrere le colonne da sinistra finché non se ne trova una non interamente nulla
  + *Posizionare il pivot:* se necessario, scambiare le righe in modo che l'elemento non nullo si trovi nella prima riga disponibile
  + *Normalizzare (opzionale):* dividere la riga del pivot per il valore del pivot stesso, ottenendo un pivot uguale a $1$
  + *Eliminare sotto il pivot:* sottrarre multipli opportuni della riga del pivot da tutte le righe sottostanti, in modo da ottenere zeri sotto il pivot
  + *Ripetere:* applicare la stessa procedura alla sottomatrice ottenuta escludendo la riga del pivot appena trattata
]

#esempio[
  Riduciamo per righe la matrice:
  $
  A = mat(0, 1, 2, 3; 0, 1, 2, 1; -1, 2, 4, 1; -2, 4, 6, 1)
  $

  *Passo 1:* la prima colonna ha elementi non nulli. Scambiamo $R_1 arrow.l.r R_3$ per avere un pivot in posizione $(1,1)$:
  $
  mat(-1, 2, 4, 1; 0, 1, 2, 1; 0, 1, 2, 3; -2, 4, 6, 1)
  $

  *Passo 2:* eliminiamo sotto il pivot. $R_4 arrow.r R_4 - 2 R_1$:
  $
  mat(-1, 2, 4, 1; 0, 1, 2, 1; 0, 1, 2, 3; 0, 0, -2, -1)
  $

  *Passo 3:* nella sottomatrice, il pivot della seconda riga è già in posizione. $R_3 arrow.r R_3 - R_2$:
  $
  mat(-1, 2, 4, 1; 0, 1, 2, 1; 0, 0, 0, 2; 0, 0, -2, -1)
  $

  *Passo 4:* scambiamo $R_3 arrow.l.r R_4$ per mantenere la struttura a scala:
  $
  mat(-1, 2, 4, 1; 0, 1, 2, 1; 0, 0, -2, -1; 0, 0, 0, 2)
  $

  La matrice è ora in forma ridotta per righe, con pivot in posizione $(1,1)$, $(2,2)$, $(3,3)$, $(4,4)$.
]

#nota[
  Le operazioni elementari possono essere eseguite in ordini diversi; ciò che conta è che il risultato finale abbia la struttura a scala.
]

== Forma Completamente Ridotta

La forma ridotta per righe semplifica il sistema, ma non lo risolve del tutto. Per ottenere la soluzione in modo diretto, si prosegue fino alla *forma completamente ridotta*.

#definizione("Forma Completamente Ridotta")[
  Una matrice è in *forma completamente ridotta* (o forma ridotta per righe a scalini ridotta, RREF) se:
  + È in forma ridotta per righe
  + Tutti i pivot sono uguali a $1$
  + Ogni pivot è l'unico elemento non nullo della sua colonna (zeri sia sotto che sopra)
]

#esempio[
  $
  mat(1, 0, 1/4, 0, | , 3;
      0, 1, 0, 0, |, 4;
      0, 0, 0, 1, |, 1)
  $
  è in forma completamente ridotta: i pivot sono tutti $1$, e nelle colonne dei pivot compaiono solo zeri al di fuori del pivot stesso.
]

Per passare dalla forma ridotta per righe alla forma completamente ridotta, si prosegue l'algoritmo *dal basso verso l'alto*: si divide ogni riga per il suo pivot e poi si eliminano gli elementi *sopra* ciascun pivot.

#osservazione[
  Dalla forma completamente ridotta la soluzione di un sistema si legge in modo diretto:
  - Le colonne contenenti un pivot corrispondono alle *variabili pivot* (determinate dal sistema)
  - Le colonne senza pivot corrispondono alle *variabili libere*, che assumono il ruolo di parametri
  - Ogni variabile pivot è uguale al termine noto della sua riga, meno i contributi delle variabili libere. In pratica, basta portare le variabili libere a destra del segno di uguale per ottenere la soluzione parametrica.
]

#teorema("Unicità della Forma Completamente Ridotta")[
  La forma completamente ridotta di una matrice è *unica*: indipendentemente dalla sequenza di operazioni elementari scelta, si ottiene sempre la stessa matrice.
]

#dimostrazione[
  Sia $A in M_(m times n)(KK)$ e supponiamo che esistano due forme completamente ridotte $R$ e $R'$ ottenute da $A$ con sequenze diverse di operazioni elementari.

  Consideriamo il sistema omogeneo $A x = 0$. Le operazioni elementari non alterano le soluzioni, quindi $R x = 0$ e $R' x = 0$ hanno lo stesso insieme di soluzioni $S$.

  Sia $j$ una colonna che contiene un pivot in $R$, diciamo nella riga $i$. Allora dalla forma completamente ridotta, la variabile $x_j$ è determinata univocamente dalle variabili libere. In particolare, esiste una soluzione in cui $x_j$ assume un certo valore fissato una volta assegnate le variabili libere.

  Poiché $S$ è lo stesso per $R$ e $R'$, le colonne pivot devono essere le stesse in entrambe le forme. Inoltre, i coefficienti che esprimono le variabili pivot in funzione delle variabili libere sono determinati univocamente dall'insieme $S$ delle soluzioni.

  Questo si estende al caso non omogeneo considerando che la forma completamente ridotta è determinata dalla struttura dello spazio delle soluzioni di $A x = b$ per ogni possibile $b$. Ne segue che $R = R'$.
]

#esempio[
  Riprendiamo l'esempio del sistema $cases(x + y = 7, 4x + 2y = 8)$.

  *Matrice completa:*
  $
  mat(1, 1, |, 7; 4, 2, |, 8)
  $

  *Passo 1:* $R_2 arrow.r R_2 - 4 R_1$
  $
  mat(1, 1, |, 7; 0, -2, |, -20)
  $

  *Passo 2:* $R_2 arrow.r -1/2 dot R_2$
  $
  mat(1, 1, |, 7; 0, 1, |, 10)
  $

  *Passo 3:* $R_1 arrow.r R_1 - R_2$
  $
  mat(1, 0, |, -3; 0, 1, |, 10)
  $

  La matrice è in forma completamente ridotta. La soluzione si legge direttamente: $(x, y) = (-3, 10)$.
]

== Rango di una Matrice

Il numero di pivot che compaiono nella forma ridotta di una matrice è un invariante fondamentale.

#definizione("Rango")[
  Il *rango* di una matrice $A$, denotato $r(A)$, è il numero di pivot nella sua forma ridotta per righe, ovvero il numero di righe non nulle nella forma a scala.
]

#teorema("Invarianza del Rango")[
  Il rango di una matrice non dipende dalla particolare sequenza di operazioni elementari utilizzata per la riduzione: qualunque percorso di riduzione produce lo stesso numero di pivot.
]

#dimostrazione[
  L'invarianza del rango segue dall'unicità della forma completamente ridotta. Infatti:

  + Ogni matrice $A$ può essere ridotta a un'unica forma completamente ridotta $R$ (per il teorema precedente)
  + Il numero di pivot in $R$ è univocamente determinato: è il numero di righe non nulle
  + Qualunque sequenza di operazioni elementari che riduca $A$ a forma a scala produrrà una matrice con lo stesso numero di righe non nulle

  Per vedere quest'ultimo punto, osserviamo che se $R'$ è una qualsiasi forma a scala di $A$, possiamo proseguire la riduzione fino alla forma completamente ridotta $R$. Il numero di pivot non cambia quando passiamo dalla forma a scala alla forma completamente ridotta (le operazioni di "pulizia" verso l'alto non eliminano né creano pivot). Dunque $R'$ ha lo stesso numero di pivot di $R$.
]

#esempio[
  Calcoliamo il rango di $A in M_(3 times 5)(RR)$:
  $
  A = mat(1, 2, -1, 4, 3; 2, 4, -2, 8, 6; 3, 6, -3, 12, 9)
  $

  $R_2 arrow.r R_2 - 2 R_1$, $R_3 arrow.r R_3 - 3 R_1$:
  $
  mat(1, 2, -1, 4, 3; 0, 0, 0, 0, 0; 0, 0, 0, 0, 0)
  $

  L'unico pivot è in posizione $(1, 1)$: $r(A) = 1$.
]

#esempio[
  $
  A = mat(1, 2, -1, 4, 3; 2, 0, 2, 1, 3; 4, 4, 0, 9, 9)
  $

  $R_2 arrow.r R_2 - 2 R_1$, $R_3 arrow.r R_3 - 4 R_1$:
  $
  mat(1, 2, -1, 4, 3; 0, -4, 4, -7, -3; 0, -4, 4, -7, -3)
  $

  $R_3 arrow.r R_3 - R_2$:
  $
  mat(1, 2, -1, 4, 3; 0, -4, 4, -7, -3; 0, 0, 0, 0, 0)
  $

  I pivot sono in posizione $(1,1)$ e $(2,2)$: $r(A) = 2$.
]

#teorema("Rango e Trasposta")[
  Per ogni matrice $A$:
  $ r(A) = r(""^t A) $
  Il rango di una matrice è uguale al rango della sua trasposta.
]

#dimostrazione[
  Dimostriamo che il rango per righe (numero di righe linearmente indipendenti) coincide con il rango per colonne (numero di colonne linearmente indipendenti).

  Sia $A in M_(m times n)(KK)$ e sia $r = r(A)$ il numero di pivot nella forma ridotta per righe.

  *Rango per righe $<=$ Rango per colonne:*
  Nella forma ridotta $R$ di $A$, le $r$ righe non nulle sono linearmente indipendenti (ogni riga ha un pivot in una posizione dove le righe precedenti hanno zero). Poiché le operazioni elementari sono combinazioni lineari delle righe, le righe di $A$ generano lo stesso spazio delle righe di $R$. Dunque $A$ ha esattamente $r$ righe linearmente indipendenti.

  Ora, le $r$ colonne che contengono i pivot in $R$ sono linearmente indipendenti: infatti, se $c_(j_1), dots, c_(j_r)$ sono le colonne dei pivot, una loro combinazione lineare nulla imporrebbe coefficienti nulli riga per riga, partendo dalla prima (dove solo $c_(j_1)$ ha elemento non nullo).

  *Rango per colonne $<=$ Rango per righe:*
  Applichiamo lo stesso ragionamento alla matrice $""^t A$: il suo rango per righe (che è il rango per colonne di $A$) non può superare il suo rango per colonne (che è il rango per righe di $A$).

  Combinando le due disuguaglianze, si ottiene l'uguaglianza: il numero di righe linearmente indipendenti coincide con il numero di colonne linearmente indipendenti. Quindi $r(A) = r(""^t A)$.
]

== Risoluzione di Sistemi Lineari

Siamo ora in grado di descrivere il metodo completo per risolvere un sistema lineare qualsiasi.

#proposizione("Metodo di Gauss-Jordan")[
  Per risolvere un sistema lineare $A x = b$:
  + Scrivere la matrice completa $C = (A | b)$
  + Ridurre $C$ alla forma completamente ridotta $C'$ tramite operazioni elementari
  + Identificare le *variabili pivot* (corrispondenti alle colonne dei pivot) e le *variabili libere* (le rimanenti)
  + Portare le variabili libere a destra del segno di uguaglianza come *parametri*: il sistema risultante è risolto
]

#esempio[
  Risolvere il sistema:
  $
  cases(
    x + y + z = 1,
    x - 2y + 3z = 2
  )
  $

  *Matrice completa:*
  $
  C = mat(1, 1, 1, |, 1; 1, -2, 3, |, 2)
  $

  $R_2 arrow.r R_2 - R_1$:
  $
  mat(1, 1, 1, |, 1; 0, -3, 2, |, 1)
  $

  $R_2 arrow.r -1/3 dot R_2$:
  $
  mat(1, 1, 1, |, 1; 0, 1, -2/3, |, -1/3)
  $

  $R_1 arrow.r R_1 - R_2$:
  $
  mat(1, 0, 5/3, |, 4/3; 0, 1, -2/3, |, -1/3)
  $

  Le variabili $x$ e $y$ sono variabili pivot; $z$ è variabile libera. Ponendo $z = t$ (parametro), si ottiene:
  $
  cases(
    x = 4/3 - 5/3 t,
    y = -1/3 + 2/3 t,
    z = t
  )
  $

  In forma vettoriale:
  $
  mat(x; y; z) = mat(4/3; -1/3; 0) + t mat(-5/3; 2/3; 1) quad t in RR
  $

  Il sistema ha $infinity^1$ soluzioni, parametrizzate da un parametro.
]

#proposizione("Criterio di Esistenza delle Soluzioni")[
  Un sistema lineare ammette soluzione se e solo se la forma completamente ridotta della sua matrice completa *non ha un pivot nell'ultima colonna* (quella dei termini noti).
]

#esempio[
  Il sistema $cases(x + y = 1, 2x + 2y = 5)$ ha matrice completa:
  $
  mat(1, 1, |, 1; 2, 2, |, 5) arrow.r^(R_2 - 2 R_1) mat(1, 1, |, 1; 0, 0, |, 3)
  $

  La seconda riga corrisponde all'equazione $0 = 3$, che è impossibile. Il pivot nell'ultima colonna segnala che il sistema *non ha soluzioni*.
]

== Teorema di Rouché-Capelli

Il criterio di esistenza delle soluzioni si può esprimere in modo elegante utilizzando il concetto di rango.

#teorema("Rouché-Capelli")[
  Un sistema lineare $A x = b$ ammette soluzione se e solo se il rango della matrice dei coefficienti è uguale al rango della matrice completa:
  $
  r(A) = r(A | b)
  $

  Inoltre, quando il sistema ammette soluzione, la *dimensione dello spazio delle soluzioni* è:
  $
  dim S = n - r(A)
  $
  dove $n$ è il numero di incognite. In altre parole, il numero di parametri liberi nella soluzione è $n - r(A)$.
]

#dimostrazione[
  _Schema di prova._ Riduciamo la matrice completa $(A | b)$ alla forma a scala. Si presentano due casi:

  - Se $r(A) < r(A|b)$, significa che nella forma ridotta esiste una riga in cui tutti i coefficienti delle incognite sono nulli ma il termine noto è non nullo, cioè una riga del tipo $(0 space 0 space dots space 0 space | space c)$ con $c != 0$. Questa riga corrisponde all'equazione $0 = c$, che è impossibile: il sistema non ha soluzioni.

  - Se $r(A) = r(A|b)$, non si presentano equazioni impossibili. Nella forma completamente ridotta, le $r(A)$ variabili pivot sono espresse in funzione delle restanti $n - r(A)$ variabili libere, che fungono da parametri. Se $n - r(A) = 0$ la soluzione è unica; altrimenti si ottiene una famiglia di soluzioni dipendente da $n - r(A)$ parametri.
]

#osservazione[
  Dal teorema seguono tre casi:
  - Se $r(A) != r(A|b)$: il sistema è *impossibile* (nessuna soluzione)
  - Se $r(A) = r(A|b) = n$: il sistema ha un'*unica soluzione* (nessun parametro libero)
  - Se $r(A) = r(A|b) < n$: il sistema ha *infinite soluzioni*, dipendenti da $n - r(A)$ parametri
]

#ricorda[
  - $r(A) != r(A|b)$ $arrow.r.double$ sistema impossibile
  - $r(A) = r(A|b) = n$ $arrow.r.double$ soluzione unica
  - $r(A) = r(A|b) < n$ $arrow.r.double$ $infinity^(n - r(A))$ soluzioni
  - Il numero di parametri liberi è sempre $n - r(A)$
]

== Matrice Inversa

Nella risoluzione del sistema $A x = b$, se la matrice $A$ possiede un'*inversa*, la soluzione si ottiene in modo diretto.

#definizione("Matrice Inversa")[
  Una matrice quadrata $A in M_(n times n)(KK)$ si dice *invertibile* se esiste una matrice $A^(-1) in M_(n times n)(KK)$ tale che:
  $
  A A^(-1) = A^(-1) A = I_n
  $
  La matrice $A^(-1)$ si chiama *inversa* di $A$.
]

#esempio[
  Sia $A = mat(2, 1; 5, 3)$. Si verifica che $A^(-1) = mat(3, -1; -5, 2)$:
  $
  mat(2, 1; 5, 3) mat(3, -1; -5, 2) = mat(6 - 5, -2 + 2; 15 - 15, -5 + 6) = mat(1, 0; 0, 1) = I_2
  $
]

La matrice inversa è importante perché fornisce una formula diretta per la soluzione dei sistemi lineari:

#proposizione("Risoluzione tramite Matrice Inversa")[
  Se $A$ è invertibile, il sistema $A x = b$ ha un'unica soluzione data da:
  $
  x = A^(-1) b
  $
]

#dimostrazione[
  Moltiplicando entrambi i membri di $A x = b$ a sinistra per $A^(-1)$:
  $
  A^(-1)(A x) = A^(-1) b arrow.r.double (A^(-1) A) x = A^(-1) b arrow.r.double I x = A^(-1) b arrow.r.double x = A^(-1) b
  $
]

#proposizione("Proprietà della Matrice Inversa")[
  Se $A$ e $B$ sono matrici invertibili dello stesso ordine:
  + $(A^(-1))^(-1) = A$
  + $(A B)^(-1) = B^(-1) A^(-1)$ #h(1em) _(si noti l'inversione dell'ordine)_
  + $(""^t A)^(-1) = ""^t(A^(-1))$
]

#nota[
  L'inversione dell'ordine nella proprietà $(A B)^(-1) = B^(-1) A^(-1)$ è analoga a quanto accade per la trasposizione: $""^t(A B) = ""^t B dot ""^t A$. In entrambi i casi, l'ordine dei fattori si inverte.
]

=== Calcolo della Matrice Inversa

Come si calcola concretamente l'inversa di una matrice? Il metodo più efficiente utilizza l'algoritmo di Gauss-Jordan applicato a una matrice aumentata particolare.

#proposizione("Metodo di Gauss-Jordan per l'Inversa")[
  Per calcolare l'inversa di una matrice $A in M_(n times n)(KK)$:
  + Costruire la matrice aumentata $(A | I_n)$, affiancando ad $A$ la matrice identità
  + Applicare operazioni elementari per righe fino a ridurre la parte sinistra alla forma completamente ridotta
  + Se la parte sinistra diventa $I_n$, allora la parte destra è $A^(-1)$:
  $
  (A | I_n) arrow.r^"operazioni elementari" (I_n | A^(-1))
  $
  + Se invece nella parte sinistra compare una riga nulla, la matrice $A$ *non è invertibile*
]

#dimostrazione[
  L'idea chiave è che ogni operazione elementare per righe equivale a moltiplicare a sinistra per una opportuna *matrice elementare*. Se una sequenza di operazioni elementari trasforma $A$ in $I_n$, allora esiste un prodotto di matrici elementari $E_k dots E_2 E_1$ tale che:
  $
  E_k dots E_2 E_1 dot A = I_n
  $
  Ma allora $E_k dots E_2 E_1 = A^(-1)$. Applicando le stesse operazioni alla matrice identità:
  $
  E_k dots E_2 E_1 dot I_n = A^(-1)
  $
  Poiché operiamo simultaneamente su $(A | I_n)$, quando la parte sinistra diventa $I_n$, la parte destra diventa proprio $A^(-1)$.
]

#esempio[
  Calcoliamo l'inversa di $A = mat(1, 2; 3, 7)$.

  *Matrice aumentata:*
  $
  (A | I_2) = mat(1, 2, |, 1, 0; 3, 7, |, 0, 1)
  $

  *Passo 1:* $R_2 arrow.r R_2 - 3 R_1$
  $
  mat(1, 2, |, 1, 0; 0, 1, |, -3, 1)
  $

  *Passo 2:* $R_1 arrow.r R_1 - 2 R_2$
  $
  mat(1, 0, |, 7, -2; 0, 1, |, -3, 1)
  $

  La parte sinistra è $I_2$, quindi:
  $
  A^(-1) = mat(7, -2; -3, 1)
  $

  *Verifica:* $A A^(-1) = mat(1, 2; 3, 7) mat(7, -2; -3, 1) = mat(7 - 6, -2 + 2; 21 - 21, -6 + 7) = mat(1, 0; 0, 1) = I_2$ #h(0.5em) $checkmark$
]

#esempio[
  Verifichiamo che $A = mat(1, 2; 2, 4)$ non è invertibile.

  $
  mat(1, 2, |, 1, 0; 2, 4, |, 0, 1) arrow.r^(R_2 - 2 R_1) mat(1, 2, |, 1, 0; 0, 0, |, -2, 1)
  $

  La seconda riga della parte sinistra è nulla: la matrice $A$ *non è invertibile*.
]

#teorema("Criterio di Invertibilità")[
  Una matrice quadrata $A in M_(n times n)(KK)$ è invertibile se e solo se $r(A) = n$, cioè se e solo se la sua forma ridotta per righe è la matrice identità $I_n$.
]

#dimostrazione[
  ($arrow.r.double$) Se $A$ è invertibile, il sistema $A x = b$ ha soluzione unica $x = A^(-1) b$ per ogni $b$. In particolare, per ogni vettore della base canonica $e_i$, esiste un unico $x$ tale che $A x = e_i$. Questo implica che il sistema ha sempre soluzione unica, dunque $r(A) = n$ (nessuna variabile libera).

  ($arrow.l.double$) Se $r(A) = n$, allora la forma ridotta per righe di $A$ è $I_n$ (tutti i pivot presenti, uno per colonna). Applicando il metodo di Gauss-Jordan alla matrice $(A | I_n)$, si ottiene $(I_n | A^(-1))$, dunque $A$ è invertibile.
]

== Esercizi

Gli esercizi seguenti coprono gli argomenti principali del capitolo. Le soluzioni sintetiche si trovano nell'Appendice.

=== Operazioni tra Matrici

#esercizio[
  Date le matrici
  $
  A = mat(1, 2; 3, 4) quad B = mat(0, -1; 2, 5)
  $
  calcolare $A + B$, $3A$, $A B$ e $B A$. Verificare che $A B != B A$.
]

#esercizio[
  Date le matrici
  $
  A = mat(1, 0, 2; -1, 3, 1) quad B = mat(2, 1; 0, -1; 4, 3)
  $
  calcolare $A B$ e dire se il prodotto $B A$ è definito. Se sì, calcolarlo e confrontare le dimensioni dei due risultati.
]

#esercizio[
  Sia $A = mat(1, 1; 0, 1)$. Calcolare $A^2$, $A^3$ e congetturare una formula per $A^n$.
]

=== Riduzione per Righe e Algoritmo di Gauss

#esercizio[
  Ridurre alla forma a scala la matrice
  $
  A = mat(1, 2, 3; 2, 4, 7; 3, 6, 10)
  $
  e determinare il rango di $A$.
]

#esercizio[
  Ridurre alla forma completamente ridotta (RREF) la matrice
  $
  mat(1, 3, 1, |, 2; 2, 6, 4, |, 8; 0, 0, 2, |, 4)
  $
  e identificare variabili pivot e variabili libere.
]

=== Risoluzione di Sistemi Lineari

#esercizio[
  Risolvere il sistema lineare:
  $
  cases(
    x + 2y - z = 3,
    2x + 5y + z = 1,
    3x + 7y = 4
  )
  $
]

#esercizio[
  Determinare per quali valori del parametro $k in RR$ il sistema
  $
  cases(
    x + y + z = 1,
    x + 2y + 3z = 2,
    2x + 3y + (k+3)z = 3
  )
  $
  ammette soluzione unica, infinite soluzioni, o nessuna soluzione.
]

#esercizio[
  Risolvere il sistema omogeneo:
  $
  cases(
    x_1 + 2x_2 + x_3 + x_4 = 0,
    2x_1 + 4x_2 + 3x_3 + 2x_4 = 0
  )
  $
  e descrivere lo spazio delle soluzioni.
]

=== Rango e Rouché-Capelli

#esercizio[
  Sia $A = mat(1, 2, 3; 4, 5, 6; 7, 8, 9)$. Calcolare $r(A)$ e determinare quante soluzioni ha il sistema $A x = b$ con $b = mat(1; 2; 3)$.
]

=== Matrice Inversa

#esercizio[
  Calcolare l'inversa della matrice $A = mat(1, 2; 3, 7)$ utilizzando la riduzione per righe sulla matrice aumentata $(A | I_2)$.
]
