# E08_HANDOFF — VALCRÉA TP01

Date: 2026-11-07. Référentiel canonique: E07 v1.8.0. Mode SOLO, budget global 720 min. Statut **PARTIAL**, revue MAIN PROGRESSION requise.

## Livrables
- E08/E08_BUDGET.csv — scénarios A/B, références et prix catalogue.
- E08/E08_BUDGET_ANALYSE.md — hypothèses, CAPEX/OPEX/TCO, comparaison, recommandation.
- E08/E08_HANDOFF.md — présent fichier.
- **1-conception.pdf: NON PRODUIT**; compilation fidèle des originaux E02–E07 et de l'image du schéma non vérifiée; ne pas annoncer le dossier final comme achevé. Le contenu source est réparti entre E02 audit, E03 cahier, E04 adressage, E05 flux/politique, E06 schéma, E07 services/résilience, E08 budget. Compiler sans réécrire les historiques après revue des sources.

## Contrôles
| Contrôle | Statut |
|---|---|
| Prix catalogue Annexe B | PASS documentaire |
| Sommes A/B, marges, TCO 5 ans | PASS arithmétique |
| Limites CAPEX/OPEX sur postes chiffrés | PASS |
| Coûts non chiffrés et hypothèses | PASS, TCO partiel |
| RTO/RPO fichiers | NOT_TESTED |
| GNS3 FW-LYON pfSense installé/boot | OBSERVED-REPORTED E01, NOT_TESTED ici |
| GNS3 SRV-AD01 Windows installé/boot | OBSERVED-REPORTED E01, NOT_TESTED ici |
| GNS3 10/10 câbles | OBSERVED-REPORTED E01, NOT_TESTED ici |
| Captures/snapshots GNS3 disponibles | NOT_TESTED, aucune preuve nouvelle |
| 1-conception.pdf fidèle et complet | NOT_TESTED / NON PRODUIT |

Temps actif E08: **UNKNOWN (aucun chronométrage fiable)**. Temps E01–E07 et cumul 720 min: UNKNOWN. Ne pas comptabiliser les 30 min pédagogiques comme temps réel.

## GNS3 — vérification manuelle demandée
1. Ouvrir VALCREA-LAB sur l'hôte habituel Windows GUI + WSL2 GNS3 server; vérifier le nom du projet, 10 liens et ports par comparaison TP p.2–3; capturer topologie et statut.
2. Démarrer **individuellement** FW-LYON, vérifier console pfSense CE et interfaces détectées; capturer écran sans secret.
3. Démarrer **individuellement** SRV-AD01, vérifier ouverture Windows Server et édition/langue; capturer écran sans secret. Ne pas supposer AD installé.
4. Arrêter proprement les VM si nécessaire, puis GNS3 > Edit > Manage snapshots > Take snapshot (libellé proposé: PRE-E09); relever nom, date et présence réelle dans la liste, capture d'écran. Ne pas confondre snapshot GNS3 et sauvegarde de production.
5. Consigner PASS/FAIL, heure, chemins des captures et problèmes. Aucune action exécutée par cette session dans GNS3; aucun snapshot créé ici.

## Décisions proposées, non approuvées
- Choix A (CAPEX 21650, OPEX 3276/an, TCO 38030) avec B comme option (CAPEX 27400, OPEX 4296/an, TCO 48880), hypothèses catalogue et TCO partiel.
- Reporter l'approbation E07-P1..P5; prioriser essais PRA et inventaire avant engagement financier.
- Maintenir V01/B03/CAP01/NF03-R13 PENDING, exceptions E05 non approuvées, D01–D12, B01/B02, A01–A05 inchangés.

## Proposition v1.9.0 (NON APPLIQUÉE)
MAIN_STATE: enregistrer E08 PARTIAL, trois livrables E08, PDF non produit, GNS3/snapshot NOT_TESTED, montants A/B et temps UNKNOWN; E09 bloqué jusqu'à vérification préalable des snapshots si MAIN l'exige.
DECISIONS: inscrire scénarios A/B et quantités comme PROPOSED, aucun achat ni modification d'architecture APPROVED; conserver toutes les décisions et PENDING existantes.

## Pré requis E09
Sauvegarder preuve de snapshot; vérifier topologie SW-LYON eth0 trunk et eth1–eth6 selon TP p.3, ports eth7–15 PARKING 999; ne configurer OVS qu'en E09. E10 pfSense VLAN/routage/DHCP/DNS, E11–E12 AD: non exécutés.

Validation finale E08 réservée à MAIN PROGRESSION.
