# HashSet&lt;T&gt;

!!! info "Riferimento originale"
    📖 [Documentazione originale](https://doc.rust-lang.org/std/collections/struct.HashSet.html)
    🔄 Ultimo aggiornamento: Ottobre 2025
    📝 Versione Rust: 1.90+

Un set basato su hash implementato come `HashMap<T, ()>`.

## Panoramica

Un **HashSet** è una collezione di valori unici, senza alcun ordine particolare. È implementato internamente come una `HashMap<T, ()>` dove vengono memorizzate solo le chiavi e il valore è il tipo unit `()`.

```rust
use std::collections::HashSet;

// Crea un nuovo HashSet
let mut libri = HashSet::new();

// Aggiungi alcuni libri
libri.insert("Il nome della rosa");
libri.insert("1984");
libri.insert("Il Signore degli Anelli");

// Verifica se un libro è presente
if libri.contains("1984") {
    println!("Abbiamo 1984!");
}

// Tentativo di inserire un duplicato
let nuovo = libri.insert("1984"); // Restituisce false
assert_eq!(nuovo, false);
```

!!! note "Quando usare HashSet"
    Usa HashSet quando hai bisogno di:
    - Memorizzare valori unici senza duplicati
    - Verificare rapidamente la presenza di un elemento O(1)
    - Operazioni matematiche su insiemi (unione, intersezione, differenza)
    - Non ti importa dell'ordine degli elementi

## Creazione di un HashSet

Ci sono diversi modi per creare un nuovo `HashSet`:

### Usando HashSet::new()

```rust
use std::collections::HashSet;

let mut set: HashSet<i32> = HashSet::new();
```

Crea un HashSet vuoto con capacità iniziale zero. Come per HashMap, serve un'annotazione di tipo se non inserisci immediatamente valori.

### Usando HashSet::with_capacity()

```rust
use std::collections::HashSet;

let mut set = HashSet::with_capacity(10);
set.insert("elemento");
```

Prealloca spazio per almeno 10 elementi, migliorando le prestazioni se conosci approssimativamente la dimensione finale.

### Da array

```rust
use std::collections::HashSet;

let set: HashSet<&str> = HashSet::from([
    "mela",
    "banana",
    "arancia",
]);
```

Crea un HashSet direttamente da un array (Rust 1.56+).

### Da iteratori

```rust
use std::collections::HashSet;

let numeri = vec![1, 2, 3, 2, 1, 4];
let set: HashSet<i32> = numeri.into_iter().collect();

assert_eq!(set.len(), 4); // Solo valori unici
```

!!! tip "Rimozione duplicati"
    Convertire un Vec in HashSet e poi di nuovo in Vec è un modo idiomatico per rimuovere duplicati:

```rust
let vec_con_duplicati = vec![1, 2, 2, 3, 3, 3];
let set: HashSet<_> = vec_con_duplicati.into_iter().collect();
let vec_unici: Vec<_> = set.into_iter().collect();
```

## Operazioni Base

### Inserimento con insert()

Il metodo `insert()` aggiunge un valore al set. Restituisce `true` se il valore era nuovo, `false` se era già presente.

```rust
use std::collections::HashSet;

let mut set = HashSet::new();

assert_eq!(set.insert("a"), true);  // Nuovo elemento
assert_eq!(set.insert("b"), true);  // Nuovo elemento
assert_eq!(set.insert("a"), false); // Duplicato, non inserito
assert_eq!(set.len(), 2);
```

### Sostituzione con replace()

A differenza di `insert()`, `replace()` sostituisce l'elemento esistente e restituisce quello vecchio se presente.

```rust
use std::collections::HashSet;

let mut set = HashSet::new();
set.insert("vecchio");

let sostituito = set.replace("vecchio");
assert_eq!(sostituito, Some("vecchio"));
```

!!! note "replace() vs insert()"
    Per tipi che implementano `Eq` in modo custom, `replace()` può essere utile per sostituire un valore considerato "uguale" ma con rappresentazione diversa.

### Rimozione con remove()

```rust
use std::collections::HashSet;

let mut set = HashSet::from([1, 2, 3]);

assert_eq!(set.remove(&2), true);  // Elemento rimosso
assert_eq!(set.remove(&2), false); // Non più presente
assert_eq!(set.len(), 2);
```

### Rimozione con recupero usando take()

Simile a `remove()`, ma restituisce l'elemento rimosso:

```rust
use std::collections::HashSet;

let mut set = HashSet::from(["a", "b", "c"]);

let elemento = set.take("b");
assert_eq!(elemento, Some("b"));
assert!(!set.contains("b"));
```

### Svuotamento con clear()

```rust
use std::collections::HashSet;

let mut set = HashSet::from([1, 2, 3]);
set.clear();

assert!(set.is_empty());
```

## Query sul Set

### Verifica presenza con contains()

```rust
use std::collections::HashSet;

let set = HashSet::from([1, 2, 3]);

if set.contains(&2) {
    println!("Il set contiene 2");
}
```

### Recupero con get()

Restituisce un riferimento all'elemento memorizzato nel set, se presente:

```rust
use std::collections::HashSet;

let set = HashSet::from([1, 2, 3]);

match set.get(&2) {
    Some(valore) => println!("Trovato: {}", valore),
    None => println!("Non trovato"),
}
```

!!! question "Perché get() su un set?"
    `get()` può sembrare ridondante, ma è utile quando hai un valore che è "uguale" secondo `Eq` ma vuoi ottenere quello effettivamente memorizzato nel set.

### Dimensione del set

```rust
use std::collections::HashSet;

let set = HashSet::from([1, 2, 3]);

println!("Elementi: {}", set.len());
assert_eq!(set.is_empty(), false);
```

## Iterazione

### Iterazione su elementi

```rust
use std::collections::HashSet;

let set = HashSet::from(["a", "b", "c"]);

// Iterazione immutabile
for elemento in &set {
    println!("{}", elemento);
}

// Consumo del set
for elemento in set {
    println!("{}", elemento);
}
```

!!! warning "Ordine arbitrario"
    Come per HashMap, l'ordine di iterazione in HashSet è **arbitrario e non garantito**. Se hai bisogno di ordine, usa `BTreeSet`.

### Drain per svuotamento iterativo

```rust
use std::collections::HashSet;

let mut set = HashSet::from([1, 2, 3]);

// Consuma tutti gli elementi
for elemento in set.drain() {
    println!("Rimosso: {}", elemento);
}

assert!(set.is_empty());
```

### Filtraggio con retain()

Mantiene solo gli elementi che soddisfano un predicato:

```rust
use std::collections::HashSet;

let mut set: HashSet<i32> = (0..8).collect();

// Mantieni solo numeri pari
set.retain(|&x| x % 2 == 0);

assert_eq!(set.len(), 4);
```

### Rimozione condizionale con extract_if()

Rimuove e itera sugli elementi che soddisfano una condizione:

```rust
use std::collections::HashSet;

let mut set: HashSet<i32> = (0..8).collect();

// Estrai i numeri pari
let pari: HashSet<i32> = set.extract_if(|&x| x % 2 == 0).collect();

assert_eq!(set.len(), 4); // Rimangono dispari
assert_eq!(pari.len(), 4); // Estratti pari
```

## Operazioni su Insiemi

Una delle caratteristiche principali di HashSet sono le operazioni matematiche su insiemi.

### Unione con union()

Restituisce un iteratore su tutti gli elementi presenti in almeno uno dei due set:

```rust
use std::collections::HashSet;

let a: HashSet<_> = [1, 2, 3].iter().cloned().collect();
let b: HashSet<_> = [3, 4, 5].iter().cloned().collect();

let unione: HashSet<_> = a.union(&b).cloned().collect();
// {1, 2, 3, 4, 5}

assert_eq!(unione.len(), 5);
```

### Intersezione con intersection()

Restituisce elementi comuni a entrambi i set:

```rust
use std::collections::HashSet;

let a: HashSet<_> = [1, 2, 3].iter().cloned().collect();
let b: HashSet<_> = [2, 3, 4].iter().cloned().collect();

let intersezione: HashSet<_> = a.intersection(&b).cloned().collect();
// {2, 3}

assert_eq!(intersezione.len(), 2);
```

### Differenza con difference()

Restituisce elementi nel primo set ma non nel secondo:

```rust
use std::collections::HashSet;

let a: HashSet<_> = [1, 2, 3].iter().cloned().collect();
let b: HashSet<_> = [2, 3, 4].iter().cloned().collect();

let differenza: HashSet<_> = a.difference(&b).cloned().collect();
// {1}

assert_eq!(differenza.len(), 1);
assert!(differenza.contains(&1));
```

### Differenza simmetrica con symmetric_difference()

Restituisce elementi presenti in uno solo dei due set (ma non in entrambi):

```rust
use std::collections::HashSet;

let a: HashSet<_> = [1, 2, 3].iter().cloned().collect();
let b: HashSet<_> = [2, 3, 4].iter().cloned().collect();

let simmetrica: HashSet<_> = a.symmetric_difference(&b).cloned().collect();
// {1, 4}

assert_eq!(simmetrica.len(), 2);
```

### Operatori bitwise per insiemi

HashSet supporta operatori per operazioni su insiemi:

```rust
use std::collections::HashSet;

let a: HashSet<_> = [1, 2, 3].iter().cloned().collect();
let b: HashSet<_> = [2, 3, 4].iter().cloned().collect();

// Intersezione con &
let inter = &a & &b;
assert_eq!(inter.len(), 2);

// Unione con |
let union = &a | &b;
assert_eq!(union.len(), 4);

// Differenza con -
let diff = &a - &b;
assert_eq!(diff.len(), 1);

// Differenza simmetrica con ^
let sym = &a ^ &b;
assert_eq!(sym.len(), 2);
```

!!! tip "Operatori vs metodi"
    Gli operatori (`&`, `|`, `-`, `^`) sono comodi ma creano nuovi set. I metodi (`intersection()`, `union()`, ecc.) restituiscono iteratori, permettendo elaborazione lazy senza allocazioni intermedie.

## Relazioni tra Insiemi

### Verifica sottoinsieme con is_subset()

Verifica se tutti gli elementi di `self` sono presenti in `other`:

```rust
use std::collections::HashSet;

let piccolo = HashSet::from([1, 2]);
let grande = HashSet::from([1, 2, 3, 4]);

assert!(piccolo.is_subset(&grande));
assert!(!grande.is_subset(&piccolo));
```

### Verifica soprainsieme con is_superset()

Verifica se `self` contiene tutti gli elementi di `other`:

```rust
use std::collections::HashSet;

let piccolo = HashSet::from([1, 2]);
let grande = HashSet::from([1, 2, 3, 4]);

assert!(grande.is_superset(&piccolo));
assert!(!piccolo.is_superset(&grande));
```

### Verifica disgiunzione con is_disjoint()

Verifica se i due set non hanno elementi in comune:

```rust
use std::collections::HashSet;

let a = HashSet::from([1, 2, 3]);
let b = HashSet::from([4, 5, 6]);
let c = HashSet::from([3, 4, 5]);

assert!(a.is_disjoint(&b));
assert!(!a.is_disjoint(&c)); // Hanno 3 in comune
```

### Esempio pratico: analisi di set

```rust
use std::collections::HashSet;

fn analizza_set(studenti_corso_a: HashSet<&str>, studenti_corso_b: HashSet<&str>) {
    // Studenti in entrambi i corsi
    let entrambi: Vec<_> = studenti_corso_a.intersection(&studenti_corso_b).collect();
    println!("In entrambi: {:?}", entrambi);

    // Solo nel corso A
    let solo_a: Vec<_> = studenti_corso_a.difference(&studenti_corso_b).collect();
    println!("Solo in A: {:?}", solo_a);

    // Tutti gli studenti
    let tutti: Vec<_> = studenti_corso_a.union(&studenti_corso_b).collect();
    println!("Totale studenti: {}", tutti.len());
}

let corso_a = HashSet::from(["Alice", "Bob", "Carol"]);
let corso_b = HashSet::from(["Bob", "David", "Eve"]);

analizza_set(corso_a, corso_b);
```

## Ownership e Borrowing

HashSet segue le stesse regole di ownership di HashMap. Per approfondimenti, vedi la [sezione ownership in HashMap](hashmap.md#ownership-e-borrowing).

### Trasferimento di ownership

```rust
use std::collections::HashSet;

let valore = String::from("hello");
let mut set = HashSet::new();

set.insert(valore);
// valore non è più utilizzabile qui
```

### Riferimenti come elementi

```rust
use std::collections::HashSet;

let valore = String::from("hello");
let mut set = HashSet::new();

set.insert(&valore);
// valore è ancora utilizzabile
println!("{}", valore);
```

!!! note "Lifetime constraints"
    Quando usi riferimenti, il set non può vivere più a lungo dei valori referenziati, come garantito dal borrow checker.

## Gestione della Capacità

HashSet usa internamente HashMap, quindi la gestione della capacità funziona allo stesso modo. Per dettagli completi, vedi [gestione capacità in HashMap](hashmap.md#gestione-della-capacita).

### Metodi di capacità

```rust
use std::collections::HashSet;

let mut set: HashSet<i32> = HashSet::with_capacity(100);

println!("Capacità: {}", set.capacity()); // >= 100

// Prealloca per altri elementi
set.reserve(50);

// Riduci capacità
set.insert(1);
set.insert(2);
set.shrink_to_fit();

println!("Capacità ridotta: {}", set.capacity());
```

## Performance e Hashing

### Complessità temporale

| Operazione | Complessità media | Caso peggiore |
|------------|-------------------|---------------|
| `insert()` | O(1) | O(n) |
| `contains()` | O(1) | O(n) |
| `remove()` | O(1) | O(n) |
| `union()` | O(n + m) | - |
| `intersection()` | O(min(n, m)) | - |
| `difference()` | O(n) | - |

### Requisiti per gli elementi: Hash + Eq

Gli elementi devono implementare `Hash` ed `Eq`, esattamente come le chiavi in HashMap. Per dettagli completi, vedi [requisiti Hash+Eq in HashMap](hashmap.md#requisiti-per-le-chiavi-hash-eq).

```rust
use std::collections::HashSet;

#[derive(Hash, Eq, PartialEq, Debug)]
struct Punto {
    x: i32,
    y: i32,
}

let mut set = HashSet::new();
set.insert(Punto { x: 0, y: 0 });
set.insert(Punto { x: 1, y: 1 });
```

!!! danger "Invariante Hash/Eq"
    Come per HashMap, se `v1 == v2`, allora `hash(v1) == hash(v2)`. Violare questo invariante causa comportamenti errati.

### Hashing e sicurezza

HashSet usa lo stesso algoritmo SipHash 1-3 di HashMap per protezione da HashDoS. Per dettagli su hasher personalizzati, vedi [hashing in HashMap](hashmap.md#algoritmo-di-hashing-siphash-1-3).

```rust
use std::collections::HashSet;
use std::hash::BuildHasherDefault;
use std::collections::hash_map::DefaultHasher;

// HashSet con hasher personalizzato
let set: HashSet<i32, BuildHasherDefault<DefaultHasher>> =
    HashSet::with_hasher(BuildHasherDefault::default());
```

## Relazione con HashMap

HashSet è letteralmente implementato come `HashMap<T, ()>`:

```rust
// Implementazione concettuale interna
pub struct HashSet<T> {
    map: HashMap<T, ()>,
}
```

Questo significa:

- **Stessa performance**: HashSet eredita le caratteristiche di performance di HashMap
- **Stesso hashing**: Usa lo stesso algoritmo e protezioni
- **Stessa capacità**: Gestione memoria identica
- **Differenze**: HashSet espone solo operazioni su chiavi e operazioni specifiche dei set

!!! tip "Quando usare quale"
    - **HashSet**: quando hai bisogno solo di verificare presenza/assenza
    - **HashMap**: quando hai bisogno di associare valori alle chiavi

## Metodi Comuni - Tabella Riassuntiva

| Categoria | Metodo | Descrizione |
|-----------|--------|-------------|
| **Creazione** | `new()` | Crea HashSet vuoto |
| | `with_capacity(n)` | Prealloca spazio |
| | `from(array)` | Crea da array |
| **Inserimento** | `insert(v)` | Inserisce valore (restituisce bool) |
| | `replace(v)` | Sostituisce valore uguale |
| **Rimozione** | `remove(&v)` | Rimuove valore (restituisce bool) |
| | `take(&v)` | Rimuove e restituisce valore |
| | `retain(pred)` | Mantiene solo elementi che soddisfano predicato |
| | `clear()` | Rimuove tutti gli elementi |
| **Query** | `contains(&v)` | Verifica presenza |
| | `get(&v)` | Restituisce riferimento a elemento |
| | `len()` | Numero di elementi |
| | `is_empty()` | Verifica se vuoto |
| **Iterazione** | `iter()` | Itera su &T |
| | `drain()` | Consuma elementi |
| | `into_iter()` | Consuma set |
| **Operazioni Set** | `union(&other)` | Unione |
| | `intersection(&other)` | Intersezione |
| | `difference(&other)` | Differenza |
| | `symmetric_difference(&other)` | Differenza simmetrica |
| **Relazioni** | `is_subset(&other)` | Verifica sottoinsieme |
| | `is_superset(&other)` | Verifica soprainsieme |
| | `is_disjoint(&other)` | Verifica disgiunzione |
| **Capacità** | `capacity()` | Spazio allocato |
| | `reserve(n)` | Prealloca spazio aggiuntivo |
| | `shrink_to_fit()` | Riduce capacità |

## Quando Usare HashSet

### Usa HashSet quando

- Hai bisogno di memorizzare valori unici senza duplicati
- Devi verificare rapidamente se un elemento esiste
- Hai bisogno di operazioni su insiemi (unione, intersezione, ecc.)
- L'ordine degli elementi non è rilevante
- Gli elementi implementano `Hash` + `Eq`

### Considera alternative quando

- **Serve ordine**: usa `BTreeSet` (elementi ordinati)
- **Hai bisogno di coppie chiave-valore**: usa `HashMap`
- **Elementi sono interi in range limitato**: considera `Vec<bool>` o bitset
- **Set piccolo e fisso**: considera array o slice
- **Devi preservare ordine di inserimento**: usa `IndexSet` (crate `indexmap`)

### Confronto con BTreeSet

| Caratteristica | HashSet | BTreeSet |
|----------------|---------|----------|
| Inserimento | O(1) medio | O(log n) |
| Ricerca | O(1) medio | O(log n) |
| Rimozione | O(1) medio | O(log n) |
| Ordine | Arbitrario | Ordinato |
| Requisiti | Hash + Eq | Ord |
| Iterazione | Ordine casuale | Ordine crescente |
| Range queries | No | Sì |
| Memoria | Maggiore overhead | Minore overhead |

## Esempi Pratici

### Esempio 1: Filtraggio duplicati da lista

```rust
use std::collections::HashSet;

fn rimuovi_duplicati(lista: Vec<i32>) -> Vec<i32> {
    let set: HashSet<_> = lista.into_iter().collect();
    set.into_iter().collect()
}

let numeri = vec![1, 2, 2, 3, 4, 4, 5];
let unici = rimuovi_duplicati(numeri);
// unici contiene [1, 2, 3, 4, 5] (ordine non garantito)
```

### Esempio 2: Analisi di parole comuni

```rust
use std::collections::HashSet;

fn parole_comuni(testo1: &str, testo2: &str) -> HashSet<String> {
    let parole1: HashSet<String> = testo1
        .split_whitespace()
        .map(|s| s.to_lowercase())
        .collect();

    let parole2: HashSet<String> = testo2
        .split_whitespace()
        .map(|s| s.to_lowercase())
        .collect();

    parole1.intersection(&parole2).cloned().collect()
}

let testo_a = "il gatto mangia il pesce";
let testo_b = "il cane mangia la carne";
let comuni = parole_comuni(testo_a, testo_b);
// comuni = {"il", "mangia"}
```

### Esempio 3: Validazione unicità

```rust
use std::collections::HashSet;

fn ha_duplicati<T: Eq + std::hash::Hash>(items: &[T]) -> bool {
    let mut set = HashSet::new();

    for item in items {
        if !set.insert(item) {
            return true; // Trovato duplicato
        }
    }

    false
}

let valori = vec![1, 2, 3, 4, 5];
assert_eq!(ha_duplicati(&valori), false);

let duplicati = vec![1, 2, 3, 2];
assert_eq!(ha_duplicati(&duplicati), true);
```

## Vedi Anche

- [**HashMap**](hashmap.md) - Mappa hash per coppie chiave-valore
- [**BTreeSet**](https://doc.rust-lang.org/std/collections/struct.BTreeSet.html) - Set ordinato
- [**Vec**](vec.md) - Array dinamico
- [**Collections**](index.md) - Panoramica di tutte le collezioni

---

!!! question "Hai trovato errori o imprecisioni?"
    Questa documentazione è mantenuta dalla community. Se noti errori, inconsistenze terminologiche o hai suggerimenti, apri una [issue su GitHub](https://github.com/rust-ita/rust-docs-it/issues) o contribuisci direttamente!

---

**Prossimi passi**: Esplora [HashMap](hashmap.md) per associazioni chiave-valore, o [BTreeSet](https://doc.rust-lang.org/std/collections/struct.BTreeSet.html) se hai bisogno di elementi ordinati.
