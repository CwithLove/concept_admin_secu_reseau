# VALCRÉA TP01 — MAIN_STATE

> Version: 1.10.0  
> Baseline: 2026-11-09  
> Project: `VALCREA-TP01`  
> Authority: MAIN PROGRESSION  
> Execution: SOLO  
> Total working-time budget: **720 minutes (12h)**  
> State: **E01–E07 and E09 VALIDATED; E08 PARTIAL (E01 technical; E02–E05 documentary). E05 core access policy approved; technical exceptions remain PROPOSED/PENDING. E01 screenshot archival and E01–E09 actual times UNKNOWN**

## 1. How to use this file

This file is the **single consolidated progress snapshot**. It records what is **verified**, what is merely **planned**, elapsed time, open problems, and where the artifacts are. It is **not evidence** by itself.

At the start of an étape session, provide:
1. `MAIN_STATE.md` (latest accepted version).
2. `DECISIONS.md` (latest accepted version).
3. Relevant earlier `E##_HANDOFF.md` and needed input artifacts (see section 5).
4. The two course PDFs, if not already available in that session's Project Sources.

At the end, the étape session produces `E##_HANDOFF.md`, actual artifacts/evidence, and **proposed** changes to these two files. Bring them back to MAIN PROGRESSION for review and acceptance **before treating the changes as canonical**. Never overwrite a newer version with an older one. A local session may prepare updated files, but its changes remain **PROPOSED** until reviewed.

**Statuses**: `TODO` / `IN_PROGRESS` / `PARTIAL` / `BLOCKED` / `VALIDATED`. Only use `VALIDATED` when the verification criteria and evidence are present. `PARTIAL` is appropriate when work exists but one or more criteria remain unverified.

## 2. Scope and source hierarchy

- Primary requirements: `TP-01-projet-reseau-securise-valcrea.pdf`, 19 pages, Étapes 1–19 and Annexes A–C.
- Pedagogical reference: `Support de Formation - Conception d'un réseau sécurisé pour une PME.pdf`, 28 pages.
- Decisions and current configuration: `DECISIONS.md`, distinguishing `SOURCE-REQUIRED`, `PROJECT-DECIDED`, `OBSERVED`, and `PENDING`.
- User-approved execution: one independent session per étape, SOLO, 12h budget, no reduction of the official 19 steps **yet**.

The source TP defines **3 parties**; the course support defines **4 modules**. They are different classifications, not competing versions of the plan.

## 3. Budget ledger

| Metric | Minutes | Notes |
|---|---:|---|
| Initial budget | 720 | User-approved total |
| Verified elapsed time | Unknown | E01–E09 active minutes not measured; do not assume zero or substitute teacher minutes |
| Remaining tracked budget | Unknown (at most 720) | Cannot compute until actual E01–E09 active minutes are provided |
| Time contingency | Not assigned | Critical-path reduction still pending |

**Time logging rule:** Record actual active minutes per session, including troubleshooting and documentation. Do not invent estimates as spent time. Record installation/download waiting separately if overlapped with other work to avoid double counting. Every accepted handoff updates the ledger once (no duplicated time).

## 4. Master étape tracker

The following durations are **teacher-indicated times**, not validated SOLO estimates. The status is `TODO` as a tracking default; it does **not** assert nothing was previously attempted.

