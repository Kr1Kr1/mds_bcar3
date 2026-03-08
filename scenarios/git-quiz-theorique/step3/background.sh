#!/bin/bash
# Crée /root/quiz_step3.sh au démarrage de l'étape 3
# Réponses correctes : Q1=4 Q2=4 Q3=3 Q4=3 Q5=3

cat > /root/quiz_step3.sh << 'QUIZ_EOF'
#!/bin/bash
ANSWER_FILE="/tmp/quiz_step3.txt"
> "$ANSWER_FILE"

CYAN='\033[0;36m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; NC='\033[0m'

echo -e "${CYAN}════════════════════════════════════════"
echo -e "  QCM Étape 3 : Bases de Git"
echo -e "════════════════════════════════════════${NC}"
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

ask "Q1. Quelle commande initialise un nouveau dépôt Git ?" \
  "git start" "git create" "git new" "git init"

ask "Q2. Quelle commande ajoute des fichiers à la zone de staging ?" \
  "git commit" "git push" "git stage" "git add"

ask "Q3. Quelle commande enregistre un commit avec un message ?" \
  'git save -m "message"' \
  'git push -m "message"' \
  'git commit -m "message"' \
  'git add -m "message"'

ask "Q4. Quelle commande crée une nouvelle branche ?" \
  "git new-branch feature" \
  "git create branch feature" \
  "git branch feature" \
  "git branch --new feature"

ask "Q5. Quelle commande récupère ET intègre les modifications d'un dépôt distant ?" \
  "git fetch" "git clone" "git pull" "git push"

echo -e "${CYAN}✓ Quiz terminé ! Cliquez sur 'Check' pour valider.${NC}"
QUIZ_EOF

chmod +x /root/quiz_step3.sh

# ── Bilan final + envoi Google Sheets ─────────────────────────────────────────
cat > /root/quiz_results.sh << 'RESULTS_EOF'
#!/bin/bash
WEBHOOK="https://script.google.com/macros/s/AKfycby4eksr3TCtLJp71SSK9bG11yfx2aHfvydlJaS3RcKQkq_QKu5nI52FQgjkpNS6VKwb/exec"
CYAN='\033[0;36m'; GREEN='\033[0;32m'; RED='\033[0;31m'; YELLOW='\033[1;33m'; NC='\033[0m'

CORRECT_1=(2 3 3 4 4)
CORRECT_2=(2 4 3 4 3)
CORRECT_3=(4 4 3 3 3)

score_step() {
  local file="$1"
  local -n correct="$2"
  if [ ! -f "$file" ]; then echo "0"; return; fi
  mapfile -t answers < "$file"
  local s=0
  for i in "${!correct[@]}"; do
    [ "${answers[$i]}" = "${correct[$i]}" ] && ((s++))
  done
  echo "$s"
}

s1=$(score_step /tmp/quiz_step1.txt CORRECT_1)
s2=$(score_step /tmp/quiz_step2.txt CORRECT_2)
s3=$(score_step /tmp/quiz_step3.txt CORRECT_3)
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
echo -e "  Étape 1 — Linux & Réseau        ${YELLOW}$s1/5${NC}  $(bar $s1 5)"
echo -e "  Étape 2 — Virtualisation        ${YELLOW}$s2/5${NC}  $(bar $s2 5)"
echo -e "  Étape 3 — Bases de Git          ${YELLOW}$s3/5${NC}  $(bar $s3 5)"
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
HOSTNAME=$(hostname)
HTTP=$(curl -s -o /tmp/webhook_resp.txt -w "%{http_code}" -L \
  -X POST "$WEBHOOK" \
  -H "Content-Type: application/json" \
  -d "{\"hostname\":\"$HOSTNAME\",\"s1\":$s1,\"s2\":$s2,\"s3\":$s3,\"total\":$total}" \
  2>/dev/null)

if [ "$HTTP" = "200" ]; then
  echo -e "${GREEN}✓ Envoyé !${NC}"
else
  echo -e "${RED}✗ Échec (code $HTTP) — montrez votre écran à votre formateur.${NC}"
fi
echo ""
RESULTS_EOF

chmod +x /root/quiz_results.sh
