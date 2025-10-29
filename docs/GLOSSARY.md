# Glossario Terminologico

Questo glossario definisce le scelte di traduzione per i termini tecnici di Rust. L'obiettivo è mantenere coerenza in tutta la documentazione.

## Principi generali

1. **Termini consolidati**: alcuni termini tecnici restano in inglese perché universalmente riconosciuti
2. **Chiarezza**: privilegiamo la comprensibilità rispetto alla traduzione letterale
3. **Coerenza**: una volta scelto un termine, lo usiamo consistentemente

---

## Termini fondamentali

| Inglese | Italiano | Note |
|---------|----------|------|
| **Ownership** | Proprietà | Concetto fondamentale di Rust |
| **Borrowing** | Prestito | Riferimento temporaneo a un valore |
| **Borrow checker** | Borrow checker | Manteniamo il termine originale |
| **Lifetime** | Tempo di vita | Durata di validità di un riferimento |
| **Move semantics** | Semantica di spostamento | |
| **Reference** | Riferimento | |
| **Mutable** | Mutabile | |
| **Immutable** | Immutabile | |
| **Variable** | Variabile | |
| **Binding** | Binding / Legame | Preferiamo "binding" |
| **Pattern matching** | Pattern matching | Manteniamo il termine originale |
| **Trait** | Trait | Manteniamo il termine originale |
| **Struct** | Struct | Manteniamo il termine originale |
| **Enum** | Enum | Manteniamo il termine originale |
| **Type** | Tipo | |
| **Generic** | Generico | |
| **Closure** | Closure | Manteniamo il termine originale |
| **Iterator** | Iteratore | |
| **Smart pointer** | Puntatore intelligente | |
| **Slice** | Slice | Manteniamo il termine originale |
| **String slice** | String slice | |
| **Array** | Array | Manteniamo il termine originale |
| **Vector** | Vector / Vec | |
| **HashMap** | HashMap | Manteniamo il nome del tipo |
| **Option** | Option | Manteniamo il nome del tipo |
| **Result** | Result | Manteniamo il nome del tipo |
| **Error handling** | Gestione degli errori | |
| **Panic** | Panic | Manteniamo il termine originale |
| **Unwrap** | Unwrap | Manteniamo il termine originale |
| **Macro** | Macro | |
| **Crate** | Crate | Manteniamo il termine originale |
| **Module** | Modulo | |
| **Package** | Package | |
| **Cargo** | Cargo | Nome dello strumento |
| **Thread** | Thread | |
| **Concurrency** | Concorrenza | |
| **Race condition** | Race condition | |
| **Unsafe** | Unsafe | Manteniamo la keyword |
| **Raw pointer** | Puntatore raw | |
| **Dereferencing** | Dereferenziazione | |
| **Method** | Metodo | |
| **Function** | Funzione | |
| **Associated function** | Funzione associata | |
| **Implementation** | Implementazione | |

## Costrutti del linguaggio

| Inglese | Italiano | Note |
|---------|----------|------|
| **if let** | if let | Keyword, non si traduce |
| **match** | match | Keyword, non si traduce |
| **loop** | loop | Keyword, non si traduce |
| **while** | while | Keyword, non si traduce |
| **for** | for | Keyword, non si traduce |
| **return** | return | Keyword, non si traduce |
| **impl** | impl | Keyword, non si traduce |

## Tipi e collezioni

| Inglese | Italiano | Note |
|---------|----------|------|
| **String** | String | Nome del tipo |
| **&str** | &str | String slice type |
| **i32, u32, etc.** | i32, u32, etc. | Tipi numerici |
| **bool** | bool | Tipo booleano |
| **char** | char | Tipo carattere |
| **Collection** | Collezione | |
| **Tuple** | Tupla | |

## Concetti avanzati

| Inglese | Italiano | Contesto |
|---------|----------|----------|
| **Zero-cost abstraction** | Astrazione a costo zero | |
| **Memory safety** | Sicurezza della memoria | |
| **Thread safety** | Sicurezza nei thread | |
| **Compile-time** | Tempo di compilazione | |
| **Runtime** | Tempo di esecuzione / Runtime | Dipende dal contesto |
| **Heap** | Heap | Manteniamo il termine |
| **Stack** | Stack | Manteniamo il termine |
| **Ownership transfer** | Trasferimento di proprietà | |
| **Drop trait** | Trait Drop | |
| **RAII** | RAII | Acronimo, non si traduce |

---

## Come contribuire al glossario

Se incontri un termine non presente in questo glossario:

1. Apri una issue su GitHub per discuterne
2. Proponi una traduzione motivandola
3. Attendi feedback dalla community prima di usarla nella documentazione

## Riferimenti

- [Rust Glossary (EN)](https://doc.rust-lang.org/book/appendix-06-glossary.html)
- Discussioni nella community italiana di Rust