| ID | Partie | Official étape | TP pages | Support pages | Teacher time | Status | Actual min | Handoff / evidence |
|---|---|---|---|---|---:|---|---:|---|
| E01 | 1 | Lancer le socle du laboratoire en tâche de fond | 2–4 | 16–17 | 10 | VALIDATED | UNKNOWN | Original `E01_HANDOFF_VALCREA(1).md` plus user-supplied mapping check 10/10; screenshot archival NOT verified |
| E02 | 1 | Auditer l'existant | 5, Annexe A 16–17 | 4–6 | 35 | VALIDATED | UNKNOWN | User-pasted `E02_HANDOFF` (2026-11-07); inspected `E02_AUDIT_VALCREA_COURT(1).xlsx`: 20 findings, 8 organizational |
| E03 | 1 | Rédiger le cahier des charges | 5–6 | 7–8 | 30 | VALIDATED | UNKNOWN | `E03/E03_CAHIER_DES_CHARGES.md` and `E03/E03_HANDOFF.md`; five rubriques, 24 exigences and 13 critères de recette (R13 threshold open) |
| E04 | 1 | Concevoir la topologie logique et le plan d'adressage | 6 | 10–11 | 30 | VALIDATED | UNKNOWN | `E04/E04_PLAN_ADRESSAGE.csv`, `E04/E04_PLAN_ADRESSAGE.md`, `E04/E04_HANDOFF.md`; Bordeaux B01/B02 approved; documentary only |
| E05 | 1 | Définir la politique d'accès par une matrice de flux | 6 | 11, 19 | 20 | VALIDATED | UNKNOWN | `E05/E05_MATRICE_FLUX.csv`, `E05/E05_POLITIQUE_ACCES.md`, `E05/E05_HANDOFF.md`; 51 rows (38 ALLOW, 13 DENY); core policy APPROVED, technical exceptions PROPOSED/PENDING |
| E06 | 1 | Dessiner le schéma logique sous draw.io | 7 | 10–12 | 20 | VALIDATED | UNKNOWN | `E06/2-schema-logique.drawio` + `E06/E06_HANDOFF.md` on GitHub; chat-attached PNG 1292×862 inspected; PNG not pushed; opening in diagrams.net / exact PNG-source equivalence NOT_TESTED |
| E07 | 1 | Choisir les services et une architecture résiliente et évolutive | 7 | 12–13 | 20 | VALIDATED | UNKNOWN | `E07/E07_SERVICES_RESILIENCE.md`, `E07/E07_HANDOFF.md` on GitHub; 7 services with required columns, RTO/RPO risk analysis, conditional HA proposals; no real recovery/HA verification |
| E08 | 1 | Chiffrer le budget prévisionnel | 8, Annexe B 17–18 | 14, 22 | 30 | PARTIAL | UNKNOWN | GitHub `E08/E08_BUDGET.csv`, `E08/E08_BUDGET_ANALYSE.md`, `E08/E08_HANDOFF.md`: arithmetic and Annex B prices PASS; `1-conception.pdf` NOT PRODUCED; GNS3 snapshot NOT_TESTED |
| E09 | 2 | Configurer le commutateur : VLAN, trunk et ports inutilisés | 8–9 | 16–17 | 25 | VALIDATED | UNKNOWN | `E09/E09_HANDOFF.md`, `E09_OVS_COMMANDES.md`, `E09_OVS_VERIFICATIONS.txt`, `E09_OVS_SHOW_CAPTURE.png`: all 16 ports PASS (configuration only). Global snapshot PRE-E09 FAIL; targeted backup PASS (restore NOT_TESTED) |
| E10 | 2 | Configurer pfSense : interfaces VLAN, routage, DHCP et DNS | 9 | 11, 17 | 45 | TODO | — | — |
| E11 | 2 | Promouvoir SRV-AD01 contrôleur de domaine | 10 | 12, 18 | 30 | TODO | — | — |
| E12 | 2 | Organiser l'annuaire, les utilisateurs et les droits | 10–11 | 18 | 40 | TODO | — | — |
| E13 | 2 | Traduire la matrice de flux en règles de pare-feu | 11–12 | 19 | 45 | TODO | — | — |
| E14 | 3 | Ouvrir l'accès distant des nomades par OpenVPN | 12 | 20 | 35 | TODO | — | — |
| E15 | 3 | Appliquer les bonnes pratiques de sécurité | 13 | 21–22 | 30 | TODO | — | — |
| E16 | 3 | Superviser avec Zabbix | 13 | 24 | 35 | TODO | — | — |
| E17 | 3 | Scanner le réseau et auditer les vulnérabilités | 13–14 | 25 | 25 | TODO | — | — |
| E18 | 3 | Mener un test d'intrusion simple et corriger | 14–15 | 21, 25 | 25 | TODO | — | — |
| E19 | 3 | Documenter, rédiger la note de synthèse et déposer | 15, Annexe C 18–19 | 26, 28 | 30 | TODO | — | — |

**Important**: The teacher-indicated durations total **560 minutes (9h20)**, excluding validation/transitions. The official class allocation is three half-days, **630 minutes (10h30)**. Neither is a proven achievable SOLO plan.

## 5. Artifact registry and session input contract

