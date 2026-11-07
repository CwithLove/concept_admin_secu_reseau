# VALCRÉA TP01 — DECISIONS

> Version: 1.6.0  
> Baseline: 2026-11-07  
> Authority: MAIN PROGRESSION  
> Companion: `MAIN_STATE.md`

## 1. Governance: what can change?

This file separates four kinds of information:

- **SOURCE-REQUIRED**: prescribed by the TP; not a free design decision. Do not change without the user's express authorization **and** acknowledgment that it may conflict with the assignment.
- **PROJECT-DECIDED**: explicitly agreed execution or design choice; preserve until the user approves a change.
- **OBSERVED**: demonstrated by actual command output, screenshot, exported config, or test result. Do not infer it from intended settings.
- **PENDING**: not yet decided or not verified; don't silently turn it into a fact.

Any session may propose a correction. Only MAIN PROGRESSION accepts a new decision after the user approves consequential deviations. Keep a concise change log showing before/after/reason/affected étapes. When PDF guidance and plans appear to conflict, **flag the discrepancy rather than silently reconcile it**.

## 2. Project-level decisions

| ID | Type | Status | Decision / constraint | Notes |
|---|---|---|---|---|
| D01 | PROJECT-DECIDED | LOCKED | Mode SOLO for TP01 | User directly chose SOLO |
| D02 | PROJECT-DECIDED | LOCKED | 12 hours = 720 minutes total execution budget | Track actual time, not estimates as spent |
| D03 | PROJECT-DECIDED | LOCKED | One dedicated conversation/session per official étape E01–E19 | Keep official numbering |
| D04 | PROJECT-DECIDED | LOCKED | MAIN PROGRESSION reviews handoffs and owns canonical state | New chats work from attached latest files |
| D05 | PROJECT-DECIDED | LOCKED | Each step must produce `E##_HANDOFF.md` and actual evidence when available | Distinguish PASS / FAIL / NOT_TESTED |
| D06 | PROJECT-DECIDED | LOCKED | Keep all 19 official étapes in the plan | 12h critical-path reduction is PENDING, no silent omissions |
| D07 | PROJECT-DECIDED | LOCKED | Two source PDFs: TP01 primary requirements, Support for teaching/examples | TP01 has 3 parties; support has 4 modules |
| D08 | PROJECT-DECIDED | LOCKED | Do not mark successful installation/configuration/tests until verified | `PARTIAL` when verification missing |
| D09 | PROJECT-DECIDED | LOCKED | Changes to user-set/locked topology, IP/VLAN and design require explicit approval | Troubleshooting does not authorize redesign |
| D10 | PROJECT-DECIDED | LOCKED | Preserve useful artifact filenames, evidence, and handoff lineage | No fabricated or renamed file paths |
| D11 | PROJECT-DECIDED | LOCKED | Use cautious 16h45 deadline pending confirmation | TP page 1 says 23h; TP Annexe C & Support p.28 say 16h45 |
| D12 | PROJECT-DECIDED | LOCKED | Prioritize small, usable step artifacts; avoid unnecessary per-step PDFs | Official submission is final consolidated dossier |

## 3. TP-prescribed architecture: SOURCE-REQUIRED

### 3.1 Site/network addressing

| Item | Required value | Reference |
|---|---|---|
| GNS3 project name | `VALCREA-LAB` | TP Étape 1 p.4 |
| Lyon addressing block | `10.10.0.0/16` | TP p.6, Annexe A |
| Bordeaux addressing block | `10.20.0.0/16` | TP p.6, Annexe A |
| Future Nantes reserve | `10.30.0.0/16` | TP Annexe A |
| Addressing convention | Third octet = VLAN ID; gateway ends `.1` | TP p.6, Annexe A |
| VLAN 10 SERVEURS | `10.10.10.0/24`, GW `10.10.10.1` | TP p.3 |
| VLAN 20 UTILISATEURS | `10.10.20.0/24`, GW `10.10.20.1` | TP p.3 |
| VLAN 30 ADMIN | `10.10.30.0/24`, GW `10.10.30.1` | TP p.3 |
| VLAN 40 INVITES | `10.10.40.0/24`, GW `10.10.40.1` | TP p.3 |
| VLAN 50 ATELIER | `10.10.50.0/24`, GW `10.10.50.1` | TP p.3 |
| VLAN 999 PARKING | No L3 routing / no gateway | TP p.3, p.8–9 |
| Nomad VPN subnet | `10.10.90.0/24` | TP p.6, p.12 |
| AD FQDN | `ad.valcrea.fr` | TP Annexe A, p.10 |
| NetBIOS | `VALCREA` | TP Annexe A, p.10 |
| SRV-AD01 | `10.10.10.10/24`; gateway `10.10.10.1`; DNS `10.10.10.10` | TP p.10 |
| SRV-SUP01 | `10.10.10.20` | TP p.3, p.13 |
| Gateway routing | pfSense on VLAN subinterfaces | TP p.3, p.9 |
| DHCP | pfSense in lab | TP p.9; Support p.12 |
| Internal DNS | SRV-AD01; guest DNS pfSense | TP p.3/p.9; Support p.11–12 |

