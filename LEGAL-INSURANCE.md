# ⚖️ Quadro Legale e Protezione Assicurativa

## 1. Natura Giuridica del Token
Il token emesso dal protocollo **Wine-Future RWA** rappresenta un "Titolo di Credito Digitale" garantito da un asset fisico (Montepulciano d'Abruzzo DOCG 2025). Il possesso del token conferisce il diritto di proprietà pro-quota sul lotto vincolato.

## 2. Segregazione del Collaterale (Legal Wrapping)
Le botti oggetto di tokenizzazione sono soggette a un **vincolo di destinazione**. In caso di insolvenza della cantina, gli asset fisici sono segregati dal patrimonio generale dell'azienda e destinati prioritariamente al soddisfacimento dei detentori dei token.

## 3. Copertura Assicurativa (Bio-Risk Policy)
Ogni lotto è coperto da una polizza assicurativa "All-Risks" che include:
- **Danni Diretti:** Incendio, furto, rottura delle botti.
- **Danni Biologici:** Alterazione del vino (spoilage) dovuta a guasti degli impianti di climatizzazione.

## 4. Gestione del Claim On-Chain
In caso di evento avverso:
1. L'**AI Agent** o un perito indipendente certificano il danno on-chain (`reportIssue`).
2. L'indennizzo liquidato dall'assicurazione viene versato nello Smart Contract.
3. Gli investitori effettuano il "Burn" del token danneggiato in cambio della loro quota di rimborso in valuta stabile (Stablecoin).
