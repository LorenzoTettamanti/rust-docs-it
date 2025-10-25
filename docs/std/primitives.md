# Tipi Primitivi

!!! info "Riferimento originale"
    📖 [Documentazione originale](https://doc.rust-lang.org/std/#primitives)
    🔄 Ultimo aggiornamento: Ottobre 2025
    📝 Versione Rust: 1.82+

I **tipi primitivi** sono i mattoni fondamentali del linguaggio Rust. Questi tipi sono integrati nel linguaggio stesso e forniscono le operazioni base per lavorare con numeri, testo, valori logici e strutture dati fondamentali.

## Panoramica

Rust fornisce 18 tipi primitivi principali, organizzati in diverse categorie:

- **Tipi numerici**: interi con e senza segno, numeri in virgola mobile
- **Tipi testuali**: caratteri e string slice
- **Tipi logici**: booleani
- **Tipi composti**: array, slice, tuple e unit type
- **Puntatori e riferimenti**: puntatori raw, riferimenti, function pointer

A differenza di molti altri linguaggi, in Rust i tipi primitivi sono tutti **a dimensione nota a compile-time** (tranne slice e str che sono dynamically sized types - DST).

## Tipi Numerici Interi

Rust offre una vasta gamma di tipi interi, permettendoti di scegliere la dimensione appropriata in base alle tue esigenze.

### Interi con Segno (Signed)

Gli interi con segno possono rappresentare sia numeri positivi che negativi usando la rappresentazione in complemento a due.

| Tipo | Dimensione | Range | Uso tipico |
|------|------------|-------|------------|
| `i8` | 8 bit | -128 a 127 | Piccoli numeri, ottimizzazione memoria |
| `i16` | 16 bit | -32,768 a 32,767 | Valori numerici medi |
| `i32` | 32 bit | -2,147,483,648 a 2,147,483,647 | **Tipo di default** per interi |
| `i64` | 64 bit | -9,223,372,036,854,775,808 a 9,223,372,036,854,775,807 | Grandi numeri, timestamp |
| `i128` | 128 bit | Estremamente ampio | Calcoli crittografici, UUID |
| `isize` | Dipende dall'architettura | 32 o 64 bit | Indicizzazione, dimensioni memoria |

```rust
let a: i8 = -128;
let b: i32 = 42;        // Tipo di default
let c: i64 = -1_000_000;
let d: i128 = 170_141_183_460_469_231_731_687_303_715_884_105_727;
```

### Interi Senza Segno (Unsigned)

Gli interi senza segno possono rappresentare solo numeri positivi (incluso lo zero), permettendo di raddoppiare il range massimo positivo.

| Tipo | Dimensione | Range | Uso tipico |
|------|------------|-------|------------|
| `u8` | 8 bit | 0 a 255 | Byte, dati binari, pixel |
| `u16` | 16 bit | 0 a 65,535 | Port numbers, ID |
| `u32` | 32 bit | 0 a 4,294,967,295 | Contatori, hash |
| `u64` | 64 bit | 0 a 18,446,744,073,709,551,615 | File size, timestamp Unix |
| `u128` | 128 bit | Estremamente ampio | Crittografia, UUID |
| `usize` | Dipende dall'architettura | 32 o 64 bit | **Indici di array e collection** |

```rust
let byte: u8 = 255;
let counter: u32 = 0;
let file_size: u64 = 1_000_000_000;
```

!!! tip "Underscore nei letterali numerici"
    Puoi usare `_` nei numeri per migliorare la leggibilità: `1_000_000` è equivalente a `1000000`.

### isize e usize

I tipi `isize` e `usize` hanno una dimensione che dipende dall'architettura del sistema:

- **32 bit** su sistemi a 32 bit
- **64 bit** su sistemi a 64 bit

```rust
let index: usize = 0;
let offset: isize = -10;

let v = vec![1, 2, 3, 4, 5];
let first = v[0];  // Gli indici sono sempre usize
```

!!! note "Quando usare isize/usize"
    - **usize**: per indicizzare array, Vec, slice e altre collection
    - **isize**: per rappresentare offset o differenze tra puntatori
    - La libreria standard usa questi tipi per dimensioni e indici

### Letterali Numerici

Rust permette di specificare i letterali numerici in vari formati:

```rust
let decimal = 98_222;           // Decimale
let hex = 0xff;                 // Esadecimale
let octal = 0o77;               // Ottale
let binary = 0b1111_0000;       // Binario
let byte = b'A';                // Byte (solo u8)

// Suffissi di tipo
let x = 42u32;                  // u32
let y = 100_i64;                // i64
```

### Overflow e Comportamenti

In modalità debug, Rust controlla l'overflow degli interi e causa **panic** se si verifica:

```rust
let mut x: u8 = 255;
// x += 1;  // Panic in debug mode!
```

In modalità release, Rust usa **wrapping behavior** (complemento a due):

```rust
let mut x: u8 = 255;
x = x.wrapping_add(1);  // x diventa 0
```

!!! warning "Gestione esplicita dell'overflow"
    Per controllare esplicitamente il comportamento in caso di overflow, usa i metodi dedicati:

    ```rust
    let x: u8 = 200;
    let y: u8 = 100;

    // wrapping_* - comportamento wrapping
    let z = x.wrapping_add(y);  // 44

    // checked_* - restituisce Option
    let z = x.checked_add(y);   // None

    // saturating_* - satura al min/max
    let z = x.saturating_add(y); // 255

    // overflowing_* - restituisce tupla (risultato, overflow)
    let (z, overflow) = x.overflowing_add(y);  // (44, true)
    ```

## Tipi Floating-Point

Rust fornisce due tipi per numeri in virgola mobile, seguendo lo standard IEEE 754.

### f32 e f64

| Tipo | Dimensione | Precisione | Uso tipico |
|------|------------|------------|------------|
| `f32` | 32 bit | ~6-9 cifre decimali | Grafica, ottimizzazione memoria |
| `f64` | 64 bit | ~15-17 cifre decimali | **Tipo di default**, calcoli scientifici |

```rust
let x = 2.0;        // f64 (default)
let y: f32 = 3.0;   // f32

// Notazione scientifica
let large = 1e6;    // 1,000,000.0
let small = 1e-6;   // 0.000001
```

### Operazioni Floating-Point

```rust
let sum = 5.0 + 10.0;
let difference = 95.5 - 4.3;
let product = 4.0 * 30.0;
let quotient = 56.7 / 32.2;
let remainder = 43.0 % 5.0;

// Funzioni matematiche
let abs = (-3.5f64).abs();
let floor = 3.7f64.floor();
let ceil = 3.2f64.ceil();
let round = 3.5f64.round();
let sqrt = 2.0f64.sqrt();
let pow = 2.0f64.powi(3);  // 8.0
```

!!! danger "Attenzione: Confronti con floating-point"
    I numeri in virgola mobile possono avere problemi di precisione. Evita confronti diretti con `==`:

    ```rust
    let x = 0.1 + 0.2;
    // x == 0.3  // Potrebbe essere false!

    // Usa una tolleranza (epsilon)
    let epsilon = 1e-10;
    let equal = (x - 0.3).abs() < epsilon;
    ```

### Valori Speciali

I tipi floating-point hanno valori speciali:

```rust
let inf = f64::INFINITY;
let neg_inf = f64::NEG_INFINITY;
let nan = f64::NAN;

// Controlli
let x = 1.0 / 0.0;
assert!(x.is_infinite());
assert!(x.is_sign_positive());

let y = 0.0 / 0.0;
assert!(y.is_nan());
```

!!! note "NaN non è uguale a se stesso"
    ```rust
    let nan = f64::NAN;
    assert!(nan != nan);  // true!

    // Usa is_nan() per verificare
    assert!(nan.is_nan());
    ```

## Tipo Booleano

Il tipo `bool` rappresenta un valore logico che può essere `true` o `false`.

```rust
let t = true;
let f: bool = false;

// Operatori logici
let and = t && f;        // false
let or = t || f;         // true
let not = !t;            // false

// Uso in condizioni
if t {
    println!("È vero!");
}
```

### Conversione da Booleani

```rust
// Bool -> numero
let n = true as u8;      // 1
let m = false as u8;     // 0

// Numero -> bool richiede confronto esplicito
let x = 5;
let is_positive = x > 0;  // true
```

!!! warning "Non conversione implicita"
    A differenza di C, Rust **non converte** automaticamente numeri in bool:

    ```rust
    let x = 5;
    // if x { }  // ❌ Errore di compilazione!
    if x != 0 { }  // ✅ Corretto
    ```

## Tipo Carattere

Il tipo `char` rappresenta un valore scalare Unicode e occupa sempre 4 byte.

```rust
let c = 'z';
let z: char = 'ℤ';
let heart = '❤';
let emoji = '😻';
```

### Caratteristiche di char

- Rappresenta un **Unicode Scalar Value** (da U+0000 a U+D7FF e da U+E000 a U+10FFFF)
- Dimensione: **4 byte** (32 bit)
- Si scrive con **apici singoli** `'a'` (le stringhe usano apici doppi `"abc"`)

```rust
let letter = 'A';
let digit = '5';
let unicode = '\u{1F600}';  // 😀 (emoji)

// Metodi utili
assert!(letter.is_alphabetic());
assert!(digit.is_numeric());
assert_eq!(letter.to_lowercase().next(), Some('a'));
```

!!! tip "char vs byte"
    ```rust
    let c: char = '€';      // 4 byte - Unicode scalar
    let b: u8 = b'A';       // 1 byte - ASCII byte

    // Un char può contenere emoji e caratteri internazionali
    let emoji: char = '🦀';  // ✅ OK
    // let byte: u8 = b'🦀';   // ❌ Errore! u8 è solo ASCII
    ```

## String Slice (str)

Il tipo `str` è un tipo primitivo per rappresentare stringhe UTF-8. Normalmente lo si incontra nella sua forma borrowed `&str`.

```rust
let hello: &str = "Ciao, mondo!";
let slice: &str = &hello[0..4];  // "Ciao"
```

### Caratteristiche di str

- Sequenza di byte UTF-8 **immutabile**
- **Dynamically Sized Type (DST)** - dimensione non nota a compile-time
- Quasi sempre usato come `&str` (riferimento a str)

```rust
// Letterali stringa sono &str
let s1 = "hello";
let s2: &str = "world";

// String slice da String
let string = String::from("hello world");
let slice = &string[0..5];  // "hello"

// Metodi comuni
let len = s1.len();              // 5
let is_empty = s1.is_empty();    // false
let contains = s1.contains("ll"); // true
let upper = s1.to_uppercase();   // "HELLO" (restituisce String)
```

!!! note "str vs String"
    - **`str`** (`&str`): vista immutabile su una stringa UTF-8 (slice)
    - **`String`**: stringa heap-allocated, mutabile e proprietaria

    ```rust
    let slice: &str = "immutabile";      // Stack o sezione dati
    let owned: String = String::from("mutabile");  // Heap
    ```

### Iterazione su str

```rust
let s = "hello";

// Caratteri Unicode
for c in s.chars() {
    println!("{}", c);
}

// Byte grezzi
for b in s.bytes() {
    println!("{}", b);
}
```

!!! warning "Indicizzazione non disponibile"
    Non puoi indicizzare direttamente una `&str` perché i caratteri UTF-8 possono occupare byte variabili:

    ```rust
    let s = "hello";
    // let c = s[0];  // ❌ Errore!

    // Usa chars() o byte()
    let c = s.chars().nth(0);  // Some('h')
    ```

## Array

Un array `[T; N]` è una collezione a **dimensione fissa** di elementi dello stesso tipo allocata sullo stack.

```rust
let a: [i32; 5] = [1, 2, 3, 4, 5];
let b = [0; 10];  // [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]

// Accesso
let first = a[0];
let second = a[1];
```

### Caratteristiche degli Array

- **Dimensione fissa** nota a compile-time
- Allocati sullo **stack**
- Accesso con indice: O(1)
- Dimensione parte del tipo: `[i32; 3]` è diverso da `[i32; 5]`

```rust
let months = [
    "January", "February", "March", "April", "May", "June",
    "July", "August", "September", "October", "November", "December"
];

// Lunghezza
let len = months.len();  // 12

// Iterazione
for month in months.iter() {
    println!("{}", month);
}
```

!!! warning "Bounds checking"
    Rust verifica sempre i limiti degli array a runtime:

    ```rust
    let a = [1, 2, 3];
    // let x = a[10];  // ❌ Panic a runtime!

    // Accesso sicuro con get()
    let x = a.get(10);  // None
    ```

### Array multidimensionali

```rust
let matrix: [[i32; 3]; 2] = [
    [1, 2, 3],
    [4, 5, 6],
];

let element = matrix[0][1];  // 2
```

## Slice

Una slice `[T]` è una vista **dynamically sized** su una sequenza contigua di elementi. Come `str`, viene quasi sempre usata come riferimento `&[T]`.

```rust
let a = [1, 2, 3, 4, 5];
let slice: &[i32] = &a[1..3];  // [2, 3]
```

### Creare Slice

```rust
let a = [1, 2, 3, 4, 5];

let complete = &a[..];     // Tutta l'array
let from_start = &a[..3];  // [1, 2, 3]
let to_end = &a[2..];      // [3, 4, 5]
let middle = &a[1..4];     // [2, 3, 4]
```

### Slice da Vec

```rust
let v = vec![1, 2, 3, 4, 5];
let slice: &[i32] = &v[1..3];  // [2, 3]

// Funzione che accetta slice
fn sum(slice: &[i32]) -> i32 {
    slice.iter().sum()
}

let total = sum(&v);        // ✅ Vec
let partial = sum(&a);      // ✅ Array
let some = sum(slice);      // ✅ Slice
```

!!! tip "Accetta slice, non array o Vec"
    Quando scrivi funzioni che leggono sequenze di dati, accetta `&[T]` invece di `&Vec<T>` o `&[T; N]`. Questo rende la funzione più flessibile e idiomatica.

### Slice mutabili

```rust
let mut a = [1, 2, 3, 4, 5];
let slice: &mut [i32] = &mut a[1..4];

slice[0] = 10;
// a è ora [1, 10, 3, 4, 5]
```

### Metodi comuni su Slice

```rust
let slice = &[1, 2, 3, 4, 5];

// Lunghezza e controlli
let len = slice.len();
let is_empty = slice.is_empty();
let first = slice.first();      // Some(&1)
let last = slice.last();        // Some(&5)

// Ricerca
let contains = slice.contains(&3);  // true
let pos = slice.iter().position(|&x| x == 3);  // Some(2)

// Suddivisione
let (left, right) = slice.split_at(2);  // ([1, 2], [3, 4, 5])

// Windows e chunks
for window in slice.windows(2) {
    println!("{:?}", window);  // [1,2], [2,3], [3,4], [4,5]
}

for chunk in slice.chunks(2) {
    println!("{:?}", chunk);   // [1,2], [3,4], [5]
}
```

## Tuple

Una tupla è una collezione **eterogenea** a dimensione fissa di valori che possono avere tipi diversi.

```rust
let tup: (i32, f64, u8) = (500, 6.4, 1);

// Destructuring
let (x, y, z) = tup;

// Accesso con indice
let five_hundred = tup.0;
let six_point_four = tup.1;
let one = tup.2;
```

### Caratteristiche delle Tuple

- **Dimensione fissa** nota a compile-time
- **Tipi eterogenei** - ogni elemento può avere un tipo diverso
- Accesso con `.0`, `.1`, `.2`, ecc.

```rust
// Tuple come valori di ritorno
fn calculate(x: i32) -> (i32, i32, i32) {
    (x + 1, x * 2, x * x)
}

let (a, b, c) = calculate(5);
// a = 6, b = 10, c = 25

// Tuple nidificate
let nested = ((1, 2), (3, 4));
let ((a, b), (c, d)) = nested;
```

### Tuple con un elemento

```rust
let single = (5,);  // Nota la virgola!
let not_tuple = (5);  // Questo è solo un i32 tra parentesi
```

!!! note "Unit type `()`"
    La tupla vuota `()` è chiamata **unit type** e rappresenta l'assenza di un valore significativo. È il tipo di ritorno di default delle funzioni che non restituiscono nulla.

## Unit Type

Il tipo `()` (pronunciato "unit") è una tupla vuota che rappresenta l'assenza di valore.

```rust
let unit: () = ();

// Funzioni senza return esplicito restituiscono ()
fn print_hello() {
    println!("Hello!");
}  // Restituisce implicitamente ()

let result: () = print_hello();
```

### Uso del Unit Type

```rust
// Equivalenti
fn do_something() -> () {
    println!("doing");
}

fn do_something() {
    println!("doing");
}

// Result con unit
fn may_fail() -> Result<(), String> {
    if true {
        Ok(())
    } else {
        Err(String::from("failed"))
    }
}
```

!!! tip "Unit in pattern matching"
    ```rust
    match some_result {
        Ok(()) => println!("Success!"),
        Err(e) => println!("Error: {}", e),
    }
    ```

## Pointer (Puntatori Raw)

I puntatori raw `*const T` e `*mut T` sono puntatori non sicuri che bypassano le regole di borrowing di Rust.

```rust
let x = 5;
let raw_ptr: *const i32 = &x as *const i32;

let mut y = 10;
let mut_ptr: *mut i32 = &mut y as *mut i32;
```

### Caratteristiche dei Puntatori Raw

- **Non garantiscono** che il puntatore sia valido
- **Non rispettano** le regole di borrowing
- **Richiedono** un blocco `unsafe` per dereferenziarli
- Possono essere null

```rust
let mut num = 5;

let r1 = &num as *const i32;
let r2 = &mut num as *mut i32;

// Dereferenziazione richiede unsafe
unsafe {
    println!("r1 is: {}", *r1);
    *r2 = 10;
    println!("r2 is: {}", *r2);
}
```

!!! danger "Usa i puntatori raw solo quando necessario"
    I puntatori raw bypassano tutte le garanzie di sicurezza di Rust. Usali solo quando:
    - Interagisci con codice C tramite FFI
    - Implementi strutture dati unsafe di basso livello
    - Hai bisogno di prestazioni estreme in scenari specifici

    Nella maggior parte dei casi, i riferimenti normali sono sufficienti e più sicuri.

### Creare puntatori null

```rust
let null_ptr: *const i32 = std::ptr::null();
let null_mut_ptr: *mut i32 = std::ptr::null_mut();

// Verifica
if null_ptr.is_null() {
    println!("Il puntatore è null!");
}
```

## Reference (Riferimenti)

I riferimenti `&T` e `&mut T` sono il modo sicuro di Rust per prestare l'accesso a un valore senza prenderne ownership.

```rust
let x = 5;
let r: &i32 = &x;  // Riferimento immutabile

let mut y = 10;
let mr: &mut i32 = &mut y;  // Riferimento mutabile
*mr = 20;
```

### Regole del Borrowing

Rust applica due regole fondamentali:

1. Puoi avere **uno qualsiasi** di questi, ma non entrambi:
   - Un riferimento mutabile (`&mut T`)
   - Qualsiasi numero di riferimenti immutabili (`&T`)

2. I riferimenti devono sempre essere **validi** (non dangling)

```rust
let mut s = String::from("hello");

let r1 = &s;        // ✅ OK
let r2 = &s;        // ✅ OK - multipli riferimenti immutabili
// let r3 = &mut s;   // ❌ Errore! Non puoi avere &mut mentre esistono &

println!("{} {}", r1, r2);

let r4 = &mut s;    // ✅ OK ora - r1 e r2 non sono più usati
r4.push_str(" world");
```

### Riferimenti immutabili

```rust
fn calculate_length(s: &String) -> usize {
    s.len()
}  // s esce dallo scope, ma non dealloca perché non ha ownership

let s1 = String::from("hello");
let len = calculate_length(&s1);
println!("Length of '{}' is {}", s1, len);  // s1 è ancora valido!
```

### Riferimenti mutabili

```rust
fn append_world(s: &mut String) {
    s.push_str(" world");
}

let mut s = String::from("hello");
append_world(&mut s);
println!("{}", s);  // "hello world"
```

!!! tip "Pattern idiomatico: accetta riferimenti"
    ```rust
    // ✅ Idiomatico - non prende ownership
    fn process(data: &[i32]) {
        // ...
    }

    // ❌ Meno idiomatico - prende ownership inutilmente
    fn process_owned(data: Vec<i32>) {
        // ...
    }
    ```

### Lifetime nei riferimenti

I riferimenti hanno sempre un **lifetime** che garantisce che il dato puntato sia ancora valido:

```rust
fn longest<'a>(x: &'a str, y: &'a str) -> &'a str {
    if x.len() > y.len() {
        x
    } else {
        y
    }
}

let string1 = String::from("long string");
let string2 = String::from("short");
let result = longest(string1.as_str(), string2.as_str());
```

## Function Pointer

Il tipo `fn` rappresenta un puntatore a una funzione. A differenza delle closure, i function pointer sono tipi primitivi.

```rust
fn add_one(x: i32) -> i32 {
    x + 1
}

let f: fn(i32) -> i32 = add_one;
let result = f(5);  // 6
```

### Passare funzioni come argomenti

```rust
fn apply_operation(x: i32, operation: fn(i32) -> i32) -> i32 {
    operation(x)
}

fn double(x: i32) -> i32 {
    x * 2
}

fn triple(x: i32) -> i32 {
    x * 3
}

let result1 = apply_operation(5, double);  // 10
let result2 = apply_operation(5, triple);  // 15
```

### Function pointer vs Closure

```rust
// Function pointer
let f: fn(i32) -> i32 = |x| x + 1;

// Closure con cattura
let y = 5;
let closure = |x| x + y;  // Non può essere convertita in fn pointer

// Usare trait bound per accettare entrambi
fn call_with_10<F>(f: F) -> i32
where
    F: Fn(i32) -> i32,
{
    f(10)
}
```

!!! note "fn implementa Fn, FnMut e FnOnce"
    Un function pointer implementa automaticamente tutti e tre i trait delle closure, quindi può essere usato ovunque si accetti una closure.

## Tabella Riepilogativa

### Tipi Numerici

| Categoria | Tipi | Dimensione | Note |
|-----------|------|------------|------|
| Interi con segno | i8, i16, i32, i64, i128, isize | 8-128 bit | Default: i32 |
| Interi senza segno | u8, u16, u32, u64, u128, usize | 8-128 bit | usize per indici |
| Floating-point | f32, f64 | 32-64 bit | Default: f64 |

### Tipi Testuali e Logici

| Tipo | Dimensione | Descrizione |
|------|------------|-------------|
| bool | 1 byte | true o false |
| char | 4 byte | Unicode scalar value |
| str | Variabile | String slice UTF-8 (DST) |

### Tipi Composti

| Tipo | Sintassi | Dimensione | Allocazione |
|------|----------|------------|-------------|
| Array | [T; N] | Fissa | Stack |
| Slice | [T] | Dinamica (DST) | Vista su dati esistenti |
| Tuple | (T, U, ...) | Fissa | Stack |
| Unit | () | 0 | N/A |

### Puntatori e Riferimenti

| Tipo | Sintassi | Sicurezza | Note |
|------|----------|-----------|------|
| Reference immutabile | &T | Sicuro | Borrow checker |
| Reference mutabile | &mut T | Sicuro | Borrow checker |
| Raw pointer const | *const T | Unsafe | Nessuna garanzia |
| Raw pointer mut | *mut T | Unsafe | Nessuna garanzia |
| Function pointer | fn(T) -> U | Sicuro | Puntatore a funzione |

## Best Practices

### Scelta del tipo numerico

```rust
// ✅ Usa i32 per interi generici (default)
let count = 42;

// ✅ Usa usize per indici e dimensioni
let index: usize = 0;
let len = vec.len();

// ✅ Usa u8 per byte e dati binari
let byte: u8 = 0xFF;

// ✅ Usa f64 per floating-point (default)
let pi = 3.14159;

// ✅ Usa tipi più grandi solo quando necessario
let timestamp: i64 = 1634567890;
```

### Gestione dell'overflow

```rust
// ✅ Usa metodi espliciti per gestire l'overflow
let result = x.checked_add(y).unwrap_or(0);
let clamped = value.saturating_sub(10);

// ❌ Evita di fare affidamento sul wrapping implicito
let result = x + y;  // Panic in debug, wrapping in release
```

### Preferisci riferimenti a ownership

```rust
// ✅ Accetta riferimenti quando non serve ownership
fn process(data: &[i32]) {
    // ...
}

// ❌ Non prendere ownership inutilmente
fn process_owned(data: Vec<i32>) {
    // ...
}
```

### Usa slice invece di array o Vec

```rust
// ✅ Accetta slice per massima flessibilità
fn sum(numbers: &[i32]) -> i32 {
    numbers.iter().sum()
}

// Funziona con array, Vec, e slice!
let arr = [1, 2, 3];
let vec = vec![1, 2, 3];
sum(&arr);
sum(&vec);
```

### Evita puntatori raw quando possibile

```rust
// ✅ Usa riferimenti normali
let x = &value;

// ❌ Evita puntatori raw a meno che strettamente necessario
let x = &value as *const i32;
```

## Conversioni tra Tipi

### Casting con as

```rust
let x = 5u32;
let y = x as i32;       // u32 -> i32
let z = y as f64;       // i32 -> f64

let c = 'A';
let byte = c as u8;     // char -> u8 (solo ASCII safe!)
```

!!! warning "Conversioni lossy"
    Il cast con `as` può perdere informazioni:

    ```rust
    let x: i32 = 1000;
    let y: u8 = x as u8;  // 232 (overflow!)

    let pi = 3.14;
    let truncated = pi as i32;  // 3 (perde la parte decimale)
    ```

### Metodi From e Into

```rust
// Conversioni sicure
let x: i32 = 5;
let y: i64 = i64::from(x);  // i32 -> i64 sempre sicuro

let byte: u8 = 65;
let character: char = char::from(byte);  // u8 -> char (se valido)
```

### Metodi TryFrom e TryInto

```rust
use std::convert::TryFrom;

let x: i32 = 1000;
let y: Result<u8, _> = u8::try_from(x);  // Err - fuori range

match y {
    Ok(val) => println!("Successo: {}", val),
    Err(e) => println!("Errore di conversione: {}", e),
}
```

## Quando Usare Ogni Tipo

### Usa i32/u32 quando:
- Hai bisogno di un intero generico
- Il range è sufficiente per i tuoi dati
- Le prestazioni non sono critiche

### Usa usize quando:
- Indicizzi array o collection
- Lavori con dimensioni di memoria
- Calcoli offset o distanze tra puntatori

### Usa f64 quando:
- Hai bisogno di numeri in virgola mobile
- La precisione è importante
- Non hai vincoli di memoria stretti

### Usa &str quando:
- Hai stringhe immutabili
- Passi stringhe a funzioni (senza ownership)
- Lavori con letterali stringa

### Usa slice (&[T]) quando:
- Passi sequenze a funzioni
- Non hai bisogno di modificare la dimensione
- Vuoi massima flessibilità (array, Vec, slice)

### Usa reference (&T, &mut T) quando:
- Vuoi accesso temporaneo senza ownership
- Rispetti le regole del borrow checker
- Non hai bisogno di unsafe

## Vedi Anche

- [Vec<T>](collections/vec.md) - Array dinamico
- [String](https://doc.rust-lang.org/std/string/struct.String.html) - Stringa heap-allocated
- [Option e Result](option-result.md) - Gestione valori opzionali ed errori
- [Collections](collections/index.md) - Altre strutture dati
- [References and Borrowing](https://doc.rust-lang.org/book/ch04-02-references-and-borrowing.html) - Approfondimento sul borrowing

---

!!! question "Hai trovato errori o imprecisioni?"
    Aiutaci a migliorare questa traduzione! [Apri una issue](https://github.com/rust-ita/rust-docs-it/issues) o proponi una modifica.
