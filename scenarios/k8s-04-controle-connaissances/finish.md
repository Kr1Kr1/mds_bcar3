# Quiz Terminé !

Félicitations, vous avez complété les 3 étapes du contrôle de connaissances sur l'architecture Kubernetes.

## Afficher votre bilan

`bash /root/quiz_results.sh`{{exec}}

> Le bilan affiche votre score par étape et votre total.
> **Montrez ce résultat à votre formateur.**

---

## Points clés à retenir

- **API Server** = seul point d'entrée, seul à accéder etcd directement
- **etcd** = mémoire du cluster, critique, à sauvegarder
- **Scheduler** = décide où placer, ne lance rien
- **Controller Manager** = boucle de réconciliation infinie
- **Kubelet** = agent sur chaque node, lance les conteneurs via CRI
- **Réconciliation** = déclaratif → K8s garantit l'état désiré en permanence
- **CNI** = plugin réseau obligatoire (Calico, Flannel, Cilium)

## Ressource de référence

[blog.stephane-robert.info — Architecture Kubernetes](https://blog.stephane-robert.info/docs/conteneurs/orchestrateurs/kubernetes/architecture/)