**Do not confuse intended settings with tested running settings.** Every entry in this table is `SOURCE-REQUIRED`, not `OBSERVED`.

### 3.2 Components and major cabling

| Element | Required role and reference |
|---|---|
| FW-LYON | pfSense CE 2.9.0; QEMU; WAN `vtnet0`, VLAN parent `vtnet1`; TP p.4, p.9 |
| SW-LYON | Open vSwitch; trunk eth0 VLAN 10/20/30/40/50 toward FW; TP p.3, p.8–9 |
| SW-LYON eth1 / eth2 | Access VLAN 10 for SRV-AD01 / SRV-SUP01 respectively |
| SW-LYON eth3 | Access VLAN 30 for KALI-AUDIT `eth0` |
| SW-LYON eth4 / eth5 / eth6 | Access VLAN 20 PC-USR / VLAN 40 PC-INV / VLAN 50 PC-ATELIER |
| SW-LYON eth7–eth15 | Parking VLAN 999 |
| KALI-AUDIT eth1 | Connected toward SW-INTERNET; used for external tests |
| SRV-AD01 | Windows Server 2025 Standard Evaluation with Desktop Experience; QEMU; TP p.4 |
| SRV-SUP01 | Zabbix 7.0 LTS QEMU qcow2 appliance; TP p.4/p.13 |
| KALI-AUDIT | Kali Linux 2026.3; TP p.2–4 |
| WAN lab | NAT/private `192.168.122.0/24`; WAN receives DHCP | TP p.3/p.9 |

Read the **full original diagram and port table in TP p.2–3** before building; this abbreviated table is not a replacement for them.

### 3.3 Security and services

| Item | Required direction |
|---|---|
| Network policy | Default deny, least privilege, segmentation |
| Guest VLAN | Internet/web + appropriate pfSense DNS; no access to internal zones |
| Atelier VLAN | Required AD/Production access, no Internet |
| User VLAN | AD/DNS/SMB to SRV-AD01, web access; no ADMIN access |
| Direct Internet RDP | Forbidden |
| Remote access | OpenVPN UDP 1194; nominal user `m.ferhat`; access only to authorized resources |
| AD permissions | AGDLP; prescribed OU/groups/users and NTFS/SMB checks; consult TP p.10–11 |
| Hardening | 12-char passwords, complexity, history 24, 10 failed attempts/15 min lockout, Windows audit, NTP, admin separation |
| Monitoring | Zabbix 7.0 LTS; pfSense via SNMP, Windows via Zabbix Agent 2 |
| Tests | Nmap from ADMIN/INVITES/WAN; lab-only test + remediation + retest |
| Availability target | File RTO 4h, RPO 24h (design objective; not a tested lab claim) |
| Budget target | CAPEX <= €30,000 excl. VAT; OPEX <= €6,000/year excl. VAT |

## 4. Decisions deliberately not yet made

| ID | Type | Pending issue | How to resolve |
|---|---|---|---|
| P01 | PARTIAL OBSERVATION | Host Windows 11/16 GB, GNS3 Windows GUI + WSL2 Linux GNS3 Server/QEMU KVM; CPU details not independently validated | E01 reported operational details; preserve as reported, not full host benchmarking |
| P02 | PENDING | Detailed target architecture, optional zones, actual equipment selection and CAPEX/OPEX amounts | E04–E08, informed by annexes; user reviews material choices |
| P03 | PENDING | Full approved flow matrix / exception rules | E05; then use unmodified in E13 |
| P04 | PENDING | 12h Critical Path and permissible scope simplifications | Separate Main Progression decision; don't implement reductions yet |
| P05 | OBSERVED-REPORTED | E01 now reports 10/10 matching GNS3 link endpoints and individual boots/installs; later VLAN/routing/domain/ACL/VPN/Zabbix/tests NOT verified | Technical E01 accepted; archive screenshots and log E01 actual time separately |
| P06 | PENDING | Exact submission naming for a SOLO student; deadline discrepancy | Ask teacher; preserve Annexe C structure |

