# E11 — Checklist de validation et collecte des preuves

**État au 2026-11-11 :** PRÉPARATION DOCUMENTAIRE UNIQUEMENT.  
**Convention :** PASS = sortie/capture réellement observée ; FAIL = échec réellement observé ; NOT_TESTED = non exécuté ; BLOCKED = prérequis non satisfait.

| ID | Contrôle / résultat attendu | État initial E11-PREP | Preuve future |
|---|---|---|---|
| E11-01 | Sauvegarde récupérable et état GNS3/WSL2/Windows avant changement | NOT_TESTED ; snapshot global E09 FAIL connu | archive + vérification, sans secret |
| E11-02 | VLAN 10 accessible, SW-LYON eth1 tag 10 et FW-LYON 10.10.10.1 | BLOCKED / NOT_TESTED en trafic | OVS, ping, route |
| E11-03 | Adapter Windows alias réel confirmé | NOT_TESTED | `Get-NetAdapter` |
| E11-04 | Nom OS `SRV-AD01` après éventuel redémarrage | NOT_TESTED | `hostname`, `Get-ComputerInfo` |
| E11-05 | IP `10.10.10.10/24`, gateway `10.10.10.1`, DNS `10.10.10.10` | NOT_TESTED | `Get-NetIPConfiguration` |
| E11-06 | Rôle `AD-Domain-Services` installé | NOT_TESTED | `Get-WindowsFeature AD-Domain-Services` |
| E11-07 | Forêt/domaine créés, NetBIOS VALCREA | NOT_TESTED | `Get-ADDomain` et sortie DNSRoot |
| E11-08 | DNS Server installé et zone `ad.valcrea.fr` vérifiée | NOT_TESTED | `Get-DnsServerZone` |
| E11-09 | Forwarder DNS `10.10.10.1` enregistré | NOT_TESTED | `Get-DnsServerForwarder` |
| E11-10 | Résolution DNS sur SRV-AD01 | NOT_TESTED | `Resolve-DnsName ad.valcrea.fr` |
| E11-11 | Résolution DNS depuis KALI-AUDIT via le réseau | NOT_TESTED ; dépend des flux | `nslookup ad.valcrea.fr` |
| E11-12 | DSRM protégé hors dépôt ; prise en compte redémarrages et activation Windows | NOT_TESTED | confirmation sans divulguer le secret |
| E11-13 | Aucune création anticipée d'OU, groupes ou ACL E12 | PASS documentaire pour le plan seulement | revue scripts et périmètre |

## Dépendances ouvertes à ne pas ignorer

- **E10** non VALIDATED : DHCP WAN `192.168.122.x` absent, route par défaut absente, DHCP/DNS internes incomplets, trafic VLAN non testé.
- **E10 INC-E10-02** : timeout POST NIO du SW-INTERNET ; pas de correction démontrée.
- **E09** : sauvegarde ciblée OVS PASS mais restauration et persistance non testées.
- Aucun script E11-PREP ne doit être présenté comme exécuté ; aucune capture AD authentique n'existe à ce stade.

## Preuves conseillées lors du déploiement ultérieur

Captures lisibles des sorties de `Get-NetIPConfiguration`, `Get-WindowsFeature`, `Get-ADDomain`, `Get-DnsServerForwarder`, `Resolve-DnsName`, `nslookup` Kali. Retirer les identifiants, secrets, adresses non pertinentes et données personnelles avant publication.

**Critère de clôture :** tous les critères obligatoires vérifiés sur environnement opérationnel, incidents bloquants documentés et handoff réel remis à MAIN PROGRESSION. **E11 reste NOT_STARTED techniquement aujourd'hui.**
