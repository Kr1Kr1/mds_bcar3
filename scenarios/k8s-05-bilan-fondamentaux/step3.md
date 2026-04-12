# Étape 3 — Namespaces, CoreDNS, vision d'ensemble

## 1. Lancer le quiz

`bash /root/quiz_step3.sh`{{exec}}

## 2. Voir le bilan final

`bash /root/quiz_results.sh`{{exec}}

---

## À retenir avant de répondre

**Namespaces — isolation logique**

- Isolent : noms de ressources, RBAC, ResourceQuota, LimitRange
- **N'isolent PAS** par défaut : le réseau inter-pods (→ NetworkPolicy), les ressources physiques
- Pack minimum production : **ResourceQuota + LimitRange + NetworkPolicy + RBAC**

**CoreDNS — format DNS**

```
<service>.<namespace>.svc.cluster.local
```

- Depuis le même namespace : `mon-service` suffit
- Cross-namespace : `mon-service.autre-namespace`
- FQDN complet toujours valide

**dnsPolicy**

| Valeur | Comportement |
|---|---|
| ClusterFirst (défaut) | CoreDNS en premier, DNS nœud en fallback |
| Default | DNS du nœud uniquement |
| None | Configuration manuelle via `dnsConfig` |

**ndots:5** — problème de performance : K8s fait jusqu'à 6 requêtes DNS pour un domaine externe

---

Répondez aux 8 questions, puis cliquez sur **Check**.
