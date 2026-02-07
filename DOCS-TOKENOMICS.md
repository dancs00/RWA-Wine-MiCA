# Tokenomics — Wine-Future RWA (Montepulciano d'Abruzzo DOCG 2025)

## 1. Panoramica del Token

| Parametro | Valore |
|-----------|--------|
| **Nome** | Wine-Future Montepulciano 2025 |
| **Standard** | ERC-1155 (Multi-Token) |
| **Token ID** | `MONTEPULCIANO_2025 = 1` |
| **Blockchain** | Ethereum (Sepolia Testnet / Mainnet) |
| **Classificazione MiCA** | Asset-Referenced Token (ART) |
| **Sottostante fisico** | Montepulciano d'Abruzzo DOCG in affinamento |
| **Unità di misura** | 1 Token = 1 Litro di vino in botte |
| **Divisibilità** | Intera (non frazionabile) |

## 2. Modello di Supply

### 2.1 Supply vincolata all'asset fisico

La supply totale dei token è **rigidamente ancorata** alla quantità di vino fisicamente presente e certificato nelle cantine (Vault). Non è possibile emettere token senza una corrispondente riserva fisica.

```
Supply Massima = Litri totali certificati in custodia
```

**Esempio pratico:**
- Lotto registrato: 10.000 litri di Montepulciano DOCG 2025
- Token emettibili: massimo 10.000 token
- Ogni token è riscattabile per 1 litro di vino a maturità raggiunta

### 2.2 Meccanismo di emissione

L'emissione avviene in due fasi distinte:

1. **Inizializzazione del lotto** (`initializeBatch`): la cantina registra on-chain la quantità fisica, la denominazione, la data di maturità e il riferimento IPFS ai documenti legali di custodia.
2. **Minting dei token** (`mintFutures`): la cantina crea i token fino al limite dei litri registrati. Il contratto impedisce emissioni superiori alla riserva fisica (`_amount <= totalLitres`).

### 2.3 Supply deflazionaria

La supply è **strutturalmente deflazionaria**:
- Il **riscatto fisico** (`redeemWine`) brucia permanentemente i token.
- Non esiste un meccanismo di re-minting per token già riscattati.
- Eventuali lotti dichiarati compromessi (`isSpoiled = true`) rendono i token associati non riscattabili, riducendo di fatto la supply attiva.

## 3. Ciclo di Vita del Token

```
┌──────────────────────────────────────────────────────────────────┐
│                    CICLO DI VITA DEL TOKEN                       │
├──────────────────────────────────────────────────────────────────┤
│                                                                  │
│  FASE 1: EMISSIONE                                               │
│  ┌─────────────┐    ┌──────────────┐    ┌───────────────┐       │
│  │ Cantina      │───▶│ initializeBatch│───▶│ mintFutures   │     │
│  │ registra     │    │ (on-chain)    │    │ (token creati)│      │
│  │ lotto fisico │    └──────────────┘    └───────────────┘       │
│  └─────────────┘                                                 │
│        │                                                         │
│        ▼                                                         │
│  FASE 2: CIRCOLAZIONE (durata: 4-5 anni)                        │
│  ┌─────────────┐    ┌──────────────┐    ┌───────────────┐       │
│  │ Investitore  │───▶│ KYC/Whitelist │───▶│ Acquisto token│      │
│  │ verificato   │    │ (compliance)  │    │ (trasferimento│      │
│  └─────────────┘    └──────────────┘    │  P2P o OTC)   │       │
│        │                                 └───────────────┘       │
│        ▼                                                         │
│  FASE 3: MONITORAGGIO (continuo)                                 │
│  ┌─────────────┐    ┌──────────────┐                             │
│  │ Agente AI +  │───▶│ reportIssue   │                           │
│  │ Sensori IoT  │    │ (se anomalia) │                           │
│  └─────────────┘    └──────────────┘                             │
│        │                                                         │
│        ▼                                                         │
│  FASE 4: MATURITÀ E RISCATTO                                    │
│  ┌─────────────┐    ┌──────────────┐    ┌───────────────┐       │
│  │ Data maturità│───▶│ redeemWine    │───▶│ Token bruciato│      │
│  │ raggiunta    │    │ (burn + claim)│    │ Vino spedito  │      │
│  └─────────────┘    └──────────────┘    └───────────────┘       │
│                                                                  │
└──────────────────────────────────────────────────────────────────┘
```

