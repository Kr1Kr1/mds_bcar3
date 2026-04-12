# Étape 1 — Explorer le cluster

Prenez connaissance du cluster avant de déployer quoi que ce soit.

## 1. Vérifier l'état du cluster

`kubectl cluster-info`{{exec}}

`kubectl get nodes`{{exec}}

`kubectl get nodes -o wide`{{exec}}

> Vous devez voir 2 nœuds : `controlplane` (Ready) et `node01` (Ready)

## 2. Explorer les namespaces

`kubectl get namespaces`{{exec}}

`kubectl get pods -n kube-system`{{exec}}

> Repérez les composants : `coredns`, `etcd`, `kube-apiserver`, `kube-scheduler`, `kube-controller-manager`, `kube-proxy`

## 3. Voir toutes les ressources du cluster

`kubectl get all -A`{{exec}}

## 4. Explorer les types de ressources disponibles

`kubectl api-resources | head -20`{{exec}}

## Validation

Vérifiez que les 2 nœuds sont en état `Ready` :

`kubectl get nodes`{{exec}}

> Cliquez sur **Check** quand les 2 nœuds sont Ready.
