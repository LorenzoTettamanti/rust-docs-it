# 🦀 Rust Docs Italia

[![Build Status](https://github.com/rust-ita/rust-docs-it/workflows/ci/badge.svg)](https://github.com/rust-ita/rust-docs-it/actions)
[![License: MIT/Apache-2.0](https://img.shields.io/badge/license-MIT%2FApache--2.0-blue.svg)](LICENSE)

Traduzione italiana della documentazione ufficiale di Rust..

📖 **[Leggi la documentazione](https://rust-ita.github.io/)** (quando pubblicata)

---

## 🎯 Obiettivi

Questo progetto si propone di tradurre in italiano la documentazione ufficiale di Rust per:

- Abbassare la barriera d'ingresso per sviluppatori italiani
- Creare una risorsa di riferimento in italiano per la community
- Facilitare l'apprendimento di Rust nelle scuole e università italiane
- Contribuire alla crescita dell'ecosistema Rust in Italia

## 📚 Cosa stiamo traducendo

### Priorità alta

- [x] Setup iniziale del progetto
- [ ] **The Rust Standard Library**
  - [ ] Tipi primitivi
  - [ ] Collections (Vec, HashMap, HashSet)
  - [ ] String e &str
  - [ ] Option e Result
  - [ ] Iterators
  - [ ] I/O e File System
- [ ] **The Rust Programming Language Book**
  - [ ] Capitoli introduttivi (1-5)
  - [ ] Ownership e borrowing (4)
  - [ ] Structs, enums e pattern matching (5-6)

### Roadmap futura

- Rust by Example
- The Cargo Book
- Async Book
- Rustonomicon (documentazione unsafe)

## 🚀 Quick Start

### Per lettori

Visita [rust-ita.github.io](https://rust-ita.github.io/) per leggere la documentazione tradotta.

### Per contributori

Vuoi aiutarci a tradurre? Fantastico! 🎉

```bash
# 1. Fai il fork del repository

# 2. Clona il tuo fork
git clone https://github.com/TUO-USERNAME/rust-docs-it.git
cd rust-docs-it

# 3. Setup ambiente
python -m venv venv
source venv/bin/activate  # Windows: venv\Scripts\activate
pip install -r requirements.txt

# 4. Avvia il server di sviluppo
mkdocs serve

# 5. Apri http://127.0.0.1:8000
```

Leggi la [**Guida al Contributo**](docs/CONTRIBUTING.md) per tutti i dettagli! 📖

## 🤝 Come contribuire

Ci sono molti modi per contribuire:

### 1. 📝 Traduzione

- Controlla le [issue aperte](https://github.com/rust-ita/rust-docs-it/issues?q=is%3Aissue+is%3Aopen+label%3Atraduzione)
- Scegli una sezione non assegnata
- Segui le [linee guida](docs/CONTRIBUTING.md)

### 2. 🔍 Revisione

- Aiuta a revisionare le [Pull Request aperte](https://github.com/rust-ita/rust-docs-it/pulls)
- Controlla accuratezza e qualità delle traduzioni
- Suggerisci miglioramenti

### 3. 📖 Glossario

- Proponi traduzioni per termini tecnici
- Discuti scelte terminologiche
- Mantieni la coerenza

### 4. 🐛 Segnalazioni

- Hai trovato un errore? [Apri una issue](https://github.com/rust-ita/rust-docs-it/issues/new)
- Suggerisci miglioramenti alla struttura
- Proponi nuove sezioni da tradurre

## 📋 Stato della traduzione

| Sezione | Stato | Assegnatario |
|---------|-------|--------------|
| Standard Library - Primitives | 📝 In corso | @username |
| Standard Library - Vec | 📅 Pianificato | - |
| Standard Library - HashMap | 📅 Pianificato | - |
| Standard Library - String | 📅 Pianificato | - |
| Standard Library - Option/Result | 📅 Pianificato | - |
| Book - Ch 1: Getting Started | 📅 Pianificato | - |
| Book - Ch 2: Guessing Game | 📅 Pianificato | - |
| Book - Ch 3: Common Concepts | 📅 Pianificato | - |
| Book - Ch 4: Ownership | 📅 Pianificato | - |

Legenda: ✅ Completato | 📝 In corso | 👀 In revisione | 📅 Pianificato

## 🛠️ Tecnologie utilizzate

- [MkDocs](https://www.mkdocs.org/) - Generatore di siti statici
- [Material for MkDocs](https://squidfunk.github.io/mkdocs-material/) - Tema moderno e responsive
- [GitHub Pages](https://pages.github.com/) - Hosting della documentazione
- [GitHub Actions](https://github.com/features/actions) - CI/CD per build e deploy automatici

## 📜 Linee guida principali

### Stile

- Usa il **tu** diretto e tono amichevole
- Mantieni precisione tecnica
- Segui il [Glossario terminologico](docs/GLOSSARY.md)

### Cosa tradurre

- ✅ Testo esplicativo
- ✅ Titoli e intestazioni
- ✅ Messaggi nella documentazione

### Cosa NON tradurre

- ❌ Codice Rust (keyword, identificatori)
- ❌ Commenti negli esempi di codice
- ❌ Nomi di tipi standard (String, Vec, Option, ...)
- ❌ Termini tecnici consolidati (vedi glossario)

## 👥 Team

### Maintainers

- [@tuo-username](https://github.com/tuo-username)
- [@LorenzoTettamanti](https://github.com/LorenzoTettamanti)

### Contributors

Un ringraziamento speciale a tutti i [contributori](https://github.com/rust-ita/rust-docs-it/graphs/contributors)! 🙏

## 📄 Licenza

Questo progetto mantiene la stessa licenza della documentazione originale di Rust:

- MIT License
- Apache License 2.0

Vedi i file [LICENSE-MIT](LICENSE-MIT) e [LICENSE-APACHE](LICENSE-APACHE) per i dettagli.

La documentazione originale è © The Rust Project Developers.

## 🔗 Link utili

- [Documentazione Rust originale](https://doc.rust-lang.org/)
- [The Rust Programming Language](https://doc.rust-lang.org/book/)
- [Rust Standard Library](https://doc.rust-lang.org/std/)
- [Rust Italia Community](https://github.com/rust-ita)
- [Rust Official Website](https://www.rust-lang.org/)

## ❓ FAQ

### Perché tradurre la documentazione?

Anche se l'inglese è importante nel mondo dello sviluppo, una documentazione nella propria lingua madre può:
- Accelerare l'apprendimento
- Ridurre il carico cognitivo
- Rendere Rust più accessibile a un pubblico più ampio

### Gli esempi di codice saranno tradotti?

No, gli esempi di codice rimarranno in inglese per:
- Mantenere coerenza con la community internazionale
- Evitare confusione con keyword e sintassi
- Facilitare la ricerca di errori online

### Come viene garantita la qualità?

- Ogni traduzione passa attraverso una review
- Usiamo un glossario condiviso per la terminologia
- Confrontiamo con altre traduzioni ufficiali (es. giapponese, francese)
- La community può sempre segnalare errori

### Posso usare questa documentazione per scopi commerciali?

Sì, la licenza MIT/Apache-2.0 permette uso commerciale. Vedi i file di licenza per i dettagli.

---

<div align="center">

**Fatto con ❤️ dalla community Rust italiana**

[Sito](https://rust-ita.github.io/) • [GitHub](https://github.com/rust-ita) • [Contribuisci](docs/CONTRIBUTING.md)

</div>