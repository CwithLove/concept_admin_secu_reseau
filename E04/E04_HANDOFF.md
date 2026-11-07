# E04_HANDOFF — VALCRÉA TP01

**Projet :** MAIN PROGRESSION | **Mode :** SOLO | **Étape :** E04 — topologie logique et plan d’adressage  
**Référentiel :** `E03/MAIN_STATE.md` et `E03/DECISIONS.md` v1.4.0 (GitHub main, consultés)  
**Statut proposé :** `PARTIAL` — conception documentaire complète pour Lyon et réserves, Bordeaux proposé mais non encore approuvé ; pool VPN effectif non défini par source. **Aucune validation officielle.**  
**Temps réellement passé :** `UNKNOWN` (pas de chronométrage fiable). Cible pédagogique 30 min, non imputée comme temps passé. E01/E02/E03 temps également UNKNOWN ; solde 720 min UNKNOWN.

## 1. Fichiers produits

- `E04_PLAN_ADRESSAGE.csv` : 11 entrées (Lyon 5 VLAN + parking, VPN, Bordeaux 2 zones proposées, Nantes réserve, WAN lab), GW, DHCP, DNS, réservations, capacités et classification.
- `E04_PLAN_ADRESSAGE.md` : architecture logique textuelle, sources, exigences E03, hypothèses, calculs et décisions en attente.
- `E04_HANDOFF.md` : présent rapport.

## 2. Couverture et classifications

- **SOURCE-REQUIRED :** Lyon `10.10.0.0/16`, Bordeaux `10.20.0.0/16`, Nantes `10.30.0.0/16` ; Lyon VLAN 10/20/30/40/50/999 et pools exacts TP p.3 ; VPN `10.10.90.0/24` ; GW `.1` des VLAN ; AD `ad.valcrea.fr`, NetBIOS `VALCREA`, SRV-AD01 `.10` statique et SRV-SUP01 `.20` réservation DHCP.
- **PROJECT-DECIDED :** D01–D12 inchangées ; SOLO, 720 min, autorité MAIN PROGRESSION et interdiction d’inférer des tests.
- **PROPOSED :** Bordeaux VLAN 20 et 40, adresses `10.20.20.0/24` et `10.20.40.0/24`, pools `.100–.199`, DNS conditionnel et local respectivement.
- **OBSERVED-REPORTED (hérité E01, pas testé ici) :** pfSense LAN temporaire `192.168.1.1/24`, WAN DHCP ancien `192.168.122.114/24`, OVS VLAN non configurés ; noms affichés NAT2 / SRV-AD01-1 / SRV-SUP01-1 ; WSL2 et Windows anglais, divergences conservées.

## 3. Vérifications

| Contrôle | Résultat | Justification |
|---|---|---|
| 4 fichiers GitHub E03 accessibles | PASS | Lecture directe branche main |
| Sources PDF pertinentes consultées | PASS | TP p.3/6/16–17 ; Support p.10–11 |
| Lyon zones et plages TP inchangées | PASS | Comparaison documentaire |
| Bordeaux utilisateurs et invités couverts | PASS documentaire / APPROVAL PENDING | Deux zones PROPOSED ; non approuvées |
| Nomades et réserve Nantes couverts | PASS documentaire | VPN /24 et réserve /16 |
| Sous-réseaux sans chevauchement | PASS | Vérification Python ipaddress |
| Passerelles dans sous-réseaux | PASS | Contrôle des VLAN routés et WAN amont |
| DHCP exclut passerelles et serveurs réservés | PASS | Contrôle numérique ; SRV-AD01 .10 et SUP .20 hors pool |
| DNS documenté pour chaque zone active | PASS documentaire | Bordeaux conditionnel, VPN selon source |
| Croissance +15 / total 63 | PASS sous hypothèses | Scénarios concentrés Lyon ou Bordeaux ; terminaux multiples inconnus |
| OpenVPN pool opérationnel / adresse serveur | NOT_TESTED | Source ne fixe pas de plage exacte ; E14 |
| Tests GNS3/pfSense/OVS/Windows | NOT_TESTED | Hors périmètre E04 |
| DNS Bordeaux via lien / continuité | NOT_TESTED | Liaison non construite ; E07 |

**FAIL :** aucun échec de cohérence identifié dans les contrôles documentaires. L’absence de test technique ne vaut pas PASS.

## 4. Écarts et questions ouvertes

- Aucune modification des VLAN, adresses, domaines ou décisions verrouillés.
- Bordeaux : validation B01/B02 nécessaire ; choix DHCP/DNS et dépendance WAN à préciser ; aucun VLAN facultatif ajouté à Lyon.
- OpenVPN : tunnel /24 imposé, mais passerelle Ethernet `.1` et pool `.100–.199` **non imposés** ; éviter de les inventer.
- Inventaire réel terminaux/visiteurs et marge de production non démontrés ; NF03/R13 seuil CAO toujours ouvert.
- E01 : WSL2 au lieu de GNS3 VM, Windows anglais, labels et captures non vérifiées ; conservés comme écarts historiques, non corrigés ici.

## 5. Dépendances

- **E05 :** reprendre zones Lyon/Bordeaux/VPN et séparer décisions approuvées des propositions ; construire la matrice de flux, pas en E04.
- **E06 :** schéma draw.io uniquement après arbitrage B01/B02 ; ne pas traiter ce texte comme schéma livré.
- **E09 :** configurer seulement SW-LYON VLAN 10/20/30/40/50 et parking 999, selon ports TP ; vérifier mapping OS et captures.
- **E10 :** pfSense Lyon interfaces, pools imposés, DNS AD/invités et réservation SRV-SUP01 ; valider MAC et bail ; ne pas appliquer Bordeaux dans le labo.
- **E07/E14 :** préciser résilience DNS Bordeaux et pool/terminaison OpenVPN avant configuration.

## 6. Patches proposés — NON APPLIQUÉS

**MAIN_STATE.md v1.4.0 :** après revue, remplacer ligne E04 TODO par statut accepté par MAIN PROGRESSION (proposition actuelle PARTIAL), temps UNKNOWN, et référencer les 3 livrables ; consigner B01/B02 et V01/B03/CAP01 ouverts. Ne pas décompter 30 minutes comme réel.

**DECISIONS.md v1.4.0 :** ne changer aucune décision D01–D12 ni SOURCE-REQUIRED. Ajouter, uniquement si approuvé, décisions Bordeaux B01/B02 comme PROJECT-DECIDED ; sinon les conserver PENDING. Conserver VPN pool, équipement Bordeaux, inventaire terminaux et NF03 en PENDING. Aucune nouvelle observation technique.

## 7. Transmission

Transmettre ces trois fichiers à MAIN PROGRESSION pour revue. **Ne pas pousser GitHub, ne pas créer E04/ ni déclarer E04 officiellement VALIDATED.** Aucun fichier E01–E03, MAIN_STATE ou DECISIONS n’a été modifié.
