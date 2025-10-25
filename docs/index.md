# Benvenuto nella Documentazione Rust in Italiano

!!! info "Progetto in sviluppo"
    Questa è una traduzione in corso della documentazione ufficiale di Rust. Alcune sezioni potrebbero non essere ancora disponibili.  
    📖 [Documentazione originale (EN)](https://doc.rust-lang.org/)

---

## 🦀 Cos'è Rust?

**Rust** è un linguaggio di programmazione che ti permette di essere più produttivo e fiducioso nel tuo codice. Rust combina prestazioni di basso livello con ergonomia di alto livello, garantendo:

- **Sicurezza della memoria** senza garbage collector
- **Concorrenza** senza data races
- **Astrazioni a costo zero** - paga solo per ciò che usi
- **Affidabilità** - errori rilevati a compile-time

## 📚 Documentazione disponibile

### The Rust Standard Library

La libreria standard di Rust fornisce le funzionalità fondamentali per scrivere applicazioni Rust.

<div class="grid cards" markdown>

-   :material-package-variant-closed:{ .lg .middle } __Tipi Primitivi__

    ---

    Tipi numerici, booleani, caratteri e altre primitive del linguaggio

    [:octicons-arrow-right-24: Esplora](std/primitives.md)

-   :material-format-list-bulleted:{ .lg .middle } __Collections__

    ---

    Vector, HashMap, HashSet e altre strutture dati

    [:octicons-arrow-right-24: Scopri di più](std/collections/index.md)

-   :material-file-document:{ .lg .middle } __I/O & File System__

    ---

    Lettura e scrittura di file, gestione dell'input/output

    [:octicons-arrow-right-24: Leggi](std/io/index.md)

-   :material-help-circle:{ .lg .middle } __Option & Result__

    ---

    Gestione di valori opzionali e degli errori

    [:octicons-arrow-right-24: Approfondisci](std/option-result.md)

</div>

[Vai alla Standard Library completa →](std/index.md){ .md-button .md-button--primary }

---

### The Rust Programming Language Book

Una guida completa per imparare Rust, dalla configurazione iniziale fino ai concetti avanzati.

!!! note "The Book"
    Conosciuto comunemente come "The Book", questo è il punto di partenza ideale per chiunque voglia imparare Rust.

**Capitoli principali:**

1. **[Per Iniziare](book/ch01-getting-started.md)** - Installazione e primo progetto
2. **Concetti Comuni** - Variabili, tipi di dati, funzioni
3. **[Ownership](book/ch04-ownership.md)** - Il sistema di proprietà di Rust
4. **Struct, Enum e Pattern Matching** - Tipi di dati personalizzati
5. **Gestione di Progetti** - Moduli, crate e Cargo

[Inizia a leggere The Book →](book/index.md){ .md-button }

---

## 🚀 Quick Start

### Installa Rust

```bash
# Su Linux o macOS
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Su Windows
# Scarica rustup-init.exe da https://rustup.rs/
```

### Il tuo primo programma

```rust
fn main() {
    println!("Ciao, mondo!");
}
```

```bash
# Compila ed esegui
rustc main.rs
./main
```

### Crea un nuovo progetto con Cargo

```bash
cargo new hello_rust
cd hello_rust
cargo run
```

---

## 🎯 Risorse per l'apprendimento

### Per principianti

- **[The Rust Book](book/index.md)** - Inizia da qui!
- **Rust by Example** - Impara attraverso esempi pratici (prossimamente)
- **Rustlings** - Esercizi interattivi

### Per sviluppatori esperti

- **[Standard Library](std/index.md)** - Riferimento API completo
- **The Cargo Book** - Gestione avanzata dei progetti
- **Async Book** - Programmazione asincrona

### Riferimenti

- **[Glossario](GLOSSARY.md)** - Terminologia tecnica
- **Rust Reference** - Specifiche del linguaggio
- **Rustonomicon** - Unsafe Rust e dettagli interni

---

## 💡 Perché Rust?

### Prestazioni

Rust è incredibilmente veloce ed efficiente in termini di memoria. Senza runtime o garbage collector, può alimentare servizi critici per le prestazioni, girare su sistemi embedded e integrarsi facilmente con altri linguaggi.

### Affidabilità

Il ricco sistema di tipi di Rust e il modello di ownership garantiscono sicurezza della memoria e sicurezza nei thread, permettendoti di eliminare molte classi di bug a compile-time.

### Produttività

Rust ha un'ottima documentazione, un compilatore amichevole con messaggi di errore utili, e strumenti di prima classe: Cargo (gestore di pacchetti e build), Rustfmt (formattazione automatica), e Rust Language Server (autocompletamento e IDE).

---

## 🤝 Contribuisci

Questa traduzione è un progetto della community. Puoi contribuire in diversi modi:

- 📝 Traducendo nuove sezioni
- 🔍 Revisionando traduzioni esistenti  
- 🐛 Segnalando errori o imprecisioni
- 💭 Discutendo scelte terminologiche

[**Scopri come contribuire →**](CONTRIBUTING.md){ .md-button .md-button--primary }

---

## 📖 Altre risorse

### Community italiana

- [GitHub rust-ita](https://github.com/rust-ita)
- Forum Rust Italia (link quando disponibile)
- Discord/Telegram (link quando disponibile)

### Community internazionale

- [Official Rust Website](https://www.rust-lang.org/)
- [Users Forum](https://users.rust-lang.org/)
- [Discord Ufficiale](https://discord.gg/rust-lang)
- [Subreddit r/rust](https://www.reddit.com/r/rust/)

---

<div class="grid" markdown>

!!! tip "Suggerimento per principianti"
    Se sei nuovo a Rust, inizia con [The Rust Book](book/index.md). È progettato per insegnarti Rust step-by-step, indipendentemente dal tuo background di programmazione.

!!! question "Hai domande?"
    Se hai dubbi sulla traduzione o vuoi proporre miglioramenti, apri una [issue su GitHub](https://github.com/rust-ita/rust-docs-it/issues).

</div>

---

**Ultima revisione**: Ottobre 2025
**Versione Rust**: 1.90+

*Documentazione originale © The Rust Project Developers | Traduzione © Rust Italia Community*