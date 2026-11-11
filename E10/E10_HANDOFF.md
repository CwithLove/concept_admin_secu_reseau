# E10_HANDOFF — VALCRÉA TP01

**Date du constat :** 2026-11-11  
**Étape officielle :** E10 — Configurer pfSense : interfaces VLAN, routage, DHCP et DNS (TP01 p.9).  
**Mode :** SOLO · **Référentiel canonique :** MAIN PROGRESSION v1.10.0 (E09).  
**Statut proposé :** **PARTIAL** — interfaces et passerelles configurées, WAN bloqué, DHCP/DNS et recette incomplets. **Non VALIDATED.**  
**Temps actif réel :** UNKNOWN — aucun chronométrage fiable ; ne pas substituer la durée pédagogique de 45 min.  
**Décision utilisateur :** suspendre le dépannage E10 et poursuivre E11 en mode **PREP documentaire uniquement**, sans déploiement technique avant résolution ou réévaluation des prérequis.

## 1. Réalisé et vérifié

| Action | État | Preuve / limite |
|---|---|---|
| Contrôle SW-LYON OVS : trunk eth0 VLAN 10,20,30,40,50 ; access eth1–eth6 = 10,10,30,20,40,50 ; parking eth7–eth15 VLAN 999 | PASS au moment de la commande | Sortie OVS fournie en conversation ; persistance après redémarrage **NOT_TESTED** |
| Sauvegarde interne de la config pfSense avant E10 | PASS limité | Fichier `/root/config-E10-before.xml` (env. 12 KiB), SHA-256 comparé à `/cf/conf/config.xml` à l'instant du contrôle ; restauration et export hors VM **NOT_TESTED** |
| Interfaces VLAN pfSense : WAN vtnet0, LAN vtnet1.30, OPT1 vtnet1.10, OPT2 vtnet1.20, OPT3 vtnet1.40, OPT4 vtnet1.50 | PASS pour l'affectation console | Affichage console pfSense ; activation effective, trafic par VLAN et persistance **NOT_TESTED** |
| Passerelles LAN/OPT : VLAN 30 10.10.30.1/24 ; VLAN 10 10.10.10.1/24 ; VLAN 20 10.10.20.1/24 ; VLAN 40 10.10.40.1/24 ; VLAN 50 10.10.50.1/24 | PASS pour la configuration et la table des routes connectées | Console et `netstat -rn -f inet` ; aucun test client vers les passerelles |
| DHCP ADMIN (VLAN 30), pool 10.10.30.100–10.10.30.149 | PARTIAL | Saisie et activation via console signalées ; aucun bail client ni DNS DHCP vérifié |
| WAN pfSense configuré pour DHCP sur vtnet0 | PARTIAL / FAIL de résultat | `config.xml` : `<ipaddr>dhcp</ipaddr>` ; vtnet0 UP/active et requêtes DHCP vues ; pas de bail IPv4 NAT |
| DHCP OPT1/OPT2/OPT3/OPT4 | TODO | DHCP refusé durant la saisie console initiale ; configuration WebGUI à effectuer |
| Réservation SRV-SUP01 MAC → 10.10.10.20 | TODO | MAC à relever ; réservation absente/non attestée |
| DNS Resolver et override ad.valcrea.fr → 10.10.10.10 | TODO | Pas de configuration ni de test attesté |
| Tests clients DHCP/DNS/inter-VLAN/Internet | NOT_TESTED / BLOCKED | Pas de validation de fonctionnement ; politiques finales pare-feu réservées à E13 |

**Adresses imposées conservées :** VLAN 10 SERVEURS 10.10.10.0/24 (DHCP .200–.220, DNS 10.10.10.10), VLAN 20 UTILISATEURS (DHCP .100–.199, DNS 10.10.10.10), VLAN 30 ADMIN (DHCP .100–.149, DNS 10.10.10.10), VLAN 40 INVITES (DHCP .100–.199, DNS 10.10.40.1), VLAN 50 ATELIER (DHCP .100–.149, DNS 10.10.10.10). VLAN 999 non routé. Référence E04.

## 2. Incidents ouverts

### INC-E10-01 — Pas de DHCP WAN / pas de route par défaut — BLOCKED

- Attendu : réseau NAT libvirt `192.168.122.0/24`, passerelle `192.168.122.1`, bail `192.168.122.x` pour FW-LYON.
- Observé : interface `vtnet0` `UP/RUNNING/LOWER_UP`, mais pas de bail DHCP ; adresse IPv4 link-local `169.254.240.20` observée ultérieurement ; `netstat -rn -f inet` sans route par défaut WAN.
- Sur pfSense : trames BOOTP/DHCP Request depuis MAC `0c:db:c8:91:00:00` observées sur `vtnet0` ; client `dhcpcd` actif. `dhcpcd -4 -T vtnet0` a indiqué « soliciting a DHCP lease » puis IPv4LL ; l'option `-T` correspond au test, **ne prouve pas une attribution DHCP**.
- WSL2 : `virbr0` UP avec `192.168.122.1/24` ; libvirt network default active/autostart, plage `192.168.122.2–254` ; `dnsmasq` PID 488 écoute UDP 67 sur `virbr0` ; `virsh net-dhcp-leases default` sans entrée.
- Captures `tcpdump` sur `gns3tap0-0` et `virbr0` : 0 paquet DHCP dans les fenêtres examinées. **Limite :** émission pfSense et captures WSL2 pas rigoureusement synchronisées ; ne pas déclarer la perte de paquets définitivement prouvée.
- Hypothèses : problème de transfert L2/NAT2–Dynamips–libvirt ; défaut de traitement DHCP ; problème de réponse retour. Aucune cause racine confirmée.

