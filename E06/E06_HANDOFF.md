# E06_HANDOFF — VALCRÉA TP01

**Projet :** MAIN PROGRESSION · **Session :** E06 (Étape 6 : schéma logique draw.io)  
**Référentiel :** E05/MAIN_STATE.md et E05/DECISIONS.md, v1.6.0  
**Statut proposé : PARTIAL — revue MAIN PROGRESSION nécessaire.**  
**Temps réellement passé : UNKNOWN** (20 min = cible pédagogique uniquement). **Mode : SOLO.**

## Livrables attendus dans E06/
- `2-schema-logique.drawio` : original modifiable fourni par l'étudiant.
- `2-schema-logique.png` : image fournie par l'étudiant (1292 × 862).
- `E06_HANDOFF.md` : présent rapport.

**Attention :** la présence du présent rapport dans GitHub ne prouve pas encore que les deux fichiers graphiques y ont été déposés. Contrôler les trois chemins séparément.

## Réalisation
Le schéma documentaire représente Internet/WAN, FW-LYON (pfSense), SW-LYON (Open vSwitch) et trunk 802.1Q, VLAN Lyon 10/20/30/40/50 et PARKING 999 non routé. Sous-réseaux et passerelles Lyon : 10.10.10/20/30/40/50.0/24 avec passerelle .1. SRV-AD01 10.10.10.10 (AD/DNS/fichiers, ad.valcrea.fr) et SRV-SUP01 10.10.10.20 (Zabbix). NOMADES : OpenVPN UDP 1194, tunnel 10.10.90.0/24, DNS/SMB limités, ADMIN interdit. Bordeaux : B01 utilisateurs VLAN 20, 10.20.20.0/24 GW 10.20.20.1 ; B02 invités VLAN 40, 10.20.40.0/24 GW 10.20.40.1 ; DNS métier futur vers Lyon, DNS local invité prévu ; lien intersites projeté **NON DÉPLOYÉ**. Nantes : 10.30.0.0/16 réservé, non déployé. Synthèse E05 : refus par défaut, invités Internet uniquement, atelier sans Internet, administration ciblée, supervision Zabbix, aucun RDP 3389 Internet.

## Contrôles
| Vérification | Résultat |
|---|---|
| Source locale `.drawio` parsable, éléments éditables | PASS (XML mxfile, Page-1 contenant 28 mxCell, Page-2 vide) |
| Ouverture du fichier livré dans diagrams.net | NOT_TESTED (captures d'édition uniquement) |
| Source locale `.png` existante | PASS (PNG 1292 × 862) |
| Identité exacte de l'export PNG avec la dernière sauvegarde drawio | NOT_TESTED |
| VLAN et adresses prescrits / Bordeaux cible / VPN non-Ethernet | PASS (revue visuelle) |
| Cohérence de la synthèse de politique E05 | PASS au niveau résumé, pas de règles actives prouvées |
| Tracé individuel de tous les flux principaux | PARTIAL (plusieurs flux décrits textuellement) |
| Lisibilité à l'impression / après export | NOT_TESTED |
| Tests réseaux ou configurations pfSense/OVS/Windows/OpenVPN/Zabbix | NOT_TESTED — aucun réalisé à E06 |

## Limitations et dépendances
Les relations switch↔VLAN sont résumées visuellement sans tous les liens d'accès individualisés. Les exceptions techniques E05 ne deviennent **pas** APPROVED : RPC AD dynamique TCP 135/49152–65535, RDP interne ADMIN, mises à jour serveur non cadrées, agent Zabbix actif TCP 10051, SSH/HTTPS équipements non inventoriés. Conserver **V01, B03, CAP01, NF03/R13 PENDING**. Aucun pool VPN opérationnel inventé.

E07 : services/résilience et B03. E08 : dossier de conception, budget et vérification des artefacts. E09 : configurer SW-LYON selon TP, VLAN 999 ports inutilisés hors trunk. E10 : interfaces VLAN/routage/DHCP/DNS pfSense selon E04. Aucune de ces étapes n'a été exécutée ici.

## Propositions (ne pas appliquer avant revue)
Après vérification GitHub des trois fichiers, ouverture/PNG et critères E06, MAIN PROGRESSION peut accepter E06 comme VALIDATED ou maintenir PARTIAL. Ajouter les chemins E06 au registre des livrables; maintenir temps E06 UNKNOWN tant que non mesuré. Ne modifier ni MAIN_STATE ni DECISIONS v1.6.0 ni les archives E01–E05 sans revue.