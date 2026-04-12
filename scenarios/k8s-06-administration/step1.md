# Étape 1 — Inspecter le control plane

Avant toute opération de maintenance, commencez par vérifier l'état du cluster.

## 1. État général du cluster

*Affichez les informations générales du cluster (adresses du control plane et de CoreDNS).*

*Listez les nœuds avec leurs informations détaillées.*

> Vous devez voir 2 nœuds : `controlplane` (Ready) et `node01` (Ready)

## 2. Composants du control plane

*Listez les pods du namespace `kube-system` pour voir tous les composants.*

> Repérez : `kube-apiserver`, `etcd`, `kube-scheduler`, `kube-controller-manager`, `coredns`, `kube-proxy`

## 3. Inspecter le pod etcd

*Décrivez le pod `etcd` dans le namespace `kube-system` (filtrez par label `component=etcd`).*

> Repérez dans la section **Command** : les chemins des certificats et l'endpoint `--listen-client-urls`

## 4. Logs du kube-apiserver

*Affichez les 20 dernières lignes de logs du pod `kube-apiserver` dans le namespace `kube-system`.*

## 5. Vérifier les certificats kubeadm

*Vérifiez la date d'expiration des certificats du cluster avec kubeadm.*

> Vérifiez que les certificats ne sont pas expirés (colonne **RESIDUAL TIME**)

## Validation

Vérifiez que tous les pods system sont Running :

*Listez les pods du namespace `kube-system` et vérifiez que tous sont en état Running.*

> Cliquez sur **Check** quand tous les composants sont en état `Running`.
