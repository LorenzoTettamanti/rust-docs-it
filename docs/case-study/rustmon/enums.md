# Enums e Pattern Matching: Il Sistema dei Tipi Pokemon

!!! info "Livello: 🟢 Principiante"
    **Concetti trattati**: Enums, Pattern Matching, Type Safety, Exhaustiveness
    **Tempo di lettura**: ~15 minuti

## Il Problema

Pokemon ha 18 tipi diversi (Fire, Water, Grass, Electric, ecc.) e ogni tipo ha vantaggi e svantaggi contro altri tipi. Come modelliamo questo sistema in modo **type-safe** ed elegante?

In molti linguaggi useresti stringhe o costanti numeriche. In Rust, usiamo **enums**!

## Soluzione Naive: Stringhe ❌

Vediamo perché le stringhe non sono ideali:

```rust
struct Pokemon {
    name: String,
    pokemon_type: String,  // ❌ Problematico!
}

fn create_charmander() -> Pokemon {
    Pokemon {
        name: String::from("Charmander"),
        pokemon_type: String::from("Fire"),  // Typo? "fire"? "FIRE"?
    }
}

fn is_fire_type(pokemon: &Pokemon) -> bool {
    pokemon.pokemon_type == "Fire"  // Fragile!
}
```

### Problemi

- ❌ Typo: "Frie" invece di "Fire" compila ma è sbagliato
- ❌ Case sensitivity: "fire" vs "Fire"
- ❌ No autocompletamento IDE
- ❌ Impossibile verificare tutti i casi gestiti
- ❌ Performance: confronto stringhe più lento

## Soluzione Rust: Enums ✅

Rust ci permette di definire un tipo che può essere **esattamente uno** tra un set di valori:

```rust
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum PokemonType {
    Normal,
    Fire,
    Water,
    Grass,
    Electric,
    Ice,
    Fighting,
    Poison,
    Ground,
    Flying,
    Psychic,
    Bug,
    Rock,
    Ghost,
    Dragon,
    Dark,
    Steel,
    Fairy,
}

struct Pokemon {
    name: String,
    pokemon_type: PokemonType,  // ✅ Type-safe!
}
```

### Vantaggi Immediati

- ✅ **Impossibile avere typo**: Solo i valori definiti sono validi
- ✅ **Autocompletamento**: L'IDE suggerisce tutti i tipi
- ✅ **Type checking**: Il compilatore verifica la correttezza
- ✅ **Performance**: Enum è un semplice integer in memoria
- ✅ **Semantica chiara**: Il codice documenta se stesso

## Pattern Matching: Calcolo dell'Efficacia

Ora arriva la parte interessante: calcolare se una mossa è super efficace, non molto efficace, o immune.

### Pattern Matching Base

```rust
fn calculate_effectiveness(
    attacking_type: PokemonType,
    defending_type: PokemonType,
) -> f32 {
    use PokemonType::*;

    match (attacking_type, defending_type) {
        // Super efficace (2.0x)
        (Fire, Grass) => 2.0,
        (Fire, Ice) => 2.0,
        (Fire, Bug) => 2.0,
        (Fire, Steel) => 2.0,

        (Water, Fire) => 2.0,
        (Water, Ground) => 2.0,
        (Water, Rock) => 2.0,

        (Grass, Water) => 2.0,
        (Grass, Ground) => 2.0,
        (Grass, Rock) => 2.0,

        // Resistente (0.5x)
        (Fire, Fire) => 0.5,
        (Fire, Water) => 0.5,
        (Fire, Rock) => 0.5,
        (Fire, Dragon) => 0.5,

        (Water, Water) => 0.5,
        (Water, Grass) => 0.5,
        (Water, Dragon) => 0.5,

        // Immune (0.0x)
        (Normal, Ghost) => 0.0,
        (Ghost, Normal) => 0.0,
        (Electric, Ground) => 0.0,
        (Ground, Flying) => 0.0,

        // Normale (1.0x) - tutti gli altri casi
        _ => 1.0,
    }
}
```

### Cosa Succede Qui?

1. `use PokemonType::*` - Importa tutte le varianti per scrivere `Fire` invece di `PokemonType::Fire`
2. `match (attacking_type, defending_type)` - Pattern matching su una **tupla** di due enums
3. `(Fire, Grass) => 2.0` - Se attacco Fire contro difesa Grass, 2x danni
4. `_ => 1.0` - Wildcard: tutti gli altri casi sono 1x (efficacia normale)

## Exhaustiveness Checking: Il Superpotere del Compilatore

Una delle feature più potenti di Rust è che il compilatore **verifica che tu gestisca tutti i casi**.

### Esempio: Aggiungere un Nuovo Tipo

Immagina di aggiungere un nuovo tipo Pokemon:

```rust
pub enum PokemonType {
    // ... tutti i tipi esistenti ...
    Cosmic,  // ← Nuovo tipo!
}
```

**Cosa succede?** Il compilatore ti avvisa di **ogni** funzione che usa pattern matching incompleto:

