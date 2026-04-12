#!/bin/bash
# Quiz step 3 — Namespaces, CoreDNS, vision d'ensemble (8 questions)
# Réponses : Q1=2 Q2=v Q3=4 Q4=2 Q5=3 Q6=v Q7=3 Q8=2

cat > /root/quiz_step3.sh << 'QUIZ_EOF'
#!/bin/bash
ANSWER_FILE="/tmp/bilan_step3.txt"
> "$ANSWER_FILE"
CYAN='\033[0;36m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; NC='\033[0m'

echo -e "${CYAN}══════════════════════════════════════════════════════════════════════════════"
echo -e "  Bilan fondamentaux — Étape 3 : Namespaces, CoreDNS, vision d'ensemble"
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

ask_qcm "Q1. Parmi ces affirmations, laquelle est FAUSSE concernant les Namespaces Kubernetes ?" \
  "Les namespaces isolent logiquement les ressources au sein d'un cluster" \
  "Par défaut, un pod dans namespace A ne peut pas communiquer avec un pod dans namespace B" \
  "Les ResourceQuota peuvent limiter le nombre de pods par namespace" \
  "Les namespaces permettent d'appliquer des RBAC différents par équipe"

ask_vf "Q2. Vrai ou Faux — Le namespace kube-system contient les composants internes de Kubernetes comme CoreDNS et kube-proxy."

ask_qcm "Q3. Depuis un pod dans le namespace 'backend', comment accéder au Service 'api' dans le namespace 'frontend' ?" \
  "api" \
  "api.frontend" \
  "api.frontend.svc.cluster.local" \
  "Les deux dernières réponses sont correctes"

ask_qcm "Q4. Quel est le rôle principal de CoreDNS dans un cluster Kubernetes ?" \
  "Gérer les certificats TLS des Services" \
  "Résoudre les noms DNS des Services et Pods dans le cluster" \
  "Configurer les règles réseau entre pods" \
  "Router le trafic HTTP vers les bons Services"

ask_qcm "Q5. Quelle valeur de dnsPolicy utilise CoreDNS en premier, puis le DNS du nœud en fallback ?" \
  "Default" \
  "None" \
  "ClusterFirst" \
  "HostNetwork"

ask_vf "Q6. Vrai ou Faux — Une LimitRange définit des valeurs par défaut de CPU/mémoire pour les conteneurs qui n'en spécifient pas."

ask_qcm "Q7. Quel outil en ligne de commande permet de switcher rapidement entre namespaces Kubernetes ?" \
  "kubectl switch" \
  "kns" \
  "kubens" \
  "kubectl context"

ask_qcm "Q8. Quel est le pack minimum recommandé pour sécuriser un namespace de production ?" \
  "Seulement RBAC suffit" \
  "ResourceQuota + LimitRange + NetworkPolicy + RBAC" \
  "NetworkPolicy uniquement (le reste est optionnel)" \
  "LimitRange + RBAC (ResourceQuota est pour le cloud uniquement)"

echo -e "${CYAN}✓ Quiz complet ! Cliquez sur 'Check', puis : bash /root/quiz_results.sh${NC}"
QUIZ_EOF
chmod +x /root/quiz_step3.sh

# ── quiz_results.sh ───────────────────────────────────────────────────────────
cat > /root/quiz_results.sh << 'RESULTS_EOF'
#!/bin/bash
CYAN='\033[0;36m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; RED='\033[0;31m'; BOLD='\033[1m'; NC='\033[0m'

# Réponses correctes
C1=(2 f 3 2 f 2 3 v 2)
C2=(2 3 v 2 3 f 2 2)
C3=(2 v 4 2 3 v 3 2)

score_step() {
  local file="$1"; shift; local correct=("$@"); local score=0
  [ ! -f "$file" ] && echo 0 && return
  mapfile -t answers < "$file"
  for i in "${!correct[@]}"; do
    local ans="${answers[$i]}"
    local exp="${correct[$i]}"
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
S1=$(score_step /tmp/bilan_step1.txt "${C1[@]}")
S2=$(score_step /tmp/bilan_step2.txt "${C2[@]}")
S3=$(score_step /tmp/bilan_step3.txt "${C3[@]}")
TOTAL=$((S1 + S2 + S3))
MAX=25

echo ""
echo -e "${CYAN}${BOLD}════════════════════════════════════════════════════════════${NC}"
echo -e "${CYAN}${BOLD}  BILAN FONDAMENTAUX KUBERNETES — $PSEUDO${NC}"
echo -e "${CYAN}${BOLD}════════════════════════════════════════════════════════════${NC}"
echo ""
echo -e "  Étape 1 — Pods, ReplicaSets, Deployments (9 q.)  : ${YELLOW}$S1/9${NC}"
echo -e "  Étape 2 — Services, ConfigMaps, Secrets (8 q.)   : ${YELLOW}$S2/8${NC}"
echo -e "  Étape 3 — Namespaces, CoreDNS, vision (8 q.)     : ${YELLOW}$S3/8${NC}"
echo ""
echo -e "  ${BOLD}TOTAL : $TOTAL / $MAX${NC}"
echo ""
PCT=$(( TOTAL * 100 / MAX ))
if [ "$PCT" -ge 80 ]; then
  echo -e "  ${GREEN}★ Excellent ($PCT%) — Fondamentaux K8s bien maîtrisés !${NC}"
elif [ "$PCT" -ge 60 ]; then
  echo -e "  ${YELLOW}★ Bien ($PCT%) — Quelques points à consolider.${NC}"
else
  echo -e "  ${RED}★ À revoir ($PCT%) — Relisez les slides fondamentaux.${NC}"
fi
echo ""
echo -e "${CYAN}════════════════════════════════════════════════════════════${NC}"
echo ""
RESULTS_EOF
chmod +x /root/quiz_results.sh