| Session | Required earlier inputs (if available) | Expected outputs / evidence |
|---|---|---|
| E01 | Two source PDFs | `VALCREA-LAB` GNS3 project; topology/cabling screenshots; pfSense/Windows install status; `E01_HANDOFF.md` |
| E02 | E01 handoff if relevant; PDFs | Audit grid (CSV/XLSX or draft), `E02_HANDOFF.md` |
| E03 | E02 audit/handoff | `E03/E03_CAHIER_DES_CHARGES.md` (accepted) and `E03/E03_HANDOFF.md`; 24 exigences, 13 recette criteria |
| E04 | E03 cahier/handoff and both PDFs | `E04/E04_PLAN_ADRESSAGE.csv`, `E04/E04_PLAN_ADRESSAGE.md`, `E04/E04_HANDOFF.md`; Bordeaux B01/B02 approved |
| E05 | E03 cahier, E04 addressing and v1.5.0 canonical snapshot | `E05/E05_MATRICE_FLUX.csv`, `E05/E05_POLITIQUE_ACCES.md`, `E05/E05_HANDOFF.md`; core policy accepted, exceptional ALLOW rows not blanket-approved |
| E06 | Latest accepted E05 v1.6.0 state/decisions, E04 plan, E05 matrix/policy and E03 cahier | `E06/2-schema-logique.drawio`, `E06/E06_HANDOFF.md` on GitHub; `2-schema-logique(4).png` delivered in MAIN chat (not on GitHub). E06 design VALIDATED; implementation NOT_TESTED |
| E07 | E06 canonical v1.7.0, E03/E04/E05/E06 design inputs, TP p.7 | `E07/E07_SERVICES_RESILIENCE.md` and `E07/E07_HANDOFF.md`, both verified on GitHub; VALIDATED for documentary requirements; HA alternatives remain PROPOSED |
| E08 | E07 accepted canonical v1.8.0 and E02–E07 artifacts + Annexe B | Budget A/B and handoff on GitHub accepted as arithmetic/documentary evidence; conception PDF missing; snapshot evidence missing; E08 overall PARTIAL |
| E09 | E01 lab and E04 plan | GitHub E09 four files accepted for VLAN/trunk/parking OVS config; local targeted tar backup (not on GitHub); snapshot global FAILED; traffic and persistence NOT_TESTED |
| E10 | E09 handoff + E09 OVS verification; E04 plan; E05 matrix; E08/E09 risk register | Before pfSense changes, verify current OVS bridge/VLAN state and create/verify pfSense-specific recoverable configuration/disk backup due to global snapshot FAIL; then VLAN gateways/DHCP/DNS/route tests, screenshots, handoff |
| E11 | E10 handoff; E04 plan | AD installation/domain/DNS test outputs, handoff |
| E12 | E11 handoff | OU/users/groups/AGDLP/NTFS and SMB access tests, handoff |
| E13 | E05 matrix; E10–E12 handoffs | pfSense rule tests/logs, secure `config.xml` export, snapshot, handoff |
| E14 | E13 handoff; E04 plan; E05 matrix | VPN connection/SMB/ADMIN denial tests; sanitized evidence; handoff |
| E15 | E11–E14 handoffs | GPO HTML, sanitized pfSense backup, inventory, audit/NTP tests; handoff |
| E16 | E10/E11/E15 handoffs; E04 plan | Zabbix SNMP/agent screenshots and alert/recovery evidence, handoff |
| E17 | E05 matrix; E13/E14 handoffs | Nmap `-oA` exports; 3 findings; handoff |
| E18 | E12/E15/E17 handoffs | Intrusion test/report, logs, corrective actions and retest; handoff |
| E19 | All available handoffs and real artifacts | Official archive + technical documentation + executive summary; final handoff |

**Official submission artifacts** (Annexe C): `1-conception.pdf`, `2-schema-logique.drawio`, `2-schema-logique.png`, `3-laboratoire/`, `4-tests/`, `5-documentation.pdf`, `6-note-de-synthese.pdf`. Supporting `.md`, `.csv` and per-step handoff files are internal working materials, not automatically official deliverables.

## 6. Current facts, unverified facts, and blockers

### E01 HANDOFF REVIEW — 2026-11-06

**E01 status revised to `VALIDATED` for the official technical verification criterion** based on the original boot/install handoff and the subsequent user-supplied inspection of the `.gns3` link configuration. Ten of ten GNS3 adapter-to-port mappings were reported conforming. This is a review of submitted inspection results, not independent access to the running lab. Screenshot files and live running interface mapping remain unverified; these are documentary/follow-up checks, not evidence of failed E01 installation.

**Reported working environment (`OBSERVED-REPORTED` from E01 handoff):**
- Windows 11 host, 16 GB physical RAM; GNS3 GUI 2.2.61.
- Ubuntu WSL2 GNS3 Server 2.2.61 on `127.0.0.1:3081`; QEMU 10.2.1/KVM (`/dev/kvm`), Docker Open vSwitch, libvirt NAT (`virbr0`). This **deviates** from the TP's GNS3 VM prerequisite, and must be identified as such in documentation.
- Ten GNS3 nodes: NAT node observed **NAT2** (required label NAT1), SW-INTERNET, FW-LYON, SW-LYON, **SRV-AD01-1**, **SRV-SUP01-1**, KALI-AUDIT, PC-USR, PC-INV, PC-ATELIER. Suffix `-1` differs from required labels.
- FW-LYON: pfSense CE 2.9.0-RELEASE, QEMU 1 GiB/1 CPU/16 GiB/3 VirtIO NICs; WAN `192.168.122.114/24` received by DHCP at test time; LAN **temporary** `192.168.1.1/24` (not final VLAN interface).
- SRV-AD01-1: Windows Server 2025 Standard Evaluation Desktop Experience, QEMU 4 GiB/2 CPU/60 GiB SATA/e1000, installed with English UI (**TP specifies French**). AD/DNS/domain NOT configured.
- SRV-SUP01-1: 2 GiB Zabbix Appliance qcow2/Rocky Linux 8.10 booted; frontend and Zabbix services NOT verified.
- KALI-AUDIT: 2 GiB/2 NICs; login screen booted. SW-LYON Open vSwitch booted; ports `eth0`–`eth15` reported present; VLAN tags/trunks NOT configured.
- Boot tests were individual. **Simultaneous running of all heavy VMs not validated**, and E01 advises against `Start All` due to 16 GB RAM.

