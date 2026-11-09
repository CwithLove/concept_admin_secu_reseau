# VALCRÉA TP01 — E09 — Commandes Open vSwitch

**Référentiel :** E08 v1.9.0 ; TP01 p. 3 et 8–9 ; Support de formation p. 16–17.  
**Portée :** SW-LYON uniquement. Aucune action E10 sur pfSense.

## Préparation et sauvegarde

- Topologie `VALCREA-LAB` rouverte dans GNS3 ; 10 nœuds et 10 liens observés dans les captures de la session.
- Sauvegarde du fichier `.gns3` : `VALCREA-LAB-E01-RECOVERY.gns3` ; somme SHA-256 identique au fichier source : `96c420670f8b5be5cc8c0fb3952886d7db2b38aad342646f6f88f9ebe6f53ce4`.
- La création du snapshot global `PRE-E09` **a échoué** : `Timeout when downloading file .../hda_disk.qcow2 from remote compute 127.0.0.1:3081`. Le répertoire `snapshots` Windows a été inspecté et était vide.
- Sauvegarde ciblée des fichiers Docker du nœud SW-LYON UUID `76db6c75-1364-4cd2-849c-96c97404dd3a` dans `SW-LYON-PRE-E09.tar.gz`. `gzip -t` : PASS ; SHA-256 : `e2e89d87a274e725097faf2f8cec9e3c018b3fe0bcd7d7d3930f91fcb51ad7c2`. **Restauration non testée.**

## Inspection initiale (lecture seule)

```sh
ovs-vsctl show
```

Résultat observé : bridge `br0` avec `eth0` à `eth15` ; aucun tag/trunk constaté dans la capture initiale. Bridges internes `br1`, `br2`, `br3` également présents.

## Commandes exécutées

Configuration individuelle exécutée et vérifiée d'abord :

```sh
ovs-vsctl set port eth0 vlan_mode=trunk trunks=10,20,30,40,50
ovs-vsctl list port eth0
ovs-vsctl set port eth1 vlan_mode=access tag=10
ovs-vsctl get port eth1 vlan_mode
ovs-vsctl get port eth1 tag
ovs-vsctl get port eth1 trunks
ovs-vsctl set port eth2 vlan_mode=access tag=10
ovs-vsctl get port eth2 vlan_mode
ovs-vsctl get port eth2 tag
ovs-vsctl get port eth2 trunks
```

Configuration complète, exécutée ensuite en transaction unique (retranscrite d'après la capture utilisateur) :

```sh
ovs-vsctl \
  -- set port eth0 vlan_mode=trunk trunks=10,20,30,40,50 \
  -- set port eth1 vlan_mode=access tag=10 trunks=[] \
  -- set port eth2 vlan_mode=access tag=10 trunks=[] \
  -- set port eth3 vlan_mode=access tag=30 trunks=[] \
  -- set port eth4 vlan_mode=access tag=20 trunks=[] \
  -- set port eth5 vlan_mode=access tag=40 trunks=[] \
  -- set port eth6 vlan_mode=access tag=50 trunks=[] \
  -- set port eth7 vlan_mode=access tag=999 trunks=[] \
  -- set port eth8 vlan_mode=access tag=999 trunks=[] \
  -- set port eth9 vlan_mode=access tag=999 trunks=[] \
  -- set port eth10 vlan_mode=access tag=999 trunks=[] \
  -- set port eth11 vlan_mode=access tag=999 trunks=[] \
  -- set port eth12 vlan_mode=access tag=999 trunks=[] \
  -- set port eth13 vlan_mode=access tag=999 trunks=[] \
  -- set port eth14 vlan_mode=access tag=999 trunks=[] \
  -- set port eth15 vlan_mode=access tag=999 trunks=[]
```

## Vérifications exécutées

```sh
ovs-vsctl --format=table --columns=name,vlan_mode,tag,trunks list port
ovs-vsctl show
```

La capture du tableau des ports confirme les 16 interfaces attendues. La capture finale `E09_OVS_SHOW_CAPTURE.png` confirme les lignes visibles dans la sortie native OVS ; son bas est coupé. Les deux captures de la conversation constituent ensemble les preuves de configuration.

## Limites

- Vérification de configuration OVS : PASS.
- Trames 802.1Q, connectivité des hôtes, DHCP, inter-VLAN, pfSense : NOT_TESTED (E10 et étapes ultérieures).
- Persistance après redémarrage ou recréation de container : NOT_TESTED.
- Le snapshot global `PRE-E09` n'est pas disponible ; l'archive Docker constitue uniquement une sauvegarde ciblée.
