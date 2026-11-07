# E03_HANDOFF — VALCRÉA TP01

**Projet :** MAIN PROGRESSION  
**Session :** E03 — Rédiger le cahier des charges  
**Mode :** SOLO  
**Référentiel :** E02/MAIN_STATE.md et E02/DECISIONS.md v1.3.0  
**Statut proposé :** `VALIDATED` **sur critères documentaires E03**, en attente d'acceptation canonique par MAIN PROGRESSION.  
**Temps réellement passé :** `UNKNOWN` ; 30 min = durée pédagogique, non temps mesuré. Budget total 720 min ; consommé et restant `UNKNOWN`.

## 1. Sources et périmètre

TP01 Étape 3 p.5–6 et Annexe A p.16–17 ; Support p.7–8 ; fichiers E02 validés (`MAIN_STATE.md`, `DECISIONS.md`, `E02_AUDIT_VALCREA_COURT.xlsx`, `E02_HANDOFF.md`). Audit E02 : 20 constats, dont 8 organisationnels ; le rapprochement exhaustif de chaque ligne du XLSX n'est pas revendiqué. Les sources métier et le risque critique RDP sont repris sans extrapoler de résultats d'essais.

## 2. Livrables

- `E03_CAHIER_DES_CHARGES.md` : cinq rubriques TP01 ; **24 exigences** (F01–F09, NF01–NF07, C01–C08), chacune avec besoin, critère, vérification, priorité ; **13 critères de recette** R01–R13.
- `E03_HANDOFF.md` : vérification, limites, dépendances et proposition de statut.
- Distinction explicite FAIT / RISQUE / EXIGENCE / SOLUTION PROPOSÉE.

## 3. Vérification E03 selon TP01

| Contrôle officiel | Résultat | Preuve |
|---|---|---|
| Contexte et périmètre | PASS | Section 1 |
| Besoins fonctionnels | PASS | Section 2, F01–F09 |
| Besoins non fonctionnels | PASS | Section 3, NF01–NF07 |
| Contraintes budget/réglementation/accessibilité/green IT | PASS | Section 4, C01–C08 |
| Principes de conception | PASS | Section 5 |
| Au moins 6 critères mesurables | PASS | 13 critères R01–R13 ; R13 conserve le seuil métier à confirmer |
| Chaque exigence vérifiable et liée à un critère | PASS | Tableaux d'exigences, registre de recette et méthodes |
| Respect des valeurs prescrites | PASS documentaire | Sous-réseaux, VLAN, domaine, RTO/RPO, croissance et budgets inchangés |
| Tests techniques sur infrastructure | HORS PÉRIMÈTRE E03 | Critères futurs définis, non exécutés |
| Traçabilité exhaustive de chaque ligne du XLSX E02 | NON REVENDIQUÉE | Audit E02 déjà accepté ; synthèse et sources conservées |

**Conclusion :** les critères **officiels de l'Étape 3** sont satisfaits ; la revue exhaustive du classeur E02 et l'exécution future des tests ne constituent pas des conditions d'achèvement prescrites pour E03. Proposition : `VALIDATED` pour le livrable documentaire, sans affirmer une validation technique.

## 4. Limites et risques ouverts

- NF03/R13 : seuil maximal de durée de transfert CAO non fourni par l'annexe A ; à confirmer avec le métier avant la recette, sans valeur inventée.
- RTO ≤4 h, RPO ≤24 h, sécurité interzones et supervision sont des exigences de cible, pas des essais déjà réussis.
- Temps E01/E02/E03 non mesurés ; ne pas déduire les temps pédagogiques.
- Écarts E01 (WSL2, langue Windows, noms affichés, LAN temporaire) conservés dans le référentiel ; aucune modification effectuée.
- Validation canonique réservée à MAIN PROGRESSION.

## 5. Dépendances E04

Reprendre les exigences et valeurs SOURCE-REQUIRED à l'identique. E04 devra produire zones, dimensionnement, passerelles, DHCP et DNS ; ne pas considérer les solutions proposées E03 comme décisions validées.

## 6. Propositions de mise à jour — NON APPLIQUÉES

**MAIN_STATE.md :** après revue par MAIN PROGRESSION, inscrire E03 `VALIDATED` documentaire, deux livrables, 24 exigences, 13 critères, temps `UNKNOWN`. E04 ne devient ouvrable qu'après cette acceptation.

**DECISIONS.md :** aucune modification des décisions D01–D12 ou des contraintes SOURCE-REQUIRED ; enregistrer seulement la validation documentaire E03 et le seuil CAO en attente si MAIN PROGRESSION le juge utile.

## 7. Transmission

Transmettre **exactement** `E03_CAHIER_DES_CHARGES.md` et `E03_HANDOFF.md`. Ne pas modifier les quatre fichiers E02, `MAIN_STATE.md` ou `DECISIONS.md` dans cette session.
