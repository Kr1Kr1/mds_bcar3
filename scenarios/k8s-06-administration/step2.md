# Étape 2 — Backup etcd

etcd est la base de données de tout le cluster. Son backup est critique.

## 1. Préparer le répertoire de backup

*Créez le répertoire `/backup` s'il n'existe pas encore.*

## 2. Récupérer les paramètres etcd

Les certificats sont montés dans le pod etcd. Récupérons les chemins :

*Décrivez le pod etcd dans le namespace `kube-system` et filtrez les lignes contenant les mots-clés `cacert`, `cert`, `key` et `endpoints` pour identifier les chemins des certificats.*

## 3. Créer le snapshot

*Utilisez `etcdctl` (API v3) pour créer un snapshot d'etcd et le sauvegarder dans `/backup/etcd-snapshot.db`, en spécifiant l'endpoint `https://127.0.0.1:2379` et les certificats situés dans `/etc/kubernetes/pki/etcd/` (ca.crt, server.crt, server.key).*

> Si la commande réussit, vous verrez : `Snapshot saved at /backup/etcd-snapshot.db`

## 4. Vérifier l'intégrité du snapshot

*Utilisez `etcdctl` pour vérifier l'intégrité et afficher le statut du snapshot `/backup/etcd-snapshot.db` en format tableau.*

> La colonne **TOTAL KEY** indique le nombre de ressources K8s sauvegardées (plusieurs milliers sur un cluster actif)

## 5. Vérifier que le fichier existe

*Listez le fichier `/backup/etcd-snapshot.db` avec ses informations détaillées (taille, date, etc.).*

> En production : stocker ce fichier hors du cluster (S3, NFS, stockage distant)

## Validation

> Cliquez sur **Check** quand le fichier `/backup/etcd-snapshot.db` est créé.
