# Vec&lt;T&gt;

!!! info "Riferimento originale"
    📖 [Documentazione originale](https://doc.rust-lang.org/std/vec/struct.Vec.html)  
    🔄 Ultimo aggiornamento: Ottobre 2025  
    📝 Versione Rust: 1.82+

Un array dinamico ridimensionabile, scritto come `Vec<T>` ma pronunciato "vector".

## Panoramica

I **vector** permettono di memorizzare più valori dello stesso tipo in una singola struttura dati, con gli elementi disposti uno dopo l'altro in memoria. I vector possono crescere o ridursi dinamicamente durante l'esecuzione del programma.

```rust
let mut v: Vec<i32> = Vec::new();
v.push(1);
v.push(2);
v.push(3);

assert_eq!(v.len(), 3);
assert_eq!(v[0], 1);
```

## Creazione di un Vec

Ci sono diversi modi per creare un nuovo `Vec`:

### Usando Vec::new()

```rust
let v: Vec<i32> = Vec::new();
```

Questo crea un vector vuoto. Nota che abbiamo fornito un'annotazione di tipo: poiché non inseriamo alcun valore nel vector, Rust non sa che tipo di elementi intendiamo memorizzare.

### Usando la macro vec!

```rust
let v = vec![1, 2, 3];
```

La macro `vec!` è un modo conveniente per creare un nuovo vector con alcuni valori iniziali. Rust può inferire che vogliamo un `Vec<i32>` dai valori forniti.

### Con capacità predefinita

```rust
let mut v = Vec::with_capacity(10);
```

Questo crea un vector vuoto ma con spazio preallocato per 10 elementi. Questo può migliorare le prestazioni se sai approssimativamente quanti elementi aggiungerai.

## Aggiornare un Vec

Per aggiungere elementi a un vector, usiamo il metodo `push`:

```rust
let mut v = Vec::new();

v.push(5);
v.push(6);
v.push(7);
v.push(8);
```

!!! warning "Mutabilità richiesta"
    Come con qualsiasi variabile, se vogliamo modificare il suo valore, dobbiamo renderlo mutabile usando la keyword `mut`.

## Leggere elementi di un Vec

Ci sono due modi per fare riferimento a un valore memorizzato in un vector:

### Usando l'indicizzazione

```rust
let v = vec![1, 2, 3, 4, 5];

let terzo: &i32 = &v[2];
println!("Il terzo elemento è {}", terzo);
```

### Usando il metodo get

```rust
let v = vec![1, 2, 3, 4, 5];

match v.get(2) {
    Some(terzo) => println!("Il terzo elemento è {}", terzo),
    None => println!("Non c'è un terzo elemento."),
}
```

!!! tip "Quale metodo scegliere?"
    - **Indicizzazione (`&v[i]`)**: più concisa, ma causa panic se l'indice è fuori range
    - **get (`v.get(i)`)**: restituisce un `Option<&T>`, permettendoti di gestire elegantemente indici non validi

### Confronto tra i metodi

```rust
let v = vec![1, 2, 3, 4, 5];

// Questo causerà un panic!
// let non_esiste = &v[100];

// Questo restituisce None
let non_esiste = v.get(100);
assert_eq!(non_esiste, None);
```

## Iterare sui valori

### Iterazione immutabile

```rust
let v = vec![100, 32, 57];
for i in &v {
    println!("{}", i);
}
```

### Iterazione mutabile

```rust
let mut v = vec![100, 32, 57];
for i in &mut v {
    *i += 50;
}
```

!!! note "Operatore di dereferenziazione"
    Per modificare il valore a cui il riferimento mutabile punta, dobbiamo usare l'operatore di dereferenziazione (`*`) prima di usare l'operatore `+=`.

## Vec e Ownership

Le regole di ownership e borrowing si applicano ai vector:

```rust
let mut v = vec![1, 2, 3, 4, 5];

let primo = &v[0];

// Questo non compilerà!
// v.push(6);

println!("Il primo elemento è: {}", primo);
```

!!! danger "Errore di compilazione"
    Questo codice potrebbe sembrare corretto, ma Rust lo impedisce. Il motivo è che aggiungere un nuovo elemento al vector potrebbe richiedere l'allocazione di nuova memoria e la copia dei vecchi elementi nella nuova locazione. In questo caso, il riferimento al primo elemento punterebbe a memoria deallocata.

## Usare un Enum per memorizzare tipi multipli

Un vector può memorizzare solo valori dello stesso tipo. Tuttavia, le varianti di un enum sono definite sotto lo stesso tipo enum, quindi quando abbiamo bisogno di memorizzare elementi di un tipo diverso in un vector, possiamo definire e usare un enum:

```rust
enum CellaFoglio {
    Int(i32),
    Float(f64),
    Text(String),
}

let riga = vec![
    CellaFoglio::Int(3),
    CellaFoglio::Text(String::from("blu")),
    CellaFoglio::Float(10.12),
];
```

Rust ha bisogno di sapere quali tipi saranno nel vector a compile-time in modo da sapere esattamente quanta memoria heap sarà necessaria per memorizzare ogni elemento.

!!! tip "Alternative agli Enum"
    Se non conosci l'insieme esaustivo di tipi che il programma otterrà a runtime, la tecnica enum non funzionerà. In questi casi, puoi usare un trait object, che tratteremo più avanti.

## Capacità e Riallocazione

I vector mantengono traccia sia della loro **lunghezza** (numero di elementi) che della loro **capacità** (quantità di memoria allocata):

```rust
let mut v = Vec::with_capacity(10);

// La lunghezza è 0, ma la capacità è 10
assert_eq!(v.len(), 0);
assert_eq!(v.capacity(), 10);

// Aggiungi elementi
for i in 0..10 {
    v.push(i);
}

// Lunghezza ora è 10, capacità ancora 10
assert_eq!(v.len(), 10);
assert_eq!(v.capacity(), 10);

// Aggiungere un altro elemento richiederà riallocazione
v.push(11);

// Capacità è ora maggiore di 10
assert!(v.capacity() > 10);
```

## Rimuovere elementi

### pop

Rimuove l'ultimo elemento:

```rust
let mut v = vec![1, 2, 3];
assert_eq!(v.pop(), Some(3));
assert_eq!(v.pop(), Some(2));
```

### remove

Rimuove un elemento a un indice specifico:

```rust
let mut v = vec![1, 2, 3];
assert_eq!(v.remove(1), 2);
assert_eq!(v, vec![1, 3]);
```

!!! warning "Prestazioni di remove"
    `remove(i)` è O(n) perché tutti gli elementi dopo l'indice devono essere spostati. Se l'ordine non è importante, usa `swap_remove` che è O(1).

### clear

Rimuove tutti gli elementi:

```rust
let mut v = vec![1, 2, 3];
v.clear();
assert_eq!(v.len(), 0);
```

## Metodi comuni

| Metodo | Descrizione | Esempio |
|--------|-------------|---------|
| `len()` | Restituisce il numero di elementi | `v.len()` |
| `is_empty()` | Controlla se il vector è vuoto | `v.is_empty()` |
| `push(val)` | Aggiunge un elemento alla fine | `v.push(5)` |
| `pop()` | Rimuove e restituisce l'ultimo elemento | `v.pop()` |
| `get(i)` | Accesso sicuro all'indice | `v.get(2)` |
| `first()` | Riferimento al primo elemento | `v.first()` |
| `last()` | Riferimento all'ultimo elemento | `v.last()` |
| `sort()` | Ordina il vector | `v.sort()` |
| `reverse()` | Inverte l'ordine | `v.reverse()` |
| `contains(&val)` | Controlla se contiene un valore | `v.contains(&3)` |

## Quando usare Vec

I **Vec** sono appropriati quando:

- Hai bisogno di una collezione ridimensionabile di elementi
- Gli elementi sono dello stesso tipo
- Vuoi accesso casuale veloce tramite indici
- L'ordine degli elementi è importante

## Vedi anche

- [HashMap](hashmap.md) - Per coppie chiave-valore
- [HashSet](hashset.md) - Per set di valori unici
- [VecDeque](https://doc.rust-lang.org/std/collections/struct.VecDeque.html) - Per una coda double-ended
- [Slices](https://doc.rust-lang.org/std/primitive.slice.html) - Viste su sequenze contigue

---

!!! question "Hai trovato errori o imprecisioni?"
    Aiutaci a migliorare questa traduzione! [Apri una issue](https://github.com/rust-ita/rust-docs-it/issues) o proponi una modifica.