**Major troubleshooting already undertaken:** VMware GNS3 VM nested virtualization failed; moved to WSL2 GNS3 Server. Cross-server links failed; consolidated nodes under WSL2. Installed required `busybox-static`, `dynamips`, libvirt and configured `virbr0`; adjusted KVM group access. Resolved Windows install ISO attachment/boot issues. WSL2 I/O errors occurred with disk C: very low (1.66 GB); E01 reported 40.04 GB free after cleanup. Exact causal link is not proven.

**E01 technical closure update (user-supplied mapping, 2026-11-06):**

| # | Observed `.gns3` link endpoints | Mapping assessment |
|---|---|---|
| 1 | NAT2 `nat0` → SW-INTERNET `e0` | PASS (reported) |
| 2 | FW-LYON `Ethernet0` → SW-INTERNET `e1` | PASS (reported) |
| 3 | KALI-AUDIT `Ethernet1` → SW-INTERNET `e2` | PASS (reported) |
| 4 | FW-LYON `Ethernet1` → SW-LYON `eth0` | PASS (reported) |
| 5 | SRV-AD01-1 `Ethernet0` → SW-LYON `eth1` | PASS (reported) |
| 6 | SRV-SUP01-1 `Ethernet0` → SW-LYON `eth2` | PASS (reported) |
| 7 | KALI-AUDIT `Ethernet0` → SW-LYON `eth3` | PASS (reported) |
| 8 | PC-USR `Ethernet0` → SW-LYON `eth4` | PASS (reported) |
| 9 | PC-INV `Ethernet0` → SW-LYON `eth5` | PASS (reported) |
| 10 | PC-ATELIER `Ethernet0` → SW-LYON `eth6` | PASS (reported) |

Adapter counts reported: FW-LYON 3 VirtIO, SW-LYON 16 Docker, Kali 2 e1000, Windows and Zabbix 1 e1000 each. Names in this table are logical GNS3 adapter/port indices, **not proof of OS-level naming**. pfSense console previously displayed `vtnet0`, `vtnet1`, `vtnet2`; Kali `eth0`/`eth1` remain expected until checked in its OS. VLAN tags and trunks are **not configured** (E09), notwithstanding presence of 16 SW-LYON adapters. Do not misread `ports present` as `VLAN configured`.

**Remaining documentary/operational follow-up (not blocking E02):**
1. Confirm screenshot files exist on disk under `Conception_reseau/preuves/E01/`; specifically full topology, OVS console, pfSense post-install console, Windows Server Manager, and Zabbix boot. No screenshot was attached with the mapping update.
2. Save/backup the GNS3 project and verify reopen/persistence when convenient. Paths reported: `C:\Users\chuho\GNS3\projects\VALCREA-LAB\VALCREA-LAB.gns3` and `/home/cwithlove/GNS3/projects/0781031e-59c8-4642-966a-2f2a0bbc49c0/`; neither existence independently verified here.
3. Document deviations WSL2 vs GNS3 VM, English Windows UI, and GNS3 display labels. Do not silently rename or rebuild.
4. Record **actual time spent** in E01 (including follow-up); until then remaining budget is UNKNOWN.
5. Optional capacity test only: staged simultaneous starts with RAM/disk monitoring; do not use Start All on 16 GB host. This is not a pass criterion for E01.

**Non-completed work (planned for subsequent étapes):** VLAN configuration E09; pfSense final VLAN/routing/DHCP/DNS E10; AD/DNS E11; SMB/rights E12; firewall E13; VPN E14; hardening E15; Zabbix monitoring E16; testing E17/E18. None was validated by E01.

### Cross-project open issues
- Deadline conflict: TP first page 23h00 vs Annexe C and Support p.28 16h45; use cautious 16h45 unless teacher confirms otherwise.
- SOLO 12h critical path not yet approved; no official étape removed.
- Memory/storage limits on host: avoid starting all heavy VMs; verify free disk before continuing.

