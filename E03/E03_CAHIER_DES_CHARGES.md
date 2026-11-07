# VALCRÉA — Cahier des charges fonctionnel et technique

**TP01 — Étape E03 | MAIN PROGRESSION | Mode SOLO**  
**Référentiel :** E02/MAIN_STATE.md et E02/DECISIONS.md v1.3.0  
**Statut documentaire proposé :** VALIDATED, sous acceptation de MAIN PROGRESSION.

**Sources :** TP01 Étape 3 p.5–6, Annexe A p.16–17 ; Support de Formation p.7–8 ; audit et handoff E02 validés. Les tests de recette sont définis, non exécutés.

**Légende :** **FAIT** = constat de source ; **RISQUE** = conséquence possible issue de l'audit ; **EXIGENCE** = résultat attendu vérifiable ; **SOLUTION PROPOSÉE** = option non approuvée. Priorité P1 impératif, P2 important.

## 1. Contexte et périmètre

**FAITS.** Valcréa est une PME de mobilier de bureau éco-conçu : 48 salariés (38 à Lyon, 6 à Bordeaux, 4 itinérants), CA 7,2 M€. Télétravail administratif/études deux jours par semaine, ERP SaaS, messagerie en ligne, fichiers CAO de 200 à 500 Mo. L'existant comprend environ 70 équipements sur un réseau à plat `192.168.1.0/24`, un serveur SRV01 Windows Server 2012 R2 cumulant des rôles critiques, RDP TCP 3389 publié vers Internet, sauvegardes locales sans restauration éprouvée, Wi-Fi visiteurs non isolé et comptes d'anciens salariés actifs. Un incident de chiffrement partiel a causé deux jours de travail perdus.

**RISQUES issus d'E02.** RDP public critique (T01), compromission latérale, fuite des données de paie, indisponibilité des fichiers et défaut de traçabilité. L'audit E02 validé compte 20 constats (12 techniques et 8 organisationnels) ; le présent cahier ne prétend pas que des tests techniques ont été exécutés.

**Périmètre.** Lyon, Bordeaux, accès nomades, identités, droits, fichiers, continuité, supervision, accès SaaS et exploitation. Le site B2B hébergé et les applications SaaS sont des dépendances d'accès ; leur réhébergement est hors périmètre. La conception détaillée, le choix des équipements, la matrice de flux et le chiffrage relèvent d'E04–E08.

## 2. Besoins fonctionnels

Chaque ligne exprime un besoin métier et une **EXIGENCE** assortie d'un critère vérifiable, d'une méthode et d'une priorité.

| ID | Besoin / EXIGENCE | Critère de recette | Vérification | Priorité |
|---|---|---|---|---|
| F01 | Accès aux fichiers Lyon/Bordeaux | Compte autorisé lit le fichier témoin ; non autorisé refusé | Test SMB et droits | P1 |
| F02 | Accès distant sécurisé | VPN autorisé fonctionnel ; aucun TCP 3389 exposé depuis Internet | Connexion VPN et scan WAN | P1 |
| F03 | Wi-Fi invités isolé | Web externe accessible ; aucun port serveur interne joignable | HTTPS et Nmap depuis INVITES | P1 |
| F04 | Atelier Windows 10 sans Internet | Lecture de programme autorisée ; aucune sortie Internet | Test fichier et filtrage | P1 |
| F05 | Transfert CAO vers production | Fichier programme transmis et lu ; écriture non autorisée refusée | Essai métier et ACL | P2 |
| F06 | Confidentialité RH et droits métier | Direction/comptabilité lisent paie ; autres refusés ; atelier lecture seule | Tests par rôles | P1 |
| F07 | Cycle de vie des comptes | Trois comptes d'anciens salariés désactivés ; aucun admin partagé | Revue d'annuaire | P1 |
| F08 | ERP et messagerie SaaS | HTTPS accessible aux postes autorisés | Essai applicatif | P2 |
| F09 | Supervision | Panne simulée détectée puis retour à la normale | Historique d'alertes | P2 |

## 3. Besoins non fonctionnels

| ID | Besoin / EXIGENCE | Critère de recette | Vérification | Priorité |
|---|---|---|---|---|
| NF01 | Continuité fichiers — RTO | Restauration représentative en ≤ 4 h (240 min) | Exercice chronométré | P1 |
| NF02 | Continuité fichiers — RPO | Point de restauration datant de ≤ 24 h | Contrôle horodatages et restauration | P1 |
| NF03 | CAO 200–500 Mo | Transfert 500 Mo réussi et intégrité identique ; seuil temporel métier à confirmer | Chronométrage et empreinte | P2 |
| NF04 | Croissance +15 salariés sur trois ans | Capacité documentée pour 63 salariés, sans renumérotation | Dimensionnement et licences | P1 |
| NF05 | Refus par défaut et moindre privilège | Flux métier autorisé fonctionne ; flux non autorisé bloqué et journalisé | Matrice et tests réseau | P1 |
| NF06 | Exploitation à temps partiel | Procédure exécutable par opérateur pour compte/sauvegarde/alerte | Essai guidé | P2 |
| NF07 | Continuité accès en ligne | Scénario de coupure Internet et responsabilité documentés | Revue de continuité | P2 |

**Point ouvert NF03 :** le TP fournit la taille des fichiers CAO, pas un délai maximal de transfert. Ne pas inventer de débit ni de seuil temporel : fixer ce seuil avec le métier avant recette.

## 4. Contraintes : budget, réglementation, accessibilité et Green IT

