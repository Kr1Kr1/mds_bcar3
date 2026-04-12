# Étape 3 — Stockage persistant avec PVC

Les pods sont éphémères. Utilisez un PersistentVolumeClaim pour conserver les données.

## 1. Voir les StorageClasses disponibles

*Listez les StorageClasses disponibles dans le cluster.*

> La StorageClass `local-path` (ou équivalent) est le provisioner par défaut sur ce cluster

## 2. Créer un PersistentVolumeClaim

*Créez le fichier `/root/pvc.yaml` définissant un PersistentVolumeClaim nommé `mon-pvc` avec le mode d'accès `ReadWriteOnce` et une capacité demandée de 100Mi.*

*Appliquez le manifest pour créer le PVC.*

*Listez les PersistentVolumeClaims pour voir l'état de `mon-pvc`.*

> Le PVC passe en `Bound` — un PersistentVolume est provisionné dynamiquement

*Listez les PersistentVolumes pour voir le volume provisionné automatiquement.*

> Le PV créé automatiquement par la StorageClass est visible ici

## 3. Monter le PVC dans un Pod

*Créez le fichier `/root/pod-pvc.yaml` définissant un Pod nommé `pod-avec-pvc` avec l'image `busybox:1.36` exécutant une boucle `sleep 3600`, montant le PVC `mon-pvc` dans le répertoire `/data`.*

*Appliquez le manifest pour créer le Pod.*

*Vérifiez que le Pod `pod-avec-pvc` est en état Running.*

## 4. Écrire des données

*Exécutez une commande dans le Pod pour écrire le texte `données persistantes` dans le fichier `/data/test.txt`.*

*Affichez le contenu du fichier `/data/test.txt` pour vérifier l'écriture.*

## 5. Supprimer le pod et vérifier la persistance

*Supprimez le Pod `pod-avec-pvc`.*

*Recréez le Pod en réappliquant le manifest.*

*Attendez que le Pod soit dans l'état Ready (timeout 60s).*

*Affichez le contenu du fichier `/data/test.txt` dans le nouveau Pod pour confirmer que les données sont toujours là.*

> Les données sont toujours là — le PVC persiste indépendamment du pod

## Validation

> Cliquez sur **Check** quand le PVC `mon-pvc` est en état `Bound`.
