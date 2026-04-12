#!/bin/bash
# Crée /root/quiz_step3.sh + /root/quiz_results.sh — Workloads, Services & Config (8 questions)
# Réponses correctes : Q1=2 Q2=3 Q3=1 Q4=4 Q5=2 Q6=3 Q7=1 Q8=3

cat > /root/quiz_step3.sh << 'QUIZ_EOF'
#!/bin/bash
ANSWER_FILE="/tmp/quiz_step3.txt"
> "$ANSWER_FILE"

CYAN='\033[0;36m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; NC='\033[0m'

echo -e "${CYAN}══════════════════════════════════════════════════════════════"
echo -e "  QCM Étape 3 : Workloads, Services & Configuration"
echo -e "══════════════════════════════════════════════════════════════${NC}"
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

ask "Q1. Pourquoi utilise-t-on un Deployment plutôt que de créer des Pods directement ?" \
  "Les Pods ne supportent pas les images Docker — seul le Deployment les gère" \
  "Le Deployment gère automatiquement le nombre de replicas, les rolling updates et le rollback — un Pod mort seul n'est pas recréé" \
  "Le Deployment est obligatoire pour que kubectl fonctionne" \
  "Les Pods ne peuvent pas avoir de variables d'environnement sans Deployment"

ask "Q2. Dans la hiérarchie Deployment → ReplicaSet → Pod, que fait le ReplicaSet ?" \
  "Il orchestre le réseau entre les pods" \
  "Il définit l'image Docker et les variables d'environnement" \
  "Il garantit qu'un nombre précis de réplicas d'un pod tourne à tout moment" \
  "Il expose les pods sur Internet via un LoadBalancer"

ask "Q3. Qu'est-ce qu'un rolling update dans Kubernetes ?" \
  "Une stratégie qui remplace progressivement les anciens pods par les nouveaux, sans interruption de service" \
  "Une mise à jour qui supprime tous les pods et les recrée (avec downtime)" \
  "Un mécanisme de sauvegarde automatique du cluster" \
  "Une procédure de mise à jour des nœuds worker du cluster"

ask "Q4. Quel type de Service expose une application uniquement à l'intérieur du cluster ?" \
  "NodePort" \
  "LoadBalancer" \
  "ExternalName" \
  "ClusterIP"

ask "Q5. Pourquoi a-t-on besoin d'un Service Kubernetes alors que les pods ont déjà des adresses IP ?" \
  "Parce que les pods n'ont pas d'adresse IP dans Kubernetes" \
  "Parce que les pods sont éphémères et changent d'IP à chaque redémarrage — le Service fournit une adresse stable et un load balancing" \
  "Parce que les Services accélèrent les communications réseau entre pods" \
  "Parce que kubectl ne peut pas communiquer directement avec les pods"

ask "Q6. Quelle est la différence entre un ConfigMap et un Secret dans Kubernetes ?" \
  "Le ConfigMap est pour les applications Go, le Secret pour les applications Python" \
  "Le ConfigMap stocke uniquement des fichiers, le Secret uniquement des variables d'environnement" \
  "Le ConfigMap stocke des données non sensibles (config, paramètres) ; le Secret stocke des données sensibles (mots de passe, tokens) encodées en base64" \
  "Le ConfigMap et le Secret ont exactement le même fonctionnement, seul le nom change"

ask "Q7. Quelle est la structure du nom DNS complet d'un Service dans Kubernetes ?" \
  "<service>.<namespace>.svc.cluster.local" \
  "<namespace>.<service>.cluster.svc.local" \
  "<service>.cluster.<namespace>.svc.local" \
  "<pod>.<service>.<namespace>.cluster.local"

ask "Q8. Pourquoi utilise-t-on des Namespaces dans Kubernetes ?" \
  "Pour accélérer les performances du cluster en séparant les workloads" \
  "Pour remplacer les labels et les selectors dans les Deployments" \
  "Pour isoler logiquement les ressources, appliquer des quotas par équipe/environnement et des politiques RBAC" \
  "Les Namespaces sont obligatoires — Kubernetes refuse de démarrer sans au moins 5 namespaces"

echo -e "${CYAN}✓ Quiz complet ! Cliquez sur 'Check', puis lancez : bash /root/quiz_results.sh${NC}"
QUIZ_EOF

chmod +x /root/quiz_step3.sh

# ── Script de résultats ────────────────────────────────────────────────────────
cat > /root/quiz_results.sh << 'RESULTS_EOF'
#!/bin/bash
CYAN='\033[0;36m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; RED='\033[0;31m'; BOLD='\033[1m'; NC='\033[0m'

CORRECT_S1=(3 2 1 3 2 4 3 2)
CORRECT_S2=(2 3 1 4 2 3 2 4)
CORRECT_S3=(2 3 1 4 2 3 1 3)

score_step() {
  local file="$1"; shift
  local correct=("$@")
  local score=0
  if [ ! -f "$file" ]; then echo 0; return; fi
  mapfile -t answers < "$file"
  for i in "${!correct[@]}"; do
    if [ "${answers[$i]}" = "${correct[$i]}" ]; then ((score++)); fi
  done
  echo $score
}

PSEUDO=$(cat /tmp/quiz_pseudo.txt 2>/dev/null | xargs || echo "Anonyme")
S1=$(score_step /tmp/quiz_step1.txt "${CORRECT_S1[@]}")
S2=$(score_step /tmp/quiz_step2.txt "${CORRECT_S2[@]}")
S3=$(score_step /tmp/quiz_step3.txt "${CORRECT_S3[@]}")
TOTAL=$((S1 + S2 + S3))

echo ""
echo -e "${CYAN}${BOLD}════════════════════════════════════════════════════${NC}"
echo -e "${CYAN}${BOLD}  BILAN QCM KUBERNETES — $PSEUDO${NC}"
echo -e "${CYAN}${BOLD}════════════════════════════════════════════════════${NC}"
echo ""
echo -e "  Étape 1 — Cloud Native & orchestration : ${YELLOW}$S1/8${NC}"
echo -e "  Étape 2 — Architecture Kubernetes       : ${YELLOW}$S2/8${NC}"
echo -e "  Étape 3 — Workloads, Services & Config  : ${YELLOW}$S3/8${NC}"
echo ""
echo -e "  ${BOLD}TOTAL : $TOTAL / 24${NC}"
echo ""

if [ "$TOTAL" -ge 20 ]; then
  echo -e "  ${GREEN}★ Excellent ! Solides bases en Kubernetes.${NC}"
elif [ "$TOTAL" -ge 14 ]; then
  echo -e "  ${YELLOW}★ Bon niveau. Quelques points à consolider.${NC}"
else
  echo -e "  ${RED}★ Des lacunes identifiées — la formation va y remédier !${NC}"
fi
echo ""
echo -e "${CYAN}════════════════════════════════════════════════════${NC}"
echo ""
RESULTS_EOF

chmod +x /root/quiz_results.sh