### E02 HANDOFF REVIEW — 2026-11-07

**E02 = VALIDATED (documentary audit only)** after checking the user-pasted E02 handoff against the uploaded workbook `E02_AUDIT_VALCREA_COURT(1).xlsx` (worksheet `Audit E02`). The workbook has 20 nonempty findings: 12 technical (T01–T12) and 8 organizational (O01–O08), each with domain, factual observation, associated risk, severity, ANSSI theme and recommendation. T01 explicitly records public TCP 3389 RDP and severity `Critique`. This meets the TP01 Étape 2 grid and quantity criteria.

**Exact artifact caution:** The handoff names `E02_AUDIT_VALCREA.csv` and claims page references for every finding; the uploaded actual evidence is a **short XLSX** with seven columns (`ID`, `Domaine`, `Constat`, `Risque`, `Gravité`, `Thème ANSSI`, `Recommandation`) and **no source-page column**. Do not claim the CSV was received or that the XLSX has page citations. These extras are not mandatory for E02 verification. The E02 handoff was pasted into chat, rather than supplied as a standalone `.md` file. No actual minutes were measured, so E02 elapsed minutes remain `UNKNOWN` (not 35 and not zero). The findings reflect Annexe A's fictional scenario, not live-network scanning.

**E03 has been accepted as documentary VALIDATED** (2026-11-07). See E03 review below. Audit recommendations remain proposals rather than approved architecture.

### E03 HANDOFF REVIEW — 2026-11-07

**E03 = VALIDATED (documentary scope only)**. Read `E03/E03_CAHIER_DES_CHARGES.md` and `E03/E03_HANDOFF.md` on GitHub main. The cahier contains five TP rubriques, 24 exigences (9 functional, 7 nonfunctional, 8 constraints), and 13 recette criteria R01–R13 (at least six required). It distinguishes FAIT, RISQUE, EXIGENCE and SOLUTION PROPOSÉE and keeps all SOURCE-REQUIRED network/domain values intact.

**OPEN:** NF03/R13 CAO file-transfer time threshold needs business confirmation; size and integrity test are defined, but no maximum acceptable duration is supplied in Annexe A. No future verification test has been run as part of E03. E03 elapsed minutes UNKNOWN. No changes to D01–D12 or to architecture; no GNS3 configuration modified. E01 screenshot/time limitations remain open.

**Accepted artifacts:** `E03/E03_CAHIER_DES_CHARGES.md` and `E03/E03_HANDOFF.md` (two files committed before canonical state update). E04 depends on these and the two current state files.

### E04 HANDOFF REVIEW — 2026-11-07

**E04 = VALIDATED (documentary)** following Main Progression review of `E04/E04_HANDOFF.md`, `E04/E04_PLAN_ADRESSAGE.md`, and `E04/E04_PLAN_ADRESSAGE.csv`. Original E04 documents marked `PARTIAL` / `PROPOSED` are historical, preserved unchanged.

**B01 — PROJECT-DECIDED, APPROVED/LOCKED:** Bordeaux UTILISATEURS VLAN 20, `10.20.20.0/24`, GW `10.20.20.1`, DHCP `10.20.20.100–10.20.20.199`, target DNS `10.10.10.10` via secured Lyon–Bordeaux link; dependency on link and DNS resiliency remains `B03 PENDING`.

**B02 — PROJECT-DECIDED, APPROVED/LOCKED:** Bordeaux INVITES VLAN 40, `10.20.40.0/24`, GW `10.20.40.1`, DHCP `10.20.40.100–10.20.40.199`, planned local resolver `10.20.40.1`, isolated from internal networks.

**Still PENDING:** `V01` actual OpenVPN address allocation/endpoint (E14), `B03` Bordeaux DHCP/DNS hosting and outage resiliency (E07), `CAP01` actual endpoint/guest counts, `NF03/R13` CAO transfer time threshold. E04 did not implement or test any lab network service. Actual active minutes E01–E04 `UNKNOWN`, remaining budget `UNKNOWN`. Lyon required network and E01 deviations unchanged.

**Scope:** Bordeaux networks are production design only; do not add them to Lyon GNS3 lab. Approved v1.5.0 is recorded in these two canonical snapshot files, not retroactively in E04 original artifacts.

### E05 HANDOFF REVIEW — 2026-11-07

**E05 = VALIDATED (documentary only)** after reading the three original E05 GitHub files and explicit user acceptance of the **core** default-deny / least-privilege policy. Original `E05_HANDOFF.md` marked `PARTIAL` and `E05_POLITIQUE_ACCES.md` marked `PROPOSÉ` are immutable historical source snapshots; the canonical acceptance is recorded here and in `DECISIONS.md` v1.6.0.

