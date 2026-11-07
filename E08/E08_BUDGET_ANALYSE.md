# E08 — Budget et recommandation (PROPOSED)

Référentiel E07 v1.8.0, TP01 étape 8 p.8, Annexe B p.17–18, Annexe C p.18–19, Support p.14/22. Tous les prix HT proviennent de l'Annexe B, catalogue fictif. **Les quantités sont des hypothèses E08 PROPOSED, non des décisions approuvées.** CSV détaillé associé. Aucune acquisition ni modification du laboratoire.

## Résultats vérifiés arithmétiquement
| Scénario | CAPEX HT | OPEX HT/an | TCO 5 ans HT | Marge CAPEX | Marge OPEX/an |
|---|---:|---:|---:|---:|---:|
| A — Socle maîtrisé | 21650 € | 3276 € | 38030 € | 8350 € | 2724 € |
| B — Résilience renforcée | 27400 € | 4296 € | 48880 € | 2600 € | 1704 € |

Formule TCO = CAPEX + 5 × OPEX annuel, tarifs constants, pas de renouvellement supposé; renouvellements matériels, hausse tarifaire et électricité réelle **non chiffrés**. B-A = 5750 € CAPEX, 1020 €/an, 10850 € TCO.

## Hypothèses et limites
- 48 salariés actuels, +15 = 63 à trois ans; 13 packs CAL-5 = 65 CAL. Licences Windows Server Standard: minimum 16 cœurs par serveur, même si SRV-T a 8 cœurs. Les droits d'accès et besoins exacts de licences additionnelles restent à confirmer.
- A: PF-M Lyon, PF-S Bordeaux; 3 switches 24 ports Lyon (un PoE) et 1 switch 8 ports PoE Bordeaux; 3 AP Wi-Fi 6; SRV-R Lyon, NAS-4, UPS sur les deux sites, fibre des deux sites, sauvegarde externalisée 2 To, 3 journées INT. Quantités et couverture Wi-Fi/ports sont à confirmer par inventaire CAP01.
- B ajoute PF-M Lyon pour CARP, SRV-T/DC Bordeaux et licence, 4G, supports supplémentaires, 2 journées INT. B ne démontre ni la bascule CARP ni la continuité SMB. Les adresses physiques CARP restent non définies; les passerelles .1 sont préservées, VIP seulement si approuvé.
- Les abonnements mensuels FIB-L 89, FIB-B 59, SAV-C 60 et 4G 35 sont annualisés ×12; SUP-PF 180/an par pare-feu, SUP-SRV 420/an par serveur. pfSense CE, Zabbix et OpenVPN: licence 0 € (support communautaire).
- SAV-C 2 To couvre nominalement 1,2 To de fichiers existants mais ne garantit ni la rétention, ni les versions, ni les sauvegardes système, ni le débit de restauration. Le NAS-4 comprend quatre disques 8 To mais capacité utile dépend du RAID non décidé.
- **Non chiffrés**: énergie réelle (support p.22: 1 W continu = 8,76 kWh/an; exemple 180 W = 315 €/an, non applicable sans inventaire), hébergement/baie, renouvellement à cinq ans, maintenance Wi-Fi/switch, installation opérateur, connectivité et forfaits additionnels, support hors catalogue, protection immuable/offline, coûts d'exploitation interne, PRA alternatif, transfert de 1,2 To, besoins de licences SaaS et de stockage supplémentaires. TCO affiché est donc **partiel et indicatif**, non un coût complet garanti.

## Comparaison E07-P1 à P5
| Proposition | A | B | Dépendances et risque résiduel |
|---|---|---|---|
| P1 second DC/DNS Bordeaux | différé | SRV-T + LIC-WS inclus | B03 PENDING, réplication et DNS client à approuver; aucun secours fichiers automatique |
| P2 CARP | différé | deuxième PF-M inclus | VIP .1 et IP physiques à arbitrer; switch et WAN toujours SPOF |
| P3 4G et UPS | UPS inclus, 4G différée | UPS + 4G inclus | couverture 4G, bascule, autonomie et NAT/VPN non testés |
| P4 3-2-1 et PRA | NAS + SAV-C proposés | idem | troisième copie et diversité supports à démontrer; restauration et protection ransomware non garanties |
| P5 DHCP Bordeaux local | PROPOSED, aucun coût distinct si équipement existant | PROPOSED, aucun coût distinct | B03 PENDING; implémentation/résilience non vérifiées |

## Recommandation soumise à MAIN
**Proposer A comme socle financier initial**, et prioriser la preuve de restauration + sauvegarde externe sécurisée, UPS et contrôle des accès. B demeure une option de résilience financièrement envisageable sur les seules lignes du catalogue, mais son intérêt doit être validé contre le coût réel et les risques dominants. En cas de dépendance critique à l'Internet Lyon, étudier 4G avant CARP; cela exige arbitrage MAIN, pas une adoption silencieuse. Le scénario A a un point unique de défaillance serveur/fichiers; B maintient ce risque. Aucune garantie RTO ≤4 h / RPO ≤24 h n'est démontrée: 1,2 To, débits, points sains, restauration ACL et temps humain non testés. Tests R05/R06 obligatoires avant conclusion.

## Gouvernance
D01–D12, A01–A05, B01/B02 inchangés. V01, B03, CAP01, NF03/R13 PENDING; exceptions E05 non approuvées; E07-P1..P5 PROPOSED. Aucun nouveau VLAN, adresse, VM, service ni règle. **E08 = PARTIAL jusqu'à validation MAIN et contrôles manquants.**