```rust
fn get_type_color(pokemon_type: PokemonType) -> &'static str {
    match pokemon_type {
        PokemonType::Fire => "red",
        PokemonType::Water => "blue",
        PokemonType::Grass => "green",
        // ... altri tipi ...
    }
    // ❌ ERROR: non-exhaustive patterns: `Cosmic` not covered
}
```

!!! success "Zero Bug Guarantee"
    Con gli enum, è **impossibile** dimenticare di gestire un caso. Il compilatore non ti lascia compilare!

## Caso Reale da Rustmon

Ecco come Rustmon implementa il sistema completo:

```rust
// Estratto da rustmon/src/types.rs
#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
pub enum Type {
    Normal, Fire, Water, Grass, Electric, Ice,
    Fighting, Poison, Ground, Flying, Psychic,
    Bug, Rock, Ghost, Dragon, Dark, Steel, Fairy,
}

impl Type {
    /// Calcola il moltiplicatore di efficacia di questo tipo
    /// quando attacca un tipo difensore
    pub fn effectiveness_against(self, defender: Type) -> f32 {
        // Tabella completa delle efficacie
        match (self, defender) {
            // Fire
            (Type::Fire, Type::Grass | Type::Ice | Type::Bug | Type::Steel) => 2.0,
            (Type::Fire, Type::Fire | Type::Water | Type::Rock | Type::Dragon) => 0.5,

            // Water
            (Type::Water, Type::Fire | Type::Ground | Type::Rock) => 2.0,
            (Type::Water, Type::Water | Type::Grass | Type::Dragon) => 0.5,

            // Grass
            (Type::Grass, Type::Water | Type::Ground | Type::Rock) => 2.0,
            (Type::Grass, Type::Fire | Type::Grass | Type::Poison |
                          Type::Flying | Type::Bug | Type::Dragon | Type::Steel) => 0.5,

            // Electric
            (Type::Electric, Type::Water | Type::Flying) => 2.0,
            (Type::Electric, Type::Electric | Type::Grass | Type::Dragon) => 0.5,
            (Type::Electric, Type::Ground) => 0.0,  // Immune!

            // ... tutti gli altri 14 tipi ...

            _ => 1.0,  // Efficacia normale
        }
    }
}
```

### Pattern Avanzati: Combinare Valori

Nota l'uso di `|` (OR) per combinare pattern:

```rust
(Type::Fire, Type::Grass | Type::Ice | Type::Bug | Type::Steel) => 2.0,
//           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
//           Fire è super efficace contro uno qualsiasi di questi
```

Questo è equivalente a:

```rust
(Type::Fire, Type::Grass) => 2.0,
(Type::Fire, Type::Ice) => 2.0,
(Type::Fire, Type::Bug) => 2.0,
(Type::Fire, Type::Steel) => 2.0,
```

Ma molto più conciso e leggibile!