**Documents and counts:** `E05/E05_MATRICE_FLUX.csv` includes 51 identified rows (38 ALLOW, 13 DENY), with 13 columns; `E05/E05_POLITIQUE_ACCES.md` and `E05/E05_HANDOFF.md` define rationale, target vs Lyon-lab scope and verification boundaries. The matrix is a **design inventory, not 38 approved firewall implementation rules**.

**APPROVED core policy:** deny by default; permit only justified limited service access by role/zone; never any-any allow; visitor isolation (Lyon and approved Bordeaux B02); workshop no Internet; nomades VPN limited to permitted DNS/SMB with no ADMIN; no WAN-exposed RDP TCP 3389; named/circumscribed administration and privacy controls; Bordeaux B01/B02 production zoning retained. E13 must implement and verify actual effective ordered rules after review.

**NOT APPROVED / PROPOSED or PENDING:** dynamic AD RPC TCP 135 and 49152–65535 (F17/F18/F43 where applicable), internal ADMIN-to-server RDP TCP 3389 (F21), unrestricted/uncatalogued outbound server updates (F42), Zabbix active-agent TCP 10051 (F39), and other scoped SSH/HTTPS or intersite permissions that need equipment/service inventory. Treat `PROPOSED` rows as conditional candidates, not permission to implement. No rule was installed or tested during E05.

**Open issues retained without change:** V01 VPN allocation/endpoint, B03 Bordeaux DHCP/DNS hosting and availability, CAP01 endpoint/guest inventory, NF03/R13 CAO file-transfer-time criterion. E01–E05 active minutes `UNKNOWN`; remaining budget `UNKNOWN`.

## 7. Next action

**NEXT CONTENT SESSION: E06 — Dessiner le schéma logique sous draw.io**, TP01 p.7 and Support p.10–12. Inputs: E05 canonical `MAIN_STATE.md` and `DECISIONS.md` v1.6.0, E04 address plan, E05 matrix and policy, E03 cahier plus both source PDFs. Produce editable `2-schema-logique.drawio`, exported `2-schema-logique.png` and `E06_HANDOFF.md` with verified existence/legibility and clearly distinguish Lyon GNS3 lab from Bordeaux approved target and Nantes non-deployed reserve. Show main segmentation/trunk/firewall/VPN/AD/DNS/supervision and only indicative approved core flows; do not depict proposed RPC/RDP/active Zabbix permissions as accepted. E06 is documentation only, not equipment configuration. Actual session minutes E01–E05 UNKNOWN.

**E01 technical validation accepted** (10/10 GNS3 port mapping reported, individual installations/boots previously reported). Screenshot archival and exact time spent remain open administrative items; check them before E09/E10 or final submission. No implied approval to change mandated names or network settings.

## 8. Accepted handoff history

| Accepted date | Étape | Handoff version | Status | Minutes added | Updated artifacts | Reviewed by |
|---|---|---|---|---:|---|---|
| 2026-11-06 | E01 | E01_HANDOFF_VALCREA(1).md | PARTIAL | Unknown (not booked) | Reported topology and individual VM boots; screenshots unverified | MAIN PROGRESSION |
| 2026-11-06 | E01 | User-supplied supplemental 10-link mapping check | VALIDATED (technical) | Unknown (not booked) | 10/10 `.gns3` port mappings confirmed by user report; screenshot archival outstanding | MAIN PROGRESSION |
| 2026-11-07 | E02 | User-pasted E02_HANDOFF and uploaded `E02_AUDIT_VALCREA_COURT(1).xlsx` | VALIDATED (documentary) | Unknown (not booked) | 20 documented findings, 8 organizational; all seven mandatory columns present, T01 RDP 3389 critical; short XLSX does not contain source-page column and is not the CSV filename cited by the handoff | MAIN PROGRESSION |
| 2026-11-07 | E03 | `E03_HANDOFF.md` + `E03_CAHIER_DES_CHARGES.md` (repo `E03/`) | VALIDATED (documentary) | Unknown (not booked) | Five rubriques; 24 requirements; 13 acceptance criteria; NF03/R13 transfer deadline pending; no infrastructure tests reported | MAIN PROGRESSION |
| 2026-11-07 | E04 | `E04_HANDOFF.md`, `E04_PLAN_ADRESSAGE.md`, `E04_PLAN_ADRESSAGE.csv` | VALIDATED (documentary) | Unknown (not booked) | B01/B02 Bordeaux approved by user; V01/B03/CAP01/NF03 remain PENDING; no lab tests | MAIN PROGRESSION |
| 2026-11-07 | E05 | `E05_MATRICE_FLUX.csv`, `E05_POLITIQUE_ACCES.md`, `E05_HANDOFF.md` in GitHub E05/ | VALIDATED (documentary) | Unknown (not booked) | 51 rows, 38 ALLOW/13 DENY; core policy user-approved; proposed RPC/RDP/updates/Zabbix active exceptions not approved; no live test | MAIN PROGRESSION |


