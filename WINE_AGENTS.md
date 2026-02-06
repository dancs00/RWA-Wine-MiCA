# 🤖 Implementazione Agente AI: Monitoraggio Qualità e Compliance Vinicola

## Panoramica
Questo agente funge da ponte autonomo tra il processo fisico di affinamento in Abruzzo e lo Smart Contract On-chain.

### 🛡️ Ruolo: Revisore Autonomo della Qualità
- **Monitoraggio:** L'agente acquisisce dati in tempo reale dai sensori IoT posizionati nelle botti di rovere sloveno.
- **Parametri:** Le soglie critiche sono impostate a 14°C-18°C per la temperatura e 70%-80% per l'umidità.
- **Azione:** Se la temperatura supera i 25°C per più di 48 ore (rischio di deterioramento), l'agente attiva la funzione `reportIssue` sullo Smart Contract.

### 📊 Ruolo: Specialista di Mercato e Regolamentazione
- **Conformità MiCA:** Verifica automaticamente che la documentazione 'legalHash' sia ancora valida e avvisa l'emittente 30 giorni prima della scadenza di qualsiasi polizza assicurativa.
- **Valutazione:** Analizza i dati delle aste di vini pregiati (es. Liv-ex) per fornire una stima del valore di mercato equo (Fair Market Value) dei Futures del Montepulciano 2025.

### ⚠️ Protocollo di Crisi
In caso di anomalia rilevata, l'agente:
1. Chiama la funzione `reportIssue(id, true, "Stress termico rilevato")`.
2. Questo sospende immediatamente la funzione `redeemWine` (riscatto fisico), proteggendo la reputazione della DOCG e i diritti legali dell'investitore.
