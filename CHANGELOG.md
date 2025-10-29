# Changelog

Tutte le modifiche significative a questo progetto verranno documentate in questo file.

Il formato è basato su [Keep a Changelog](https://keepachangelog.com/it/1.0.0/),
e questo progetto aderisce al [Semantic Versioning](https://semver.org/lang/it/).

---

## [Unreleased]

### Da Fare

- Aggiungere sezione String
- Iniziare traduzione The Rust Book
- Aggiungere sezione I/O e File System

---

## [0.3.0] - 2025-10-29

### Aggiunto

- **📚 Sezione HashMap\<K, V\> completa** (`docs/std/collections/hashmap.md`)
  - Panoramica e quando usare HashMap
  - Creazione (new, with_capacity, from array/iteratori)
  - Inserimento e aggiornamento (insert, try_insert, Entry API)
  - Lettura valori (get, get_mut, get_key_value, contains_key, indicizzazione)
  - Rimozione elementi (remove, remove_entry, retain, extract_if, clear, drain)
  - Iterazione (iter, iter_mut, keys, values, into_iter, into_keys, into_values)
  - Ownership e borrowing con HashMap
  - Gestione capacità (capacity, reserve, shrink_to_fit, try_reserve)
  - Performance e hashing (SipHash 1-3, requisiti Hash+Eq, hasher personalizzati)
  - Vincoli e limitazioni (const/static, LazyLock)
  - Tabelle comparative e esempi pratici (contatori, cache)
  - 866 righe di documentazione completa
- **📚 Sezione HashSet\<T\> completa** (`docs/std/collections/hashset.md`)
  - Panoramica e relazione con HashMap\<T, ()\>
  - Creazione e operazioni base (insert, remove, replace, take, clear)
  - Query (contains, get, len, is_empty)
  - Iterazione (iter, drain, retain, extract_if)
  - Operazioni su insiemi (union, intersection, difference, symmetric_difference)
  - Operatori bitwise (&, |, -, ^)
  - Relazioni tra insiemi (is_subset, is_superset, is_disjoint)
  - Ownership, capacità e performance
  - Esempi pratici (filtro duplicati, analisi parole comuni, validazione unicità)
  - 722 righe di documentazione completa
- **🔗 Cross-reference**: Aggiornati link tra HashMap, HashSet e Vec

### Modificato

- **📋 Collections Index** (`docs/std/collections/index.md`)
  - Spostati HashMap e HashSet da "Prossimamente" a "Tradotte"
  - Aggiunte descrizioni dettagliate per entrambe le collections
- **📖 README.md**
  - Aggiornata roadmap con completamento HashMap e HashSet
  - Aggiornata tabella stato traduzioni
- **📝 CONTRIBUTING.md**
  - Rimossi HashMap e HashSet dalle sezioni prioritarie da tradurre

### Migliorato

- **Coerenza terminologica**: Utilizzato GLOSSARY.md per terminologia Hash, Eq, Entry
- **Qualità esempi**: 10+ esempi pratici funzionanti in HashMap e HashSet
- **Performance documenti**: Tabelle comparative dettagliate con complessità O(...)
- **Collegamenti interni**: Sistema completo di cross-reference tra collections

---

## [0.2.0] - 2025-10-25

### Aggiunto

- **📚 Sezione Tipi Primitivi completa** (`docs/std/primitives.md`)
  - Documentazione completa dei 18 tipi primitivi di Rust
  - Tipi numerici (interi e floating-point)
  - Tipi testuali (char, str) e booleani
  - Tipi composti (array, slice, tuple, unit)
  - Puntatori e riferimenti (pointer, reference, fn)
  - Tabelle riepilogative
  - Best practices e esempi
- **📝 File DEPRECATIONS.md** per tracciare deprecazioni future
- **📋 File CHANGELOG.md** per tracciare modifiche al progetto
- Aggiornamento `.gitignore` con sezioni per MkDocs e sviluppo Python

### Modificato

- Aggiornato riferimenti versione Rust da 1.82+ a **1.90+** in tutti i documenti
  - `docs/std/primitives.md`
  - `docs/std/collections/vec.md`
  - `docs/index.md`

### Migliorato

- `.gitignore` ora include:
  - Directory `site/` di MkDocs
  - Cache e file temporanei di sviluppo
  - File IDE aggiuntivi (PyCharm, IntelliJ)
  - File OS Windows (Thumbs.db, Desktop.ini)

---

## [0.1.0] - 2025-10-22

### Aggiunto

- **📚 Sezione Vec\<T\> completa** (`docs/std/collections/vec.md`)
  - Panoramica e creazione di Vec
  - Operazioni base (push, pop, get)
  - Iterazione e ownership
  - Capacità e riallocazione
  - Manipolazione avanzata (insert, remove, swap_remove, retain, dedup)
  - Relazione Vec e Slice
  - Operazioni bulk (append, extend_from_slice, drain, split_off)
  - Gestione avanzata capacità
- **🏗️ Setup iniziale progetto**
  - Configurazione MkDocs con Material theme
  - Struttura directory `docs/`
  - File di licenza (MIT + Apache 2.0)
- **📖 Documentazione di supporto**
  - `README.md` - Introduzione e guida quick start
  - `docs/CONTRIBUTING.md` - Guida completa per contributori
  - `docs/GLOSSARY.md` - Glossario terminologico
  - `docs/TEMPLATE.md` - Template per nuove traduzioni
  - `docs/index.md` - Homepage documentazione
- **⚙️ Configurazione**
  - `mkdocs.yml` - Configurazione completa sito
  - `requirements.txt` - Dipendenze Python
  - `.gitignore` - File da ignorare in git
- **🤖 CI/CD**
  - `.github/workflows/ci.yml` - Build e deploy automatico
  - `.github/PULL_REQUEST_TEMPLATE.md` - Template per PR

### Struttura Iniziale

```
rust-docs-it/
├── docs/
│   ├── std/
│   │   ├── collections/
│   │   │   └── vec.md           ✅ Completato
│   │   └── primitives.md        ✅ Completato (v0.2.0)
│   ├── book/                    📅 Pianificato
│   ├── CONTRIBUTING.md          ✅ Creato
│   ├── GLOSSARY.md              ✅ Creato
│   ├── TEMPLATE.md              ✅ Creato
│   └── index.md                 ✅ Creato
├── .github/
│   └── workflows/
│       └── ci.yml               ✅ Configurato
├── mkdocs.yml                   ✅ Configurato
├── requirements.txt             ✅ Creato
├── README.md                    ✅ Creato
└── LICENSE-MIT, LICENSE-APACHE  ✅ Aggiunti
```

---

## Legenda

- ✅ **Completato** - Traduzione completa e revisionata
- 📝 **In corso** - Traduzione in progress
- 👀 **In revisione** - In attesa di review
- 📅 **Pianificato** - Nella roadmap futura
- 🐛 **Fix** - Correzione di bug o errori
- 🔧 **Miglioramento** - Miglioramento esistente
- ⚠️ **Deprecato** - Feature deprecata o rimossa

---

## Categorie di Cambiamenti

### Aggiunto

Nuove funzionalità, sezioni, documenti.

### Modificato

Modifiche a funzionalità esistenti che cambiano il comportamento.

### Deprecato

Funzionalità che verranno rimosse nelle prossime versioni.

### Rimosso

Funzionalità rimosse in questa versione.

### Corretto

Bug fix e correzioni.

### Sicurezza

Aggiornamenti di sicurezza.

### Migliorato

Miglioramenti che non cambiano funzionalità (performance, leggibilità, etc).

---

## Roadmap Futura

### v0.3.0 ✅ (Completato: Ottobre 2025)

- [x] Standard Library - HashMap
- [x] Standard Library - HashSet

### v0.4.0 (Previsto: Novembre 2025)

- [ ] Standard Library - String e &str

### v0.5.0 (Previsto: Dicembre 2025)

- [ ] Standard Library - Option e Result
- [ ] Standard Library - I/O basics

### v0.6.0 (Previsto: Q1 2026)

- [ ] The Rust Book - Capitolo 1: Getting Started
- [ ] The Rust Book - Capitolo 2: Guessing Game
- [ ] The Rust Book - Capitolo 3: Common Concepts

### v1.0.0 (Obiettivo: Q2 2026)

- [ ] Completamento sezioni prioritarie Standard Library
- [ ] Completamento primi 5 capitoli The Rust Book
- [ ] Sistema di ricerca ottimizzato
- [ ] Versioning automatico

---

## Contributi

Vedi [CONTRIBUTING.md](docs/CONTRIBUTING.md) per come contribuire a questo progetto.

### Contributori Principali

- [@AndreaBozzo](https://github.com/AndreaBozzo) - Setup iniziale, Vec, Primitives, HashMap, HashSet
- [@LorenzoTettamanti](https://github.com/LorenzoTettamanti) - Collections (Performance, Iterators, Entries API)

Grazie a tutti i [contributori](https://github.com/rust-ita/rust-docs-it/graphs/contributors)! 🎉

---

## Versioning

Questo progetto usa [Semantic Versioning](https://semver.org/):

- **MAJOR** (X.0.0): Cambiamenti incompatibili o ristrutturazioni importanti
- **MINOR** (0.X.0): Nuove sezioni/documenti tradotti
- **PATCH** (0.0.X): Correzioni, miglioramenti, fix

---

**Nota**: Questo progetto è in sviluppo attivo. Le versioni pre-1.0 potrebbero avere cambiamenti frequenti.

[Unreleased]: https://github.com/rust-ita/rust-docs-it/compare/v0.3.0...HEAD
[0.3.0]: https://github.com/rust-ita/rust-docs-it/compare/v0.2.0...v0.3.0
[0.2.0]: https://github.com/rust-ita/rust-docs-it/compare/v0.1.0...v0.2.0
[0.1.0]: https://github.com/rust-ita/rust-docs-it/releases/tag/v0.1.0
