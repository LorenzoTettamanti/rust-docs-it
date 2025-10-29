# Vec&lt;T&gt;

!!! info "Riferimento originale"
    📖 [Documentazione originale](https://doc.rust-lang.org/std/vec/struct.Vec.html)
    🔄 Ultimo aggiornamento: Ottobre 2025
    📝 Versione Rust: 1.90+

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

### Usando la macro vec

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

## Manipolazione avanzata degli elementi

### insert

Inserisce un elemento in una posizione specifica, spostando tutti gli elementi successivi a destra:

```rust
let mut v = vec![1, 2, 3];
v.insert(1, 4);
assert_eq!(v, vec![1, 4, 2, 3]);
```

!!! warning "Prestazioni di insert"
    `insert(i, val)` è O(n) perché tutti gli elementi dopo l'indice devono essere spostati. Se l'ordine non è importante, considera di aggiungere alla fine con `push` che è O(1).

### swap_remove

Rimuove un elemento sostituendolo con l'ultimo elemento del vector. Questo è molto più veloce di `remove` perché non richiede di spostare gli elementi:

```rust
let mut v = vec!["foo", "bar", "baz", "qux"];

assert_eq!(v.swap_remove(1), "bar");
assert_eq!(v, vec!["foo", "qux", "baz"]);

assert_eq!(v.swap_remove(0), "foo");
assert_eq!(v, vec!["baz", "qux"]);
```

!!! tip "Quando usare swap_remove"
    - **Usa `swap_remove`** quando l'ordine degli elementi non è importante e vuoi prestazioni O(1)
    - **Usa `remove`** quando devi preservare l'ordine degli elementi (anche se è O(n))

### truncate

Accorcia il vector alla lunghezza specificata. Se la lunghezza attuale è già minore o uguale, non fa nulla:

```rust
let mut v = vec![1, 2, 3, 4, 5];
v.truncate(2);
assert_eq!(v, vec![1, 2]);

// Non fa nulla se la lunghezza è già minore
v.truncate(10);
assert_eq!(v, vec![1, 2]);
```

!!! note "truncate vs clear"
    `truncate(0)` è equivalente a `clear()`, ma `clear()` è più esplicito e leggibile quando vuoi svuotare completamente il vector.

### retain

Mantiene solo gli elementi che soddisfano un predicato, rimuovendo tutti gli altri:

```rust
let mut v = vec![1, 2, 3, 4, 5, 6];
v.retain(|&x| x % 2 == 0);
assert_eq!(v, vec![2, 4, 6]);
```

Questo metodo è efficiente perché modifica il vector in-place senza allocazioni aggiuntive.

### dedup

Rimuove elementi duplicati consecutivi:

```rust
let mut v = vec![1, 2, 2, 3, 2];
v.dedup();
assert_eq!(v, vec![1, 2, 3, 2]);
```

!!! warning "dedup funziona solo su elementi consecutivi"
    Nota che `dedup` rimuove solo duplicati adiacenti. Per rimuovere tutti i duplicati, devi prima ordinare il vector:

    ```rust
    let mut v = vec![1, 2, 2, 3, 2, 1];
    v.sort();
    v.dedup();
    assert_eq!(v, vec![1, 2, 3]);
    ```

## Vec e Slice

Una delle caratteristiche più importanti di `Vec` è la sua relazione con le **slice** (`&[T]`). Comprendere questa relazione è fondamentale per scrivere codice Rust idiomatico.

### Coercion automatica

Un `Vec<T>` può essere automaticamente convertito in una slice `&[T]` usando l'operatore `&`:

```rust
fn processa_numeri(numeri: &[i32]) {
    for n in numeri {
        println!("{}", n);
    }
}

let v = vec![1, 2, 3, 4, 5];
processa_numeri(&v);  // Vec<i32> → &[i32]
```

!!! tip "Best practice: accetta slice, non Vec"
    Quando scrivi funzioni che necessitano solo di **leggere** una sequenza di elementi, accetta sempre `&[T]` invece di `&Vec<T>`. Questo rende la funzione più flessibile:

    ```rust
    // ✅ Meglio: accetta qualsiasi sequenza contigua
    fn somma(numeri: &[i32]) -> i32 {
        numeri.iter().sum()
    }

    // ❌ Meno flessibile: accetta solo Vec
    fn somma_vec(numeri: &Vec<i32>) -> i32 {
        numeri.iter().sum()
    }

    let v = vec![1, 2, 3];
    let arr = [4, 5, 6];

    somma(&v);      // ✅ Funziona
    somma(&arr);    // ✅ Funziona anche con array!

    somma_vec(&v);  // ✅ Funziona
    // somma_vec(&arr);  // ❌ Non compila!
    ```

### as_slice e as_mut_slice

Puoi ottenere esplicitamente una slice da un vector usando i metodi `as_slice()` e `as_mut_slice()`:

```rust
let v = vec![1, 2, 3];
let slice: &[i32] = v.as_slice();
```

Per modifiche mutabili:

```rust
let mut v = vec![1, 2, 3];
let slice: &mut [i32] = v.as_mut_slice();
slice[0] = 10;
assert_eq!(v, vec![10, 2, 3]);
```

!!! note "Equivalenza con l'operatore &"
    `v.as_slice()` è equivalente a `&v[..]` e `&v`. Nella maggior parte dei casi, l'operatore `&` è più conciso e preferibile.

### Differenze chiave tra Vec e Slice

| Caratteristica | Vec<T> | &[T] |
|---------------|--------|------|
| **Ownership** | Possiede i dati | Prende in prestito i dati |
| **Ridimensionabile** | Sì (`push`, `pop`, etc.) | No (dimensione fissa) |
| **Allocazione** | Heap | Può puntare a heap, stack, o memoria statica |
| **Uso tipico** | Quando devi modificare la dimensione | Per accesso in sola lettura |

## Operazioni bulk

### append

Sposta tutti gli elementi da un vector a un altro. Il vector sorgente diventa vuoto:

```rust
let mut v1 = vec![1, 2, 3];
let mut v2 = vec![4, 5, 6];

v1.append(&mut v2);

assert_eq!(v1, vec![1, 2, 3, 4, 5, 6]);
assert_eq!(v2, vec![]);  // v2 è ora vuoto
```

!!! warning "append consuma il vector sorgente"
    Dopo `append`, il vector sorgente è vuoto ma mantiene la sua capacità allocata. Se vuoi preservare entrambi i vector, usa `extend_from_slice` invece.

### extend_from_slice

Copia tutti gli elementi da una slice alla fine del vector:

```rust
let mut v = vec![1, 2, 3];
let slice = [4, 5, 6];

v.extend_from_slice(&slice);
assert_eq!(v, vec![1, 2, 3, 4, 5, 6]);
// slice è ancora utilizzabile
```

Puoi anche estendere da un altro vector senza consumarlo:

```rust
let mut v1 = vec![1, 2, 3];
let v2 = vec![4, 5, 6];

v1.extend_from_slice(&v2);

assert_eq!(v1, vec![1, 2, 3, 4, 5, 6]);
assert_eq!(v2, vec![4, 5, 6]);  // v2 è ancora intatto
```

### drain

Rimuove un range di elementi e li restituisce come iteratore:

```rust
let mut v = vec![1, 2, 3, 4, 5];
let drenati: Vec<_> = v.drain(1..4).collect();

assert_eq!(v, vec![1, 5]);
assert_eq!(drenati, vec![2, 3, 4]);
```

Puoi anche usare `drain` per rimuovere elementi senza raccoglierli:

```rust
let mut v = vec![1, 2, 3, 4, 5];
v.drain(2..);  // Rimuove dalla posizione 2 in poi
assert_eq!(v, vec![1, 2]);
```

!!! tip "drain è utile per trasformazioni complesse"
    `drain` è particolarmente utile quando vuoi processare e rimuovere elementi contemporaneamente:

    ```rust
    let mut v = vec![1, 2, 3, 4, 5];
    let somma: i32 = v.drain(1..4).sum();
    assert_eq!(somma, 9);  // 2 + 3 + 4
    assert_eq!(v, vec![1, 5]);
    ```

### split_off

Divide il vector in due parti alla posizione specificata:

```rust
let mut v = vec![1, 2, 3, 4, 5, 6];
let v2 = v.split_off(3);

assert_eq!(v, vec![1, 2, 3]);
assert_eq!(v2, vec![4, 5, 6]);
```

Questo metodo è utile quando devi separare i dati in due vector distinti mantenendo l'ownership di entrambi.

## Gestione avanzata della capacità

Oltre ai metodi base di gestione della capacità, `Vec` offre controllo fine sulla memoria allocata.

### reserve

Riserva capacità per almeno `n` elementi aggiuntivi:

```rust
let mut v = vec![1];
v.reserve(10);

// La capacità ora è almeno 11 (1 esistente + 10 riservati)
assert!(v.capacity() >= 11);
```

Questo è utile quando sai quanti elementi aggiungerai, evitando riallocazioni multiple:

```rust
let mut v = Vec::new();

// Scenario inefficiente: riallocazioni multiple
for i in 0..1000 {
    v.push(i);  // Potrebbe riallocare molte volte
}

// Scenario ottimizzato: una sola allocazione
let mut v = Vec::new();
v.reserve(1000);  // Alloca spazio sufficiente subito
for i in 0..1000 {
    v.push(i);  // Nessuna riallocazione
}
```

### reserve_exact

Come `reserve`, ma richiede esattamente la capacità specificata senza margine aggiuntivo:

```rust
let mut v = vec![1];
v.reserve_exact(10);
assert!(v.capacity() >= 11);
```

!!! note "reserve vs reserve_exact"
    `reserve` può allocare più spazio del richiesto per ridurre future riallocazioni. `reserve_exact` alloca solo lo spazio necessario. Nella maggior parte dei casi, `reserve` è la scelta migliore.

### shrink_to_fit

Riduce la capacità del vector al minimo necessario per contenere gli elementi:

```rust
let mut v = Vec::with_capacity(100);
v.push(1);
v.push(2);
v.push(3);

assert!(v.capacity() >= 100);

v.shrink_to_fit();
assert!(v.capacity() >= 3);
```

!!! warning "shrink_to_fit non garantisce una capacità esatta"
    L'allocatore potrebbe comunque allocare più spazio del richiesto. Questo metodo è solo un suggerimento per liberare memoria in eccesso.

### shrink_to

Riduce la capacità del vector a un valore minimo specificato:

```rust
let mut v = Vec::with_capacity(100);
v.extend([1, 2, 3]);

v.shrink_to(10);
assert!(v.capacity() >= 10);
assert!(v.capacity() < 100);
```

Questo è utile quando vuoi ridurre la memoria ma mantenere un buffer di capacità per future aggiunte.

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
