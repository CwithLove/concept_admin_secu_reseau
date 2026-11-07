# E07_HANDOFF — VALCRÉA TP01

**Projet :** MAIN PROGRESSION | **Mode :** SOLO | **Session :** E07 | **Référentiel :** E06 v1.7.0 (2026-11-07).

**Statut proposé : PARTIAL, revue/validation MAIN PROGRESSION requise.** Dossier documentaire rédigé ; aucune preuve de fonctionnement ou approbation d'options HA. **Temps réellement passé : UNKNOWN** (non chronométré ; 20 min dans le TP est une indication pédagogique, pas le temps réel). Temps cumulé et solde sur 720 min : UNKNOWN.

## Livrables produits
- E07/E07_SERVICES_RESILIENCE.md : exactement sept services, rôle, hébergement, ports, redondance, sauvegarde et supervision ; étiquettes SOURCE-REQUIRED, PROJECT-DECIDED, PROPOSED ; résilience RTO/RPO et évolution.
- E07/E07_HANDOFF.md : présent fichier.
- E07_SERVICES.csv : non créé (tableau Markdown suffisant).
- Aucune modification des fichiers canoniques E06, GNS3, firewall ou autres configurations.

## Contrôles

| ID | Vérification | Statut | Justification |
|---|---|---|---|
| C01 | Sept services exactement : DHCP, DNS, Active Directory, Fichiers, Supervision, Accès distant, Sauvegarde | PASS | Sept lignes du tableau de conception. |
| C02 | Chaque service a rôle, hébergement, ports, redondance, sauvegarde et supervision | PASS | Colonnes complètes, données conditionnelles explicitement signalées. |
| C03 | Statuts et sources reconnaissables | PASS | SOURCE-REQUIRED / PROJECT-DECIDED / PROPOSED et LAB/CIBLE distingués. |
| C04 | Adressage, VLAN, B01/B02, topologie E06 préservés | PASS documentaire | Aucun changement ni création de nœud. |
| C05 | Exceptions E05 non approuvées demeurent en attente | PASS documentaire | Aucun ALLOW non approuvé devenu politique. |
| C06 | Méthode RTO 240 min et RPO 24 h décrite | PASS documentaire | Tests, mesures et risques explicités. |
| C07 | Restauration de fichiers RTO≤4h et RPO≤24h vérifiée | NOT_TESTED | Aucun test de reprise réel. |
| C08 | Deux DC, CARP, 4G, UPS, failover intersite | NOT_TESTED | Scénarios proposés, non déployés. |
| C09 | CAPEX≤30 000 € HT, OPEX≤6 000 € HT/an prouvés | NOT_TESTED | E08 doit chiffrer exclusivement via annexe B. |
| C10 | Supervision, DNS/DHCP, VPN et fichiers actifs sur le lab | NOT_TESTED | E09–E16 non exécutées ici. |
| C11 | Aucune modification du canon E06 ni du lab pendant E07 | PASS dans le périmètre d'E07 | Création de deux nouveaux fichiers E07 seulement. |

**FAIL constaté : aucun contrôle documentaire en échec.** Ceci ne constitue pas une validation d'exploitation.

## Propositions NON APPROUVÉES
- E07-P1 : second DC/DNS Bordeaux (réplication et continuité) ; dépend B03.
- E07-P2 : cluster CARP (IP physiques à déterminer, passerelles .1 préservées comme VIP envisagées) ; cohérence adresse et équipements à revoir.
- E07-P3 : secours 4G et onduleurs ; dépend E08.
- E07-P4 : sauvegarde 3-2-1, copie isolée/hors site et procédure PRA fichiers ; tests R05/R06 nécessaires.
- E07-P5 : DHCP local à Bordeaux ; pools B01/B02 inchangés ; B03 à arbitrer.

**PENDING conservés :** V01 (OpenVPN allocation/endpoint), B03 (services et continuité Bordeaux), CAP01 (terminaux/visiteurs), NF03/R13 (durée transfert CAO 500 Mo). Exceptions E05 F17/F18/F21/F23/F39/F42/F43 et nouveaux flux intersites non approuvés.

## Risques / limites
1. RTO 4 h non démontré pour les données historiques d'environ 1,2 To ; performance stockage/réseau/temps d'intervention inconnus.
2. Un second DC protège AD/DNS mais pas nécessairement le service fichiers (SPOF sur SRV-AD01).
3. Avec B01 DNS Lyon, la perte du lien intersite pourrait affecter Bordeaux jusqu'à arbitrage et déploiement B03.
4. CARP ne couvre pas panne switch/stockage/WAN ; fonctionnement et bascule non testés.
5. Coût de scénarios HA inconnu, risque de dépassement CAPEX/OPEX ; pas de fournisseur choisi.
6. Laboratoire sur hôte 16 Go RAM, WSL2 GNS3 ; ne pas ajouter de VM ni supposer HA opérationnelle.
7. Temps E01–E06 UNKNOWN ; archivage captures E01 et correspondance PNG E06 encore à vérifier.

## Pré requis / travail E08
- Comparer scénarios budgétés (socle minimal et HA renforcée) avec références exactes annexe B, quantités, licences CAL, CAPEX/OPEX et TCO 5 ans.
- Justifier le compromis avec le RTO/RPO, annoncer clairement les risques non couverts si une option n'est pas financée.
- Trancher les propositions E07-P1 à E07-P5 uniquement après revue MAIN ; ne pas ouvrir d'exception réseau par défaut.
- Garder E09–E16 distinctes pour les configurations/tests et E19 pour l'archive officielle.

## Mises à jour du canon proposées, NON APPLIQUÉES
- E06/MAIN_STATE.md : E07 TODO → PARTIAL à réception ; éventuellement VALIDATED documentaire si MAIN confirme ; temps actif UNKNOWN ; chemins des deux fichiers E07 dans le registre.
- E06/DECISIONS.md : consigner E07-P1..P5 comme PROPOSED, ne pas approuver automatiquement ; maintenir D01–D12, A01–A05, B01/B02 et les quatre PENDING.

**Validation finale : réservée à MAIN PROGRESSION.**
