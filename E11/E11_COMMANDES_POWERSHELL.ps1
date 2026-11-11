# E11 — COMMANDES POWERSHELL DE REFERENCE — NE PAS EXECUTER CE FICHIER EN BLOC
# Source : TP01 p.10/19, Étape 11 ; commandes reprises par phase.
# Statut : PREP / DOCUMENTAIRE. Aucune commande n'a été exécutée ici.
# ATTENTION : redémarrages, adressage, promotion AD et DSRM ; effectuer phase par phase
# sous supervision, après sauvegardes et vérifications des prérequis E10.
# Le préfixe '# ' maintient TOUTES les lignes inertes par défaut.
# Ne retirer les commentaires d'une phase qu'au moment du déploiement autorisé.
# Ne pas stocker de mot de passe dans ce fichier ou dans Git.

# Phase P0 — Vérifications initiales (lecture seule ; à réaliser plus tard)
# Get-NetAdapter
# Get-NetIPConfiguration
# Get-NetIPAddress -AddressFamily IPv4
# Get-NetRoute -DestinationPrefix '0.0.0.0/0'
# Get-ComputerInfo | Select-Object CsName, WindowsProductName

# Phase P1 — Renommage / reboot, puis rouvrir une session administrateur
# Rename-Computer -NewName SRV-AD01 -Restart

# Phase P2 — Adresse IP statique (vérifier l'alias exact avant exécution)
# New-NetIPAddress -InterfaceAlias "Ethernet" -IPAddress 10.10.10.10 `
#   -PrefixLength 24 -DefaultGateway 10.10.10.1

# Cas CONDITIONNEL uniquement, évoqué par le TP si route DHCP existante et erreur de passerelle :
# Vérifier Get-NetRoute avant tout retrait. Ne PAS exécuter par défaut :
# Remove-NetRoute -InterfaceAlias "Ethernet" -DestinationPrefix 0.0.0.0/0 -Confirm:$false

# Phase P3 — DNS client sur SRV-AD01
# Set-DnsClientServerAddress -InterfaceAlias "Ethernet" `
#   -ServerAddresses 10.10.10.10

# Phase P4 — Installation du rôle AD DS
# Install-WindowsFeature AD-Domain-Services -IncludeManagementTools

# Phase P5 — Création de forêt (impact important ; mot de passe DSRM demandé en session)
# Install-ADDSForest -DomainName "ad.valcrea.fr" `
#   -DomainNetbiosName "VALCREA" -InstallDns

# Phase P6 — Après redémarrage/promotion : DNS forwarder
# Add-DnsServerForwarder -IPAddress 10.10.10.1

# Phase P7 — Vérifications AD / DNS depuis SRV-AD01
# Get-ADDomain
# Resolve-DnsName ad.valcrea.fr
# Get-DnsServerForwarder
# Get-NetIPConfiguration
# Test-Connection 10.10.10.1 -Count 2

# Test prescrit depuis KALI-AUDIT, dans le terminal Linux (PAS PowerShell) :
# nslookup ad.valcrea.fr

# Aucun test externe n'a été exécuté dans le cadre de E11-PREP.