## 4A. E01 implementation record — deviations and constraints (2026-11-06)

The following facts are **E01-HANDOFF-REPORTED**, not newly mandated design choices, and not independently re-tested by MAIN PROGRESSION:

| ID | Classification | E01 report | TP requirement / treatment |
|---|---|---|---|
| O01 | OBSERVED-REPORTED / DEVIATION | GNS3 GUI Windows 11 + GNS3 Server Ubuntu WSL2/KVM; all nodes hosted on WSL2 server | TP prescribes GNS3 VM; WSL2 used after VMware nested virtualization failed. Record deviation; do not misrepresent compliance or silently switch hypervisor. Any rebuild needs user approval. |
| O02 | OBSERVED-REPORTED / DEVIATION | Windows Server 2025 Standard Evaluation Desktop Experience installed **in English** | TP requests French. Preserve installed VM pending decision; document language difference. Reinstallation is not implicitly authorized. |
| O03 | OBSERVED-REPORTED / NOMENCLATURE | NAT node named `NAT2`; Windows/Zabbix GNS3 nodes named `SRV-AD01-1` and `SRV-SUP01-1` | TP labels are NAT1, SRV-AD01, SRV-SUP01. Validate whether safe to rename GNS3 display labels (not OS identities); do not assume already renamed. |
| O04 | OBSERVED-REPORTED / TEMPORARY | pfSense `vtnet0` DHCP `192.168.122.114/24`, `vtnet1` provisional LAN `192.168.1.1/24` | Target VLAN/subinterface addresses in section 3 remain unchanged and must be implemented in E10. WAN DHCP value is not a reserved static IP. |
| O05 | OBSERVED-REPORTED / OPERATIONS | Host 16 GB RAM; individual boots only; constrained disk C: / WSL2 storage; 40.04 GB free after cleanup | Avoid `Start All` until capacity confirmed; monitor free space. No assumption that all nodes can run concurrently. |
| O06 | OBSERVED-REPORTED / TOOLING | QEMU 10.2.1 KVM; Docker Open vSwitch; libvirt NAT `virbr0`; port 3081 for local GNS3 API | This is an operational dependency for sessions E09–E18; preserve server locality and document startup sequence. |

**Decisions still pending:** whether the teacher explicitly accepts WSL2 for the GNS3 VM prerequisite and English Windows; exact E01 time spent; verified screenshot files and actual E01 time (cable port assignment now reported 10/10 verified from `.gns3`). Document the deviations; do not silently remove them from the report. No change to locked addressing/VLAN/AD specifications was approved or made by this record.

## 4B. E01 supplemental acceptance record — 2026-11-06

- Main Progression accepted **E01 VALIDATED for the narrow technical criterion** after a user-supplied check of all 10 GNS3 links (NAT2↔SW-INTERNET; FW WAN and Kali WAN↔SW-INTERNET; FW LAN↔SW-LYON eth0; AD/SUP/Kali/three VPCS↔SW-LYON eth1–eth6).
- Reported adapter inventory: pfSense 3 VirtIO; OVS 16 Docker ports; Kali 2 e1000; AD and Zabbix 1 e1000 each. **Presence of 16 ports is not VLAN configuration**; E09 remains TODO.
- `.gns3` endpoint names/adapter indices do not establish OS `vtnet`/`eth` mapping. Validate under OS when E09/E10 require it.
- Source-required names vs actual display labels remain a documented deviation, not a permission to rename. WSL2 replacement and English Windows remain deviations.
- **Not yet verified:** screenshot files on disk, full concurrent VM boot, ongoing OVS operational state, exact E01 minutes. None of these is silently declared complete.
- No address, VLAN, topology, or security-policy decision changed from this handoff.

## 4C. E02 documentary audit acceptance — 2026-11-07

