# E04 — Plan logique et plan d’adressage VALCRÉA

**Session :** E04 | **Référentiel :** E03/MAIN_STATE.md et E03/DECISIONS.md v1.4.0 | **Statut :** PROPOSED, revue MAIN PROGRESSION requise.  
**Périmètre :** conception documentaire exclusivement. Aucune modification GNS3, pfSense, OVS, Windows ni GitHub.

## 1. Sources vérifiées et règles de gouvernance

- TP01 p.3 (VLAN, DHCP, DNS, WAN), p.6 (Étape 4), Annexe A p.16–17 (effectifs, usages, contraintes), p.9, p.10 et p.12 consultées pour la cohérence des étapes ultérieures.
- Support de Formation p.10–11 (topologie et segmentation).
- GitHub branche `main`, dossier `E03/` : `MAIN_STATE.md`, `DECISIONS.md` (v1.4.0), `E03_CAHIER_DES_CHARGES.md`, `E03_HANDOFF.md` : tous accessibles.
- `SOURCE-REQUIRED` : exigé par TP ; `PROJECT-DECIDED` : décision verrouillée D01–D12 ; `PROPOSED` : choix E04 à approuver ; `OBSERVED-REPORTED` : état rapporté en E01, non vérifié en direct dans cette session.

## 2. Besoins E03 repris

- F01/F06 : fichiers, AD et confidentialité des données par rôle ; F02 : VPN sans RDP public ; F03 : invités isolés ; F04/F05 : atelier isolé d’Internet et accès aux programmes ; F08 : accès SaaS ; F09 : supervision.
- NF04/R07 : 48 salariés actuels (38 Lyon, 6 Bordeaux, 4 nomades) +15 = **63** à trois ans ; NF05 : cloisonnement et refus par défaut ; NF06 : exploitation simple ; NF01/NF02 : RTO 4 h, RPO 24 h, non démontrés par l’adressage.
- C08 : conservation stricte des réseaux imposés ; C01/C02 : budget à traiter E08 ; NF03/R13 : seuil de transfert CAO encore inconnu.

## 3. Topologie logique (sans dessin E06)

Internet / WAN → FW-LYON pfSense → trunk 802.1Q → SW-LYON → VLAN 10 SERVEURS, 20 UTILISATEURS, 30 ADMIN, 40 INVITES, 50 ATELIER. VLAN 999 PARKING : L2 non routé et hors trunk. OpenVPN nomades : réseau tunnel 10.10.90.0/24, sans VLAN Ethernet. Bordeaux : site distant, réseau utilisateurs et réseau invités à séparer ; interconnexion sécurisée à détailler ultérieurement, sans imposer de topologie physique supplémentaire. Nantes : réserve /16 uniquement. La matrice des flux et les règles sont réservées à E05/E13.

## 4. Réseaux, adressage et DNS

Le fichier `E04_PLAN_ADRESSAGE.csv` est la table exhaustive et fait foi pour les plages. Synthèse :

| Site / zone | Réseau | GW | DHCP | DNS | Statut |
|---|---|---|---|---|---|
| Lyon VLAN 10 SERVEURS | 10.10.10.0/24 | .1 | .200–.220 | 10.10.10.10 | SOURCE-REQUIRED |
| Lyon VLAN 20 UTILISATEURS | 10.10.20.0/24 | .1 | .100–.199 | 10.10.10.10 | SOURCE-REQUIRED |
| Lyon VLAN 30 ADMIN | 10.10.30.0/24 | .1 | .100–.149 | 10.10.10.10 | SOURCE-REQUIRED |
| Lyon VLAN 40 INVITES | 10.10.40.0/24 | .1 | .100–.199 | 10.10.40.1 | SOURCE-REQUIRED |
| Lyon VLAN 50 ATELIER | 10.10.50.0/24 | .1 | .100–.149 | 10.10.10.10 | SOURCE-REQUIRED |
| Lyon VLAN 999 PARKING | aucun | aucune | aucun | aucun | SOURCE-REQUIRED |
| Nomades OpenVPN | 10.10.90.0/24 | tunnel (pas de GW Ethernet imposée) | serveur VPN, pool à confirmer | 10.10.10.10 | Réseau/DNS SOURCE-REQUIRED |
| Bordeaux VLAN 20 UTILISATEURS | 10.20.20.0/24 | 10.20.20.1 | .100–.199 | 10.10.10.10 via tunnel | PROPOSED |
| Bordeaux VLAN 40 INVITES | 10.20.40.0/24 | 10.20.40.1 | .100–.199 | 10.20.40.1 local | PROPOSED |
| Nantes réserve | 10.30.0.0/16 | aucune | aucun | aucun | SOURCE-REQUIRED |
| WAN laboratoire NAT | 192.168.122.0/24 | amont 192.168.122.1 | DHCP NAT | DHCP NAT (non imposé) | SOURCE-REQUIRED contexte lab |

