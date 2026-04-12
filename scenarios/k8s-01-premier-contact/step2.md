# Étape 2 — Premier Pod

Créez votre premier Pod depuis un manifest YAML.

## 1. Créer le manifest

```bash
cat > /root/premier-pod.yaml << 'EOF'
apiVersion: v1
kind: Pod
metadata:
  name: nginx-pod
  labels:
    app: nginx
    env: lab
spec:
  containers:
    - name: nginx
      image: nginx:1.25
      ports:
        - containerPort: 80
      resources:
        requests:
          memory: "64Mi"
          cpu: "100m"
        limits:
          memory: "128Mi"
          cpu: "200m"
EOF
```{{exec}}

## 2. Appliquer le manifest

`kubectl apply -f /root/premier-pod.yaml`{{exec}}

## 3. Vérifier le statut

`kubectl get pods`{{exec}}

`kubectl get pod nginx-pod -o wide`{{exec}}

> Attendez que le pod soit en état `Running` (téléchargement de l'image peut prendre quelques secondes)

## 4. Inspecter les labels

`kubectl get pods --show-labels`{{exec}}

`kubectl get pods -l app=nginx`{{exec}}

> Cliquez sur **Check** quand `nginx-pod` est en état `Running`.
