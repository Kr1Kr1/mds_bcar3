#!/bin/bash
# Crée /root/quiz_step2.sh au démarrage de l'étape 2
# Réponses correctes : Q1=2 Q2=4 Q3=3 Q4=4 Q5=3

cat > /root/quiz_step2.sh << 'QUIZ_EOF'
#!/bin/bash
ANSWER_FILE="/tmp/quiz_step2.txt"
> "$ANSWER_FILE"

CYAN='\033[0;36m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; NC='\033[0m'

echo -e "${CYAN}════════════════════════════════════════"
echo -e "  QCM Étape 2 : Virtualisation & Scripting"
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

ask "Q1. Un hyperviseur de type 1 (bare-metal) s'exécute ..." \
  "Sur un système d'exploitation hôte" \
  "Directement sur le matériel, sans OS hôte" \
  "À l'intérieur d'un conteneur Docker" \
  "Via un émulateur logiciel"

ask "Q2. Quelle commande exécute un script Bash ?" \
  "run script.sh" "start script.sh" "exec script.sh" "bash script.sh"

ask "Q3. Quelle variable Bash contient le code de retour de la dernière commande ?" \
  '$0' '$1' '$?' '$$'

ask "Q4. Quelle technologie repose sur les namespaces et cgroups du noyau Linux ?" \
  "VirtualBox" "VMware" "Hyper-V" "Docker"

ask "Q5. Comment rendre un script Bash exécutable ?" \
  "chmod -x script.sh" "bash +x script.sh" "chmod +x script.sh" "exec +x script.sh"

echo -e "${CYAN}✓ Quiz terminé ! Cliquez sur 'Check' pour valider.${NC}"
QUIZ_EOF

chmod +x /root/quiz_step2.sh
