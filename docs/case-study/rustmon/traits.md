# Traits: Comportamenti Comuni per Pokemon

!!! info "Livello: 🟡 Intermedio"
    **Concetti trattati**: Traits, Trait Bounds, Default Implementations, Polymorphism
    **Tempo di lettura**: ~20 minuti
    **Prerequisiti**: Familiarità con struct, enums, e ownership

## Il Problema

Diversi tipi di entità nel gioco condividono comportamenti comuni:
- Tutti i Pokemon possono **attaccare**
- Tutti i Pokemon hanno **statistiche** (HP, Attack, Defense)
- Tutte le mosse possono essere **eseguite** in battaglia
- Tutte le entità possono essere **visualizzate** come stringa

Come condividiamo questi comportamenti senza duplicare codice?

## Soluzione 1: Duplicazione ❌

L'approccio naive sarebbe duplicare i metodi:

```rust
struct Pokemon {
    name: String,
    hp: u32,
    attack: u32,
}

impl Pokemon {
    fn get_hp(&self) -> u32 { self.hp }
    fn get_attack(&self) -> u32 { self.attack }
    fn is_alive(&self) -> bool { self.hp > 0 }
}

struct Trainer {
    name: String,
    hp: u32,  // I trainer hanno HP in alcuni giochi
}

impl Trainer {
    fn get_hp(&self) -> u32 { self.hp }  // ❌ Codice duplicato!
    fn is_alive(&self) -> bool { self.hp > 0 }  // ❌ Duplicato!
}
```

### Problemi:
- ❌ Codice duplicato
- ❌ Impossibile scrivere funzioni generiche
- ❌ Difficile manutenzione

## Soluzione Rust: Traits ✅

I **traits** definiscono comportamenti condivisi che tipi diversi possono implementare:

```rust
// Definizione del trait
trait HasStats {
    fn hp(&self) -> u32;
    fn attack(&self) -> u32;
    fn defense(&self) -> u32;

    // Metodo con implementazione di default
    fn is_alive(&self) -> bool {
        self.hp() > 0
    }
}

// Implementazione per Pokemon
struct Pokemon {
    name: String,
    hp: u32,
    attack: u32,
    defense: u32,
}

impl HasStats for Pokemon {
    fn hp(&self) -> u32 { self.hp }
    fn attack(&self) -> u32 { self.attack }
    fn defense(&self) -> u32 { self.defense }

    // is_alive() eredita l'implementazione default
}
```

### Vantaggi:
- ✅ Comportamento definito una sola volta
- ✅ Funzioni generiche possibili
- ✅ Implementazione di default riutilizzabile
- ✅ Type safety mantenuta

## Trait Bounds: Funzioni Generiche

Ora possiamo scrivere funzioni che lavorano con **qualsiasi tipo** che implementa il trait:

```rust
fn print_stats<T: HasStats>(entity: &T) {
    println!("HP: {}", entity.hp());
    println!("Attack: {}", entity.attack());
    println!("Defense: {}", entity.defense());
    println!("Status: {}", if entity.is_alive() { "Alive" } else { "Fainted" });
}

// Funziona con qualsiasi tipo che implementa HasStats!
let pikachu = Pokemon { /* ... */ };
print_stats(&pikachu);  // ✅ OK!
```

### Sintassi Alternative

Rust offre diverse sintassi per i trait bounds:

=== "Sintassi Base"
    ```rust
    fn battle<T: HasStats>(attacker: &T, defender: &T) {
        // ...
    }
    ```

=== "Where Clause"
    ```rust
    fn battle<T>(attacker: &T, defender: &T)
    where
        T: HasStats,
    {
        // Più leggibile con molti bounds
    }
    ```

=== "Impl Trait"
    ```rust
    fn battle(attacker: &impl HasStats, defender: &impl HasStats) {
        // Sintassi più concisa per casi semplici
    }
    ```

