# E09_HANDOFF — VALCRÉA TP01

**Référentiel :** E08 v1.9.0 · **Mode :** SOLO · **Décision MAIN PROGRESSION :** en attente.  
**Statut proposé :** `PARTIAL` — configuration OVS **PASS**, snapshot global **FAIL**, persistance et tests de trafic **NOT_TESTED**.  
**Temps actif réel :** `UNKNOWN` (non mesuré).

## Bilan

| Action réalisée | Vérification | Résultat | Preuve |
|---|---|---|---|
| Réouverture VALCREA-LAB | 10 nœuds, 10 liens et mapping SW-LYON eth0–eth6 | PASS | Captures GUI en conversation |
| Vérification WSL2/Docker/OVS | Docker répond ; `ovs-vsctl show` | PASS | Sorties utilisateur |
| Sauvegarde ciblée SW-LYON | Archive lisible (`tar -tzf`, `gzip -t`) ; SHA-256 relevé | PASS | Sorties utilisateur ; archive sur poste |
| Snapshot GNS3 `PRE-E09` | Téléchargement distant du QCOW2 échoue (timeout) | FAIL | Message d'erreur utilisateur |
| Trunk eth0 | VLAN 10,20,30,40,50 ; mode trunk | PASS | Capture console OVS |
| Access eth1–eth6 | 10,10,30,20,40,50 | PASS | Capture tableau OVS |
| Parking eth7–eth15 | Access VLAN 999 | PASS | Capture tableau OVS |
| Vérification finale | `ovs-vsctl show` | PASS pour les lignes visibles ; tableau complet séparé | `E09_OVS_SHOW_CAPTURE.png` |

## Points importants

- L'état courant des **16 ports OVS** est conforme au TP01 p.3 et p.8–9 ; aucun adressage, VLAN imposé ni décision canonique modifié.
- Échec du snapshot global : `Timeout when downloading file .../hda_disk.qcow2 from remote compute 127.0.0.1:3081`. L'archive ciblée **n'est pas équivalente** au snapshot intégral. Restauration non testée.
- Le disque SRV-AD01 présent sur WSL2 mesure 16,7 GiB et utilise un backing file ; metadata des deux QCOW2 lisibles avec `corrupt: false` (intégrité complète non testée).
- Aucun test réel du trafic VLAN, aucune vérification de persistance après redémarrage/recréation du container.
- E10 non entamée ; ne pas déclarer les interfaces pfSense, routes, DHCP ou DNS comme réalisées.

## Livrables / preuves

- `E09_OVS_COMMANDES.md` : commandes utilisées et précautions.
- `E09_OVS_VERIFICATIONS.txt` : tableau de vérification PASS/FAIL/NOT_TESTED.
- `E09_OVS_SHOW_CAPTURE.png` : capture finale OVS (partie basse tronquée).
- Capture console tableau complet OVS et mapping GNS3 : fournies dans la conversation ; à archiver dans les preuves E09.
- Archive `SW-LYON-PRE-E09.tar.gz` : sur le poste utilisateur, non transférée ici ; checksum `e2e89d87a274e725097faf2f8cec9e3c018b3fe0bcd7d7d3930f91fcb51ad7c2`.

## Conditions de passage à E10

MAIN PROGRESSION doit examiner ce handoff et accepter explicitement le traitement du snapshot global manquant. Avant modification E10, vérifier l'état courant d'OVS et prévoir une protection suffisante des disques pfSense ; ne pas supposer la persistance des VLAN après recréation Docker. Aucun changement des décisions canoniques demandé.
