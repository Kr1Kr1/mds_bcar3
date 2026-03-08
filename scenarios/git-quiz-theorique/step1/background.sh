#!/bin/bash
# Crée /root/quiz_step1.sh — Git : concepts & pourquoi
# Réponses correctes : Q1=2 Q2=3 Q3=2 Q4=2 Q5=3

cat > /root/quiz_step1.sh << 'QUIZ_EOF'
#!/bin/bash
ANSWER_FILE="/tmp/quiz_step1.txt"
> "$ANSWER_FILE"

CYAN='\033[0;36m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; NC='\033[0m'

echo -e "${CYAN}════════════════════════════════════════════════"
echo -e "  QCM Étape 1 : Git — concepts & pourquoi"
echo -e "════════════════════════════════════════════════${NC}"
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

ask "Q1. Pourquoi utilise-t-on un système de contrôle de version comme Git ?" \
  "Pour compresser les fichiers du projet" \
  "Pour garder un historique des modifications et collaborer sans écraser le travail des autres" \
  "Pour accélérer l'exécution du code" \
  "Pour documenter automatiquement le code"

ask "Q2. Qu'est-ce qu'un commit dans Git ?" \
  "Un message d'erreur envoyé au dépôt distant" \
  "Une sauvegarde temporaire non enregistrée" \
  "Un instantané (snapshot) de l'état du projet à un moment précis" \
  "Une copie complète du dépôt distant"

ask "Q3. Pourquoi crée-t-on des branches dans Git ?" \
  "Pour sauvegarder le projet sur plusieurs serveurs simultanément" \
  "Pour travailler sur une fonctionnalité en isolation sans affecter le code stable" \
  "Pour accélérer la vitesse des commits" \
  "Pour chiffrer le code source"

ask "Q4. Que désigne 'origin' dans Git ?" \
  "Le premier commit du projet" \
  "Le nom par défaut donné au dépôt distant (remote)" \
  "La branche principale obligatoire" \
  "L'auteur initial du dépôt"

ask "Q5. Dans quelle situation préfère-t-on git merge plutôt que git rebase ?" \
  "Quand on veut réécrire l'historique pour le rendre parfaitement linéaire" \
  "Quand on travaille seul sur une branche locale expérimentale" \
  "Quand on intègre une branche partagée et qu'on veut préserver l'historique des collaborations" \
  "Quand le dépôt distant est vide"

echo -e "${CYAN}✓ Quiz terminé ! Cliquez sur 'Check' pour valider.${NC}"
QUIZ_EOF

chmod +x /root/quiz_step1.sh
