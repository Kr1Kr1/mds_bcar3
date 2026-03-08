#!/bin/bash
# Crée /root/quiz_step3.sh — Git + Docker : vision d'ensemble & cas d'usage
# Réponses correctes : Q1=2 Q2=3 Q3=2 Q4=2 Q5=3

cat > /root/quiz_step3.sh << 'QUIZ_EOF'
#!/bin/bash
ANSWER_FILE="/tmp/quiz_step3.txt"
> "$ANSWER_FILE"

CYAN='\033[0;36m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; NC='\033[0m'

echo -e "${CYAN}════════════════════════════════════════════════════"
echo -e "  QCM Étape 3 : Git + Docker — vision d'ensemble"
echo -e "════════════════════════════════════════════════════${NC}"
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

ask "Q1. Dans un workflow professionnel typique, dans quel ordre ces étapes se produisent-elles ?" \
  "docker build → git commit → git push → déploiement" \
  "git commit → git push → docker build → déploiement" \
  "déploiement → git commit → docker build → git push" \
  "git push → déploiement → docker build → git commit"

ask "Q2. Qu'est-ce que l'Infrastructure as Code (IaC) ?" \
  "Coder directement dans l'interface graphique d'un hébergeur cloud" \
  "Gérer les serveurs uniquement via des scripts bash non versionnés" \
  "Décrire et gérer l'infrastructure dans des fichiers texte versionnés (Dockerfile, docker-compose.yml...)" \
  "Installer les dépendances à la main sur chaque serveur"

ask "Q3. Pourquoi versionne-t-on son Dockerfile avec Git ?" \
  "Parce que Docker refuse de fonctionner sans un dépôt Git actif" \
  "Pour pouvoir retrouver, auditer et rejouer n'importe quelle version de l'environnement d'exécution" \
  "Pour compresser l'image Docker et réduire sa taille" \
  "Pour éviter les conflits réseau entre conteneurs"

ask "Q4. Un développeur dit : 'ça tourne sur mon laptop mais pas en production'. Quelle combinaison adresse ce problème ?" \
  "Changer de système d'exploitation en production" \
  "Git pour versionner le code + Docker pour garantir un environnement identique partout" \
  "Ajouter un antivirus sur le serveur de production" \
  "Redémarrer le serveur de production régulièrement"

ask "Q5. Qu'est-ce qu'un registry Docker (ex : Docker Hub, GitLab Registry) ?" \
  "Un outil de versioning de code source, concurrent de Git" \
  "Un gestionnaire de paquets Linux (comme apt ou yum)" \
  "Un dépôt centralisé pour stocker, partager et distribuer des images Docker" \
  "Un système de monitoring et d'alerting pour les conteneurs"

echo -e "${CYAN}✓ Quiz terminé ! Cliquez sur 'Check' pour valider.${NC}"
QUIZ_EOF

chmod +x /root/quiz_step3.sh

# ── Bilan final + envoi Google Sheets ─────────────────────────────────────────
cat > /root/quiz_results.sh << 'RESULTS_EOF'
#!/bin/bash
WEBHOOK="https://script.google.com/macros/s/AKfycby4eksr3TCtLJp71SSK9bG11yfx2aHfvydlJaS3RcKQkq_QKu5nI52FQgjkpNS6VKwb/exec"
CYAN='\033[0;36m'; GREEN='\033[0;32m'; RED='\033[0;31m'; YELLOW='\033[1;33m'; NC='\033[0m'

# Vérification que tous les quizzes ont été complétés
missing=0
for step in 1 2 3; do
  if [ ! -f "/tmp/quiz_step${step}.txt" ]; then
    echo -e "${RED}⚠ Étape $step non complétée (quiz_step${step}.sh non exécuté).${NC}"
    missing=1
  fi
done
if [ "$missing" -eq 1 ]; then
  echo ""
  echo "Complétez les étapes manquantes avant d'afficher le bilan."
  exit 1
fi

# Calcul des scores — sans nameref pour compatibilité bash universelle
compute_score() {
  local file="$1"; shift
  local -a correct=("$@")
  mapfile -t answers < "$file"
  local s=0
  for i in "${!correct[@]}"; do
    [ "${answers[$i]:-x}" = "${correct[$i]}" ] && ((s++))
  done
  echo "$s"
}

s1=$(compute_score /tmp/quiz_step1.txt 2 3 2 2 3)
s2=$(compute_score /tmp/quiz_step2.txt 2 2 3 3 2)
s3=$(compute_score /tmp/quiz_step3.txt 2 3 2 2 3)
total=$((s1 + s2 + s3))

bar() {
  local score=$1 max=$2
  local filled=$(( score * 10 / max ))
  local b=""
  for ((i=0; i<10; i++)); do
    [ $i -lt $filled ] && b+="█" || b+="░"
  done
  echo "$b"
}

echo ""
echo -e "${CYAN}╔══════════════════════════════════════════╗"
echo -e "║     BILAN DU QCM DE POSITIONNEMENT      ║"
echo -e "╚══════════════════════════════════════════╝${NC}"
echo ""
echo -e "  Étape 1 — Git (concepts & pourquoi)    ${YELLOW}$s1/5${NC}  $(bar $s1 5)"
echo -e "  Étape 2 — Docker (concepts & pourquoi) ${YELLOW}$s2/5${NC}  $(bar $s2 5)"
echo -e "  Étape 3 — Vision d'ensemble Git+Docker ${YELLOW}$s3/5${NC}  $(bar $s3 5)"
echo    "  ──────────────────────────────────────────"

if   [ "$total" -ge 12 ]; then
  echo -e "  TOTAL                          ${GREEN}$total/15${NC}  ✓ Excellent"
elif [ "$total" -ge 9 ]; then
  echo -e "  TOTAL                          ${YELLOW}$total/15${NC}  ~ Satisfaisant"
else
  echo -e "  TOTAL                          ${RED}$total/15${NC}  ✗ À retravailler"
fi

echo ""
echo -ne "  Envoi des résultats au formateur... "
MACHINE=$(hostname)
HTTP=$(curl -s -o /tmp/webhook_resp.txt -w "%{http_code}" -L \
  -X POST "$WEBHOOK" \
  -H "Content-Type: application/json" \
  -d "{\"hostname\":\"$MACHINE\",\"s1\":$s1,\"s2\":$s2,\"s3\":$s3,\"total\":$total}" \
  2>/dev/null)

if [ "$HTTP" = "200" ]; then
  echo -e "${GREEN}✓ Envoyé !${NC}"
else
  echo -e "${RED}✗ Échec réseau (code $HTTP).${NC}"
fi
echo ""
RESULTS_EOF

chmod +x /root/quiz_results.sh