**SERVEURS :** SRV-AD01 `10.10.10.10/24` statique, GW `10.10.10.1`, DNS lui-même ; SRV-SUP01 `10.10.10.20` réservé par mapping DHCP (MAC à relever en E10). Ces adresses sont hors pool `.200–.220`. Domaine `ad.valcrea.fr`, NetBIOS `VALCREA`. DNS invités via pfSense local, sans exposition du DNS AD. Les DNS Bordeaux sont des choix **conditionnels** : DNS AD Lyon exige une liaison opérationnelle ; résolveur local invité reste à approuver. La résilience DNS Bordeaux relève d’E07.

**Convention :** chaque VLAN routé a pour troisième octet son identifiant, passerelle `.1` ; `999` ne peut pas être représenté comme troisième octet IPv4 et reste non routé. Le VPN est un tunnel, non un VLAN ; aucune passerelle `.1` n’est inventée. Les plages Bordeaux ne sont pas prescrites par le TP.

## 5. Capacité et vérifications documentaires

Chaque `/24` fournit 254 adresses hôtes (hors réseau et broadcast). Pools Lyon : SERVEURS 21, UTILISATEURS 100, ADMIN 50, INVITES 100, ATELIER 50. Pools Bordeaux proposés : UTILISATEURS 100, INVITES 100. Hypothèse conservatrice : si les **15 recrutements** rejoignent tous Lyon, ses 38 salariés deviennent 53, inférieurs aux 100 baux utilisateurs ; si tous rejoignent Bordeaux, 6 deviennent 21, inférieurs aux 100 baux proposés. Les 4 nomades actuels sont largement sous 254 adresses théoriques VPN ; capacité simultanée réelle dépend de l’implémentation OpenVPN. Ces calculs portent sur salariés, non sur le nombre réel de terminaux par personne : terminaux multiples, invités, atelier et pic de connexions restent à inventorier.

**PASS documentaire (contrôles automatisés du CSV) :** sous-réseaux sans chevauchement ; passerelles IPv4 dans leurs sous-réseaux ; DHCP dans les plages et sans adresses de passerelles ni serveurs réservés ; noms et adresses Lyon conservés ; couverture nominale 63 salariés sous hypothèses. **NOT_TESTED technique :** DHCP, DNS, OpenVPN, connectivité intersites, interfaces, pare-feu, capacité de connexion simultanée. Les réserves Nantes et parking n’ont pas de DHCP/DNS car non actifs.

## 6. Propositions et questions pour MAIN PROGRESSION

1. **PROPOSED B01 :** Bordeaux VLAN 20 UTILISATEURS `10.20.20.0/24`, GW `.1`, pool `.100–.199`, DNS AD Lyon via liaison sécurisée. Il s’agit de la zone métier requise, non d’un VLAN facultatif ajouté au laboratoire.
2. **PROPOSED B02 :** Bordeaux VLAN 40 INVITES `10.20.40.0/24`, GW `.1`, pool `.100–.199`, DNS résolveur local `.1` ; nécessaire à l’isolement du showroom. Ne pas ajouter de zone ADMIN/SERVEURS/ATELIER à Bordeaux sans décision.
3. **PENDING V01 :** OpenVPN : pool effectif, IP de terminaison et méthode d’attribution selon serveur et mode de tunnel ; ne pas fixer de plage arbitraire dans le TP.
4. **PENDING B03 :** équipement DHCP/DNS et résilience à Bordeaux, comportement en panne du lien intersites ; arbitrage E07.
5. **PENDING CAP01 :** nombre de terminaux par salarié, pics invités et équipements atelier ; confirmer dimensionnement de production.
6. **PENDING NF03 :** seuil de durée acceptable pour fichiers CAO 500 Mo (E03/R13).

**Aucune proposition n’est une décision PROJECT-DECIDED ni une configuration OBSERVED.** E05 devra consommer ces zones après arbitrage ; E06 représentera uniquement la conception approuvée ; E09/E10 implémenteront les VLAN et pools **Lyon prescrits** sans extension Bordeaux dans GNS3. La réserve Nantes reste intacte.
