# E07 — Services, résilience et évolutivité

Projet : MAIN PROGRESSION | Mode SOLO | Référentiel : v1.7.0 (E06) | Statut : PROPOSED (revue MAIN requise).

## Sources et statut
TP01 étape 7 p.7, annexe A p.16–17, annexe B p.17–18 ; support p.12–13 ; E03 cahier, E04 plan, E05 politique et matrice 51 flux, E06 dessin et handoff ; E06 MAIN_STATE et DECISIONS v1.7.0.

SOURCE-REQUIRED = prescrit par le TP. PROJECT-DECIDED = approuvé par MAIN. PROPOSED = architecture seulement, non déployée, non chiffrée ni approuvée. LAB LYON ≠ ARCHITECTURE CIBLE Lyon/Bordeaux/Nantes.

## A. Tableau des services : exactement sept catégories

| Service | Rôle | Hébergement | Ports | Redondance | Sauvegarde | Supervision |
|---|---|---|---|---|---|---|
| DHCP | Baux par VLAN (SOURCE-REQUIRED Lyon ; pools Bordeaux B01/B02 PROJECT-DECIDED). | LAB : pfSense FW-LYON, pools E04. CIBLE Bordeaux : DHCP local sur passerelle proposé, B03 PENDING ; alternative Windows + relais DHCP étudiée mais non retenue en LAB. | UDP 67/68 | PROPOSED : continuité firewall/DHCP ; synchronisation et cohérence des baux à valider, pas de HA en lab. | PROPOSED : export chiffré configuration, étendues et réservations, procédure de reprise. | PROPOSED : disponibilité, échecs baux, saturation plages, alerte Zabbix. |
| DNS | Résolution ad.valcrea.fr, Internet, invités isolés (SOURCE-REQUIRED). | LAB : SRV-AD01 10.10.10.10 ; invités Lyon pfSense 10.10.40.1. B01 PROJECT-DECIDED : Bordeaux utilisateurs DNS cible 10.10.10.10 via tunnel ; B02 : invités résolveur local 10.20.40.1. | TCP/UDP 53 | PROPOSED : second DNS AD Bordeaux et secours local ; B03 non décidé, B01 inchangé. | PROPOSED : System State AD/DNS, configurations et tests de restauration. | PROPOSED : sondes de résolution/délai/échec. |
| Active Directory | Authentification, identités, annuaire, GPO/AGDLP (SOURCE-REQUIRED). | LAB : SRV-AD01 10.10.10.10 Windows Server 2025. CIBLE : DC complémentaire Bordeaux PROPOSED, aucun ajout GNS3. | DNS 53, Kerberos TCP/UDP 88/464, LDAP 389, LDAPS TCP 636, GC TCP 3268/3269, RPC TCP 135 et 49152–65535 conditionnels E05, NTP UDP 123. | PROPOSED : deux DC (un/site), réplication, DNS/GC ; failover dépend de connectivité et configuration. | PROPOSED : sauvegardes System State et scénario de restauration AD éprouvé. | PROPOSED : réplication, authentification, DNS, horloge, santé DC, logs. |
| Fichiers | Partages SMB, ACL NTFS/AGDLP, confidentialité RH et Production lecture Atelier (SOURCE-REQUIRED). | LAB : SRV-AD01 10.10.10.10. CIBLE : reprise de fichiers sur stockage/serveur de secours PROPOSED, non installé. | TCP 445 ; flux AD associés selon E05. | PROPOSED : réserve de stockage et procédures de restauration ; deux DC ne répliquent pas automatiquement les fichiers. | PROPOSED : versions quotidiennes minimum, copie locale et externe isolée, restaurations testées ; données historiques 1,2 To. | PROPOSED : SMB, capacité, disque, dernière sauvegarde valide et durée de reprise. |
| Supervision | Alertes de service et infrastructure (SOURCE-REQUIRED). | LAB : SRV-SUP01 10.10.10.20, Zabbix 7.0 LTS ; pfSense SNMP et SRV-AD01 Agent 2 ; proxy Bordeaux PROPOSED. | SNMP UDP 161, agent passif TCP 10050 ; actif TCP 10051 seulement si approuvé ; interface web TCP 80/443 sous filtre ADMIN. | PROPOSED : contrôle externe de disponibilité Zabbix et restauration rapide ; pas de cluster acquis. | PROPOSED : base Zabbix, configuration, historique, restauration testée. | PROPOSED : auto-contrôle, files d'attente, alertes et acquittements. |
| Accès distant | Nomades VPN et futur tunnel intersites sécurisé ; aucun RDP public (SOURCE-REQUIRED ; politique A04 PROJECT-DECIDED). | LAB : OpenVPN FW-LYON WAN, tunnel 10.10.90.0/24 ; V01 PENDING. CIBLE : IPsec Lyon–Bordeaux PROPOSED, pas de tunnel déployé. | OpenVPN UDP 1194 ; IPsec conditionnel UDP 500/4500 et ESP protocole IP 50, soumis à revue E05. | PROPOSED : failover 4G et/ou HA pare-feu ; reconnexions VPN non garanties transparentes. | PROPOSED : config VPN, certificats/PKI, procédures de révocation et récupération sécurisée. | PROPOSED : tunnel, sessions, certificats, échecs, perte et disponibilité. |
| Sauvegarde | Copies récupérables et PRA (stratégie 3-2-1 recommandée par TP, PROPOSED). | CIBLE PROPOSED : NAS local + copie hors site isolée ; aucun nouveau NAS ou VM en LAB E07. | Selon solution retenue : TCP 445 SMB ou HTTPS TCP 443 ; ports non approuvés. | PROPOSED : plusieurs emplacements et protection immuable/hors ligne contre ransomware ; sauvegarde ≠ HA. | PROPOSED : 3 copies, 2 types de supports, 1 hors site, versions chiffrées et test de restauration. | PROPOSED : succès/échecs, point restaurable ≤24 h, intégrité, rétention, capacité, alerte. |

