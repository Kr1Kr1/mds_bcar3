#!/bin/bash
# Crée /root/quiz_step2.sh — Architecture Kubernetes (8 questions)
# Réponses correctes : Q1=2 Q2=3 Q3=1 Q4=4 Q5=2 Q6=3 Q7=2 Q8=4

cat > /root/quiz_step2.sh << 'QUIZ_EOF'
#!/bin/bash
ANSWER_FILE="/tmp/quiz_step2.txt"
> "$ANSWER_FILE"

CYAN='\033[0;36m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; NC='\033[0m'

echo -e "${CYAN}══════════════════════════════════════════════════════════"
echo -e "  QCM Étape 2 : Architecture Kubernetes"
echo -e "══════════════════════════════════════════════════════════${NC}"
echo ""

ask() {
  local q="$1"; shift
  local opts=("$@")
  local max=${#opts[@]}
  echo -e "${YELLOW}$q${NC}"
  for i in "${!opts[@]}"; do echo "  $((i+1))) ${opts[$i]}"; done
  local ans
  while true; do
    echo -n "Votre réponse [1-$max] : "
    read -r ans
    if [[ "$ans" =~ ^[0-9]+$ ]] && [ "$ans" -ge 1 ] && [ "$ans" -le "$max" ]; then
      echo "$ans" >> "$ANSWER_FILE"
      echo -e "${GREEN}✓ Réponse enregistrée.${NC}"; echo ""; break
    fi
    echo "Réponse invalide. Entrez un chiffre entre 1 et $max."
  done
}

ask "Q1. Quel composant du control plane est la 'mémoire' du cluster — il stocke tout l'état ?" \
  "kube-apiserver" \
  "etcd" \
  "kube-scheduler" \
  "kube-controller-manager"

ask "Q2. Quel est le rôle du kube-scheduler ?" \
  "Exécuter les conteneurs sur les nœuds worker" \
  "Authentifier les requêtes API entrantes" \
  "Décider sur quel nœud chaque pod doit être lancé en fonction des ressources disponibles" \
  "Surveiller la santé du cluster et redémarrer les composants défaillants"

ask "Q3. Quel composant sur un worker node est responsable de démarrer et surveiller les pods ?" \
  "kubelet" \
  "kube-proxy" \
  "containerd" \
  "kube-controller-manager"

ask "Q4. Pourquoi dit-on que 'tout passe par l'API server' dans Kubernetes ?" \
  "Parce que l'API server est le seul composant avec accès à Internet" \
  "Parce que l'API server génère automatiquement les manifests YAML" \
  "Parce que l'API server contient la logique métier de toutes les ressources K8s" \
  "Parce que tous les composants (scheduler, kubelet, kubectl…) communiquent exclusivement via l'API server — jamais directement entre eux"

ask "Q5. Quels sont les 4 champs obligatoires dans tout manifest YAML Kubernetes ?" \
  "name, image, replicas, namespace" \
  "apiVersion, kind, metadata, spec" \
  "kind, labels, selector, template" \
  "version, type, name, containers"

ask "Q6. Quelle est la différence entre un label et un namespace dans Kubernetes ?" \
  "Les labels isolent les ressources réseau, les namespaces les isolent en stockage" \
  "Les labels sont uniquement pour kubectl, les namespaces pour le cluster" \
  "Les labels sont des métadonnées clé-valeur pour sélectionner/grouper des ressources ; les namespaces sont des espaces d'isolation logique du cluster" \
  "Les labels et les namespaces ont exactement le même rôle, c'est juste une question de préférence"

ask "Q7. Quelle distribution Kubernetes est recommandée pour un environnement de lab/apprentissage léger ?" \
  "OpenShift — car c'est la plus complète" \
  "k3s ou Minikube — distributions légères, un seul nœud, idéales pour apprendre" \
  "EKS — car il est géré par AWS et donc plus stable" \
  "kubeadm — car c'est l'outil officiel de la CNCF"

ask "Q8. Que contient le fichier ~/.kube/config (kubeconfig) ?" \
  "La liste de tous les pods du cluster" \
  "Les secrets et certificats TLS des applications déployées" \
  "Les règles RBAC définissant les droits d'accès aux ressources" \
  "La configuration des connexions aux clusters : adresses, certificats, utilisateurs et contextes"

echo -e "${CYAN}✓ Étape 2 terminée ! Cliquez sur 'Check'.${NC}"
QUIZ_EOF

chmod +x /root/quiz_step2.sh
