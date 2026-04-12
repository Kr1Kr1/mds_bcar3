# Étape 3 — Inspecter et déboguer

Apprenez à diagnostiquer l'état d'un pod.

## 1. Décrire le pod en détail

`kubectl describe pod nginx-pod`{{exec}}

> Repérez : les **Events**, les **Conditions**, les **Limits/Requests**, l'IP du pod

## 2. Voir les logs

`kubectl logs nginx-pod`{{exec}}

`kubectl logs nginx-pod --tail=5`{{exec}}

## 3. Exécuter une commande dans le conteneur

`kubectl exec nginx-pod -- nginx -v`{{exec}}

`kubectl exec -it nginx-pod -- sh`{{exec}}

Dans le conteneur, explorez :
```sh
cat /etc/nginx/nginx.conf
curl localhost
exit
```

## 4. Port-forward pour tester depuis l'hôte

`kubectl port-forward pod/nginx-pod 8080:80 &`{{exec}}

`curl localhost:8080`{{exec}}

`kill %1`{{exec}}

## 5. Voir le YAML complet

`kubectl get pod nginx-pod -o yaml | head -50`{{exec}}

## 6. Nettoyer

`kubectl delete pod nginx-pod`{{exec}}

`kubectl get pods`{{exec}}

> Cliquez sur **Check** quand le pod est supprimé.
