#!/bin/bash
# Quiz step 3 — Réconciliation, réseau, vision d'ensemble (8 questions)
# Réponses : Q1=2 Q2=v Q3=2 Q4=2 Q5=v Q6=f Q7=1 Q8=2

cat > /root/quiz_step3.sh << 'QUIZ_EOF'
#!/bin/bash
ANSWER_FILE="/tmp/ck_step3.txt"
> "$ANSWER_FILE"
CYAN='\033[0;36m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; NC='\033[0m'

echo -e "${CYAN}══════════════════════════════════════════════════════════════════════════════"
echo -e "  Contrôle de connaissances — Étape 3 : Réconciliation, réseau, vision d'ensemble"
echo -e "══════════════════════════════════════════════════════════════════════════════${NC}"
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

ask_qcm "Q1. Comment s'appelle le mécanisme par lequel Kubernetes maintient automatiquement l'état souhaité ?" \
  "Scheduling" \
  "Réconciliation" \
  "Provisioning" \
  "Orchestration"

ask_vf "Q2. Vrai ou Faux — En Kubernetes, l'approche déclarative signifie qu'on décrit l'état souhaité et Kubernetes se débrouille pour l'atteindre et le maintenir."

ask_qcm "Q3. Vous avez 3 replicas. Un pod crashe. Que fait Kubernetes automatiquement ?" \
  "Il envoie une alerte et attend une intervention manuelle" \
  "Il recrée un nouveau pod pour maintenir 3 replicas" \
  "Il réduit le nombre souhaité à 2 replicas" \
  "Il redémarre le pod crashé sur le même nœud"

ask_qcm "Q4. Dans quel ordre correct les composants interviennent-ils lors d'un 'kubectl apply' ?" \
  "Scheduler → API Server → etcd → Kubelet" \
  "API Server → etcd → Scheduler → Kubelet" \
  "etcd → API Server → Kubelet → Scheduler" \
  "Kubelet → API Server → Scheduler → etcd"

ask_vf "Q5. Vrai ou Faux — Chaque Pod dans un cluster Kubernetes a sa propre adresse IP unique."

ask_vf "Q6. Vrai ou Faux — Si etcd est perdu sans backup, le cluster Kubernetes peut être restauré depuis les configurations YAML versionnées dans Git."

ask_qcm "Q7. Quel plugin CNI est recommandé pour un environnement de production nécessitant des Network Policies avancées ?" \
  "Calico" \
  "Flannel" \
  "Bridge" \
  "Host-network"

ask_qcm "Q8. Quelle est la principale différence entre le Control Plane et les Worker Nodes ?" \
  "Le Control Plane exécute les conteneurs applicatifs" \
  "Le Control Plane décide et surveille, les Worker Nodes exécutent les conteneurs" \
  "Les Worker Nodes stockent l'état dans etcd" \
  "Il n'y a pas de différence fonctionnelle"

echo -e "${CYAN}✓ Quiz complet ! Cliquez sur 'Check', puis : bash /root/quiz_results.sh${NC}"
QUIZ_EOF
chmod +x /root/quiz_step3.sh

# ── quiz_results.sh ───────────────────────────────────────────────────────────
cat > /root/quiz_results.sh << 'RESULTS_EOF'
#!/bin/bash
CYAN='\033[0;36m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; RED='\033[0;31m'; BOLD='\033[1m'; NC='\033[0m'

# Réponses correctes
C1=(3 1 f 3 2 1 2 f 3)
C2=(3 3 v 2 1 2 f f)
C3=(2 v 2 2 v f 1 2)

score_step() {
  local file="$1"; shift; local correct=("$@"); local score=0
  [ ! -f "$file" ] && echo 0 && return
  mapfile -t answers < "$file"
  for i in "${!correct[@]}"; do
    local ans="${answers[$i]}"
    local exp="${correct[$i]}"
    # normalise : v/f ou 1/2 pour vrai/faux
    if [[ "$exp" == "v" ]]; then
      [[ "$ans" == "v" || "$ans" == "1" ]] && ((score++))
    elif [[ "$exp" == "f" ]]; then
      [[ "$ans" == "f" || "$ans" == "2" ]] && ((score++))
    else
      [ "$ans" = "$exp" ] && ((score++))
    fi
  done
  echo $score
}

PSEUDO=$(cat /tmp/quiz_pseudo.txt 2>/dev/null | xargs || echo "Anonyme")
S1=$(score_step /tmp/ck_step1.txt "${C1[@]}")
S2=$(score_step /tmp/ck_step2.txt "${C2[@]}")
S3=$(score_step /tmp/ck_step3.txt "${C3[@]}")
TOTAL=$((S1 + S2 + S3))
MAX=25

echo ""
echo -e "${CYAN}${BOLD}════════════════════════════════════════════════════════════${NC}"
echo -e "${CYAN}${BOLD}  CONTRÔLE DE CONNAISSANCES K8s ARCHITECTURE — $PSEUDO${NC}"
echo -e "${CYAN}${BOLD}════════════════════════════════════════════════════════════${NC}"
echo ""
echo -e "  Étape 1 — Control Plane (9 questions)      : ${YELLOW}$S1/9${NC}"
echo -e "  Étape 2 — Worker Nodes (8 questions)       : ${YELLOW}$S2/8${NC}"
echo -e "  Étape 3 — Réconciliation & réseau (8 q.)   : ${YELLOW}$S3/8${NC}"
echo ""
echo -e "  ${BOLD}TOTAL : $TOTAL / $MAX${NC}"
echo ""
PCT=$(( TOTAL * 100 / MAX ))
if [ "$PCT" -ge 80 ]; then
  echo -e "  ${GREEN}★ Excellent ($PCT%) — Architecture K8s bien maîtrisée !${NC}"
elif [ "$PCT" -ge 60 ]; then
  echo -e "  ${YELLOW}★ Bien ($PCT%) — Quelques points à consolider.${NC}"
else
  echo -e "  ${RED}★ À revoir ($PCT%) — Relisez le cours architecture.${NC}"
fi
echo ""
echo -e "${CYAN}════════════════════════════════════════════════════════════${NC}"
echo ""
RESULTS_EOF
chmod +x /root/quiz_results.sh