=== "Multiple Bounds"
    ```rust
    fn battle<T>(attacker: &T, defender: &T)
    where
        T: HasStats + Clone + Debug,
    {
        // T deve implementare tutti e tre i traits
    }
    ```

## Caso Reale da Rustmon: Battler Trait

In Rustmon, definiamo un trait per entità che possono combattere:

```rust
// Estratto semplificato da rustmon
pub trait Battler {
    /// Restituisce il nome dell'entità
    fn name(&self) -> &str;

    /// HP correnti
    fn current_hp(&self) -> u32;

    /// HP massimi
    fn max_hp(&self) -> u32;

    /// Statistica di attacco
    fn attack_stat(&self) -> u32;

    /// Statistica di difesa
    fn defense_stat(&self) -> u32;

    /// Il tipo (o tipi) dell'entità
    fn battle_type(&self) -> PokemonType;

    /// Infligge danno all'entità
    fn take_damage(&mut self, damage: u32);

    /// Verifica se è ancora in grado di combattere
    fn can_battle(&self) -> bool {
        self.current_hp() > 0
    }

    /// Calcola il danno inflitto da una mossa
    fn calculate_damage(&self, move_power: u32, move_type: PokemonType, defender: &impl Battler) -> u32 {
        let type_effectiveness = move_type.effectiveness_against(defender.battle_type());
        let base_damage = (self.attack_stat() * move_power) / defender.defense_stat();
        let final_damage = (base_damage as f32 * type_effectiveness) as u32;
        final_damage.max(1)  // Minimo 1 danno
    }
}
```

### Implementazione per Pokemon

```rust
pub struct Pokemon {
    pub name: String,
    pub pokemon_type: PokemonType,
    pub current_hp: u32,
    pub max_hp: u32,
    pub attack: u32,
    pub defense: u32,
}

impl Battler for Pokemon {
    fn name(&self) -> &str {
        &self.name
    }

    fn current_hp(&self) -> u32 {
        self.current_hp
    }

    fn max_hp(&self) -> u32 {
        self.max_hp
    }

    fn attack_stat(&self) -> u32 {
        self.attack
    }

    fn defense_stat(&self) -> u32 {
        self.defense
    }

    fn battle_type(&self) -> PokemonType {
        self.pokemon_type
    }

    fn take_damage(&mut self, damage: u32) {
        self.current_hp = self.current_hp.saturating_sub(damage);
    }

    // can_battle() e calculate_damage() usano le implementazioni default
}
```

### Sistema di Battaglia Generico

Ora possiamo scrivere una funzione di battaglia che funziona con **qualsiasi** `Battler`:

```rust
pub fn simulate_battle<A, D>(attacker: &A, defender: &mut D, move_power: u32, move_type: PokemonType)
where
    A: Battler,
    D: Battler,
{
    if !attacker.can_battle() {
        println!("{} can't battle!", attacker.name());
        return;
    }

    let damage = attacker.calculate_damage(move_power, move_type, defender);

    println!("{} attacks {}!", attacker.name(), defender.name());
    println!("Damage: {}", damage);

    defender.take_damage(damage);

    if !defender.can_battle() {
        println!("{} fainted!", defender.name());
    } else {
        println!("{} has {} HP remaining", defender.name(), defender.current_hp());
    }
}
```

