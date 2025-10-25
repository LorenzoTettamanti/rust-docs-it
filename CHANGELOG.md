# Changelog

Tutte le modifiche significative a questo progetto verranno documentate in questo file.

Il formato è basato su [Keep a Changelog](https://keepachangelog.com/it/1.0.0/),
e questo progetto aderisce al [Semantic Versioning](https://semver.org/lang/it/).

---

## [Unreleased]

### Da Fare
- Completare traduzione HashMap e HashSet
- Aggiungere sezione String
- Iniziare traduzione The Rust Book
- Aggiungere sezione I/O e File System

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

### v0.3.0 (Previsto: Novembre 2025)
- [ ] Standard Library - HashMap
- [ ] Standard Library - HashSet
- [ ] Standard Library - String e &str

### v0.4.0 (Previsto: Dicembre 2025)
- [ ] Standard Library - Option e Result
- [ ] Standard Library - I/O basics

### v0.5.0 (Previsto: Q1 2026)
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

- [@AndreaBozzo](https://github.com/AndreaBozzo) - Setup iniziale, Vec, Primitives
- [@LorenzoTettamanti](https://github.com/LorenzoTettamanti) - Maintainer

Grazie a tutti i [contributori](https://github.com/rust-ita/rust-docs-it/graphs/contributors)! 🎉

---

## Versioning

Questo progetto usa [Semantic Versioning](https://semver.org/):

- **MAJOR** (X.0.0): Cambiamenti incompatibili o ristrutturazioni importanti
- **MINOR** (0.X.0): Nuove sezioni/documenti tradotti
- **PATCH** (0.0.X): Correzioni, miglioramenti, fix

---

**Nota**: Questo progetto è in sviluppo attivo. Le versioni pre-1.0 potrebbero avere cambiamenti frequenti.

[Unreleased]: https://github.com/rust-ita/rust-docs-it/compare/v0.2.0...HEAD
[0.2.0]: https://github.com/rust-ita/rust-docs-it/compare/v0.1.0...v0.2.0
[0.1.0]: https://github.com/rust-ita/rust-docs-it/releases/tag/v0.1.0
