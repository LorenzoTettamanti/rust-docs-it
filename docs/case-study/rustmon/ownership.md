# Ownership in Pratica: Pokemon Battles

!!! info "Livello: 🟢 Principiante"
    **Concetti trattati**: Ownership, Borrowing, References, Move Semantics
    **Tempo di lettura**: ~15 minuti

## Il Problema

Immagina di voler simulare una battaglia Pokemon. Hai due Pokemon e devono attaccarsi a vicenda. Come gestisci la proprietà di questi Pokemon? Chi li "possiede"? Come li passi tra funzioni senza creare copie costose?

Questo è esattamente il tipo di problema che il sistema di ownership di Rust risolve in modo elegante e sicuro.

## Scenario: Una Battaglia Semplice

Consideriamo una battaglia tra Charmander e Bulbasaur:

```rust
struct Pokemon {
    name: String,
    hp: u32,
    attack: u32,
    defense: u32,
}

fn main() {
    let charmander = Pokemon {
        name: String::from("Charmander"),
        hp: 39,
        attack: 52,
        defense: 43,
    };

    let bulbasaur = Pokemon {
        name: String::from("Bulbasaur"),
        hp: 45,
        attack: 49,
        defense: 49,
    };

    // Come facciamo a farli combattere?
}
```

## Approccio 1: Move Ownership ❌

Cosa succederebbe se provassimo a "muovere" i Pokemon in una funzione di battaglia?

```rust
fn battle(attacker: Pokemon, defender: Pokemon) {
    println!("{} attacks {}!", attacker.name, defender.name);
    // Calcola danno...
}

fn main() {
    let charmander = Pokemon { /* ... */ };
    let bulbasaur = Pokemon { /* ... */ };

    battle(charmander, bulbasaur);

    // ❌ ERRORE! charmander e bulbasaur sono stati "moved"
    // println!("{}", charmander.name); // Questo non compila!
}
```

### Cosa È Successo?

Quando passiamo `charmander` e `bulbasaur` alla funzione `battle`, l'**ownership viene trasferito**. Dopo la chiamata, le variabili originali non sono più valide!

!!! danger "Problema"
    Dopo una singola battaglia, abbiamo perso i nostri Pokemon! Non possiamo più usarli.

## Approccio 2: Borrowing con References ✅

La soluzione di Rust: **prestare** i Pokemon invece di trasferirne la proprietà.

```rust
fn battle(attacker: &Pokemon, defender: &Pokemon) {
    //        ^                ^
    //        |                |
    //    Borrowing immutabile

    println!("{} attacks {}!", attacker.name, defender.name);
    let damage = calculate_damage(attacker, defender);
    println!("Damage dealt: {}", damage);
}

fn calculate_damage(attacker: &Pokemon, defender: &Pokemon) -> u32 {
    // Formula semplificata
    let base_damage = attacker.attack.saturating_sub(defender.defense / 2);
    base_damage.max(1) // Minimo 1 danno
}

fn main() {
    let charmander = Pokemon { /* ... */ };
    let bulbasaur = Pokemon { /* ... */ };

    battle(&charmander, &bulbasaur);
    //     ^            ^
    //     |            |
    //  Prestiamo i Pokemon

    // ✅ OK! Possiamo ancora usarli
    println!("{} has {} HP", charmander.name, charmander.hp);
}
```

### Perché Funziona?

- `&Pokemon` significa "reference ad un Pokemon" (borrowing)
- La funzione può **leggere** i dati, ma non li possiede
- Dopo la funzione, i Pokemon originali sono ancora validi
- Il compilatore garantisce che le reference siano sempre valide

## Approccio 3: Mutable Borrowing per Modificare ✏️

E se vogliamo davvero infliggere danno e modificare gli HP?

```rust
fn attack(attacker: &Pokemon, defender: &mut Pokemon) {
    //                          ^^^^
    //                    Mutable reference!

    let damage = calculate_damage(attacker, defender);
    defender.hp = defender.hp.saturating_sub(damage);

    println!("{} attacks {}!", attacker.name, defender.name);
    println!("{} takes {} damage! (HP: {})",
             defender.name, damage, defender.hp);
}

fn main() {
    let charmander = Pokemon { /* ... */ };
    let mut bulbasaur = Pokemon { /* ... */ };
    //  ^^^ Deve essere dichiarato mutabile!

    attack(&charmander, &mut bulbasaur);
    //                  ^^^^
    //            Mutable borrow

    println!("Bulbasaur HP after attack: {}", bulbasaur.hp);
}
```

### Le Regole del Borrowing

Rust applica queste regole a compile-time:

1. **Una sola reference mutabile** OPPURE **multiple reference immutabili**
2. Le reference devono sempre essere valide (no dangling pointers)

```rust
fn example() {
    let mut pokemon = Pokemon { /* ... */ };

    let r1 = &pokemon;     // ✅ OK - immutable borrow
    let r2 = &pokemon;     // ✅ OK - più immutable borrow vanno bene

    // let r3 = &mut pokemon; // ❌ ERRORE! Già borrowato immutabilmente

    println!("{} {}", r1.name, r2.name);

    // r1 e r2 non sono più usate, quindi:
    let r4 = &mut pokemon; // ✅ OK ora!
    r4.hp = 100;
}
```