## 9. E06 acceptance and v1.7.0 reconciliation — 2026-11-07

- Canonical predecessor: GitHub `E05/MAIN_STATE.md` and `E05/DECISIONS.md`, version **1.6.0**. Earlier local v1.2.x snapshots were outdated and **not** used as the base. The E01–E05 statuses, design decisions, risk and exception register from v1.6.0 are preserved.
- **E06 VALIDATED (documentary design scope)** by MAIN PROGRESSION after inspecting user-provided PNG and GitHub source. GitHub branch `main`: `E06/2-schema-logique.drawio` (18,640 bytes per GitHub metadata) and `E06/E06_HANDOFF.md`; in-chat evidence: `2-schema-logique(4).png` (1292×862). **No `E06/2-schema-logique.png` in GitHub at review**; not a blocking acceptance condition because PNG is actually attached in MAIN chat. Store/attach in final submission E19.
- Design content: Lyon WAN/pfSense/OVS/trunk and VLANs 10/20/30/40/50/999 with gateways; SRV-AD01 `.10`, SRV-SUP01 `.20`, OpenVPN nomades `10.10.90.0/24`, Bordeaux future VLAN 20/40, Nantes `10.30.0.0/16` reserve, E05 default-deny summary. Remote sites and VPN deployment are **planned**, not demonstrated in lab.
- Outstanding complementary E06 quality checks (non-blocking acceptance): direct opening in diagrams.net NOT_TESTED; exact PNG export identity to last saved `.drawio` NOT_TESTED; all individual flux arrows and print readability NOT_TESTED. E06 working time UNKNOWN, budget remainder UNKNOWN.
- **Preserve pending exception IDs V01, B03, CAP01, NF03/R13** and E05 technical exceptions as PROPOSED/PENDING (including AD RPC ports, internal ADMIN RDP, update egress, Zabbix active-agent ports and device-management accesses). E06 graphic did not grant approval or alter the E05 matrix.
- Status progression now **6/19 VALIDATED (E01–E06)**, E07 next. No VLAN/AD/pfSense/firewall/VPN/Zabbix operational setup is implied by documentary statuses.
- Acceptance log: 2026-11-07 | E06 | `E06/E06_HANDOFF.md` plus `.drawio` GitHub and PNG in MAIN chat | VALIDATED (documentary) | actual minutes UNKNOWN | reviewed by MAIN PROGRESSION.


## 10. E07 documentary acceptance — 2026-11-07 (v1.8.0)

- **E07 VALIDATED (documentary design only)** after MAIN PROGRESSION inspected the live GitHub `E07/E07_SERVICES_RESILIENCE.md` and `E07/E07_HANDOFF.md` against TP01 Étape 7 p.7. Exactly seven specified categories (DHCP, DNS, AD, fichiers, supervision, accès distant, sauvegarde), each with rôle, hébergement, ports, redondance, sauvegarde and supervision, plus RESILIENCE/EVOLUTION narrative. E07 handoff's original `PARTIAL` is a historical proposal; acceptance here supersedes its proposed status without rewriting it.
- RTO fichiers 240 min, RPO fichiers 24 h, 1.2 TB file volume and restoration tests clearly discussed. **No restoration test, HA failover or cost compliance demonstrated**. No operational configuration or purchase took place in E07.
- Proposed only: `E07-P1` second DC/DNS Bordeaux, `E07-P2` CARP pair with .1 VIP if approved, `E07-P3` 4G backup and UPS, `E07-P4` 3-2-1 offsite/isolated backup and PRA test, `E07-P5` local Bordeaux DHCP. These are design alternatives pending budget/technical approval, **not approved as implementation decisions**. `V01`, `B03`, `CAP01`, `NF03/R13` and E05 proposed security flow exceptions remain PENDING.
- Residual design challenge for E08: quantitatively justify proposed HA options and check whether CAPEX ≤€30,000 HT / OPEX ≤€6,000 HT per year (using Annexe B) and 4h/24h restoration objective are plausible. A secondary DC does not automatically provide SMB file HA; restoring complete 1.2 TB within 4h is NOT_TESTED and might be infeasible depending on throughput. Distinguish budgeted options and accepted selected scenario.
- Actual minutes E07 UNKNOWN, cumulative remaining budget UNKNOWN. Status count **7/19 VALIDATED; E08 last step of official Partie 1**. Current GitHub main canonical path: `E07/MAIN_STATE.md` and `E07/DECISIONS.md` v1.8.0.
- Acceptance log: 2026-11-07 | E07 | live GitHub `E07/E07_SERVICES_RESILIENCE.md` + `E07/E07_HANDOFF.md` | VALIDATED (documentary) | elapsed UNKNOWN | MAIN PROGRESSION.


