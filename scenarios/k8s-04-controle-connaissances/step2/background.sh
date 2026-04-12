#!/bin/bash
# Quiz step 2 — Worker Nodes (8 questions)
# Réponses : Q1=3 Q2=1 Q3=v Q4=2 Q5=1 Q6=2 Q7=f Q8=f

cat > /root/quiz_step2.sh << 'QUIZ_EOF'
#!/bin/bash
ANSWER_FILE="/tmp/ck_step2.txt"
> "$ANSWER_FILE"
CYAN='\033[0;36m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; NC='\033[0m'

echo -e "${CYAN}══════════════════════════════════════════════════════════════════════"
echo -e "  Contrôle de connaissances — Étape 2 : Worker Nodes"
echo -e "══════════════════════════════════════════════════════════════════════${NC}"
echo ""

ask_qcm() {
  local q="$1"; shift; local opts=("$@"); local max=${#opts[@]}
  echo -e "${YELLOW}$q${NC}"
  for i in "${!opts[@]}"; do echo "  $((i+1))) ${opts[$i]}"; done
  local ans
  while true; do
    echo -n "Réponse [1-$max] : "; read -r ans
    if [[ "$ans" =~ ^[0-9]+$ ]] && [ "$ans" -ge 1 ] && [ "$ans" -le "$max" ]; then
      echo "$ans" >> "$ANSWER_FILE"; echo -e "${GREEN}✓${NC}"; echo ""; break
    fi
    echo "Invalide."
  done
}

ask_vf() {
  local q="$1"
  echo -e "${YELLOW}$q${NC}"
  echo "  1) Vrai   2) Faux"
  local ans
  while true; do
    echo -n "Réponse [v/f ou 1/2] : "; read -r ans
    ans=$(echo "$ans" | tr '[:upper:]' '[:lower:]')
    if [[ "$ans" == "v" || "$ans" == "1" ]]; then
      echo "v" >> "$ANSWER_FILE"; echo -e "${GREEN}✓${NC}"; echo ""; break
    elif [[ "$ans" == "f" || "$ans" == "2" ]]; then
      echo "f" >> "$ANSWER_FILE"; echo -e "${GREEN}✓${NC}"; echo ""; break
    fi
    echo "Entrez v (Vrai) ou f (Faux)."
  done
}

ask_qcm "Q1. Quels sont les trois composants essentiels d'un Worker Node ?" \
  "API Server, etcd, Scheduler" \
  "Controller Manager, Kubelet, etcd" \
  "Kubelet, Kube-proxy, Container Runtime" \
  "Scheduler, Kubelet, Kube-proxy"

ask_qcm "Q2. Quel est le rôle principal du Kubelet sur un Worker Node ?" \
  "Stocker l'état du cluster dans etcd" \
  "Décider sur quel nœud déployer les pods" \
  "Lancer les conteneurs et surveiller leur santé" \
  "Configurer les règles réseau iptables"

ask_vf "Q3. Vrai ou Faux — Le Kubelet continue de faire tourner les pods existants même si le Control Plane devient injoignable."

ask_qcm "Q4. Quel composant configure les règles iptables/IPVS pour le routage réseau des Services ?" \
  "kubelet" \
  "kube-proxy" \
  "containerd" \
  "kube-scheduler"

ask_qcm "Q5. Quel Container Runtime est recommandé par défaut pour Kubernetes depuis la version 1.24 ?" \
  "containerd" \
  "Docker Engine" \
  "rkt" \
  "LXC"

ask_qcm "Q6. Comment les Kubelets obtiennent-ils la liste des pods à exécuter ?" \
  "L'API Server pousse les ordres (push) directement aux kubelets" \
  "Les kubelets interrogent régulièrement l'API Server (modèle pull/watch)" \
  "etcd envoie directement les PodSpecs aux kubelets" \
  "Le Scheduler contacte directement chaque kubelet"

ask_vf "Q7. Vrai ou Faux — Depuis Kubernetes 1.24, les images Docker ne fonctionnent plus sur les clusters Kubernetes."

ask_vf "Q8. Vrai ou Faux — Le Scheduler lance directement les conteneurs sur le nœud qu'il a choisi."

echo -e "${CYAN}✓ Étape 2 terminée ! Cliquez sur 'Check'.${NC}"
QUIZ_EOF
chmod +x /root/quiz_step2.sh
