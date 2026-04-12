#!/bin/bash
# Vérifier que le snapshot etcd existe et est valide
if [ ! -f /backup/etcd-snapshot.db ]; then
  echo "ERREUR : /backup/etcd-snapshot.db introuvable"
  echo "Lancez la commande etcdctl snapshot save"
  exit 1
fi
SIZE=$(stat -c%s /backup/etcd-snapshot.db 2>/dev/null)
if [ "$SIZE" -gt 10000 ]; then
  echo "✓ Snapshot etcd créé (/backup/etcd-snapshot.db — $(ls -lh /backup/etcd-snapshot.db | awk '{print $5}'))"
  exit 0
fi
echo "ERREUR : Le fichier snapshot semble invalide (taille trop petite : $SIZE octets)"
exit 1
