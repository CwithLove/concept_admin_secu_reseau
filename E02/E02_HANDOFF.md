# E02_HANDOFF — VALCRÉA TP01

Projet : MAIN PROGRESSION · Session : E02 · Référentiel : MAIN_STATE / DECISIONS v1.2.0 (2026-11-06)
Statut proposé : VALIDATED (audit documentaire E02 ; sous réserve de l’acceptation par MAIN PROGRESSION).
Temps réellement passé : NON MESURÉ — aucune durée fiable de travail actif n’a été fournie ou enregistrée. La durée pédagogique de 35 minutes n’est pas déclarée comme temps passé. Le budget global consommé et restant demeure INCONNU, notamment parce que le temps E01 n’est pas renseigné.

## Périmètre et méthode

Audit sur dossier uniquement, à partir de l’annexe A du TP01, pages 16–17. L’étape 2 du TP01, page 5, définit les critères ; le Support de Formation, pages 4–6, sert uniquement à la méthode et au calibrage des gravités. Les thèmes ANSSI sont des rattachements thématiques, non des numéros de mesures certifiés ni des citations littérales du guide. Aucun scan, test, incident supplémentaire ou équipement nouveau n’est présumé. Les faits sont isolés des risques déduits et des recommandations proposées.

## Résultats et vérification

- 20 constats, dont 8 organisationnels et 12 techniques.
- PASS — Minimum 10 constats et 4 organisationnels atteint.
- PASS — Pour chaque ligne : domaine, fait issu de l’annexe A, risque, gravité dans l’échelle du TP, thème ANSSI et recommandation ; source paginée ajoutée.
- PASS — RDP de SRV01 publié sur Internet en TCP 3389, classé Critique (T01).
- PASS — Faits distincts des risques inférés et des corrections ; aucune configuration de GNS3 modifiée.
- PASS — Audit limité à l’existant, sans anticipation d’exécution des étapes E03–E19.
- NOT_TESTED — Validation technique sur infrastructure réelle : hors périmètre E02, audit documentaire.

## Synthèse prioritaire pour E03

1. Critique : RDP TCP 3389 directement publié vers SRV01 : risque de compromission depuis Internet.
2. Élevée : serveur unique ancien, absence d’onduleur, sauvegardes locales non externalisées et restauration non testée : risque de rupture d’activité ; l’annexe rapporte déjà deux jours de travail perdus après un chiffrement partiel du partage commun.
3. Élevée : réseau à plat, Wi-Fi visiteurs partagé, comptes d’anciens salariés actifs, administration partagée et accès général aux bulletins de paie : risques de propagation et de divulgation.

## Livrables créés — déclaration de la session E02

- `E02_AUDIT_VALCREA.csv` — grille UTF-8 avec BOM, séparateur ; (import Excel en environnement français).
- `E02_HANDOFF.md` — présent document.

**Note de réception MAIN PROGRESSION (07/11/2026) :** le fichier transmis et vérifié en pratique est `E02_AUDIT_VALCREA_COURT.xlsx` (version Excel courte, sans colonne source paginée), et non le CSV mentionné ci-dessus. Les six colonnes exigées par le TP01 sont présentes et E02 a été validée. Cette note distingue la déclaration de la session du fichier effectivement disponible.

## Difficultés / limites

- Aucun relevé de temps actif vérifiable ; ne pas imputer les 35 minutes indicatives du professeur.
- L’annexe A est un scénario fictif et ne fournit ni preuves de configuration ni résultats de scan ; les risques sont des conséquences possibles, pas des incidents démontrés.
- Les libellés ANSSI sont des thèmes de rapprochement, sans attribution arbitraire de numéros de mesures.
- E01 validée techniquement selon MAIN PROGRESSION ; captures E01 et temps E01 restent à régulariser, sans bloquer E02.

## Dépendances E03

- Utiliser l'audit effectivement disponible et ce handoff comme base factuelle pour rédiger les besoins et critères de recette.
- Relire les entretiens et contraintes de l’annexe A, sans confondre risques constatés et exigences futures.
- Ne pas modifier la topologie, les VLAN, les adresses, les choix ni les configurations en place.

## Propositions de mise à jour (NON APPLIQUÉES à ce handoff)

MAIN_STATE.md v1.2.0 : après revue, passer E02 de TODO à VALIDATED ; indiquer 20 constats / 8 organisationnels, les deux livrables, et Actual min = UNKNOWN ; désigner E03 comme prochaine session ; conserver E01 et son temps inconnu sans modification.

DECISIONS.md v1.2.0 : aucune nouvelle décision d’architecture, aucun changement de D01–D12 ni des paramètres SOURCE-REQUIRED. Proposer uniquement une note de traçabilité : « E02 audit documentaire achevé ; 20 constats dont 8 organisationnels ; RDP 3389 critique ; recommandations non approuvées comme architecture cible ». Validation exclusivement par MAIN PROGRESSION.

## Transmission

À transmettre à MAIN PROGRESSION : les deux fichiers ci-dessus. Statut E02 proposé : VALIDATED car les critères documentaires de l’étape 2 ont été contrôlés ; la validation canonique demeure à sa charge. Temps : NON MESURÉ, sans valeur inventée.

**Réception MAIN PROGRESSION :** E02 acceptée VALIDATED le 07/11/2026 ; référentiel actualisé à v1.3.0.