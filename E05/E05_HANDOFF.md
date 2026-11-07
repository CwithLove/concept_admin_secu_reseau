# E05_HANDOFF — VALCRÉA TP01

**Projet :** MAIN PROGRESSION | **Mode :** SOLO | **Référence :** v1.5.0  
**Statut proposé : PARTIAL** (matrice livrée, propositions techniques encore soumises à arbitrage). **E05 NON officiellement VALIDATED.**  
**Temps réel : UNKNOWN** ; cible pédagogique 20 min non imputée ; budget restant UNKNOWN.

## Livrables exacts
- `E05/E05_MATRICE_FLUX.csv` — UTF-8 BOM, séparateur point-virgule, 51 règles, 13 colonnes.
- `E05/E05_POLITIQUE_ACCES.md` — règles par zone, exceptions et tests futurs.
- `E05/E05_HANDOFF.md` — présent bilan.

## Bilan
- **38 ALLOW / 13 DENY** ; identifiants uniques F01–F51.
- Zones : Lyon VLAN 10/20/30/40/50, 999 ; VPN ; WAN ; Bordeaux VLAN 20/40 ; Nantes réserve.
- Classification : SOURCE-REQUIRED = principe/besoin explicitement prescrit ; PROJECT-DECIDED = B01/B02 approuvés ; PROPOSED = choix technique ou exception à arbitrer. Aucun port « usuel » n'est prétendu obligatoire simplement parce qu'il figure dans l'aide TP.
- **PASS documentaire :** couverture des zones, justifications ALLOW, default deny, pas ANY→ANY ALLOW, blocages invités/atelier/VPN/RDP, Bordeaux cible, exigences E03 tracées, structure CSV et BOM.
- **NOT_TESTED :** efficacité du filtrage, GNS3, pfSense, OVS, AD, NTFS, OpenVPN, intersites, Zabbix et scans E17.
- **FAIL :** aucun échec documentaire identifié ; exceptions proposées non approuvées ≠ tests PASS.

## Arbitrages à MAIN PROGRESSION
- Valider ou réduire les flux PROPOSED : RPC AD 135/49152–65535, RDP interne ADMIN, SSH/HTTPS équipements inventoriés, sorties mises à jour, agent Zabbix actif ; confirmer restrictions DNS/AD/SMB Bordeaux.
- Conserver **PENDING** : V01, B03, CAP01, NF03/R13. Ne pas étendre les autorisations en attendant.
- Point de vigilance : le Support p.11 résume ADMIN « toutes zones » et VPN « comme utilisateurs » ; la politique détaillée applique le moindre privilège et l'accès VPN restreint exigé par TP p.12.
- Pas de modification d'E01–E04 ni de MAIN_STATE/DECISIONS. Aucune configuration technique exécutée.

## Dépendances
- **E06 :** dessiner Lyon/Bordeaux/VPN et principaux flux ; indiquer Bordeaux cible.
- **E09 :** conserver trunk 10/20/30/40/50 et parking 999 ; aucune règle E05 à configurer sur OVS.
- **E10 :** créer interfaces/DHCP/DNS Lyon selon E04 ; préserver accès ADMIN ; règles de sécurité finales en E13.
- **E13 :** convertir ALLOW/DENY approuvés en règles ordonnées, alias, journalisation ; supprimer TEMPORAIRE SERVEURS, vérifier anti-lockout. E17 apportera les preuves.

## Patches proposés — NON APPLIQUÉS
- **MAIN_STATE :** E05 → PARTIAL (proposé), temps UNKNOWN, référencer les trois fichiers et les arbitrages E13.
- **DECISIONS :** garder D01–D12, B01/B02 inchangés ; inscrire les exceptions techniques comme PROPOSED sans les verrouiller ; V01/B03/CAP01/NF03 restent PENDING.
