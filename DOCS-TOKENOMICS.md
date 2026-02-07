# 📊 Modello Economico e Tokenomics: Wine-Future RWA

## 1. Valutazione dell'Asset e Logica di Minting
La tokenizzazione del **Montepulciano d'Abruzzo 2025** segue un modello di "Valutazione Prudenziale" per proteggere gli investitori dalla volatilità del mercato durante il periodo di affinamento.

- **Valutazione Iniziale:** Il prezzo di emissione (minting) è fissato al **70% del Valore Futuro Stimato (EFV)** post-imbottigliamento. Questo "buffer" del 30% funge da margine di sicurezza contro le fluttuazioni del mercato.
- **Unità di Conto:** 1 Token = 1 Litro di vino in botte.
- **Offerta (Supply):** Capata alla produzione fisica reale (es. 5.000 litri), verificata tramite certificazione DOCG.

## 2. Liquidità e Mercato Secondario
Per evitare la "Trappola dell'Illiquidità" tipica degli investimenti in vino fisico:
- **Integrazione DEX:** I token possono essere scambiati su Exchange Decentralizzati (come Uniswap) in coppia con USDC/EURC.
- **Programma di Buyback:** La cantina si riserva il diritto di riacquistare i token al prezzo di mercato prima dell'imbottigliamento per gestire il proprio inventario.

## 3. Gestione del Rischio e AI Circuit Breaker (Interruttore di Emergenza)
Questo protocollo introduce un **"Meccanismo di Stabilità Algoritmica"**:
- **Monitoraggio:** L'Agente AI monitora costantemente le condizioni di invecchiamento (Temperatura/Umidità).
- **Esecuzione:** Se viene rilevata un'anomalia critica, l'Agente AI chiama la funzione `reportIssue`, che:
  1. Congela la funzione di riscatto ("Redeem").
  2. Segnala l'anomalia al mercato secondario, impedendo la vendita di asset danneggiati a acquirenti ignari.

## 4. Legal Wrapping (Il Livello di Fiducia Legale)
I token non sono semplici "punti digitali", ma rappresentazioni digitali di un **diritto legale**.
- **Collateralizzazione:** Le botti fisiche sono legalmente costituite in pegno come garanzia per i detentori dei token.
- **Assicurazione:** Una polizza assicurativa contro i rischi biologici è collegata allo Smart Contract; in caso di perdita totale (es. incendio o deterioramento), l'indennizzo assicurativo viene distribuito proporzionalmente ai detentori dei token.
