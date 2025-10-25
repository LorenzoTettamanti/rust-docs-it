# Note su Deprecazioni e Cambiamenti

!!! warning "Documento per tracciamento deprecazioni"
    Questo documento tiene traccia delle deprecazioni e dei cambiamenti importanti nella documentazione Rust, per mantenere la traduzione italiana aggiornata.

## Informazioni sulla Versione

**Versione Rust corrente della traduzione**: 1.90+ (Ottobre 2025)

La documentazione viene aggiornata seguendo le release stabili di Rust, che seguono un ciclo di rilascio di 6 settimane.

---

## Come Viene Gestito l'Aggiornamento

### Processo di Aggiornamento

1. **Monitoraggio Release**: Seguiamo i [Rust Blog](https://blog.rust-lang.org/) per gli annunci di nuove versioni
2. **Verifica Cambiamenti**: Controlliamo il [RELEASES.md](https://github.com/rust-lang/rust/blob/master/RELEASES.md) ufficiale
3. **Identificazione Deprecazioni**: Cerchiamo feature deprecate o modificate
4. **Aggiornamento Traduzione**: Aggiorniamo la documentazione italiana di conseguenza

### Compatibilità

La nostra traduzione indica **"Versione Rust: X.YY+"** per indicare:
- La documentazione è accurata per la versione X.YY
- È compatibile con le versioni successive finché non ci sono breaking changes
- Potrebbe non coprire nuove feature aggiunte dopo X.YY

---

## Deprecazioni Note (da Verificare in Future Release)

### Tipi Primitivi

Nessuna deprecazione nota attualmente per i tipi primitivi fondamentali.

!!! info "Tipi Sperimentali"
    I seguenti tipi sono attualmente sperimentali e potrebbero subire modifiche:
    - `f16` - Floating-point a 16 bit (sperimentale)
    - `f128` - Floating-point a 128 bit (sperimentale)
    - `!` (never type) - Tipo "never" (sperimentale ma in stabilizzazione)

### Standard Library

!!! tip "Stabilità API"
    Rust ha un forte impegno verso la stabilità. Le deprecazioni nella standard library sono rare e ben documentate con:
    - Attributo `#[deprecated]` nel codice
    - Note nelle release notes
    - Periodo di transizione lungo (spesso multiple release)

---

## Cambiamenti Recenti per Versione

### Rust 1.90.0 (Ottobre 2025)

**Stato traduzione**: ✅ Allineato

- Nessun cambiamento breaking ai tipi primitivi
- Standard library stabile

### Rust 1.89.0 (Agosto 2025)

**Stato traduzione**: ✅ Allineato

- Miglioramenti alle prestazioni
- Nessuna deprecazione rilevante per la nostra documentazione

### Rust 1.88.0 (Giugno 2025)

**Stato traduzione**: ✅ Allineato

- Nessun cambiamento ai fondamentali

### Rust 1.87.0 (Maggio 2025)

**Celebrazione 10 anni di Rust 1.0!** 🎉

**Stato traduzione**: ✅ Allineato

---

## Feature Stabilizzate Recenti

Queste feature erano sperimentali e sono state stabilizzate. La documentazione è stata aggiornata:

### Nessuna Feature Recente da Documentare

Al momento della stesura (Ottobre 2025, Rust 1.90), non ci sono nuove feature stabilizzate da aggiungere alla documentazione base dei tipi primitivi.

---

## Prossimi Aggiornamenti da Monitorare

### Rust 1.91.0 (Previsto: Fine Ottobre 2025)

- 🔍 Da verificare quando rilasciato
- Link: [Release Notes](https://github.com/rust-lang/rust/blob/master/RELEASES.md)

### Rust 1.92.0 (Previsto: Dicembre 2025)

- 🔍 Da monitorare

### Rust Edition 2024

!!! note "Edition 2024"
    Rust Edition 2024 è stata rilasciata con Rust 1.85.0 (Febbraio 2025)

    Le Edition non sono breaking changes, ma raggruppamenti di piccoli miglioramenti opt-in.
    La nostra documentazione copre sia Edition 2021 che 2024.

---

## Risorse per Rimanere Aggiornati

### Fonti Ufficiali

- 📰 [Rust Blog](https://blog.rust-lang.org/) - Annunci release
- 📋 [Release Notes](https://github.com/rust-lang/rust/blob/master/RELEASES.md) - Cambiamenti dettagliati
- 📚 [This Week in Rust](https://this-week-in-rust.org/) - Newsletter settimanale
- 🐦 [Rust Twitter](https://twitter.com/rustlang) - Aggiornamenti veloci

### Strumenti

- [releases.rs](https://releases.rs/) - Timeline release Rust
- [endoflife.date/rust](https://endoflife.date/rust) - Ciclo di vita versioni
- [Rust Changelog](https://releases.rs/docs/) - Changelog aggregato

---

## Come Contribuire agli Aggiornamenti

Se noti che la documentazione italiana non è aggiornata con l'ultima versione Rust:

1. **Verifica la versione**: Controlla quale versione Rust copre la sezione
2. **Identifica il cambiamento**: Trova il cambiamento nelle release notes ufficiali
3. **Apri una Issue**: Segnala la necessità di aggiornamento su [GitHub](https://github.com/rust-ita/rust-docs-it/issues)
4. **Proponi una PR**: Se puoi, proponi direttamente l'aggiornamento

### Template Issue per Aggiornamento Versione

```markdown
# Aggiornamento necessario per Rust X.YY

**Sezione interessata**: [Nome sezione]
**Versione attuale documentazione**: X.XX
**Nuova versione Rust**: X.YY
**Release date**: [Data]

## Cambiamenti da integrare

- [ ] Cambiamento 1
- [ ] Cambiamento 2

## Link di riferimento

- Release notes: [link]
- Documentazione originale aggiornata: [link]
```

---

## Policy di Deprecazione

### Cosa Facciamo Quando Rust Depreca una Feature

1. **Aggiungiamo warning box** alla documentazione esistente:
   ```markdown
   !!! warning "Deprecato da Rust X.YY"
       Questa feature è deprecata. Usa [alternativa] invece.
       Sarà rimossa in Rust X.ZZ.
   ```

2. **Documentiamo l'alternativa** nella stessa pagina o in una nuova sezione

3. **Manteniamo la documentazione** della feature deprecata fino alla rimozione definitiva

4. **Aggiorniamo gli esempi** per usare l'approccio raccomandato

### Esempio di Gestione Deprecazione

Se in futuro Rust deprecasse, ad esempio, un metodo:

```markdown
### vecchio_metodo() (Deprecato)

!!! danger "Deprecato da Rust 1.95"
    Questo metodo è stato deprecato e sarà rimosso in Rust 2.0.

    **Alternativa**: Usa `nuovo_metodo()` invece.

    **Motivazione**: [Spiegazione del perché è stato deprecato]

**Esempio vecchio codice** (da non usare):
\`\`\`rust
// ⚠️ Deprecato!
let result = x.vecchio_metodo();
\`\`\`

**Esempio nuovo codice** (raccomandato):
\`\`\`rust
// ✅ Usa questo
let result = x.nuovo_metodo();
\`\`\`

[Link alla documentazione originale](https://doc.rust-lang.org/...)
```

---

## Vedi Anche

- [CHANGELOG.md](https://github.com/rust-ita/rust-docs-it/blob/main/CHANGELOG.md) - Storia delle modifiche alla traduzione
- [CONTRIBUTING.md](CONTRIBUTING.md) - Come contribuire
- [Rust Release Process](https://forge.rust-lang.org/release/process.html) - Processo di release ufficiale

---

**Ultimo aggiornamento**: Ottobre 2025
**Prossima revisione consigliata**: Novembre 2025 (post Rust 1.91.0)
