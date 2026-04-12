# Étape 1 — NetworkPolicies : isolation réseau

Par défaut, tous les pods peuvent communiquer entre eux. Mettez en place une isolation.

## 1. Préparer les namespaces et applications

*Créez les namespaces `frontend` et `backend`, puis lancez un pod `frontend-pod` (image `nicolaka/netshoot`, label `app=frontend`) dans le namespace `frontend` avec la commande `sleep 3600`. Créez également un pod `backend-pod` (image `nginx:1.25`, label `app=backend`) dans le namespace `backend` et exposez-le avec un Service `backend-svc` sur le port 80.*

*Listez les pods de tous les namespaces et attendez qu'ils soient Running.*

> Attendez que les pods soient Running

## 2. Tester la communication AVANT NetworkPolicy

*Depuis le pod `frontend-pod` dans le namespace `frontend`, envoyez une requête HTTP vers `http://backend-svc.backend.svc.cluster.local` avec un timeout de 3 secondes.*

> La communication réussit — par défaut tout est ouvert

## 3. Appliquer un default-deny sur le namespace backend

*Créez le fichier `/root/default-deny.yaml` définissant une NetworkPolicy nommée `default-deny-ingress` dans le namespace `backend`, ciblant tous les pods (`podSelector: {}`), bloquant tout trafic Ingress.*

*Appliquez le manifest pour créer la NetworkPolicy.*

## 4. Tester : la communication est maintenant bloquée

*Depuis le pod `frontend-pod`, envoyez de nouveau une requête HTTP vers `http://backend-svc.backend.svc.cluster.local` avec un timeout de 3 secondes.*

> Timeout — le trafic est bloqué par la NetworkPolicy

## 5. Autoriser uniquement le trafic depuis frontend

*Créez le fichier `/root/allow-frontend.yaml` définissant une NetworkPolicy nommée `allow-from-frontend` dans le namespace `backend`, ciblant les pods avec le label `app: backend`, autorisant le trafic Ingress TCP sur le port 80 uniquement depuis les pods avec le label `app: frontend` du namespace `frontend` (utilisez un `namespaceSelector` avec `kubernetes.io/metadata.name: frontend` combiné avec un `podSelector`).*

*Appliquez le manifest pour créer la NetworkPolicy.*

## 6. Vérifier que la communication est restaurée

*Depuis le pod `frontend-pod`, envoyez une requête HTTP vers `http://backend-svc.backend.svc.cluster.local` et affichez les 5 premières lignes de la réponse.*

> Le trafic frontend→backend est de nouveau autorisé

## Validation

> Cliquez sur **Check** quand les 2 NetworkPolicies sont créées dans le namespace backend.
