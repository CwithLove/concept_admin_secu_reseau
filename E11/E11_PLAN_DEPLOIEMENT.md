# E11 — Plan de déploiement AD DS et DNS (PRÉPARATION)

**Projet :** VALCRÉA TP01 · **Étape :** E11 — Promouvoir SRV-AD01 contrôleur de domaine.  
**Date :** 2026-11-11 · **Mode :** SOLO · **Statut :** E11-PREP (documentaire), **E11-DEPLOY NOT_STARTED**.  
**Source principale :** TP01 p.10/19, Étape 11 et ses commandes PowerShell. **Référence pédagogique :** Support de Formation p.18 (Active Directory, préparation de la structure AGDLP pour E12).  
**Dépendance ouverte :** E10 PARTIAL, incident DHCP WAN/NIO et DHCP/DNS internes non finalisés ; voir `E10/E10_HANDOFF.md`.

## 1. Objectif et limites

Transformer le serveur Windows en premier contrôleur de domaine d'une nouvelle forêt `ad.valcrea.fr`, installer le service DNS et orienter sa résolution externe vers pfSense. La création des OU, comptes, groupes, partages et ACL AGDLP appartient à **E12**, pas à E11.

**Cette session ne réalise aucune configuration sur une VM :** pas de redémarrage, promotion, rôle ajouté ou test réseau exécuté. Les commandes préparées ne sont pas des preuves d'exécution.

## 2. Paramètres imposés à conserver

| Paramètre | Valeur |
|---|---|
| Hôte cible | SRV-AD01 (dans GNS3, l'étiquette peut être SRV-AD01-1) |
| OS observé E01 | Windows Server 2025 Standard Evaluation Desktop Experience, interface anglaise |
| Site / VLAN | Lyon / VLAN 10 SERVEURS |
| IPv4 / préfixe | 10.10.10.10 / 24 |
| Passerelle | 10.10.10.1 (pfSense, VLAN 10) |
| DNS client du serveur | 10.10.10.10 (lui-même, service DNS à installer) |
| Nouveau domaine / forêt | ad.valcrea.fr |
| NetBIOS | VALCREA |
| DNS forwarder | 10.10.10.1 (pfSense) |
| Switch | SW-LYON eth1 access VLAN 10 |

**N'inventer ni adresse secondaire, ni domaine alternatif, ni nouvelle règle de pare-feu.** DSRM doit être saisi/sauvegardé selon le tableau des identifiants demandé par le TP, **jamais commité dans Git**.

## 3. Conditions préalables à une future exécution

1. Lancement contrôlé de SRV-AD01 : mémoire Windows et WSL2 disponibles ; disque et instantané/sauvegarde récupérable évalués avant changement (snapshot global GNS3 E09 échoué).
2. SW-LYON eth1 confirmé sur VLAN 10 et trunk eth0 opérationnel après toute relance de Docker.
3. FW-LYON `vtnet1.10` présent, activé et adressé `10.10.10.1/24` ; test effectif depuis SRV-AD01 vers passerelle **à effectuer**, pas encore attesté.
4. Vérifier le nom réel de l'interface Windows via `Get-NetAdapter` : `Ethernet` dans le TP, à confirmer dans la VM avant exécution.
5. Vérifier `Get-NetIPConfiguration`, routes et adresses existantes pour éviter doublon/conflit de passerelle avec un ancien bail DHCP ; ne pas supprimer automatiquement une route sans diagnostic.
6. Confirmer un accès administrateur et un moyen sûr de conserver le mot de passe DSRM hors repository ; vérifier date/heure et espace disque.
7. Accepter explicitement la reprise technique avant exécution des commandes. Les défauts E10 ne sont **pas** implicitement corrigés par E11.

## 4. Séquence technique différée (TP01 p.10)

| Phase | Opération prévue | Risque / checkpoint |
|---|---|---|
| P0 | Contrôler l'état initial, l'interface Ethernet, la route et la sauvegarde | Observation seule |
| P1 | `Rename-Computer -NewName SRV-AD01 -Restart` | Redémarrage immédiat ; reprendre la session ensuite |
| P2 | `New-NetIPAddress ... 10.10.10.10/24 ... 10.10.10.1` | Vérifier avant toute modification de route/DHCP |
| P3 | `Set-DnsClientServerAddress ... 10.10.10.10` | La résolution via AD DNS n'est pas encore opérationnelle à cette phase |
| P4 | `Install-WindowsFeature AD-Domain-Services -IncludeManagementTools` | Rôle installé != domaine créé |
| P5 | `Install-ADDSForest -DomainName ad.valcrea.fr -DomainNetbiosName VALCREA -InstallDns` | Opération conséquente ; mot de passe DSRM, redémarrage, sauvegarde et confirmation préalables |
| P6 | `Add-DnsServerForwarder -IPAddress 10.10.10.1` | Nécessite DNS Server actif et pfSense DNS Resolver joignable |
| P7 | Tests AD / DNS depuis serveur et KALI-AUDIT | Enregistrer résultats observés, distinguer interne/externe |

**Remarque TP :** si `New-NetIPAddress` échoue en raison d'une route par défaut liée au DHCP, l'énoncé cite `Remove-NetRoute -InterfaceAlias "Ethernet" -DestinationPrefix 0.0.0.0/0 -Confirm:$false`. Ce retrait est **conditionnel** : contrôler d'abord les routes et la passerelle ; ne pas l'exécuter par défaut.

**Remarque TP :** activer Windows dans les 10 jours et reprendre après chaque redémarrage. Le statut d'activation/licence reste NOT_TESTED.

## 5. Liens avec E10/E12/E13

- **E10** : le routage interne, les services DHCP et DNS pfSense et la connectivité du VLAN 10 doivent être vérifiés. L'absence de WAN peut empêcher l'accès aux mises à jour ou aux DNS publics, même si AD local peut ensuite fonctionner.
- **E12** : OU `Valcrea`, comptes, groupes globaux/locaux, modèle AGDLP et droits de fichiers ne seront créés qu'après l'AD validé.
- **E13** : politique pfSense pérenne d'après E05 ; ne pas remplacer ce travail par une autorisation ANY→ANY persistante.
- **Bordeaux** : pas de création de VLAN/service Bordeaux dans le laboratoire de Lyon.

## 6. Critères de clôture E11 (non exécutés)

- Nom ordinateur `SRV-AD01` vérifié ; adresse `10.10.10.10/24`, passerelle `10.10.10.1`, DNS local vérifiés.
- Rôle AD DS et DNS installé ; forêt/domaine `ad.valcrea.fr` créée avec NetBIOS `VALCREA`.
- `Get-ADDomain` retourne `DNSRoot : ad.valcrea.fr`.
- `Resolve-DnsName ad.valcrea.fr` et `nslookup ad.valcrea.fr` depuis Kali réussissent, conformément à la vérification prescrite par TP01 p.10. Ne pas présumer que ces commandes seront concluantes si les routes/politiques E10/E13 sont bloquées.
- DNS forwarder `10.10.10.1` configuré et vérifié séparément ; journal/capture d'exécution disponibles.

**État à l'issue de ce document :** PLAN RÉDIGÉ, DÉPLOIEMENT ET TOUS LES TESTS : NOT_TESTED. Attente de validation par MAIN PROGRESSION avant toute modification des états canoniques.
