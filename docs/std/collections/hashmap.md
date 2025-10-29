# HashMap<K, V>

!!! info "Riferimento originale"
    📖 [Documentazione originale](https://doc.rust-lang.org/std/collections/struct.HashMap.html)
    🔄 Ultimo aggiornamento: Ottobre 2025
    📝 Versione Rust: 1.90+

Una hash map implementata con quadratic probing e SIMD lookup.

## Panoramica

Le **HashMap** memorizzano coppie chiave-valore, permettendo di recuperare valori in base alla loro chiave in tempo mediamente costante O(1). A differenza dei vector, che usano indici numerici, le HashMap permettono di usare qualsiasi tipo che implementi i trait `Hash` ed `Eq` come chiave.

```rust
use std::collections::HashMap;

// Crea una nuova HashMap per memorizzare punteggi
let mut punteggi = HashMap::new();

// Inserisci alcune coppie chiave-valore
punteggi.insert(String::from("Blu"), 10);
punteggi.insert(String::from("Giallo"), 50);

// Accedi a un valore tramite la sua chiave
let squadra = String::from("Blu");
let punteggio = punteggi.get(&squadra);

println!("Punteggio squadra Blu: {:?}", punteggio); // Some(10)
```

!!! note "Quando usare HashMap"
    Usa HashMap quando hai bisogno di:
    - Associare valori a chiavi specifiche
    - Ricerca veloce di valori (O(1) medio)
    - Inserimento e rimozione frequenti
    - Chiavi che non sono numeri sequenziali

## Creazione di una HashMap

Ci sono diversi modi per creare una nuova `HashMap`:

### Usando HashMap::new()

```rust
use std::collections::HashMap;

let mut map: HashMap<String, i32> = HashMap::new();
```

Questo crea una HashMap vuota con capacità iniziale zero. Nota l'annotazione di tipo: poiché non inseriamo alcun valore, Rust ha bisogno di sapere i tipi di chiave e valore.

### Usando HashMap::with_capacity()

```rust
use std::collections::HashMap;

let mut map = HashMap::with_capacity(10);
map.insert("chiave", "valore");
```

Questo crea una HashMap vuota ma con spazio preallocato per almeno 10 elementi. Questo può migliorare significativamente le prestazioni se conosci approssimativamente quanti elementi aggiungerai.

### Da array di coppie

```rust
use std::collections::HashMap;

let map: HashMap<&str, i32> = HashMap::from([
    ("uno", 1),
    ("due", 2),
    ("tre", 3),
]);
```

Puoi creare una HashMap direttamente da un array di tuple (chiave, valore).

### Da iteratori

```rust
use std::collections::HashMap;

let squadre = vec!["Blu", "Giallo"];
let punteggi_iniziali = vec![10, 50];

let map: HashMap<_, _> = squadre.iter().zip(punteggi_iniziali.iter()).collect();
```

Qualsiasi iteratore che produce coppie `(K, V)` può essere trasformato in una HashMap usando il metodo `collect()`.

!!! tip "Inferenza di tipo"
    Quando usi `collect()`, spesso puoi lasciare che Rust inferisca i tipi usando `HashMap<_, _>` o specificando solo il tipo della variabile.

## Inserimento e Aggiornamento

### Inserimento base con insert()

Il metodo `insert()` aggiunge una coppia chiave-valore alla map. Se la chiave era già presente, il valore viene aggiornato e `insert()` restituisce il valore precedente.

```rust
use std::collections::HashMap;

let mut map = HashMap::new();

// Primo inserimento: restituisce None
let old = map.insert("chiave", 1);
assert_eq!(old, None);

// Aggiornamento: restituisce Some con il valore precedente
let old = map.insert("chiave", 2);
assert_eq!(old, Some(1));
assert_eq!(map.get("chiave"), Some(&2));
```

!!! warning "Sovrascrittura valori"
    `insert()` sovrascrive sempre il valore se la chiave esiste già. Se vuoi inserire solo se la chiave è assente, usa l'Entry API.

### Inserimento condizionale con try_insert()

```rust
use std::collections::HashMap;

let mut map = HashMap::new();
map.insert("chiave", 1);

// try_insert fallisce se la chiave esiste già
match map.try_insert("chiave", 2) {
    Ok(value) => println!("Inserito: {}", value),
    Err(error) => println!("Chiave già presente con valore: {}", error.entry.get()),
}
```

### Entry API: manipolazione in-place

L'**Entry API** permette di manipolare un'entrata nella map in modo efficiente, senza dover cercare la chiave più volte.

```rust
use std::collections::HashMap;

let mut map = HashMap::new();

// Inserisci solo se la chiave non esiste
map.entry("chiave").or_insert(0);
map.entry("chiave").or_insert(1);
assert_eq!(map["chiave"], 0); // Non sovrascritto

// Modifica il valore esistente
map.entry("chiave").and_modify(|v| *v += 10).or_insert(0);
assert_eq!(map["chiave"], 10);
```

#### Esempio pratico: contatore di parole

```rust
use std::collections::HashMap;

let testo = "il gatto e il cane il gatto";
let mut contatore = HashMap::new();

for parola in testo.split_whitespace() {
    let count = contatore.entry(parola).or_insert(0);
    *count += 1;
}

println!("{:?}", contatore);
// {"il": 3, "gatto": 2, "e": 1, "cane": 1}
```

!!! tip "Entry API vs insert"
    - **Entry API**: una sola ricerca della chiave, più efficiente per logica condizionale
    - **insert()**: più semplice per sostituzioni incondizionate

#### Esempio: cache con inizializzazione lazy

```rust
use std::collections::HashMap;

fn calcolo_costoso(x: i32) -> i32 {
    println!("Calcolo costoso per {}", x);
    x * x
}

let mut cache = HashMap::new();

// Prima chiamata: calcola e memorizza
let result1 = cache.entry(5).or_insert_with(|| calcolo_costoso(5));
println!("Risultato: {}", result1);

// Seconda chiamata: usa il valore cached
let result2 = cache.entry(5).or_insert_with(|| calcolo_costoso(5));
println!("Risultato (cached): {}", result2);
```

## Lettura di Valori

Ci sono diversi metodi per accedere ai valori in una HashMap:

### Usando get()

Il metodo `get()` restituisce un `Option<&V>`, permettendoti di gestire chiavi assenti senza panic.

```rust
use std::collections::HashMap;

let mut map = HashMap::new();
map.insert("chiave", 42);

match map.get("chiave") {
    Some(valore) => println!("Trovato: {}", valore),
    None => println!("Chiave non trovata"),
}

// Oppure usa unwrap_or
let valore = map.get("chiave").unwrap_or(&0);
```

### Usando get_mut()

Per ottenere un riferimento mutabile a un valore:

```rust
use std::collections::HashMap;

let mut map = HashMap::new();
map.insert("punteggio", 10);

if let Some(punteggio) = map.get_mut("punteggio") {
    *punteggio += 5;
}

assert_eq!(map["punteggio"], 15);
```

### Usando get_key_value()

Restituisce sia la chiave memorizzata che il valore:

```rust
use std::collections::HashMap;

let mut map = HashMap::new();
map.insert(String::from("chiave"), 42);

let (k, v) = map.get_key_value("chiave").unwrap();
println!("Chiave: {}, Valore: {}", k, v);
```

!!! note "Perché get_key_value()?"
    Anche se hai la chiave, la chiave *memorizzata* nella map potrebbe essere utile (ad esempio, per evitare allocazioni quando usi `String` come chiave ma cerchi con `&str`).

### Usando l'operatore di indicizzazione

```rust
use std::collections::HashMap;

let mut map = HashMap::new();
map.insert("chiave", 42);

let valore = &map["chiave"];
println!("Valore: {}", valore);
```

!!! danger "Rischio di panic"
    L'indicizzazione (`map[key]`) causa **panic** se la chiave non esiste. Usa `get()` per gestione sicura degli errori.

### Usando contains_key()

Verifica se una chiave è presente senza accedere al valore:

```rust
use std::collections::HashMap;

let mut map = HashMap::new();
map.insert("chiave", 42);

if map.contains_key("chiave") {
    println!("La chiave esiste");
}
```

### Confronto tra i metodi

| Metodo | Tipo restituito | Panic se assente | Mutabilità |
|--------|-----------------|------------------|------------|
| `get(&key)` | `Option<&V>` | No | Immutabile |
| `get_mut(&key)` | `Option<&mut V>` | No | Mutabile |
| `get_key_value(&key)` | `Option<(&K, &V)>` | No | Immutabile |
| `&map[key]` | `&V` | **Sì** | Immutabile |
| `contains_key(&key)` | `bool` | No | N/A |

!!! tip "Quale metodo scegliere?"
    - **get()**: per lettura sicura con gestione di chiavi assenti
    - **get_mut()**: per modificare un valore esistente
    - **contains_key()**: per verifica booleana senza accedere al valore
    - **indicizzazione**: solo quando sei certo che la chiave esiste

## Rimozione di Elementi

### Rimozione base con remove()

```rust
use std::collections::HashMap;

let mut map = HashMap::new();
map.insert("chiave", 42);

// Rimuove e restituisce il valore
let valore = map.remove("chiave");
assert_eq!(valore, Some(42));
assert!(!map.contains_key("chiave"));
```

### Rimozione con remove_entry()

Restituisce sia la chiave che il valore:

```rust
use std::collections::HashMap;

let mut map = HashMap::new();
map.insert(String::from("chiave"), 42);

let (k, v) = map.remove_entry("chiave").unwrap();
println!("Rimossi chiave: {}, valore: {}", k, v);
```

### Rimozione condizionale con retain()

Mantiene solo le entrate che soddisfano un predicato:

```rust
use std::collections::HashMap;

let mut map: HashMap<i32, i32> = (0..8).map(|x| (x, x * 10)).collect();

// Mantieni solo chiavi pari
map.retain(|&k, _| k % 2 == 0);
assert_eq!(map.len(), 4);
```

### Rimozione con extract_if()

Rimuove e itera sugli elementi che soddisfano una condizione:

```rust
use std::collections::HashMap;

let mut map: HashMap<i32, i32> = (0..8).map(|x| (x, x)).collect();

// Estrai e rimuovi tutti i numeri pari
let pari: HashMap<i32, i32> = map.extract_if(|&k, _| k % 2 == 0).collect();

assert_eq!(map.len(), 4); // Rimangono solo i dispari
assert_eq!(pari.len(), 4); // Estratti i pari
```

### Svuotamento completo con clear()

```rust
use std::collections::HashMap;

let mut map = HashMap::new();
map.insert("a", 1);
map.insert("b", 2);

map.clear();
assert!(map.is_empty());
assert!(map.capacity() >= 0); // Capacità mantenuta
```

!!! note "clear() vs drop"
    `clear()` rimuove tutti gli elementi ma mantiene la memoria allocata. Per deallocare la memoria, usa `drop(map)` o lascia che la variabile esca dallo scope.

### Consumo con drain()

```rust
use std::collections::HashMap;

let mut map = HashMap::new();
map.insert("a", 1);
map.insert("b", 2);

// Consuma tutte le entrate come iteratore
for (k, v) in map.drain() {
    println!("{}: {}", k, v);
}

assert!(map.is_empty());
```

## Iterazione

Le HashMap forniscono diversi modi per iterare su chiavi, valori o entrambi:

### Iterazione su coppie chiave-valore

```rust
use std::collections::HashMap;

let mut map = HashMap::new();
map.insert("a", 1);
map.insert("b", 2);
map.insert("c", 3);

// Iterazione immutabile
for (chiave, valore) in &map {
    println!("{}: {}", chiave, valore);
}

// Iterazione mutabile sui valori
for (chiave, valore) in &mut map {
    *valore *= 2;
}
```

### Iterazione sulle chiavi

```rust
use std::collections::HashMap;

let map = HashMap::from([("a", 1), ("b", 2), ("c", 3)]);

for chiave in map.keys() {
    println!("Chiave: {}", chiave);
}
```

### Iterazione sui valori

```rust
use std::collections::HashMap;

let map = HashMap::from([("a", 1), ("b", 2), ("c", 3)]);

for valore in map.values() {
    println!("Valore: {}", valore);
}

// Iterazione mutabile sui valori
let mut map = HashMap::from([("a", 1), ("b", 2)]);
for valore in map.values_mut() {
    *valore *= 10;
}
```

### Consumo della HashMap con into_iter()

```rust
use std::collections::HashMap;

let map = HashMap::from([("a", 1), ("b", 2)]);

// Consuma la map, prendendo ownership di chiavi e valori
for (chiave, valore) in map.into_iter() {
    println!("{}: {}", chiave, valore);
}

// map non è più utilizzabile dopo into_iter()
```

### Consumo di sole chiavi o valori

```rust
use std::collections::HashMap;

let map = HashMap::from([("a", 1), ("b", 2)]);

// Consuma e ottieni solo le chiavi
let chiavi: Vec<&str> = map.into_keys().collect();

// Oppure solo i valori
let map = HashMap::from([("a", 1), ("b", 2)]);
let valori: Vec<i32> = map.into_values().collect();
```

!!! warning "Ordine di iterazione"
    L'ordine di iterazione nelle HashMap è **arbitrario e non garantito**. Non fare affidamento su un ordine specifico. Se hai bisogno di ordine, usa `BTreeMap`.

### Metodi di iterazione disponibili

| Metodo | Tipo elementi | Ownership | Mutabilità |
|--------|---------------|-----------|------------|
| `iter()` | `(&K, &V)` | Prestito | Immutabile |
| `iter_mut()` | `(&K, &mut V)` | Prestito | Valori mutabili |
| `into_iter()` | `(K, V)` | Consumo | N/A |
| `keys()` | `&K` | Prestito | Immutabile |
| `values()` | `&V` | Prestito | Immutabile |
| `values_mut()` | `&mut V` | Prestito | Mutabile |
| `into_keys()` | `K` | Consumo | N/A |
| `into_values()` | `V` | Consumo | N/A |

## Ownership e Borrowing

Le HashMap seguono le regole standard di ownership di Rust:

### Trasferimento di ownership

```rust
use std::collections::HashMap;

let chiave = String::from("colore");
let valore = String::from("blu");

let mut map = HashMap::new();
map.insert(chiave, valore);

// chiave e valore non sono più validi qui
// println!("{}", chiave); // ERRORE: value borrowed after move
```

Quando inserisci valori che non implementano `Copy` (come `String`), la ownership viene trasferita alla HashMap.

### Riferimenti come chiavi o valori

```rust
use std::collections::HashMap;

let chiave = String::from("colore");
let valore = String::from("blu");

let mut map = HashMap::new();
map.insert(&chiave, &valore);

// chiave e valore sono ancora validi
println!("Chiave: {}, Valore: {}", chiave, valore);
```

!!! danger "Lifetimes con riferimenti"
    Quando usi riferimenti come chiavi o valori, la HashMap non può vivere più a lungo dei valori referenziati. Il borrow checker garantisce questo:

```rust
let mut map = HashMap::new();
{
    let chiave = String::from("temp");
    map.insert(&chiave, 42);
} // chiave viene droppato qui
// println!("{:?}", map); // ERRORE: chiave non vive abbastanza
```

### Accesso in prestito

```rust
use std::collections::HashMap;

let mut map = HashMap::new();
map.insert(String::from("chiave"), 10);

// Prestito immutabile
let valore = map.get("chiave");
println!("Valore: {:?}", valore);

// Prestito mutabile
if let Some(v) = map.get_mut("chiave") {
    *v += 5;
}
```

!!! note "Regole del borrow checker"
    Non puoi avere prestiti mutabili e immutabili simultanei. La HashMap rispetta queste regole come ogni altra struttura dati in Rust.

## Gestione della Capacità

Le HashMap allocano memoria dinamicamente e possono crescere o ridursi secondo necessità.

### Capacità corrente

```rust
use std::collections::HashMap;

let map: HashMap<i32, i32> = HashMap::with_capacity(10);
println!("Capacità: {}", map.capacity()); // >= 10
```

### Preallocazione con reserve()

```rust
use std::collections::HashMap;

let mut map = HashMap::new();

// Assicurati che ci sia spazio per altri 100 elementi senza riallocazione
map.reserve(100);

for i in 0..100 {
    map.insert(i, i * 2);
}
```

!!! tip "Quando usare reserve()"
    Se conosci approssimativamente quanti elementi inserirai, `reserve()` può evitare riallocazioni multiple e migliorare le prestazioni.

### Riduzione della capacità con shrink_to_fit()

```rust
use std::collections::HashMap;

let mut map: HashMap<i32, i32> = HashMap::with_capacity(100);
map.insert(1, 2);
map.insert(3, 4);

println!("Capacità prima: {}", map.capacity()); // >= 100

map.shrink_to_fit();
println!("Capacità dopo: {}", map.capacity()); // ~= 2
```

### Riduzione con limite minimo

```rust
use std::collections::HashMap;

let mut map: HashMap<i32, i32> = HashMap::with_capacity(100);
map.insert(1, 2);

// Riduci ma mantieni almeno capacità per 10 elementi
map.shrink_to(10);
println!("Capacità: {}", map.capacity()); // >= 10
```

!!! note "Garanzie di capacità"
    La capacità effettiva può essere maggiore di quanto richiesto a causa di arrotondamenti interni della hash table.

### try_reserve() per allocazioni fallibili

```rust
use std::collections::HashMap;

let mut map: HashMap<i32, i32> = HashMap::new();

match map.try_reserve(1000000000) {
    Ok(_) => println!("Allocazione riuscita"),
    Err(e) => println!("Allocazione fallita: {:?}", e),
}
```

## Performance e Hashing

### Complessità temporale

Le HashMap forniscono ottime prestazioni medie:

| Operazione | Complessità media | Caso peggiore |
|------------|-------------------|---------------|
| `insert()` | O(1) | O(n) |
| `get()` | O(1) | O(n) |
| `remove()` | O(1) | O(n) |
| `contains_key()` | O(1) | O(n) |

!!! note "Complessità ammortizzata"
    L'inserimento è O(1) ammortizzato perché occasionalmente richiede riallocazioni O(n), ma queste sono rare e distribuite nel tempo.

### Requisiti per le chiavi: Hash + Eq

Le chiavi devono implementare:

- **`Hash`**: per calcolare il valore hash
- **`Eq`**: per confrontare chiavi (dopo collisione hash)

```rust
use std::collections::HashMap;

#[derive(Hash, Eq, PartialEq, Debug)]
struct Punto {
    x: i32,
    y: i32,
}

let mut map = HashMap::new();
map.insert(Punto { x: 0, y: 0 }, "origine");
```

!!! danger "Invariante critico Hash/Eq"
    **Se `k1 == k2`, allora `hash(k1) == hash(k2)`**

    Violare questo invariante causa comportamenti logici errati ma **non** undefined behavior:

```rust
use std::hash::{Hash, Hasher};
use std::collections::HashMap;

// ESEMPIO DI IMPLEMENTAZIONE ERRATA - NON FARE COSÌ
struct Bad {
    value: i32,
}

impl Hash for Bad {
    fn hash<H: Hasher>(&self, state: &mut H) {
        // Sempre lo stesso hash, viola l'invariante
        0.hash(state);
    }
}

impl PartialEq for Bad {
    fn eq(&self, other: &Self) -> bool {
        self.value == other.value
    }
}

impl Eq for Bad {}
```

### Algoritmo di hashing: SipHash 1-3

Di default, le HashMap usano **SipHash 1-3**, un algoritmo crittograficamente sicuro che protegge da attacchi HashDoS (Denial of Service).

!!! info "HashDoS Protection"
    SipHash usa un seed casuale inizializzato all'avvio del programma, rendendo praticamente impossibile per un attaccante creare deliberatamente molte collisioni hash.

### Hasher personalizzati

Se hai bisogno di prestazioni maggiori e non ti preoccupa HashDoS, puoi usare hasher alternativi:

```rust
use std::collections::HashMap;
use std::hash::BuildHasherDefault;
use std::collections::hash_map::DefaultHasher;

let mut map = HashMap::with_hasher(BuildHasherDefault::<DefaultHasher>::default());
map.insert(1, 2);
```

!!! warning "Hasher personalizzati"
    Usa hasher non crittografici solo quando:
    - Le chiavi provengono da fonti fidate
    - Il profiling mostra che l'hashing è un collo di bottiglia
    - Hai valutato i rischi di sicurezza

### Note sulle prestazioni dell'iterazione

L'iterazione su una HashMap visita tutti i bucket allocati, inclusi quelli vuoti:

```rust
use std::collections::HashMap;

let mut map = HashMap::with_capacity(100);
map.insert(1, "uno");
map.insert(2, "due");

// Anche se ci sono solo 2 elementi, l'iterazione ha costo O(capacity)
for (k, v) in &map {
    println!("{}: {}", k, v);
}
```

!!! tip "Ottimizzazione iterazione"
    Se itererai frequentemente su una HashMap piccola con grande capacità, considera `shrink_to_fit()` prima dell'iterazione.

## Vincoli e Limitazioni

### Impossibilità di uso in const/static

Le HashMap standard non possono essere create in contesti `const` o `static` perché richiedono inizializzazione casuale del seed:

```rust
use std::collections::HashMap;

// ERRORE: cannot call non-const fn
// static MAP: HashMap<i32, i32> = HashMap::new();
```

**Soluzioni**:

#### Opzione 1: LazyLock (Rust 1.80+)

```rust
use std::collections::HashMap;
use std::sync::LazyLock;

static MAP: LazyLock<HashMap<i32, &str>> = LazyLock::new(|| {
    let mut m = HashMap::new();
    m.insert(1, "uno");
    m.insert(2, "due");
    m
});

fn main() {
    println!("{:?}", MAP.get(&1));
}
```

#### Opzione 2: Hasher deterministico

```rust
use std::collections::HashMap;
use std::hash::BuildHasherDefault;
use std::collections::hash_map::DefaultHasher;

const fn create_map() -> HashMap<i32, i32, BuildHasherDefault<DefaultHasher>> {
    HashMap::with_hasher(BuildHasherDefault::default())
}
```

!!! warning "Trade-off sicurezza"
    Gli hasher deterministici sacrificano la protezione HashDoS per consentire inizializzazione const/static.

## Metodi Comuni - Tabella Riassuntiva

| Categoria | Metodo | Descrizione |
|-----------|--------|-------------|
| **Creazione** | `new()` | Crea HashMap vuota |
| | `with_capacity(n)` | Prealloca spazio per n elementi |
| | `from(array)` | Crea da array di tuple |
| **Inserimento** | `insert(k, v)` | Inserisce o aggiorna |
| | `try_insert(k, v)` | Inserisce solo se assente |
| | `entry(k)` | Accesso Entry API |
| **Lettura** | `get(&k)` | Legge valore (Option) |
| | `get_mut(&k)` | Legge mutabile |
| | `contains_key(&k)` | Verifica presenza |
| | `&map[k]` | Indicizzazione (panic se assente) |
| **Rimozione** | `remove(&k)` | Rimuove entrata |
| | `remove_entry(&k)` | Rimuove e restituisce coppia |
| | `retain(pred)` | Mantiene solo entrate che soddisfano predicato |
| | `clear()` | Rimuove tutto |
| **Iterazione** | `iter()` | Itera su (&K, &V) |
| | `keys()` | Itera su &K |
| | `values()` | Itera su &V |
| | `into_iter()` | Consuma e itera su (K, V) |
| **Capacità** | `len()` | Numero di elementi |
| | `is_empty()` | Verifica se vuota |
| | `capacity()` | Spazio allocato |
| | `reserve(n)` | Prealloca per n elementi aggiuntivi |
| | `shrink_to_fit()` | Riduce capacità al minimo |

## Quando Usare HashMap

### Usa HashMap quando

- Hai bisogno di associazioni chiave-valore con chiavi non numeriche
- Richiedi accesso O(1) in media
- L'ordine degli elementi non è importante
- Le chiavi implementano `Hash` + `Eq`
- Inserimenti e rimozioni sono frequenti

### Considera alternative quando

- **Serve ordine**: usa `BTreeMap` (ordine di chiavi)
- **Chiavi sono interi sequenziali**: usa `Vec<T>` (più efficiente)
- **Set senza valori**: usa `HashSet<T>`
- **Chiavi sono `String`**: considera `HashMap<&str, V>` con lifetime se possibile
- **Dati read-only**: considera `phf` crate per perfect hash functions (compile-time)

### Confronto con BTreeMap

| Caratteristica | HashMap | BTreeMap |
|----------------|---------|----------|
| Accesso | O(1) medio | O(log n) |
| Inserimento | O(1) medio | O(log n) |
| Rimozione | O(1) medio | O(log n) |
| Ordine | Arbitrario | Ordinato |
| Requisiti chiave | Hash + Eq | Ord |
| Memoria | Maggiore overhead | Minore overhead |
| Range queries | No | Sì |

## Vedi Anche

- [**HashSet**](hashset.md) - Set basato su HashMap
- [**BTreeMap**](https://doc.rust-lang.org/std/collections/struct.BTreeMap.html) - Mappa ordinata
- [**Vec**](vec.md) - Array dinamico per indici sequenziali
- [**Collections**](index.md) - Panoramica di tutte le collezioni
- [**Entry API**](index.md#entry-api) - Approfondimento su pattern Entry

---

!!! question "Hai trovato errori o imprecisioni?"
    Questa documentazione è mantenuta dalla community. Se noti errori, terminology inconsistenze o hai suggerimenti per miglioramenti, apri una [issue su GitHub](https://github.com/rust-ita/rust-docs-it/issues) o contribuisci direttamente!

---

**Prossimi passi**: Esplora [HashSet](hashset.md) per set di valori unici, o [BTreeMap](https://doc.rust-lang.org/std/collections/struct.BTreeMap.html) se hai bisogno di chiavi ordinate.
