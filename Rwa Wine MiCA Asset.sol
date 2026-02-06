// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Importiamo le librerie standard di sicurezza
import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract WineRWA_MiCA is ERC1155, Ownable {
    using Strings for uint256;

    // Definiamo l'ID univoco per l'annata 2025
    uint256 public constant MONTEPULCIANO_2025 = 1;

    // Struttura dati per la trasparenza MiCA
    struct WineBatch {
        string appellation;      // Es: "Montepulciano d'Abruzzo DOCG"
        uint256 totalLitres;     // Quantità fisica in botte
        uint256 maturityDate;    // Timestamp di quando sarà imbottigliato
        string legalHash;        // Link al documento legale di vincolo (IPFS)
        bool isSpoiled;          // Stato di salute dell'asset (da IoT/Audit)
    }

    mapping(uint256 => WineBatch) public batches;
    mapping(address => bool) public isWhitelisted;

    // Eventi per la trasparenza on-chain
    event BatchCreated(uint256 indexed id, string name, uint256 litres);
    event AssetAlert(uint256 indexed id, string message);

    constructor() 
        ERC1155("https://api.winerwa.io/metadata/") 
        Ownable(msg.sender) 
{}

    // 1. Inizializzazione legale del lotto (MiCA Art. 36 - Trasparenza)
    function initializeBatch(
        uint256 _id,
        string memory _appellation,
        uint256 _litres,
        uint256 _yearsToMaturity,
        string memory _legalHash
    ) external onlyOwner {
        uint256 releaseDate = block.timestamp + (_yearsToMaturity * 365 days);
        
        batches[_id] = WineBatch({
            appellation: _appellation,
            totalLitres: _litres,
            maturityDate: releaseDate,
            legalHash: _legalHash,
            isSpoiled: false
        });

        emit BatchCreated(_id, _appellation, _litres);
    }

    // 2. Minting condizionato (Liquidità per l'azienda)
    // L'azienda crea i token che rappresentano i litri in affinamento
    function mintFutures(uint256 _id, uint256 _amount) external onlyOwner {
        require(bytes(batches[_id].appellation).length > 0, "Lotto non inizializzato");
        require(_amount <= batches[_id].totalLitres, "Emissione superiore alla riserva fisica");
        
        _mint(msg.sender, _id, _amount, "");
    }

    // 3. Sistema di Whitelist (Compliance KYC/AML)
    function updateWhitelist(address _investor, bool _status) external onlyOwner {
        isWhitelisted[_investor] = _status;
    }

    // 4. Override del trasferimento: Solo tra portafogli verificati
    function safeTransferFrom(
        address from, 
        address to, 
        uint256 id, 
        uint256 amount, 
        bytes memory data
    ) public override {
        require(isWhitelisted[to], "Destinatario non autorizzato (No KYC)");
        super.safeTransferFrom(from, to, id, amount, data);
    }

    // 5. Segnalazione Criticità (AI Agent / IoT Integration)
    // Se l'AI rileva parametri fuori norma (es. Temp > 25°C), declassa il lotto
    function reportIssue(uint256 _id, bool _isSpoiled, string memory _reason) external onlyOwner {
        batches[_id].isSpoiled = _isSpoiled;
        emit AssetAlert(_id, _reason);
    }

    // 6. Riscatto Fisico (MiCA Compliance - Art. 39: Diritto di Riscatto)
    // L'investitore brucia i token e ottiene il certificato di ritiro bottiglie
    function redeemWine(uint256 _id, uint256 _amount) external {
        WineBatch memory batch = batches[_id];
        
        // Controllo 1: Il vino deve essere pronto (data di maturazione passata)
        require(block.timestamp >= batch.maturityDate, "Il vino e ancora in affinamento");
        
        // Controllo 2: L'asset deve essere integro (nessuno spoilage segnalato)
        require(!batch.isSpoiled, "Asset declassato: Riscatto fisico sospeso per verifiche tecniche");
        
        // Controllo 3: L'utente deve avere i token
        require(balanceOf(msg.sender, _id) >= _amount, "Bilancio insufficiente");

        // Esecuzione: Bruciamo i token (Burn)
        _burn(msg.sender, _id, _amount);
        
        // Qui verrebbe integrato un evento per la logistica di spedizione
    }

    // 7. Funzione di supporto per visualizzare i metadati MiCA
    function getBatchDetails(uint256 _id) external view returns (WineBatch memory) {
        return batches[_id];
    }
}