## 11. E08 review — 2026-11-07 (v1.9.0)

- Inspected GitHub main `E08/E08_BUDGET.csv` (18 lines A, 25 lines B), `E08/E08_BUDGET_ANALYSE.md`, `E08/E08_HANDOFF.md` and compared reference/unit prices to TP01 Annexe B pp17–18. **Budget calculations PASS**: A CAPEX 21,650 EUR HT, OPEX 3,276 EUR/year, TCO 5 years 38,030 EUR; B CAPEX 27,400 EUR, OPEX 4,296 EUR/year, TCO 48,880 EUR. Both under CAPEX 30k, OPEX 6k *on budgeted lines only*; costs omitted are explicitly identified. CSV line arithmetic checked.
- **E08 overall PARTIAL**: official `1-conception.pdf` NOT PRODUCED; GNS3 snapshot `PRE-E09` and latest pfSense/Windows boot screenshots NOT_TESTED in E08. E01 old reported individual boots remain accepted history only. Do not claim GNS3 snapshot is present. Restoration RTO 4h / RPO 24h not operationally demonstrated; remains future test and risk.
- Proposed Scénario A is **ACCEPTED AS FINANCIAL BASELINE FOR PLANNING**, not approved procurement or architecture implementation: A 21,650/3,276/year/38,030 TCO; B alternative 27,400/4,296/year/48,880 TCO. E07-P1..P5 remain PROPOSED, V01/B03/CAP01/NF03-R13 and E05 exceptions PENDING. Quantity, license scope, storage capacity, backup restore throughput, omitted recurrent costs need future validation.
- Action before full E08 VALIDATED: assemble verified `1-conception.pdf` from actually available accepted E02–E08 sources; confirm or create PRE-E09 GNS3 snapshot and capture verification with actual user assistance; note E06 PNG availability for E19 archive. E09 can be planned but preserve caution around config changes until snapshot.
- E08 actual working minutes and remaining 720-min project budget UNKNOWN. **7/19 validated; E08 PARTIAL** (budget subtask PASS). Do not mark Partie 1 complete yet.


## 12. E09 switch configuration acceptance — 2026-11-09 (v1.10.0)

- E09 **VALIDATED for specific TP Étape 9 requirement**: GitHub main contains `E09/E09_HANDOFF.md`, `E09/E09_OVS_COMMANDES.md`, `E09/E09_OVS_VERIFICATIONS.txt`, `E09/E09_OVS_SHOW_CAPTURE.png`. Review of actual outputs transcribed in verification file and capture report: OVS bridge br0; `eth0` explicit trunk allowed VLANs 10/20/30/40/50; `eth1,2=10`, `eth3=30`, `eth4=20`, `eth5=40`, `eth6=50`, `eth7–eth15=999` with access mode. All 16 ports PASS configuration. Current network traffic, tagged-frame forwarding and persistence after Docker recreation **NOT_TESTED** (E10 integration checks).
- Backup risk **OPEN / IMPORTANT**: global `PRE-E09` GNS3 snapshot **FAILED** due to timeout downloading ~16.7 GiB Windows QCOW2 from remote GNS3 compute `127.0.0.1:3081`. Windows snapshot directory empty. Targeted `SW-LYON-PRE-E09.tar.gz` archive was checked with tar/gzip and SHA-256 `e2e89d87a274e725097faf2f8cec9e3c018b3fe0bcd7d7d3930f91fcb51ad7c2` but remains only on user host; restoration NOT_TESTED. `.gns3` recovery copy hash matched, but neither alone replaces a tested full-lab snapshot. Do not mark snapshot PASS.
- **E10 safety prerequisite**: first read-only inspect current SW-LYON VLAN state (after possible restart) and establish a **verified pfSense-specific recovery point** (e.g., offline/safely copied VM disk or export valid running config and verified accessible file) before changing VLAN interface/DHCP/routing. Do not copy live QCOW2 unsafely. Report backup location and limits. No permission to silently rebuild lab or disregard failed snapshot.
- E08 updated evidence: `E08/VALCREA_Conception_E08.pdf` is now present on GitHub (384,727 bytes), but direct final PDF quality/source review and snapshot closure are outstanding; E08 remains PARTIAL. E09 acceptance independent of E08 remaining documentary review.
- Time spent E09 UNKNOWN; cumulative remaining 720-minute budget UNKNOWN. Progress **E01–E07 and E09 VALIDATED = 8/19; E08 PARTIAL**, E10 next. Do not infer pfSense/routing/DHCP/DNS, VPN, AD or Zabbix complete.
