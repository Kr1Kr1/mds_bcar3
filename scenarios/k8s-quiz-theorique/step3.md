# Étape 3 — Workloads, Services & Configuration

Ces questions portent sur les **objets K8s fondamentaux** : Pods, Deployments, Services, ConfigMaps, Secrets et Namespaces.

## Lancer le quiz

`bash /root/quiz_step3.sh`{{exec}}

---

## À retenir avant de répondre

**Hiérarchie des workloads**
`Deployment → ReplicaSet → Pod(s)`

| Objet | Rôle |
|---|---|
| **Pod** | Plus petite unité déployable — 1 ou plusieurs conteneurs |
| **ReplicaSet** | Garantit N replicas d'un pod |
| **Deployment** | Gère les ReplicaSets, rolling update, rollback |

**Services**

| Type | Portée |
|---|---|
| ClusterIP | Interne uniquement (défaut) |
| NodePort | Expose sur les nœuds (port 30000-32767) |
| LoadBalancer | IP publique via cloud provider |

**Configuration**

| Objet | Contenu |
|---|---|
| ConfigMap | Données non sensibles (env vars, fichiers config) |
| Secret | Données sensibles (mots de passe, tokens) — encodées en base64 |
| Namespace | Isolation logique des ressources dans le cluster |

**DNS interne** : `<service>.<namespace>.svc.cluster.local`

---

Quand vous avez répondu aux 8 questions, cliquez sur **Check**.
