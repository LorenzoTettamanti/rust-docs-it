# Guida al Contributo

Grazie per il tuo interesse nel contribuire alla traduzione italiana della documentazione di Rust! 🦀

## Indice

1. [Come iniziare](#come-iniziare)
2. [Processo di traduzione](#processo-di-traduzione)
3. [Linee guida stilistiche](#linee-guida-stilistiche)
4. [Workflow Git](#workflow-git)
5. [Revisione delle traduzioni](#revisione-delle-traduzioni)

---

## Come iniziare

### Prerequisiti

- Conoscenza di Rust (almeno livello intermedio)
- Buona padronanza dell'italiano scritto
- Familiarità con Git e GitHub
- (Opzionale) Esperienza con MkDocs

### Setup locale

```bash
# Clona il repository
git clone https://github.com/rust-ita/rust-docs-it.git
cd rust-docs-it

# Crea un ambiente virtuale Python
python -m venv venv
source venv/bin/activate  # Su Windows: venv\Scripts\activate

# Installa le dipendenze
pip install -r requirements.txt

# Avvia il server locale
mkdocs serve
```

Ora puoi visitare `http://127.0.0.1:8000` per vedere la documentazione in locale.

---

## Processo di traduzione

### 1. Scegli una sezione da tradurre

- Controlla le [issue aperte](https://github.com/rust-ita/rust-docs-it/issues) con label `traduzione`
- Cerca sezioni non ancora assegnate
- Commenta l'issue per farti assegnare la sezione

### 2. Crea una issue (se non esiste)

Se vuoi tradurre una sezione non ancora tracciata:

```markdown
**Titolo**: Traduzione: [Nome sezione]

**Descrizione**:
- Link alla documentazione originale: [URL]
- Stima pagine/parole: ~X pagine
- Priorità: Alta/Media/Bassa

Mi piacerebbe occuparmi di questa traduzione.
```

### 3. Traduci la sezione

- Usa il [TEMPLATE.md](TEMPLATE.md) come base
- Consulta il [GLOSSARY.md](GLOSSARY.md) per la terminologia
- Mantieni la struttura della documentazione originale
- Gli esempi di codice restano in inglese

### 4. Verifica la traduzione

Prima di aprire una PR, controlla:

- [ ] Terminologia coerente con il glossario
- [ ] Link funzionanti
- [ ] Formattazione markdown corretta
- [ ] Codice di esempio testato (se modificato)
- [ ] Nessun errore di battitura
- [ ] Preview locale con `mkdocs serve`

---

## Linee guida stilistiche

### Tono e registro

- **Registro informale-professionale**: usa il "tu" diretto
- **Tono amichevole ma tecnico**: la documentazione deve essere accessibile ma precisa
- **Esempi**: "Puoi usare..." invece di "Si può usare..."

### Formattazione

#### Enfasi

```markdown
- **Grassetto** per termini tecnici importanti alla prima occorrenza
- *Corsivo* per enfasi leggera
- `Codice inline` per keyword, tipi, nomi di funzioni
```

#### Blocchi di codice

```markdown
\`\`\`rust
// Commenti in inglese per coerenza
fn example() {
    println!("Codice in inglese");
}
\`\`\`
```

#### Note e avvisi

Usa gli admonition di MkDocs:

```markdown
!!! note "Nota"
    Informazioni aggiuntive

!!! tip "Suggerimento"
    Consigli pratici

!!! warning "Attenzione"
    Avvertimenti importanti

!!! danger "Pericolo"
    Operazioni rischiose (unsafe, comportamenti indefiniti)

!!! info "Info"
    Riferimenti e link utili
```

### Traduzione vs Adattamento

#### Cosa tradurre

- Testo esplicativo
- Intestazioni e titoli
- Commenti nella documentazione
- Messaggi d'errore (nei testi esplicativi)

#### Cosa NON tradurre

- Codice Rust (keyword, identificatori, commenti negli esempi)
- Nomi di tipi standard (`String`, `Vec`, `Option`, etc.)
- Nomi di trait (`Debug`, `Clone`, `Iterator`, etc.)
- URL e link
- Termini tecnici consolidati (vedi glossario)

### Esempi pratici

**❌ Non fare così:**

```markdown
Il Vec è una collezione dinamica.
```

**✅ Fai così:**

```markdown
Il **Vec** è una collezione dinamica che può crescere o ridursi durante l'esecuzione.
```

---

**❌ Non fare così:**

```markdown
Quando fai il borrow di una variabile...
```

**✅ Fai così:**

```markdown
Quando prendi in prestito (borrow) una variabile...
```

---

## Workflow Git

### Branching strategy

```bash
# Crea un branch per la tua traduzione
git checkout -b traduzione/std-vec

# Naming convention:
# - traduzione/[sezione]  → per nuove traduzioni
# - fix/[sezione]         → per correzioni
# - aggiornamento/[sezione] → per aggiornamenti
```

### Commit messages

Usa commit messages chiari in italiano:

```bash
# ✅ Buoni esempi
git commit -m "Traduce sezione Vec della standard library"
git commit -m "Corregge terminologia in Option e Result"
git commit -m "Aggiorna esempi nella sezione borrowing"

# ❌ Esempi da evitare
git commit -m "fix"
git commit -m "update"
git commit -m "wip"
```

### Pull Request

#### Template PR

```markdown
## Descrizione

Traduzione della sezione [nome] della documentazione Rust.

## Checklist

- [ ] Ho consultato il glossario per la terminologia
- [ ] Ho testato la build locale con `mkdocs serve`
- [ ] Ho verificato tutti i link
- [ ] Ho seguito le linee guida stilistiche
- [ ] Gli esempi di codice sono in inglese
- [ ] Ho aggiunto il link alla documentazione originale

## Link

- Documentazione originale: [URL]
- Issue correlata: #[numero]

## Note

[Eventuali note per i revisori]
```

---

## Revisione delle traduzioni

### Per i revisori

Quando revisioni una PR, controlla:

1. **Accuratezza tecnica**
   - La traduzione è fedele all'originale?
   - I concetti tecnici sono corretti?

2. **Terminologia**
   - Segue il glossario?
   - È coerente con altre traduzioni?

3. **Leggibilità**
   - Il testo è fluido in italiano?
   - È comprensibile per il pubblico target?

4. **Formattazione**
   - Markdown corretto?
   - Link funzionanti?
   - Preview senza errori?

### Come lasciare feedback

- Sii costruttivo e rispettoso
- Suggerisci alternative concrete
- Spiega il motivo delle tue osservazioni
- Approva quando soddisfatto

```markdown
# ✅ Feedback costruttivo
"Qui suggerirei 'prendere in prestito' invece di 'borroware'
per essere più coerenti con il glossario. Vedi GLOSSARY.md."

# ❌ Feedback poco utile
"Questo non va bene."
```

---

## Priorità di traduzione

Stiamo dando priorità alle sezioni più utilizzate:

### Alta priorità 🔴

- [ ] Standard Library - Tipi primitivi
- [ ] Standard Library - String e &str
- [ ] Standard Library - Vec
- [ ] Standard Library - Option e Result
- [ ] Standard Library - HashMap
- [ ] The Rust Book - Capitoli 1-10

### Media priorità 🟡

- [ ] Standard Library - Iterator
- [ ] Standard Library - Collections avanzate
- [ ] The Rust Book - Capitoli 11-20
- [ ] Error handling patterns

### Bassa priorità 🟢

- [ ] Sezioni avanzate e specialistiche
- [ ] Unsafe Rust
- [ ] Macro avanzate

---

## Domande frequenti

### Posso tradurre più sezioni contemporaneamente?

È meglio concentrarsi su una sezione alla volta per mantenere alta la qualità e velocizzare le review.

### Quanto tempo dovrebbe richiedere una traduzione?

Dipende dalla lunghezza, ma in media:

- Pagina piccola: 1-2 ore
- Pagina media: 3-5 ore
- Pagina grande: 1-2 giorni

### Cosa faccio se non sono sicuro di una traduzione?

1. Consulta il glossario
2. Cerca nella documentazione già tradotta
3. Chiedi nel canale Discord/Telegram della community
4. Apri una discussion su GitHub

### Posso proporre modifiche al glossario?

Assolutamente sì! Apri una issue con label `glossario` e discutiamone insieme.

---

## Risorse utili

- 📖 [Documentazione Rust originale](https://doc.rust-lang.org/)
- 📝 [Glossario termini](GLOSSARY.md)
- 🎨 [Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)
- 🦀 [Rust Italia Community](https://github.com/rust-ita)

---

## Contatti

- **GitHub Issues**: per domande specifiche sul progetto
- **Discussioni**: per proposte e discussioni generali

Grazie per il tuo contributo! 🚀