Les ports mentionnés ne valent jamais approbation de règles : exceptions E05 F17/F18/F21/F23/F39/F42/F43 et liaisons supplémentaires restent PROPOSED/PENDING.

## B. Résilience / haute disponibilité : justification

- Deux DC dont un par site : recommandation pédagogique TP p.7 / Support p.12–13, PROPOSED. Protection AD/DNS sous condition de réplication, disponibilité de la liaison et de résolveurs utilisables ; aucun secours automatique SMB.
- Deux pare-feu CARP : repère pédagogique, PROPOSED. Trois adresses par réseau HA (deux physiques et une VIP). Conserver les passerelles approuvées terminant en .1 : dans le scénario CARP elles seraient des VIP ; les IP physiques seraient définies après vérification de disponibilité et décision MAIN. Ne pas inventer les adresses ni installer un deuxième FW GNS3.
- Lien 4G : recommandation pédagogique, PROPOSED. Secours d'accès SaaS/Internet sous réserve de couverture, routage, VPN, NAT et test de bascule.
- Onduleurs : recommandation pédagogique, PROPOSED. Continuité courte et arrêt propre ; autonomie à dimensionner.
- 3-2-1 : recommandation pédagogique, PROPOSED. Trois copies, deux supports différents, une copie hors site ; privilégier une copie protégée de ransomware. RAID 1 ≠ sauvegarde.
- PRA fichiers : objectif SOURCE-REQUIRED RTO 4 h (240 minutes) et RPO 24 h ; procédure PROPOSED et non testée. RTO = du déclenchement de l'indisponibilité au retour vérifié des partages et permissions ; RPO = ancienneté du dernier point sain réellement restaurable. Programmer au minimum des points de sauvegarde compatibles avec une fenêtre de 24 h, surveiller les échecs et tester intégrité/ACL. Une sauvegarde quotidienne non réussie ne satisfait pas le RPO.
- Recette E03 R05/R06 : panne simulée du stockage principal, sélection du dernier point sain, restauration échantillon représentatif puis volume complet si pertinent, tests comptes autorisés/interdits, chronométrage total ≤240 min et point restauré ≤24 h. 1,2 To historiques ; débits, temps de transfert, volume delta, disponibilité du matériel de reprise et fenêtre backup non mesurés. Une restauration intégrale hors site peut dépasser 4 h. Pas de conformité revendiquée avant essai.
- 99,9 % de disponibilité ≈ 8 h 46 min d'arrêt/an : repère du cours seulement, aucun SLA de 99,9 % décidé pour tous les services.

