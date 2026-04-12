# Étape 3 — Maintenance d'un nœud

Mettre un nœud en maintenance sans interrompre les applications.

## 1. Vérifier la répartition actuelle des pods

*Listez tous les pods avec leurs informations étendues (notamment le nœud d'exécution).*

> Les pods du deployment `demo-admin` sont répartis sur les 2 nœuds

## 2. Cordonner le nœud (marquer non-schedulable)

*Cordonner le nœud `node01` pour l'empêcher d'accueillir de nouveaux pods.*

*Listez les nœuds pour voir le changement de statut.*

> Le statut de `node01` est maintenant `Ready,SchedulingDisabled`
> Les pods existants restent en place — seuls les NOUVEAUX pods ne seront pas schedulés sur ce nœud

## 3. Drainer le nœud (éviction des pods)

*Drainez le nœud `node01` en ignorant les DaemonSets et en autorisant la suppression des pods avec volumes emptyDir.*

> `--ignore-daemonsets` : ne pas bloquer sur les DaemonSets (kube-proxy, etc.)
> `--delete-emptydir-data` : supprimer les pods avec volumes emptyDir

## 4. Vérifier que les pods ont migré

*Listez les pods avec leurs informations étendues pour confirmer la migration vers `controlplane`.*

> Tous les pods `demo-admin` sont maintenant sur `controlplane`

*Listez les nœuds pour vérifier leur état.*

## 5. Remettre le nœud en service

Après la maintenance (mises à jour OS, remplacement disque, etc.) :

*Décordonner le nœud `node01` pour lui permettre d'accueillir de nouveaux pods.*

*Listez les nœuds pour confirmer le retour à l'état `Ready`.*

> Le nœud est de nouveau `Ready` — les nouveaux pods peuvent y être schedulés
> Note : les pods existants ne migrent pas automatiquement

## Validation

> Cliquez sur **Check** quand `node01` est de nouveau en état `Ready` (uncordonné).
