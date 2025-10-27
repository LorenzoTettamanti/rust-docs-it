# Case Study: Rustmon 🎮

!!! example "Progetto Community"
    **Autore**: [@AndreaBozzo](https://github.com/AndreaBozzo)
    **Repository**: [github.com/AndreaBozzo/rustmon](https://github.com/AndreaBozzo/rustmon)
    **Licenza**: MIT
    **Livello**: 🟢 Principiante / 🟡 Intermedio

## Panoramica

**Rustmon** è un simulatore di battaglie Pokemon scritto in Rust, sviluppato come risorsa educativa per la community italiana. Il progetto implementa meccaniche di combattimento complete con tutti i 18 tipi Pokemon e calcoli di efficacia delle mosse.

### Cosa Rende Rustmon Interessante?

Rustmon è un esempio perfetto per imparare Rust perché:

- 🎯 **Dominio familiare**: Pokemon è un sistema di regole che molti conoscono
- 🏗️ **Architettura reale**: Utilizza Bevy ECS (Entity Component System)
- 📦 **Struttura modulare**: Separazione chiara tra logica e presentazione
- 🔧 **Pattern pratici**: Mostra Rust in un contesto applicativo concreto

## Caratteristiche Tecniche

### Sistema dei Tipi

Il progetto implementa tutti i 18 tipi Pokemon con:

```rust
enum PokemonType {
    Normal, Fire, Water, Grass, Electric,
    Ice, Fighting, Poison, Ground, Flying,
    Psychic, Bug, Rock, Ghost, Dragon,
    Dark, Steel, Fairy
}
```

**Concetti Rust**: Enums, Pattern Matching, Type Safety

### Meccaniche di Battaglia

- ⚔️ Calcolo danni basato su tipo e statistiche
- 🎲 Sistema di efficacia (super efficace, non molto efficace, immune)
- 🔄 Simulazione turni di battaglia

**Concetti Rust**: Ownership, Borrowing, Methods

### Architettura ECS (Bevy)

Il progetto utilizza il pattern Entity-Component-System:

- **Entity**: I Pokemon come entità nel mondo di gioco
- **Component**: Stats, Types, Moves come componenti
- **System**: Logica di battaglia come sistemi

**Concetti Rust**: Traits, Generics, Composition over Inheritance

## Struttura del Progetto

```
rustmon/
├── src/
│   ├── lib.rs           # Libreria con logica core
│   ├── main.rs          # Binary con esempio di battaglia
│   ├── types.rs         # Sistema dei tipi Pokemon
│   ├── battle.rs        # Meccaniche di combattimento
│   └── pokemon.rs       # Strutture dati Pokemon
└── Cargo.toml
```

## Esempi Disponibili

Questa sezione contiene analisi approfondite di specifici aspetti di Rustmon:

### 🟢 Livello Principiante

<div class="grid cards" markdown>

-   **[Ownership in Pratica](ownership.md)**

    Come Rustmon gestisce la proprietà dei Pokemon durante le battaglie

    *Concetti*: Ownership, Borrowing, References

-   **[Enums e Pattern Matching](enums.md)**

    Il sistema dei tipi Pokemon implementato con enums

    *Concetti*: Enums, Match, Type Safety

</div>

### 🟡 Livello Intermedio

<div class="grid cards" markdown>

-   **[Traits Personalizzati](traits.md)**

    Come definire comportamenti comuni per Pokemon e mosse

    *Concetti*: Traits, Polymorphism, Default Implementations

</div>

## Come Usare Questo Case Study

### 1️⃣ Esplora il Codice

Clona il repository e prova il progetto:

```bash
git clone https://github.com/AndreaBozzo/rustmon.git
cd rustmon
cargo run
```

### 2️⃣ Leggi gli Esempi

Ogni esempio in questa sezione:

- 📖 Spiega un concetto Rust specifico
- 💻 Mostra il codice reale di Rustmon
- 🔗 Linka ai file sorgente su GitHub
- 💡 Fornisce takeaway pratici

### 3️⃣ Sperimenta

Dopo aver letto gli esempi, prova a:

- ✏️ Modificare il codice
- ➕ Aggiungere nuovi Pokemon o mosse
- 🐛 Risolvere eventuali issue
- 🔧 Implementare nuove feature

## Prerequisiti

Per seguire gli esempi dovresti avere familiarità con:

- ✅ Sintassi base di Rust (variabili, funzioni, struct)
- ✅ Concetti di ownership (livello base)
- ✅ Enum e pattern matching (utile ma non essenziale)

Non ti preoccupare se alcuni concetti non sono chiari: ogni esempio li spiega nel contesto!

## Link Utili

- 📦 [Repository GitHub](https://github.com/AndreaBozzo/rustmon)
- 📚 [Documentazione Bevy](https://bevyengine.org/)
- 🦀 [Standard Library - Enums](../std/primitives.md#enum)

---

## Cosa Imparerai

Esplorando Rustmon attraverso questi case study, capirai:

| Concetto | Applicazione in Rustmon |
|----------|-------------------------|
| **Ownership** | Chi possiede un Pokemon durante la battaglia? |
| **Borrowing** | Come passare Pokemon tra funzioni senza copiarli? |
| **Enums** | Rappresentare i 18 tipi Pokemon in modo type-safe |
| **Pattern Matching** | Calcolare efficacia delle mosse in base ai tipi |
| **Traits** | Definire comportamenti comuni (attaccare, difendere) |
| **Error Handling** | Gestire mosse non valide o Pokemon KO |
| **Collections** | Gestire team di Pokemon e liste di mosse |

---

**Pronto a iniziare?** Parti con [Ownership in Pratica →](ownership.md){ .md-button .md-button--primary }
