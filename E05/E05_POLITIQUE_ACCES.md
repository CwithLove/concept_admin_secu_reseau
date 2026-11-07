# E05 — Politique d'accès Valcréa

**Statut : PROPOSÉ — revue MAIN PROGRESSION requise.** Références : TP01 p.3,6,11–13 ; Support p.11,19 ; E03 exigences F01–F09/NF05 ; E04 plan ; MAIN_STATE et DECISIONS v1.5.0.

## Principes
- **Refus par défaut**, pare-feu à états, règles évaluées de haut en bas sur l'interface d'entrée. Aucun ANY→ANY ALLOW.
- Autoriser seulement les couples source/destination/port justifiés ; journaliser les refus sensibles sans saturer les logs.
- Les règles ALLOW proposées restent à approuver/affiner avant E13. Les ports indiqués par le TP sont des repères, pas une obligation d'ouvrir tous les ports.
- Une règle vers « Internet public hors RFC1918 » exige à E13 des alias/blocages privés **avant** l'autorisation web, y compris accès au pare-feu lui-même.

## Par zone
| Zone | Autorisé | Interdit / limite |
|---|---|---|
| Lyon UTILISATEURS 10.10.20.0/24 | AD/DNS/SMB sur 10.10.10.10, web 80/443 | ADMIN, autres zones non justifiées |
| Lyon SERVEURS 10.10.10.0/24 | DNS/NTP nécessaires, mises à jour ciblées | Accès sortants non justifiés |
| Lyon ADMIN 10.10.30.0/24 | Administration ciblée FW/serveurs, supervision | Pas d'ANY→ANY ; maintenir anti-lockout pfSense |
| Lyon INVITES 10.10.40.0/24 | DNS 10.10.40.1, web Internet | Tous réseaux internes et GUI pfSense |
| Lyon ATELIER 10.10.50.0/24 | AD et partage Production sur SRV-AD01 | Aucun Internet ; aucun accès latéral |
| VPN 10.10.90.0/24 | DNS et SMB vers SRV-AD01 après OpenVPN UDP 1194 | Aucun accès VLAN ADMIN ni accès général |
| Bordeaux UTILISATEURS 10.20.20.0/24 | DNS/AD/fichiers Lyon via **future liaison sécurisée**, web | ADMIN ; aucun tunnel prétendu opérationnel |
| Bordeaux INVITES 10.20.40.0/24 | DNS local 10.20.40.1 et web | Réseaux internes Lyon/Bordeaux |
| VLAN 999 / Nantes réserve | Aucun flux routé | Non déployés |

## Cas particuliers et dépendances
- **AD :** DNS 53, Kerberos 88/464, LDAP 389, SMB 445 sont documentés ; RPC 135 et plage dynamique 49152–65535 sont **PROPOSED/conditionnels**, uniquement vers SRV-AD01 et après justification technique. LDAPS 636 et catalogue global 3268/3269 ne sont pas ouverts sans usage identifié. L'accès DNS/SMB du VPN suit le TP ; les besoins d'authentification supplémentaires sont à vérifier.
- **Production/RH :** SMB 445 n'accorde pas les droits aux fichiers. Les ACL AGDLP/NTFS de E12 doivent limiter RH à Direction/Comptabilité et Production en lecture seule pour Atelier.
- **Supervision :** Zabbix 10.10.10.20 → pfSense 10.10.10.1 UDP 161 ; Zabbix → AD TCP 10050. TCP 10051 seulement si agent actif choisi. Le trafic au sein d'un même VLAN 10 ne traverse pas nécessairement pfSense : les pare-feu hôtes sont aussi nécessaires.
- **DHCP :** service local pfSense par interface Lyon ; les échanges DHCP locaux ne constituent pas une autorisation inter-VLAN. Bordeaux B03 (hébergement DHCP/DNS/résilience) reste PENDING.
- **VPN :** V01 (allocation réelle du pool 10.10.90.0/24) reste PENDING ; ne pas créer de gateway fictive.
- **Bordeaux :** B01/B02 approuvés, mais le mode d'hébergement B03 et le lien intersites ne le sont pas. Pas de VLAN Bordeaux à ajouter au GNS3 Lyon.
- **CAP01** inventaire matériel et **NF03/R13** délai de transfert CAO restent PENDING.
- **Exceptions à approuver :** RPC dynamique AD (F06 et F43), RDP interne ADMIN, SSH/HTTPS équipements inventoriés, mises à jour sortantes, agent Zabbix actif et modalités précises intersites. Aucune de ces propositions ne vaut configuration.

## Contrôles futurs E13/E17
1. Ordre des règles pfSense et exceptions anti-lockout ADMIN ; suppression de la règle TEMPORAIRE SERVEURS en E13.
2. Test VLAN INVITES : Internet HTTPS OK, aucun serveur ni GUI accessible ; logs des refus.
3. Test ATELIER : Production en lecture, aucune sortie Internet.
4. Test UTILISATEURS : SMB et AD OK, ADMIN inaccessible ; vérifier ACL RH séparément.
5. Test WAN : UDP 1194 VPN uniquement, **aucun RDP TCP 3389** publié.
6. Test VPN : fichiers autorisés OK, ADMIN inaccessible ; confirmer V01.
7. Test Zabbix SNMP/agent et règles de pare-feu Windows ; vérifier la liaison Bordeaux uniquement après déploiement.

**E05 est documentaire : tous les tests GNS3/pfSense/Windows/OVS restent NOT_TESTED.**