## 4. Modello di Prezzo

### 4.1 Determinazione del prezzo iniziale

Il prezzo di emissione (floor price) è calcolato sulla base di:

```
Prezzo per Token = (Costo di produzione per litro + Margine cantina) + Premio di custodia
```

**Componenti:**

| Voce | Descrizione | Esempio (EUR) |
|------|-------------|---------------|
| Costo uva | Acquisto/produzione materia prima | 2,50 / litro |
| Vinificazione | Processo di trasformazione | 1,00 / litro |
| Affinamento | Botti di rovere, cantina, energia | 1,50 / litro |
| Assicurazione | Polizza sulla riserva fisica | 0,30 / litro |
| Compliance | Costi legali, audit, certificazioni | 0,20 / litro |
| Margine cantina | Profitto dell'emittente | 1,50 / litro |
| **Totale floor price** | | **7,00 / litro** |

> **Nota:** I valori sono indicativi e soggetti a variazione in base al produttore, all'annata e alle condizioni di mercato.

### 4.2 Dinamiche di prezzo sul mercato secondario

Dopo l'emissione, il prezzo sul mercato secondario è influenzato da:

- **Tempo rimanente alla maturità**: più si avvicina la data di imbottigliamento, più il token tende ad apprezzarsi (riduzione del rischio temporale).
- **Qualità dell'affinamento**: dati IoT positivi (temperatura e umidità in range) supportano il valore; segnalazioni di stress (`reportIssue`) lo deprimono.
- **Indici di mercato**: quotazioni Liv-ex per il Montepulciano DOCG e denominazioni comparabili.
- **Scarsità**: la supply deflazionaria (riscatti progressivi) aumenta la scarsità dei token rimanenti.
- **Rating annata**: valutazioni di critici e guide enologiche sulla vendemmia 2025.

### 4.3 Formula di Fair Market Value (FMV)

L'agente AI calcola periodicamente il FMV secondo la formula:

```
FMV = Prezzo base × (1 + Premio annata) × (1 - Sconto temporale) × Fattore qualità
```

Dove:
- **Premio annata** = differenziale % rispetto alla media storica (fonte: Liv-ex)
- **Sconto temporale** = f(mesi rimanenti alla maturità) — decresce linearmente verso zero
- **Fattore qualità** = 1.0 se parametri IoT in norma, <1.0 se anomalie registrate, 0 se `isSpoiled = true`

## 5. Struttura delle Fee

| Operazione | Fee | Destinatario | Note |
|------------|-----|-------------|------|
| Minting iniziale | 0% | — | Nessuna fee: la cantina emette i propri token |
| Trasferimento P2P | 1-2% | Cantina (treasury) | Da implementare nel contratto |
| Riscatto fisico | 0% | — | Il costo di spedizione è a carico dell'investitore |
| Gas fees | Variabile | Rete Ethereum | Pagata dall'esecutore della transazione |

> **Nota sulla fee di trasferimento:** Attualmente il contratto non prevede una fee sui trasferimenti. Si raccomanda l'implementazione di un meccanismo di royalty per sostenere i costi operativi della cantina nel periodo di affinamento.

## 6. Modello di Revenue per la Cantina

### 6.1 Flussi di ricavo

