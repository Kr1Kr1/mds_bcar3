#!/bin/bash
# Crée /root/quiz_step1.sh au démarrage de l'étape 1
# Réponses correctes : Q1=2 Q2=3 Q3=3 Q4=4 Q5=4

cat > /root/quiz_step1.sh << 'QUIZ_EOF'
#!/bin/bash
ANSWER_FILE="/tmp/quiz_step1.txt"
> "$ANSWER_FILE"

CYAN='\033[0;36m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; NC='\033[0m'

echo -e "${CYAN}════════════════════════════════════════"
echo -e "  QCM Étape 1 : Linux & Réseau"
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

ask "Q1. Quelle commande liste les fichiers cachés sous Linux ?" \
  "ls -h" "ls -a" "ls -l" "ls -r"

ask "Q2. Quelle commande affiche l'adresse IP de votre machine ?" \
  "ipconfig" "netstat" "ifconfig" "ping"

ask "Q3. Quel port utilise SSH par défaut ?" \
  "21" "80" "22" "443"

ask "Q4. Quelle commande modifie les permissions d'un fichier ?" \
  "chown" "chgrp" "chattr" "chmod"

ask "Q5. Quelle commande affiche les processus en cours d'exécution ?" \
  "ls" "cat" "grep" "top"

echo -e "${CYAN}✓ Quiz terminé ! Cliquez sur 'Check' pour valider.${NC}"
QUIZ_EOF

chmod +x /root/quiz_step1.sh
