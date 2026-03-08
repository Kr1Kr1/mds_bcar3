#!/bin/bash
# Crée les trois scripts de quiz sur la machine Ubuntu Killercoda

# ──────────────────────────────────────────────
# Quiz Étape 1 : Linux & Réseau
# Réponses correctes : Q1=2 Q2=3 Q3=3 Q4=4 Q5=4
# ──────────────────────────────────────────────
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

# ──────────────────────────────────────────────
# Quiz Étape 2 : Virtualisation & Scripting
# Réponses correctes : Q1=2 Q2=4 Q3=3 Q4=4 Q5=3
# ──────────────────────────────────────────────
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

# ──────────────────────────────────────────────
# Quiz Étape 3 : Bases de Git
# Réponses correctes : Q1=4 Q2=4 Q3=3 Q4=3 Q5=3
# ──────────────────────────────────────────────
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