```
┌─────────────────────────────────────────────────┐
│          FLUSSI DI RICAVO DELLA CANTINA         │
├─────────────────────────────────────────────────┤
│                                                  │
│  1. VENDITA PRIMARIA                             │
│     └─ Ricavo immediato dalla vendita dei token  │
│        (liquidità anticipata di 4-5 anni)        │
│                                                  │
│  2. FEE MERCATO SECONDARIO (da implementare)     │
│     └─ Royalty 1-2% su ogni trasferimento P2P    │
│                                                  │
│  3. SERVIZI ACCESSORI                            │
│     └─ Visite in cantina per holder              │
│     └─ Degustazioni esclusive                    │
│     └─ Accesso prioritario a nuove annate        │
│                                                  │
│  4. PREMIUM DI MARCA                             │
│     └─ Incremento di valore del brand grazie     │
│        alla trasparenza on-chain e certificazioni│
│                                                  │
└─────────────────────────────────────────────────┘
```

### 6.2 Esempio numerico

| Voce | Calcolo | Valore (EUR) |
|------|---------|-------------|
| Lotto registrato | 10.000 litri | — |
| Prezzo emissione | 7,00 EUR/token | — |
| **Ricavo vendita primaria** | 10.000 × 7,00 | **70.000** |
| Fee secondario (stima annua) | 20% turnover × 1,5% fee | **~2.100/anno** |
| **Ricavo totale su 5 anni** | 70.000 + (2.100 × 5) | **~80.500** |

> Senza tokenizzazione, la cantina avrebbe incassato solo alla vendita delle bottiglie (anno 5), con un costo-opportunità significativo.

## 7. Distribuzione dei Token

### 7.1 Allocazione iniziale

| Allocazione | % Supply | Destinazione | Vesting |
|-------------|----------|-------------|---------|
| Vendita pubblica | 70% | Investitori verificati (KYC) | Nessuno (liquido) |
| Riserva cantina | 20% | Treasury aziendale | Lock-up fino a maturità |
| Partnership & Marketing | 5% | Collaborazioni strategiche | 12 mesi cliff |
| Team / Consulenti | 5% | Sviluppatori e advisor | 24 mesi vesting lineare |

### 7.2 Calendario di distribuzione

```
Mese 0      ──── Minting completo (100% supply creata)
Mese 0-3    ──── Vendita pubblica (70% distribuito a investitori)
Mese 12     ──── Sblocco allocazione Partnership (5%)
Mese 0-24   ──── Vesting lineare Team (5%)
Mese 0-60   ──── Lock-up riserva cantina (20%)
Mese ~60    ──── Maturità: inizio periodo di riscatto fisico
```

## 8. Meccanismo di Riscatto (Redemption)

### 8.1 Condizioni per il riscatto

Il riscatto fisico è soggetto a tre condizioni verificate on-chain:

1. **Maturità raggiunta**: `block.timestamp >= batch.maturityDate`
2. **Asset integro**: `batch.isSpoiled == false`
3. **Bilancio sufficiente**: `balanceOf(msg.sender, id) >= amount`

### 8.2 Processo di riscatto

```
Investitore chiama redeemWine(id, amount)
    │
    ├─ Verifica maturità ────────── FAIL → "Il vino è ancora in affinamento"
    ├─ Verifica qualità ─────────── FAIL → "Asset declassato: riscatto sospeso"
    ├─ Verifica bilancio ────────── FAIL → "Bilancio insufficiente"
    │
    └─ SUCCESS:
        ├─ Token bruciati (burn permanente)
        ├─ Evento emesso per il sistema logistico
        └─ Cantina prepara la spedizione delle bottiglie
```

### 8.3 Rapporto di conversione

```
1 Token riscattato = 1 Litro di Montepulciano d'Abruzzo DOCG imbottigliato
```

La conversione in bottiglie dipende dal formato:
- 1 token = ~1,33 bottiglie da 0,75L
- 1 token = 1 bottiglia da 1L
- 6 token = ~1 damigiana da 5L + 1 bottiglia da 0,75L