| ID | Contrainte / EXIGENCE | Critère de recette | Vérification | Priorité |
|---|---|---|---|---|
| C01 | Investissement | CAPEX ≤ 30 000 € HT | Revue du chiffrage E08 | P1 |
| C02 | Fonctionnement | OPEX ≤ 6 000 € HT/an | Revue du chiffrage E08 | P1 |
| C03 | RGPD | Registre, sécurité, procédure violation et droits RH documentés | Revue RGPD et tests de droits | P1 |
| C04 | Exigences clients et ANSSI | Dossier de mesures et écarts documenté | Revue documentaire | P2 |
| C05 | Accessibilité | Parcours essentiel réalisable avec lecteur d'écran | Essai utilisateur | P1 |
| C06 | Green IT et REEN | Dimensionnement et consommation justifiés | Revue énergétique | P2 |
| C07 | Exploitation limitée | Responsabilités et procédures disponibles | Revue opérationnelle | P2 |
| C08 | Contraintes SOURCE-REQUIRED | Aucune adresse/VLAN/domaine imposé modifié | Comparaison TP et DECISIONS | P1 |

**Réglementation selon le TP :** RGPD articles 30, 32 et 33 ; recommandations CNIL sur mots de passe et journalisation (repère pédagogique de conservation de 6 mois à 1 an à adapter) ; hygiène ANSSI ; loi REEN ; RGAA en référence à une collaboratrice malvoyante utilisant un lecteur d'écran. Valcréa est présentée **hors champ NIS2**, mais certains clients y sont soumis : distinguer obligations directes et exigences contractuelles. L'applicabilité juridique exacte de REEN/RGAA à la PME n'est pas affirmée.

**Paramètres SOURCE-REQUIRED, non modifiables en E03 :** Lyon `10.10.0.0/16`, Bordeaux `10.20.0.0/16`, réserve Nantes `10.30.0.0/16` ; troisième octet = VLAN, passerelle `.1` ; VLAN 10 SERVEURS `10.10.10.0/24`, 20 UTILISATEURS `10.10.20.0/24`, 30 ADMIN `10.10.30.0/24`, 40 INVITES `10.10.40.0/24`, 50 ATELIER `10.10.50.0/24`, 999 PARKING non routé ; VPN `10.10.90.0/24` ; AD `ad.valcrea.fr`, NetBIOS `VALCREA`. Ces valeurs décrivent la cible prescrite, pas une configuration déjà réalisée.

## 5. Principes de conception et critères de recette

**Principes.** Défense en profondeur ; moindre privilège ; refus par défaut ; cloisonnement serveurs/utilisateurs/admin/invités/atelier ; administration nominative distincte ; sauvegardes restaurables ; exploitation simple pour un technicien à temps partiel ; évolutivité sans renumérotation.

### Registre des critères de recette mesurables

| ID | Exigence(s) | Seuil ou résultat mesurable | Preuve attendue |
|---|---|---|---|
| R01 | F02 | 0 port TCP 3389 exposé sur WAN et VPN autorisé opérationnel | Scan externe et essai VPN |
| R02 | F03 | 0 port serveur interne accessible depuis INVITES ; HTTPS Internet OK | Nmap et test web |
| R03 | F04 | 0 accès Internet depuis ATELIER ; lecture programme OK | Tests réseau et métier |
| R04 | F06 | 100 % des droits RH/production conformes aux rôles | Matrice et comptes tests |
| R05 | NF01 | Restauration des fichiers ≤ 240 minutes | PV horodaté |
| R06 | NF02 | Point restaurable ≤ 24 heures | Sauvegarde et restauration |
| R07 | NF04 | Capacité ≥ 63 salariés sans chevauchement | Tableau de dimensionnement |
| R08 | C01,C02 | CAPEX ≤ 30 000 € HT ; OPEX ≤ 6 000 € HT/an | Budget E08 |
| R09 | F07 | 0 des 3 comptes sortants actifs ; 0 admin partagé | Inventaire annuaire |
| R10 | F09 | 1 alerte panne et 1 retour normal visibles | Historique Zabbix |
| R11 | NF05 | Par zone testée, 1 flux autorisé OK et 1 interdit bloqué/loggé | Matrice, essais, logs |
| R12 | C05 | 1 parcours métier essentiel sans obstacle bloquant au lecteur d'écran | Compte rendu |
| R13 | NF03 | 500 Mo transférés, intégrité vérifiée, durée mesurée ; seuil de durée à confirmer | Chronomètre, empreinte |

**Limite méthodologique.** R13 définit un essai mesurable (taille, intégrité, durée), mais le seuil de performance métier reste à confirmer ; les douze autres critères disposent d'une condition d'acceptation explicite. Aucun test n'est déclaré PASS en E03, car leur exécution appartient aux étapes ultérieures.

### SOLUTIONS PROPOSÉES — non approuvées

- Accès distant via VPN chiffré ; OpenVPN UDP 1194 est prescrit par le TP pour le laboratoire, sans publication RDP.
- Séparation des zones et filtrage interzones selon la matrice à établir en E05 ; aucune règle n'est appliquée ici.
- Groupes de rôles, comptes nominatifs et droits NTFS/SMB à détailler lors des étapes AD.
- Sauvegarde hors site, restauration testée et supervision adaptée à la continuité, à justifier en E07/E08 et à mettre en œuvre ensuite.

**Frontière :** aucune recommandation d'E02 n'est convertie en choix d'architecture approuvé. Aucune action E04–E19 n'est réputée accomplie.
