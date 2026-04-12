# Étape 1 — StatefulSet et DNS stable

Déployez une application avec état et observez l'identité stable des pods.

## 1. Créer le Service Headless

*Créez le fichier `/root/headless-svc.yaml` définissant un Service headless (clusterIP: None) nommé `db-headless` avec le label `app: db`, ciblant les pods avec `app: db`, exposant le port 80 nommé `web`.*

*Appliquez le manifest pour créer le Service headless.*

## 2. Créer le StatefulSet

*Créez le fichier `/root/statefulset.yaml` définissant un StatefulSet nommé `db` avec 3 replicas, référençant le Service headless `db-headless`, avec des pods utilisant l'image `nginx:1.25` sur le port 80 et le label `app: db`.*

*Appliquez le manifest pour créer le StatefulSet.*

## 3. Observer la création ordonnée

*Observez en temps réel la création des pods pour constater l'ordre séquentiel (db-0, puis db-1, puis db-2).*

> Ctrl+C après avoir vu db-0, db-1, db-2 apparaître **séquentiellement**

## 4. Vérifier les noms stables

*Listez les pods portant le label `app=db` pour voir leurs noms prévisibles.*

> Les pods ont des noms prévisibles : `db-0`, `db-1`, `db-2`

## 5. Tester la résolution DNS pod-par-pod

*Lancez un pod temporaire `busybox:1.36` pour résoudre le nom DNS complet du pod `db-0` : `db-0.db-headless.default.svc.cluster.local`.*

> Format DNS : `<pod-name>.<service-headless>.<namespace>.svc.cluster.local`

## Validation

> Cliquez sur **Check** quand les 3 pods du StatefulSet sont en état `Running`.
