# Étape 1 — Explorer le cluster

Prenez connaissance du cluster avant de déployer quoi que ce soit.

## 1. Vérifier l'état du cluster

*Affichez les informations générales du cluster (adresses du control plane et de CoreDNS).*

*Listez les nœuds du cluster.*

*Listez les nœuds avec leurs informations détaillées (IP interne/externe, OS, version du kernel, version de kubelet).*

> Vous devez voir 2 nœuds : `controlplane` (Ready) et `node01` (Ready)

## 2. Explorer les namespaces

*Listez tous les namespaces existants dans le cluster.*

*Listez les pods du namespace `kube-system`.*

> Repérez les composants : `coredns`, `etcd`, `kube-apiserver`, `kube-scheduler`, `kube-controller-manager`, `kube-proxy`

## 3. Voir toutes les ressources du cluster

*Affichez toutes les ressources de tous les namespaces.*

## 4. Explorer les types de ressources disponibles

*Listez les types de ressources disponibles dans l'API Kubernetes et limitez l'affichage aux 20 premiers résultats.*

## Validation

Vérifiez que les 2 nœuds sont en état `Ready` :

*Listez les nœuds du cluster et vérifiez que les 2 sont en état Ready.*

> Cliquez sur **Check** quand les 2 nœuds sont Ready.