🔗 [Vedi il codice completo su GitHub](https://github.com/AndreaBozzo/rustmon/blob/main/src/battle.rs)

## Trait con Associated Types

I trait possono avere **tipi associati** per maggiore flessibilità:

```rust
trait Move {
    type Target;  // Tipo associato

    fn name(&self) -> &str;
    fn power(&self) -> u32;
    fn execute(&self, user: &impl Battler, target: &mut Self::Target);
}

// Mossa che colpisce un singolo Pokemon
struct SingleTargetMove {
    name: String,
    power: u32,
}

impl Move for SingleTargetMove {
    type Target = Pokemon;  // Specifica il tipo

    fn name(&self) -> &str { &self.name }
    fn power(&self) -> u32 { self.power }

    fn execute(&self, user: &impl Battler, target: &mut Pokemon) {
        let damage = user.calculate_damage(self.power, PokemonType::Normal, target);
        target.take_damage(damage);
    }
}

// Mossa che colpisce tutto il team
struct MultiTargetMove {
    name: String,
    power: u32,
}

impl Move for MultiTargetMove {
    type Target = Vec<Pokemon>;  // Target diverso!

    fn name(&self) -> &str { &self.name }
    fn power(&self) -> u32 { self.power }

    fn execute(&self, user: &impl Battler, targets: &mut Vec<Pokemon>) {
        for target in targets.iter_mut() {
            let damage = user.calculate_damage(self.power, PokemonType::Normal, target);
            target.take_damage(damage);
        }
    }
}
```

## Trait Standard Library

Rust viene con molti trait standard che dovresti conoscere:

### Debug e Display

```rust
use std::fmt;

impl fmt::Display for Pokemon {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(f, "{} (HP: {}/{})", self.name, self.current_hp, self.max_hp)
    }
}

// Ora possiamo usare println! senza {:?}
let pikachu = Pokemon { /* ... */ };
println!("Pokemon: {}", pikachu);  // Pokemon: Pikachu (HP: 35/35)
```

### Clone e Copy

```rust
#[derive(Clone)]  // Macro derive per Clone
struct Pokemon {
    // ...
}

let pikachu = Pokemon { /* ... */ };
let pikachu_copy = pikachu.clone();  // Copia esplicita
```

### PartialEq e Eq

```rust
#[derive(PartialEq, Eq)]
struct Pokemon {
    // ...
}

let pika1 = Pokemon { name: "Pikachu".into(), /* ... */ };
let pika2 = Pokemon { name: "Pikachu".into(), /* ... */ };

if pika1 == pika2 {  // Confronto per uguaglianza
    println!("Same Pokemon!");
}
```

### From e Into

```rust
// Conversione da tuple a Pokemon
impl From<(String, PokemonType, u32, u32, u32)> for Pokemon {
    fn from(data: (String, PokemonType, u32, u32, u32)) -> Self {
        Pokemon {
            name: data.0,
            pokemon_type: data.1,
            max_hp: data.2,
            current_hp: data.2,
            attack: data.3,
            defense: data.4,
        }
    }
}

// Into è automaticamente implementato!
let pikachu: Pokemon = (
    "Pikachu".to_string(),
    PokemonType::Electric,
    35, 55, 40
).into();
```

## Trait Objects: Dynamic Dispatch

A volte non sappiamo il tipo esatto a compile-time. Usiamo **trait objects**:

```rust
// Vec di Pokemon che implementano Battler
let battlers: Vec<Box<dyn Battler>> = vec![
    Box::new(pokemon1),
    Box::new(pokemon2),
    Box::new(pokemon3),
];

// Possiamo iterare e chiamare metodi del trait
for battler in &battlers {
    println!("{} has {} HP", battler.name(), battler.current_hp());
}
```

### Static vs Dynamic Dispatch

| Static Dispatch (`<T: Trait>`) | Dynamic Dispatch (`dyn Trait`) |
|--------------------------------|--------------------------------|
| ✅ Più veloce (no overhead) | ⚠️ Leggermente più lento (vtable) |
| ✅ Inlining possibile | ❌ No inlining |
| ⚠️ Code size maggiore (monomorphization) | ✅ Code size minore |
| ⚠️ Tipo noto a compile-time | ✅ Tipo determinato a runtime |

**Regola pratica**: Usa static dispatch di default, dynamic solo se necessario.

## Composizione di Traits

I trait possono richiedere che altri trait siano implementati:

```rust
// Display richiede Debug
trait DisplayableBattler: Battler + fmt::Display + fmt::Debug {
    fn display_status(&self) {
        println!("{} | HP: {}/{} | Status: {}",
            self.name(),
            self.current_hp(),
            self.max_hp(),
            if self.can_battle() { "OK" } else { "Fainted" }
        );
    }
}
```

## Esercizi Pratici

### Esercizio 1: Healable Trait

Implementa un trait per entità che possono essere curate:

```rust
trait Healable {
    fn current_hp(&self) -> u32;
    fn max_hp(&self) -> u32;
    fn heal(&mut self, amount: u32);

    // Implementa questo con default implementation
    fn heal_to_full(&mut self) {
        // TODO: Cura fino a max_hp
    }
}
```

??? success "Soluzione"
    ```rust
    trait Healable {
        fn current_hp(&self) -> u32;
        fn max_hp(&self) -> u32;
        fn heal(&mut self, amount: u32);

        fn heal_to_full(&mut self) {
            let max = self.max_hp();
            let current = self.current_hp();
            let heal_amount = max.saturating_sub(current);
            self.heal(heal_amount);
        }
    }

    impl Healable for Pokemon {
        fn current_hp(&self) -> u32 { self.current_hp }
        fn max_hp(&self) -> u32 { self.max_hp }

        fn heal(&mut self, amount: u32) {
            self.current_hp = (self.current_hp + amount).min(self.max_hp);
        }
    }
    ```

### Esercizio 2: Describable Trait

Crea un trait che permette a entità di descriversi:

```rust
trait Describable {
    fn description(&self) -> String;

    // Default: descrizione breve
    fn short_description(&self) -> String {
        let desc = self.description();
        // TODO: Ritorna primi 50 caratteri + "..."
        todo!()
    }
}
```

??? success "Soluzione"
    ```rust
    trait Describable {
        fn description(&self) -> String;

        fn short_description(&self) -> String {
            let desc = self.description();
            if desc.len() > 50 {
                format!("{}...", &desc[..47])
            } else {
                desc
            }
        }
    }

    impl Describable for Pokemon {
        fn description(&self) -> String {
            format!(
                "{} is a {:?}-type Pokemon with {} HP, {} Attack, and {} Defense.",
                self.name, self.pokemon_type, self.max_hp, self.attack, self.defense
            )
        }
    }
    ```

## Punti Chiave da Ricordare 💡

!!! tip "Takeaways"
    - **Traits**: Definiscono comportamenti condivisi tra tipi
    - **Trait Bounds**: `<T: Trait>` permette funzioni generiche
    - **Default Implementations**: Riduci duplicazione con implementazioni di default
    - **Trait Objects**: `dyn Trait` per polymorphism runtime
    - **Associated Types**: Maggiore flessibilità con tipi associati
    - **Standard Traits**: Debug, Clone, Display, From/Into sono fondamentali

## Quando Usare Traits

✅ **Usa traits quando:**

- Vuoi definire comportamenti condivisi tra tipi diversi
- Vuoi scrivere codice generico
- Vuoi permettere estensibilità futura
- Vuoi sfruttare i trait della standard library

❌ **Non usare traits quando:**

- Un singolo tipo è sufficiente
- La relazione è più "is-a" che "can-do" (considera composition)

## Prossimi Passi

Hai completato i case study principali di Rustmon! 🎉

Per approfondire:

- [← **Enums e Pattern Matching**](enums.md) - Sistema dei tipi Pokemon
- [← **Ownership in Pratica**](ownership.md) - Gestione memoria
- [**Torna alla panoramica**](index.md) - Esplora altri aspetti

## Approfondimenti

- 📚 [Rust Book - Traits](https://doc.rust-lang.org/book/ch10-02-traits.html)
- 📚 [Rust Book - Advanced Traits](https://doc.rust-lang.org/book/ch19-03-advanced-traits.html)
- 🦀 [Standard Library - Traits](https://doc.rust-lang.org/std/index.html#traits)

---

**Hai domande?** Apri una [discussion su GitHub](https://github.com/rust-ita/rust-docs-it/discussions)!