> Il formato di imbottigliamento viene concordato al momento del riscatto tramite il portale della cantina.

## 9. Governance e Ruoli

| Ruolo | Responsabilità | Controllo on-chain |
|-------|---------------|-------------------|
| **Owner (Cantina)** | Inizializzazione lotti, minting, gestione whitelist | Funzioni `onlyOwner` |
| **Agente AI** | Monitoraggio qualità, segnalazione anomalie | Chiamata a `reportIssue` (delegata dall'Owner) |
| **Investitore** | Acquisto, detenzione, trasferimento, riscatto | Interazione con `safeTransferFrom`, `redeemWine` |
| **Auditor esterno** | Verifica trimestrale delle riserve | Aggiornamento `legalHash` via IPFS |

> **Nota sulla decentralizzazione:** Nella fase iniziale (MVP), il contratto è centralizzato con un unico Owner. In fasi successive si prevede l'introduzione di un modello multi-sig o DAO per la governance, in conformità con i principi di decentralizzazione progressiva.

## 10. Gestione del Rischio

### 10.1 Rischi e mitigazioni

| Rischio | Probabilità | Impatto | Mitigazione |
|---------|-------------|---------|-------------|
| Deterioramento del vino | Bassa | Critico | Monitoraggio IoT continuo + Agente AI con `reportIssue` |
| Perdita fisica (incendio, furto) | Molto bassa | Critico | Polizza assicurativa obbligatoria (registrata in `legalHash`) |
| Volatilità del prezzo | Media | Moderato | Floor price ancorato ai costi di produzione |
| Rischio regolamentare | Media | Alto | Design MiCA-compliant, consulenza legale continua |
| Rischio smart contract | Bassa | Critico | Audit formale prima del mainnet, librerie OpenZeppelin |
| Illiquidità mercato secondario | Media | Moderato | Market making incentivato, community building |

### 10.2 Scenari di stress

**Scenario 1 — Spoilage del lotto:**
- L'agente AI rileva `Temp > 25°C per > 48h`
- Chiama `reportIssue(id, true, "Stress termico")`
- `isSpoiled = true` → riscatto fisico bloccato
- Conseguenza: i token perdono il valore di riscatto ma rimangono trasferibili
- Risoluzione: indagine, eventuale compensazione assicurativa, aggiornamento `legalHash`

**Scenario 2 — Riscatto massivo alla maturità:**
- Tutti gli holder riscattano contemporaneamente
- La cantina deve avere capacità logistica sufficiente
- Mitigazione: finestra di riscatto estesa (es. 6 mesi), prenotazione slot di spedizione

## 11. Roadmap Tokenomics

| Fase | Milestone | Stato |
|------|-----------|-------|
| **v1.0 — MVP** | Supply ancorata 1:1, whitelist KYC, riscatto base | Completato |
| **v1.1 — Fee** | Implementazione fee di trasferimento (royalty cantina) | Pianificato |
| **v1.2 — Multi-batch** | Supporto per annate multiple (2025, 2026, ...) | Pianificato |
| **v2.0 — Oracle** | Integrazione Chainlink per FMV automatizzato | Pianificato |
| **v2.1 — Governance** | Transizione a multi-sig / DAO | Pianificato |
| **v3.0 — Mainnet** | Deploy su Ethereum mainnet + audit formale | Pianificato |
| **v3.1 — Interoperabilità** | Bridge cross-chain (Polygon, Arbitrum) per fee ridotte | In valutazione |

## 12. Disclaimer

Questo documento ha finalità informative e non costituisce un'offerta di investimento, una sollecitazione o una consulenza finanziaria. I token Wine-Future RWA sono classificati come Asset-Referenced Token ai sensi del Regolamento MiCA (EU 2023/1114). L'acquisto e la detenzione di token comportano rischi, inclusa la possibile perdita totale del capitale investito. Si consiglia di consultare un consulente finanziario e legale prima di procedere all'acquisto.