- **Record type:** `OBSERVED-REPORTED / DOCUMENT-REVIEWED`, not a new network architecture decision. Étape E02 accepted as `VALIDATED` based on inspected `E02_AUDIT_VALCREA_COURT(1).xlsx` and the user's pasted handoff.
- **Inspected facts:** 20 findings (T01–T12 technical, O01–O08 organizational), all with domain, observation, risk, severity, ANSSI theme, and recommendation. RDP 3389 exposure is T01 `Critique`.
- **Traceability limit:** The uploaded workbook is a short XLSX **without** page-source references, although the pasted handoff describes a CSV and paginated references. Cite the actual uploaded XLSX and do not silently claim those extras exist.
- **Decision boundary:** Audit recommendations are **proposals**, not approved architecture or implemented mitigations. `SOURCE-REQUIRED` parameters, D01–D12, and E01 runtime deviations are unchanged.
- **Time:** E02 active time `UNKNOWN`; E01 also `UNKNOWN`. Preserve uncertainty in budget ledger. E03 may proceed using the audit as a factual input.

## 4D. E03 cahier des charges acceptance — 2026-11-07

- **Record type:** `DOCUMENT-REVIEWED` (not a new architecture decision). E03 accepted `VALIDATED` for documentary TP01 Étape 3 criteria after reading `E03/E03_CAHIER_DES_CHARGES.md` and `E03/E03_HANDOFF.md` on branch main.
- **Contents:** Five required rubriques; 24 exigences (`F01–F09`, `NF01–NF07`, `C01–C08`) and 13 recette criteria (`R01–R13`). All stated future tests remain unexecuted.
- **PENDING — NF03/R13:** Annexe A gives CAO file size (200–500 Mo) but no maximum acceptable transfer duration. Do not invent a time target; confirm with business before final performance recette. This pending threshold does not invalidate E03 documentary completion.
- **No change** to D01–D12, prescribed VLAN/IP/domain, E01 implementation deviations or E02 factual audit. E03 `SOLUTION PROPOSÉE` entries are not approval to implement a new architecture.
- **Time:** E03 actual minutes `UNKNOWN`, likewise E01 and E02. E04 is next and must use these accepted requirements.

## 4E. E04 plan d'adressage approval — 2026-11-07

**User authorization:** B01 and B02 explicitly approved in MAIN PROGRESSION. E04 becomes `VALIDATED` for documentary design only. Do not edit original E04 `PARTIAL` handoff or `PROPOSED` source plan; those remain historical evidence.

| ID | Type | Status | Approved target design | Remaining dependencies |
|---|---|---|---|---|
| B01 | PROJECT-DECIDED | APPROVED / LOCKED | Bordeaux UTILISATEURS VLAN 20, `10.20.20.0/24`, GW `10.20.20.1`, DHCP `10.20.20.100–10.20.20.199`, target DNS `10.10.10.10` via secured link to Lyon | E07 specifies DHCP/DNS hosting and resilience |
| B02 | PROJECT-DECIDED | APPROVED / LOCKED | Bordeaux INVITES VLAN 40, `10.20.40.0/24`, GW `10.20.40.1`, DHCP `10.20.40.100–10.20.40.199`, planned local DNS resolver `10.20.40.1`, no internal guest access | E07 specifies local resolver and resilience |

**Production vs lab:** Bordeaux decisions are target architecture, not implemented GNS3 configuration. Lyon SOURCE-REQUIRED VLAN 10/20/30/40/50/999, DHCP, AD `ad.valcrea.fr`, VPN `10.10.90.0/24` and D01–D12 unchanged.

**PENDING unchanged:** `V01` (actual OpenVPN allocation/endpoint), `B03` (Bordeaux service hosting, connectivity and continuity), `CAP01` (concurrent devices/visitors), and `NF03/R13` (CAO 500 Mo transfer deadline). No E04 live network tests or time measurements have been claimed.

## 4F. E05 core policy acceptance — 2026-11-07

**Scope of explicit user approval:** E05 `VALIDATED` for **documentary completeness** and approval of the **core access-control principles** only. The E05 files remain unchanged historical proposals; neither the full list of 38 ALLOW entries nor the implementation-ready pfSense firewall configuration has been automatically approved.

