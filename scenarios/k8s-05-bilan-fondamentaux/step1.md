# Étape 1 — Pods, ReplicaSets, Deployments

## 0. S'identifier

`bash /root/set_pseudo.sh`{{exec}}

## 1. Lancer le quiz

`bash /root/quiz_step1.sh`{{exec}}

---

## À retenir avant de répondre

**Pod — rappels clés**

| Concept | Détail |
|---|---|
| Partage dans un Pod | Réseau (IP), volumes, cycle de vie |
| Phases | Pending → Running → Succeeded / Failed / Unknown |
| restartPolicy | Always (défaut), OnFailure, Never |
| Backoff exponentiel | 10s → 20s → 40s → … → 300s (max 5 min) |
| Readiness Probe | Retire le pod du Service si KO |
| Liveness Probe | Redémarre le conteneur si KO |

**ReplicaSet vs Deployment**

- Le ReplicaSet garantit N replicas mais **ne fait pas de rolling update**
- Changer l'image d'un RS existant → seuls les **nouveaux** pods ont la nouvelle image
- Le **Deployment** crée un nouveau RS pour chaque mise à jour → rolling update propre

**Deployment — champs importants**

- `revisionHistoryLimit` : nombre de RS gardés pour le rollback (défaut: 10)
- `minReadySeconds` : délai avant de considérer un pod "ready"
- `readinessProbe` : **critique** pour un rolling update sans coupure

---

Répondez aux 9 questions, puis cliquez sur **Check**.
