# E10 — Incidents, hypothèses et plan de reprise différée

**Date :** 2026-11-11 · **Statut :** OPEN / investigation suspendue sur décision de l'utilisateur.  
**Périmètre :** lab GNS3 `VALCREA-LAB`, Windows 11 + GNS3 2.2.61 (contrôleur :3080), WSL2-GNS3 2.2.61 (compute :3081), pfSense CE 2.9.0, switch Dynamips SW-INTERNET, NAT2/libvirt.  
**Objectif :** permettre une reprise efficace sans répéter la longue série de tests déjà effectués.

## A. INC-E10-01 — WAN DHCP non fonctionnel

**Symptôme :** aucune adresse `192.168.122.x` sur `vtnet0`, pas de route par défaut ; IPv4LL `169.254.240.20` observée.

**Constats solides :**
- Configuration pfSense WAN DHCP vérifiée dans `/cf/conf/config.xml`.
- `vtnet0` actif/UP ; `dhcpcd` démarré, gestionnaire et BPF BOOTP sur `vtnet0`.
- DHCP Request observés par `tcpdump` directement sur `vtnet0`, MAC `0c:db:c8:91:00:00`; pas d'Offer dans cet échantillon.
- libvirt default active + autostart ; `virbr0` = `192.168.122.1/24`, TAP `gns3tap0-0` attaché au bridge (état `forwarding` observé) ; `dnsmasq` écoute `0.0.0.0%virbr0:67`, sans bail listé.
- Capture pfSense et captures `gns3tap0-0`/`virbr0` **non garanties simultanées**, donc elles ne localisent pas formellement la perte.

**Hypothèses (non validées) :** défaillance L2 entre SW-INTERNET/NAT2 et TAP/libvirt ; défaut de traitement/diffusion DHCP par NAT2 ; retour DHCP absent ou non accepté par pfSense.

**Test de reprise à forte valeur :** après sécurisation et remise en état de la fonction de création de liens (INC-E10-02), raccorder temporairement un VPCS au VLAN 1 de SW-INTERNET et exécuter `ip dhcp` ; surveiller simultanément sur `virbr0` et `vtnet0` lors d'une sollicitation. En cas de bail VPCS mais non pfSense, investiguer chemin/client pfSense ; sinon investiguer GNS3 NAT/libvirt. Ne pas supposer que le VPCS déjà créé a été câblé : création du lien a échoué.

**Critères de clôture :** `vtnet0` reçoit `192.168.122.x/24`, route par défaut `192.168.122.1`, ping amont réussi puis connectivité externe testée séparément ; preuve datée.

## B. INC-E10-02 — POST NIO Ethernet switch timeout

**Symptôme :** nouvelle liaison `PC1 e0 ↔ SW-INTERNET e3` refusée, `POST /links` retourne 409 après un timeout de 120 s.

**Éléments probants :**
- Trace Windows controller : POST sur WSL2 `/ethernet_switch/nodes/ee664115-c0c7-4822-9bd7-3686ee988cae/adapters/0/ports/3/nio` timeout 120 s.
- API des deux serveurs répondent (WSL2 HTTP 200, Windows 401 sans credentials). WSL2 mémoire disponible 5.8 GiB, swap inutilisé, faible charge.
- Dynamips PID 922 présent, contrôleur :34993 ; journal du projet WSL2 avec `nio create_udp` et `ethsw add_nio` pour la tentative e3 ; absence de confirmation `set_access_port` dans les 80 dernières lignes consultées.
- Un filtre de capture avait été installé sur le NIO du lien WAN ; la commande GUI Stop Capture n'a pas pu être effectuée. Aucune preuve que ce filtre a causé le timeout.
- Emplacements des journaux : `C:\Users\chuho\AppData\Roaming\GNS3\2.2\gns3_server.log` et `/home/cwithlove/GNS3/projects/0781031e-59c8-4642-966a-2f2a0bbc49c0/project-files/dynamips/dynamips_i1_log.txt`.

**Hypothèses (non validées) :** commande NIO bloquée, incohérence d'état Dynamips↔compute, capture toujours attachée, défaut de transport/traitement UDP ; connexion à départager par tests ciblés.

**Remise en état envisagée, PAS ENCORE AUTORISÉE :**
1. Relever les nœuds actifs, les captures et les ports ; préserver la config pfSense/OVS et faire une sauvegarde externe récupérable (global snapshot E09 avait échoué).
2. Contrôler l'état de l'application GNS3 et des NIO UDP sur le compute, ainsi que la validité des liens existants ; identifier les processus bloquants plutôt que redémarrer aveuglément.
3. Si nécessaire seulement : redémarrage contrôlé des composants GNS3/Dynamips avec accord explicite du responsable et vérification de la persistance du lab ; **pas de `kill -9`, suppression de disque, modification de VLAN ni `wsl --shutdown` par défaut**.
4. Retenter une seule liaison temporaire, valider dans le compute et les logs, puis la retirer après le test ; ne pas ajouter définitivement un VPCS au périmètre TP.

**Critère de clôture :** création et suppression d'une liaison temporaire sans timeout ; trames fonctionnelles de bout en bout ; validation de non-régression des liens et ports officiels.

## C. Décision opérationnelle / dépendances

- **E10 : PARTIAL / WAN BLOCKED**, non éligible à VALIDATED à ce stade.
- **Stopper le dépannage pour l'instant** (décision utilisateur explicite) ; conserver toutes les anomalies et leurs preuves.
- **E11-PREP : AUTORISÉ, documentaire uniquement**, sans mise en production, sans promotion AD réelle et sans prétendre DNS fonctionnel.
- **E11-DEPLOY : DIFFÉRÉ** tant que l'état réseau, les sauvegardes et les prérequis de l'annuaire ne sont pas suffisamment vérifiés.
- Ne pas effacer ni réécrire les décisions antérieures, ne pas confondre absence de test et échec, ni problèmes GNS3 et pfSense dont le lien causal reste inconnu.
- Revue requise par **MAIN PROGRESSION** avant toute modification de `MAIN_STATE.md` / `DECISIONS.md`.

## D. Checklist de reprise (à effectuer plus tard, pas maintenant)

- [ ] Geler la configuration, exporter une sauvegarde pfSense et vérifier les sauvegardes GNS3/OVS.
- [ ] Résoudre/contourner proprement l'incident NIO sans changement permanent non approuvé.
- [ ] Reproduire un test DHCP discriminant et **simultané**, déterminer où l'échange s'interrompt.
- [ ] Obtenir bail WAN IPv4 + passerelle + test d'accès externe.
- [ ] Vérifier persistance OVS après redémarrage.
- [ ] Terminer DHCP 5 VLAN, réservation SUP01 et paramètres DNS selon E04.
- [ ] Valider les tests clients VLAN et les règles provisoires strictement nécessaires, sans anticiper la matrice E13.
- [ ] Collecter captures et temps réellement mesuré ; soumettre E10 à MAIN PROGRESSION.