| ID | Type | Status | Approved core rule / decision | Implementation boundary |
|---|---|---|---|---|
| A01 | PROJECT-DECIDED | APPROVED / LOCKED | Refus par défaut / least privilege; no ANY→ANY ALLOW; justify source, destination and service for each exception | Detailed E13 firewall rule sequence still requires review/testing |
| A02 | PROJECT-DECIDED | APPROVED / LOCKED | Lyon/Bordeaux INVITES: DNS and restricted web Internet only; deny internal networks and firewall GUI access | Verify DNS exception ordering, private-network and management interface blocking |
| A03 | PROJECT-DECIDED | APPROVED / LOCKED | Lyon ATELIER: no Internet, only minimal necessary AD / authorized Production access | File permissions remain E12 ACL/NTFS responsibility |
| A04 | PROJECT-DECIDED | APPROVED / LOCKED | VPN NOMADES: allow only necessary authorized DNS/SMB access; no access to VLAN ADMIN; no published WAN TCP 3389; OpenVPN UDP 1194 target | V01 VPN real pool/endpoint still PENDING; E14/E17 implementation/test not completed |
| A05 | PROJECT-DECIDED | APPROVED / LOCKED | ADMIN targeted authorized management only, with protection of sensitive/RH access; VLAN 999 non-routed; preserve Bordeaux B01/B02 | No blanket ADMIN-to-all permissions; host firewalls and AD/SMB rights checked separately |

**Technical exceptions NOT approved:** dynamic Active Directory RPC TCP 135 + TCP 49152–65535 (notably F17/F18/F43); internal ADMIN RDP TCP 3389 (F21); server outbound updates (F42) pending tightly scoped destination and need; Zabbix active agent TCP 10051 (F39) pending mode choice. Also keep equipment SSH/HTTPS (F23), additional intersite permissions and other technical `PROPOSED` entries conditional until independently justified. Document status as `PROPOSED/PENDING`; not blanket ALLOW.

**Implementation warning:** The E05 CSV contains rows `Decision=ALLOW` whose `Type=PROPOSED`. That column describes a requested design flow, **not approval**. E13 must consult canonical v1.6.0 decision status, review ordering and validate service requirements; guest privacy and no-Internet workshop are nonnegotiable. Same-VLAN Zabbix/AD traffic might be controlled by host firewall rather than pfSense. No GNS3, firewall, AD, VPN, or Zabbix tests were performed in E05.

**Prior PENDING unchanged:** V01, B03, CAP01, NF03/R13. E01–E05 actual time UNKNOWN and remaining budget UNKNOWN. D01–D12 and B01/B02 unchanged.

## 5. Operational rules for step sessions

1. Read the latest `MAIN_STATE.md` and `DECISIONS.md`, plus the official TP and support pages for the étape.
2. Read relevant earlier handoffs and artifacts. If missing, say **MISSING** and work only on safe, independent components.
3. First state prerequisites and success criteria; then guide execution incrementally.
4. Do not claim actual system states from a prompt or a planned value. Record command output/test proof for `OBSERVED`.
5. Keep original configuration and unrelated steps unchanged. Any potentially consequential deviation must be submitted as a proposal with its effect on dependencies.
6. At session end deliver an `E##_HANDOFF.md` containing: status, actual minutes, completed, verified (PASS/FAIL/NOT_TESTED), unresolved issues, artifacts, configuration changes, deviations, ready/blocked follow-ups, next action.
7. Propose patches to `MAIN_STATE.md` and `DECISIONS.md` if needed, but do not present them as accepted canonical state until reviewed in MAIN PROGRESSION.
8. Do not put passwords, private keys, SNMP communities or secrets in submission files or handoffs. Sanitized evidence is preferred; a pfSense config export may include secrets and needs secure handling.

## 6. Change-control log

| Date | Decision ID | Old value | New value | Reason | Approved by | Affected étapes |
|---|---|---|---|---|---|---|
| 2026-11-06 | O01–O06 | No E01 implementation record | E01 handoff reported operational setup and deviations; mandatory target parameters preserved | Handoff review (not retrofit approval) | MAIN PROGRESSION | E01, E09–E19 |
| 2026-11-07 | B01/B02 | PROPOSED in E04 source files | APPROVED/LOCKED Bordeaux VLAN 20/40 addressing, DHCP ranges and target DNS | User approved in MAIN PROGRESSION; no change to Lyon source-required values | User (Master) | E04, E05, E06, E07 |
| 2026-11-07 | A01–A05 | E05 core policy awaiting Main Progression acceptance | APPROVED/LOCKED principles only; technical RPC/RDP/server updates/Zabbix-active exceptions remain PROPOSED/PENDING | Explicit user acceptance; prevent accidental blanket approval of 38 ALLOW candidates | User (Master) | E05, E06, E12–E17 |
