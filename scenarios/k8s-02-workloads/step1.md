# Étape 1 — Deployment et scaling

## 1. Créer le Deployment

```bash
cat > /root/deployment.yaml << 'EOF'
apiVersion: apps/v1
kind: Deployment
metadata:
  name: webapp
  labels:
    app: webapp
spec:
  replicas: 3
  selector:
    matchLabels:
      app: webapp
  template:
    metadata:
      labels:
        app: webapp
        version: "1.0"
    spec:
      containers:
        - name: nginx
          image: nginx:1.24
          ports:
            - containerPort: 80
          resources:
            requests:
              cpu: "50m"
              memory: "32Mi"
            limits:
              cpu: "100m"
              memory: "64Mi"
EOF
```{{exec}}

`kubectl apply -f /root/deployment.yaml`{{exec}}

## 2. Vérifier le déploiement

`kubectl get deployment webapp`{{exec}}

`kubectl rollout status deployment/webapp`{{exec}}

`kubectl get pods -l app=webapp`{{exec}}

`kubectl get replicaset`{{exec}}

## 3. Scaler le Deployment

`kubectl scale deployment webapp --replicas=5`{{exec}}

`kubectl get pods -l app=webapp -w`{{exec}}

> Appuyez sur Ctrl+C pour arrêter le watch

## 4. Réduire les replicas

`kubectl scale deployment webapp --replicas=3`{{exec}}

`kubectl get pods`{{exec}}

> Cliquez sur **Check** quand le Deployment `webapp` a 3 pods Running.