### Modes dégradés et SPOF
Panne DC Lyon : un DC Bordeaux répliqué pourrait préserver l'authentification, pas les fichiers SRV-AD01. Panne tunnel : B01 DNS Lyon risque de devenir indisponible ; B03 doit arbitrer DNS AD local, annonce client et DHCP Bordeaux sans changer silencieusement B01. Panne FW : CARP pourrait aider mais switch, stockage, WAN et courant restent SPOF. Perte totale Lyon/ransomware : sauvegarde externe nécessaire mais reprise en 4 h non prouvée.

## C. Évolutivité

- Nouvelle agence Nantes : 10.30.0.0/16 SOURCE-REQUIRED actuellement réservé/non routé ; à l'ouverture, créer des /24 par VLAN selon convention octet 3 = VLAN, passerelle .1, liaison chiffrée, routes ACL minimales, DHCP/DNS et surveillance après validation ; aucun routage nouveau maintenant.
- Nouveau service : analyse métiers/flux, VLAN distinct proposé dans le /16 correspondant, sous-réseau /24 et passerelle .1 après validation, extension de trunk et filtrage deny-by-default, supervision et tests ; aucune modification E04/E05/E06 en E07.
- +15 salariés sur 3 ans (48 → 63) : pools utilisateurs E04 Lyon/Bordeaux 100 baux chacun offrent une marge de principe, mais CAP01 (nombre de terminaux simultanés, invités) PENDING ; augmenter identités, droits groupes, CAL et capacité sans renumérotation approuvée.

## D. Compatibilité E03–E06

- E03 NF01/NF02 R05/R06 : objectifs repris PASS documentaire ; restauration NOT_TESTED.
- E03 NF04/R07 : croissance prise en compte PASS conceptuel ; terminaux CAP01 et licences NOT_TESTED.
- E03 C01/C02 : CAPEX ≤30 000 € HT, OPEX annuel ≤6 000 € HT conservés ; chiffrage E08 NOT_TESTED.
- E04/E06 : Lyon 10.10.0.0/16, Bordeaux 10.20.0.0/16, Nantes 10.30.0.0/16 réservé ; VLAN Lyon 10/20/30/40/50, parking 999, VPN 10.10.90.0/24 conservés PASS documentaire.
- B01/B02 PROJECT-DECIDED conservés ; B03 PENDING. Aucun changement passerelles, plages DHCP, DNS ou topologie.
- E05 politiques A01–A05 préservées : refus par défaut, invités isolés, atelier sans Internet, VPN sans ADMIN, pas de RDP WAN ; exceptions non approuvées NON TRANSFORMÉES en décisions.
- V01, B03, CAP01, NF03/R13 restent PENDING.

## E. Propositions MAIN et dépendances E08

E07-P1 DC/DNS Bordeaux ; E07-P2 CARP avec VIP .1 et IP physiques à définir ; E07-P3 4G et UPS ; E07-P4 sauvegarde 3-2-1 et PRA testé ; E07-P5 DHCP Bordeaux local. **Toutes PROPOSED.** MAIN décide ; aucune acquisition, changement fournisseur, VM, topologie ou règle.

E08 doit comparer scénario socle et scénario résilience renforcée, chiffrer via annexe B uniquement : pare-feu, serveurs/licences/CAL, NAS, UPS, 4G, fibres, copie externe, support, intégration, CAPEX/OPEX/TCO 5 ans. Documenter contraintes budget et risques de RTO/RPO résiduels sans inventer prix ni preuves.
