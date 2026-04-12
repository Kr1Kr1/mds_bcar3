#!/bin/bash
# Quiz step 1 — Control Plane (9 questions)
# Réponses : Q1=3 Q2=1 Q3=f Q4=3 Q5=2 Q6=1 Q7=2 Q8=f Q9=2

# ── set_pseudo.sh ─────────────────────────────────────────────────────────────
cat > /root/set_pseudo.sh << 'PSEUDO_EOF'
#!/bin/bash
PSEUDO_FILE="/tmp/quiz_pseudo.txt"
CYAN='\033[0;36m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; RED='\033[0;31m'; NC='\033[0m'
echo -e "${CYAN}════════════════════════════════════════════════════"
echo -e "  Contrôle de connaissances — Architecture K8s"
echo -e "════════════════════════════════════════════════════${NC}"
echo -e "${YELLOW}Entrez votre prénom et nom (ex : Marie Dupont) :${NC}"
while true; do
  echo -n "> "
  read -r pseudo
  pseudo="$(echo "$pseudo" | xargs)"
  if [ -n "$pseudo" ]; then
    echo "$pseudo" > "$PSEUDO_FILE"
    echo -e "${GREEN}✓ Bonjour $pseudo !${NC}"; break
  fi
  echo -e "${RED}Nom vide.${NC}"
done
PSEUDO_EOF
chmod +x /root/set_pseudo.sh

# ── quiz_step1.sh ─────────────────────────────────────────────────────────────
cat > /root/quiz_step1.sh << 'QUIZ_EOF'
#!/bin/bash
ANSWER_FILE="/tmp/ck_step1.txt"
> "$ANSWER_FILE"
CYAN='\033[0;36m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; NC='\033[0m'

echo -e "${CYAN}════════════════════════════════════════════════════════════════"
echo -e "  Contrôle de connaissances — Étape 1 : Control Plane"
echo -e "════════════════════════════════════════════════════════════════${NC}"
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

ask_qcm "Q1. Quel composant choisit sur quel nœud un pod sera déployé ?" \
  "etcd" \
  "kube-controller-manager" \
  "kube-scheduler" \
  "kubectl"

ask_qcm "Q2. Quel composant est le point d'entrée principal de Kubernetes pour toutes les requêtes API ?" \
  "kube-apiserver" \
  "etcd" \
  "kube-scheduler" \
  "kubelet"

ask_vf "Q3. Vrai ou Faux — Tous les composants du control plane communiquent directement avec etcd."

ask_qcm "Q4. Quel composant stocke l'état du cluster Kubernetes (pods, services, secrets…) ?" \
  "kube-proxy" \
  "kubelet" \
  "etcd" \
  "cloud-controller-manager"

ask_qcm "Q5. Lequel de ces composants est optionnel et spécifique aux déploiements sur cloud public ?" \
  "kube-apiserver" \
  "cloud-controller-manager" \
  "kubelet" \
  "etcd"

ask_qcm "Q6. Quel composant agit comme chef d'orchestre en boucle continue pour maintenir l'état souhaité ?" \
  "kube-controller-manager" \
  "kube-scheduler" \
  "cloud-controller-manager" \
  "etcd"

ask_qcm "Q7. Quel composant du cloud-controller-manager crée automatiquement un Load Balancer sur AWS/GCP/Azure ?" \
  "Node Controller" \
  "Service Controller" \
  "Route Controller" \
  "Endpoint Controller"

ask_vf "Q8. Vrai ou Faux — Le cloud-controller-manager est obligatoire pour faire fonctionner un cluster Kubernetes."

ask_qcm "Q9. Lequel de ces composants ne fait PAS partie du control plane ?" \
  "kube-scheduler" \
  "etcd" \
  "kubelet" \
  "kube-controller-manager"

echo -e "${CYAN}✓ Étape 1 terminée ! Cliquez sur 'Check'.${NC}"
QUIZ_EOF
chmod +x /root/quiz_step1.sh
