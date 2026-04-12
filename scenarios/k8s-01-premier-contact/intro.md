# Kubernetes — Premier contact

Bienvenue sur votre premier cluster Kubernetes !

Ce scénario utilise un cluster **kubeadm** à 2 nœuds (1 control-plane + 1 worker).

## Objectifs

À la fin de ce TP, vous saurez :
- Explorer l'état d'un cluster avec `kubectl`
- Comprendre les composants du système (namespace `kube-system`)
- Créer votre premier Pod depuis un manifest YAML
- Inspecter, déboguer et supprimer des ressources

## Outil principal

```bash
kubectl <verbe> <ressource> [nom] [options]
```

Tous les exercices sont à faire depuis le **nœud controlplane**.
