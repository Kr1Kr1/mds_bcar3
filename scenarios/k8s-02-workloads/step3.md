# Étape 3 — Service : exposer l'application

## 1. Créer un Service ClusterIP

```bash
cat > /root/service-clusterip.yaml << 'EOF'
apiVersion: v1
kind: Service
metadata:
  name: webapp-svc
spec:
  type: ClusterIP
  selector:
    app: webapp
  ports:
    - port: 80
      targetPort: 80
EOF
```{{exec}}

`kubectl apply -f /root/service-clusterip.yaml`{{exec}}

`kubectl get svc webapp-svc`{{exec}}

## 2. Tester le ClusterIP

`kubectl run test-curl --image=curlimages/curl --rm -it --restart=Never -- curl webapp-svc`{{exec}}

> Le Service répartit les requêtes entre les 3 pods

## 3. Créer un Service NodePort

```bash
cat > /root/service-nodeport.yaml << 'EOF'
apiVersion: v1
kind: Service
metadata:
  name: webapp-nodeport
spec:
  type: NodePort
  selector:
    app: webapp
  ports:
    - port: 80
      targetPort: 80
      nodePort: 30080
EOF
```{{exec}}

`kubectl apply -f /root/service-nodeport.yaml`{{exec}}

`kubectl get svc`{{exec}}

## 4. Tester le NodePort depuis l'hôte

`curl http://localhost:30080`{{exec}}

## 5. Vérifier les Endpoints

`kubectl get endpoints webapp-svc`{{exec}}

> Les Endpoints correspondent aux IPs des pods — le Service les met à jour automatiquement

`kubectl describe svc webapp-svc`{{exec}}

> Cliquez sur **Check** quand les Services sont créés et que curl fonctionne.