## Caso Reale da Rustmon

Nel codice reale di Rustmon, questo pattern è usato nelle funzioni di battaglia:

```rust
// Estratto semplificato da rustmon
pub fn simulate_turn(
    attacker: &Pokemon,      // Read-only: chi attacca
    defender: &mut Pokemon,  // Modificabile: chi subisce danno
    move_used: &Move,        // Read-only: la mossa usata
) -> BattleResult {
    let effectiveness = calculate_type_effectiveness(
        move_used.move_type,
        defender.pokemon_type
    );

    let damage = (attacker.attack * effectiveness) / defender.defense;
    defender.current_hp = defender.current_hp.saturating_sub(damage);

    if defender.current_hp == 0 {
        BattleResult::Knockout
    } else {
        BattleResult::Success { damage }
    }
}
```

🔗 [Vedi il codice completo su GitHub](https://github.com/AndreaBozzo/rustmon/blob/main/src/battle.rs)

## Vantaggi di Questo Approccio

| Vantaggio | Descrizione |
|-----------|-------------|
| 🔒 **Safety** | Il compilatore previene data races e accessi invalidi |
| ⚡ **Performance** | Nessuna copia, nessun garbage collector |
| 📖 **Chiarezza** | Il tipo di signature dice esattamente cosa fa la funzione |
| 🐛 **Meno Bug** | Errori di memoria catturati a compile-time |

## Confronto con Altri Linguaggi

=== "Rust"
    ```rust
    fn attack(attacker: &Pokemon, defender: &mut Pokemon) {
        // Chiaro: leggo attacker, modifico defender
        defender.hp -= attacker.attack;
    }
    ```

=== "C++"
    ```cpp
    void attack(Pokemon* attacker, Pokemon* defender) {
        // Posso modificare entrambi? Chi lo sa!
        // Potrebbero essere nullptr?
        defender->hp -= attacker->attack;
    }
    ```

=== "Python"
    ```python
    def attack(attacker, defender):
        # Tutto è mutabile, nessuna garanzia
        defender.hp -= attacker.attack
    ```

=== "Java"
    ```java
    void attack(Pokemon attacker, Pokemon defender) {
        // Reference implicite, sempre mutabili
        defender.hp -= attacker.attack;
    }
    ```

## Esercizi Pratici

### Esercizio 1: Healing

Implementa una funzione che cura un Pokemon:

```rust
fn heal(pokemon: /* tipo? */, amount: u32) {
    // Il Pokemon deve essere modificabile
    // Aggiungi HP senza superare il massimo
}
```

??? success "Soluzione"
    ```rust
    fn heal(pokemon: &mut Pokemon, amount: u32) {
        pokemon.hp = (pokemon.hp + amount).min(pokemon.max_hp);
        println!("{} healed for {} HP!", pokemon.name, amount);
    }
    ```

### Esercizio 2: Battaglia Multi-Turno

Crea una funzione che simula più turni di battaglia:

```rust
fn battle_until_ko(pokemon1: /* tipo? */, pokemon2: /* tipo? */) {
    // Entrambi devono essere modificabili
    // Continua finché uno non raggiunge 0 HP
}
```

??? success "Soluzione"
    ```rust
    fn battle_until_ko(pokemon1: &mut Pokemon, pokemon2: &mut Pokemon) {
        let mut turn = 1;
        loop {
            println!("Turn {}", turn);

            // Pokemon1 attacca
            attack(pokemon1, pokemon2);
            if pokemon2.hp == 0 {
                println!("{} wins!", pokemon1.name);
                break;
            }

            // Pokemon2 attacca
            attack(pokemon2, pokemon1);
            if pokemon1.hp == 0 {
                println!("{} wins!", pokemon2.name);
                break;
            }

            turn += 1;
        }
    }
    ```

## Punti Chiave da Ricordare 💡

!!! tip "Takeaways"
    - **Ownership**: Ogni valore ha un unico proprietario
    - **Move**: Trasferire ownership invalida la variabile originale
    - **Borrowing**: Prestare con `&` permette l'accesso senza trasferire ownership
    - **Mutable Borrow**: `&mut` permette modifiche, ma solo una alla volta
    - **Compilatore**: Verifica tutte le regole a compile-time, zero overhead a runtime

## Prossimi Passi

Ora che hai capito l'ownership, esplora:

- [**Enums e Pattern Matching** →](enums.md) - Come Rustmon gestisce i tipi Pokemon
- [**Traits** →](traits.md) - Comportamenti comuni per tutti i Pokemon

## Approfondimenti

Per saperne di più sull'ownership:

- 📚 [Rust Book - Ownership](https://doc.rust-lang.org/book/ch04-00-understanding-ownership.html)
- 🦀 [Standard Library - References](https://doc.rust-lang.org/std/primitive.reference.html)
- 🎓 [Rust by Example - Borrowing](https://doc.rust-lang.org/rust-by-example/scope/borrow.html)

---

**Hai domande?** Apri una [discussion su GitHub](https://github.com/rust-ita/rust-docs-it/discussions)!