🔗 [Vedi il codice completo su GitHub](https://github.com/AndreaBozzo/rustmon/blob/main/src/types.rs)

## Enum con Dati: Mosse Pokemon

Gli enum in Rust possono anche **contenere dati**:

```rust
pub enum Move {
    Physical {
        name: String,
        power: u32,
        move_type: PokemonType,
    },
    Special {
        name: String,
        power: u32,
        move_type: PokemonType,
    },
    Status {
        name: String,
        effect: StatusEffect,
    },
}

enum StatusEffect {
    Burn,
    Poison,
    Paralysis,
    Sleep,
}
```

### Pattern Matching con Dati

```rust
fn calculate_damage(pokemon_move: &Move, attacker: &Pokemon) -> u32 {
    match pokemon_move {
        Move::Physical { power, move_type, .. } => {
            // Usa statistica Attack
            (attacker.attack * power) / 50
        }
        Move::Special { power, move_type, .. } => {
            // Usa statistica Special Attack
            (attacker.special_attack * power) / 50
        }
        Move::Status { .. } => {
            // Mosse status non fanno danno
            0
        }
    }
}
```

### Destructuring

Il `..` nel pattern significa "ignora gli altri campi":

```rust
Move::Physical { power, move_type, .. }
//                                 ^^
//                      Non ci interessa `name`
```

## Comparazione con Altri Linguaggi

=== "Rust"
    ```rust
    enum PokemonType {
        Fire, Water, Grass
    }

    match pokemon_type {
        PokemonType::Fire => "fire",
        PokemonType::Water => "water",
        PokemonType::Grass => "grass",
    }
    // ✅ Compilatore verifica tutti i casi
    ```

=== "TypeScript"
    ```typescript
    enum PokemonType {
        Fire, Water, Grass
    }

    switch (pokemonType) {
        case PokemonType.Fire: return "fire";
        case PokemonType.Water: return "water";
        // ❌ Manca Grass, nessun errore!
    }
    ```

=== "Java"
    ```java
    enum PokemonType {
        FIRE, WATER, GRASS
    }

    switch (pokemonType) {
        case FIRE: return "fire";
        case WATER: return "water";
        // ⚠️ Warning, ma compila
    }
    ```

=== "Python"
    ```python
    from enum import Enum

    class PokemonType(Enum):
        FIRE = 1
        WATER = 2
        GRASS = 3

    # ❌ Nessun controllo exhaustiveness
    if pokemon_type == PokemonType.FIRE:
        return "fire"
    # Dimenticare casi è facile!
    ```

## Esercizi Pratici

### Esercizio 1: Weather System

Implementa un sistema meteo per Pokemon:

```rust
enum Weather {
    Sunny,
    Rain,
    Sandstorm,
    Hail,
}

fn weather_boost(weather: Weather, pokemon_type: PokemonType) -> f32 {
    // Sunny: Fire type gets 1.5x
    // Rain: Water type gets 1.5x
    // Sandstorm: Rock type gets 1.5x defense
    // Hail: Ice type is immune to damage
    todo!()
}
```

??? success "Soluzione"
    ```rust
    fn weather_boost(weather: Weather, pokemon_type: PokemonType) -> f32 {
        match (weather, pokemon_type) {
            (Weather::Sunny, PokemonType::Fire) => 1.5,
            (Weather::Rain, PokemonType::Water) => 1.5,
            (Weather::Sandstorm, PokemonType::Rock) => 1.5,
            (Weather::Hail, PokemonType::Ice) => 1.5,
            _ => 1.0,
        }
    }
    ```

### Esercizio 2: Dual Type Pokemon

Molti Pokemon hanno due tipi. Implementa:

```rust
enum TypeSlot {
    Single(PokemonType),
    Dual(PokemonType, PokemonType),
}

fn calculate_effectiveness_dual(
    attacking_type: PokemonType,
    defender_types: TypeSlot,
) -> f32 {
    // Hint: con Dual, moltiplica l'efficacia di entrambi i tipi
    todo!()
}
```

??? success "Soluzione"
    ```rust
    fn calculate_effectiveness_dual(
        attacking_type: PokemonType,
        defender_types: TypeSlot,
    ) -> f32 {
        match defender_types {
            TypeSlot::Single(type1) => {
                calculate_effectiveness(attacking_type, type1)
            }
            TypeSlot::Dual(type1, type2) => {
                let eff1 = calculate_effectiveness(attacking_type, type1);
                let eff2 = calculate_effectiveness(attacking_type, type2);
                eff1 * eff2  // Esempio: 2.0 * 0.5 = 1.0
            }
        }
    }
    ```

## Derive Macros: Funzionalità Gratuite

Notato il `#[derive(...)]` sopra l'enum?

```rust
#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
pub enum PokemonType {
    // ...
}
```

Queste **derive macros** generano automaticamente implementazioni:

| Derive | Funzionalità |
|--------|-------------|
| `Debug` | Permette `println!("{:?}", pokemon_type)` |
| `Clone` | Permette `.clone()` per duplicare |
| `Copy` | Permette copie implicite (enum è piccolo) |
| `PartialEq` | Permette `==` e `!=` |
| `Eq` | Garantisce equivalenza totale |
| `Hash` | Permette uso in HashMap/HashSet |

!!! tip "Copy vs Clone"
    `Copy` è permesso solo per tipi piccoli che possono essere copiati velocemente (come gli enum semplici).
    `Clone` è più generale ma richiede chiamata esplicita `.clone()`.

## Punti Chiave da Ricordare 💡

!!! tip "Takeaways"
    - **Enums**: Tipo che può essere esattamente una variante tra un set
    - **Type Safety**: Impossibile creare valori invalidi
    - **Pattern Matching**: Gestisci tutti i casi in modo esplicito
    - **Exhaustiveness**: Il compilatore verifica che tu gestisca tutti i casi
    - **Enums con Dati**: Ogni variante può contenere dati diversi
    - **Performance**: Enums sono efficienti come integer

## Quando Usare Enums

✅ **Usa enums quando:**

- Hai un set finito di possibilità (tipi, stati, comandi)
- Vuoi type safety invece di stringhe/numeri magici
- Vuoi che il compilatore ti aiuti a non dimenticare casi
- Vuoi pattern matching espressivo

❌ **Non usare enums quando:**

- Il set di valori è dinamico o illimitato
- I valori arrivano da input esterno (usa parsing con validation)

## Prossimi Passi

Continua il tuo viaggio:

- [← **Ownership in Pratica**](ownership.md) - Gestione memoria sicura
- [**Traits** →](traits.md) - Comportamenti comuni e polimorfismo

## Approfondimenti

- 📚 [Rust Book - Enums](https://doc.rust-lang.org/book/ch06-00-enums.html)
- 📚 [Rust Book - Pattern Matching](https://doc.rust-lang.org/book/ch18-00-patterns.html)
- 🦀 [Standard Library - Option & Result](../../std/option-result.md)

---

**Hai domande?** Apri una [discussion su GitHub](https://github.com/rust-ita/rust-docs-it/discussions)!
