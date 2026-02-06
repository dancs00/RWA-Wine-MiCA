# RWA-Wine-MiCA

# 🍷 Wine-Future RWA: Tokenizzazione del Montepulciano d'Abruzzo DOCG 2025

## 📌 Visione del Progetto
Il settore vitivinicolo di alta gamma, in particolare per denominazioni come il **Montepulciano d'Abruzzo DOCG**, affronta una sfida finanziaria strutturale: il "gap di liquidità". Il vino prodotto richiede anni di affinamento obbligatorio prima di poter essere venduto, immobilizzando capitale operativo per le cantine.

**Wine-Future RWA** trasforma l'inventario in affinamento in un asset digitale liquido. Attraverso lo standard **ERC-1155**, le aziende vinicole possono emettere "Futures" digitali conformi alla normativa **MiCA**, ottenendo finanziamenti immediati mentre il prodotto matura in botte.

## ⚖️ Framework di Compliance (MiCA-Ready)
Il progetto è progettato come un **Asset-Referenced Token (ART)**, seguendo le linee guida del regolamento MiCA:
- **Proof of Custody:** Ogni token è collegato legalmente a una specifica partita di vino vincolata presso la cantina (Vault).
- **Trasparenza delle Riserve:** Audit trimestrali condotti da agronomi indipendenti vengono registrati on-chain via IPFS.
- **Redemption Logic:** Il riscatto fisico è protetto da una "Maturity Date" per garantire che l'asset sia prelevabile solo a qualità certificata raggiunta.

## 🛠️ Architettura Tecnica
- **Smart Contract:** Implementazione ERC-1155 per la gestione multi-batch (diverse annate o vigneti in un unico contratto).
- **Standard di Sicurezza:** OpenZeppelin per Access Control e protezione dai rientri.
- **Oracle Integration:** Predisposizione per sensori IoT (Temperatura/Umidità) per il monitoraggio dell'affinamento.
- **AI Agent Monitoring:** Un agente autonomo supervisiona i metadati legali e segnala anomalie nel processo di invecchiamento.

## 📂 Struttura del Repository
- `/contracts`: Codice Solidity del protocollo di tokenizzazione.
- `/compliance`: Prospetto informativo (Whitepaper) e schema dei metadati MiCA.
- `/metadata`: Esempi di file JSON per l'annata 2025.