### INC-E10-02 — Timeout création lien GNS3 et capture WAN — OPEN

- La création d'un lien VPCS de test vers `SW-INTERNET Ethernet3` échoue après 120 s. VPCS/PC1 et NAT2 sont localisés sur le compute WSL2-GNS3 :3081.
- Trace GNS3 Windows : `ComputeError: Timeout error for POST call to http://127.0.0.1:3081/v2/compute/projects/0781031e-59c8-4642-966a-2f2a0bbc49c0/ethernet_switch/nodes/ee664115-c0c7-4822-9bd7-3686ee988cae/adapters/0/ports/3/nio after 120s`. API `POST /links` renvoie 409. Ce diagnostic prouve le **point de blocage de l'opération de création de lien**, pas la cause du défaut DHCP.
- Log Dynamips du projet WSL2 : `ethsw create SW-INTERNET` et configuration initiale des NIO UDP avec `set_access_port ... 1` enregistrés. Le 11/11 à 00:27:51 : `nio create_udp udp-956ab286... 20027 127.0.0.1 20026` et `ethsw add_nio SW-INTERNET ...` enregistrés ; pas de `set_access_port` ultérieur dans l'extrait fourni. **Ne pas interpréter une absence de log comme preuve formelle de blocage d'une commande particulière.**
- `ps` : Dynamips PID 922 `Sl+`, contrôleur `127.0.0.1:34993`. Capture WAN `FW-LYON_Ethernet0_to_SW-INTERNET_Ethernet1.pcap` initialisée côté Dynamips ; l'utilisateur n'a pas pu utiliser « Stop capture » via GUI. Son état final reste **UNKNOWN**.
- Vérifications de disponibilité : WSL2 RAM 7.6 GiB, disponible 5.8 GiB, swap 0 ; faible load average ; API WSL2 :3081 `/v2/version` HTTP 200 en ~0.009 s ; server principal Windows :3080 retourne 401 (authentification requise, non une panne). Le timeout reste circonscrit à une opération GNS3, pas à toute l'API.

Voir `E10_INCIDENTS_ET_REPRISE.md` pour la démarche de résolution différée.

## 3. Pièces justificatives et traçabilité

**Communiquées dans la conversation :** captures console pfSense (assignation VLAN/IP, `ifconfig vtnet0`, processus `dhcpcd`, DHCP Request), configuration SW-INTERNET VLAN 1 access, informations NAT2/VPCS, Task Manager Windows, extraits WSL2 et logs Windows/Dynamips. **Archivage des fichiers image dans le repository : NOT_VERIFIED** ; ne pas supposer qu'ils sont présents dans `E10/`.

**Chemins locaux rapportés, non transférés ici :**
- Windows : `C:\Users\chuho\AppData\Roaming\GNS3\2.2\gns3_server.log`, `gns3_gui.log`.
- WSL2 : `/home/cwithlove/GNS3/projects/0781031e-59c8-4642-966a-2f2a0bbc49c0/project-files/dynamips/dynamips_i1_log.txt`.
- Capture : sous `.../project-files/captures/FW-LYON_Ethernet0_to_SW-INTERNET_Ethernet1.pcap` (création indiquée au log, contenu non relu).
- Sauvegarde interne pfSense : `/root/config-E10-before.xml` ; export externe et restauration NOT_TESTED.

Aucun fichier QCOW2, config.xml confidentiel, secret, mot de passe ou capture brute n'est téléversé avec ce handoff.

## 4. Décision de session et prochaines étapes

**PROJECT-DECIDED au niveau de la session (soumis à MAIN PROGRESSION pour consolidation) :**
1. **ARRÊT du diagnostic E10**, pour limiter le temps supplémentaire consommé. Ne pas répéter les commandes exploratoires sans test discriminant.
2. **Passage à E11-PREP**, documentation uniquement : plan AD DS/DNS, scripts non exécutés, checklist et prérequis.
3. **AUCUNE validation fictive** : E10 PARTIAL ; E11 technique NOT_STARTED ; aucun DHCP/DNS/inter-VLAN/Internet déclaré fonctionnel.
4. Préserver VLAN/IP imposés, topologie officielle et documents canoniques. Le VPCS de diagnostic est temporaire, sans droit de devenir un nœud permanent du sujet.
5. Une reprise technique ultérieure est obligatoire avant de valider E10 et avant d'affirmer SRV-AD01/domain/DNS opérationnels.

**Pour reprise E10** : vérifier état/backup du projet et du pare-feu ; inspecter côté compute l'état NIO/UDP du SW-INTERNET et les captures encore actives ; envisager redémarrage contrôlé **après sauvegarde et validation utilisateur**, sans kill brut ; reproduire un test DHCP simultané aux deux extrémités ou un client VPCS sur le LAN NAT, puis corriger selon résultat. Finaliser ensuite DHCP et DNS WebGUI, réservation, tests et preuves. Les règles de sécurité durables restent du ressort d'E13.

## 5. Gouvernance

Ce handoff **n'édite pas** les fichiers `MAIN_STATE.md` et `DECISIONS.md`. Il constitue une proposition de mise à jour du tracker canonique après revue MAIN PROGRESSION. Aucun temps de travail réel n'a été inventé. Les états PASS sont strictement limités aux résultats observés.
