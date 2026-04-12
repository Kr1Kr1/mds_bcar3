# Kubernetes — Workloads avancés

Bienvenue dans ce TP sur les workloads avancés Kubernetes !

Ce scénario utilise un cluster **kubeadm** à 2 nœuds (1 control-plane + 1 worker).

## Objectifs

À la fin de ce TP, vous saurez :
- Créer un **StatefulSet** avec identité stable et DNS par pod
- Déployer un **DaemonSet** sur tous les nœuds
- Contrôler le scheduling avec les **taints et tolerations**

## Rappel

```bash
kubectl get pods -w         # observer les pods en temps réel
kubectl describe pod <nom>  # inspecter le scheduling d'un pod
```

Tous les exercices sont à faire depuis le **nœud controlplane**.
