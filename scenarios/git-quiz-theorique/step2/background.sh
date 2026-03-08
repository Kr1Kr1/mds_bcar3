#!/bin/bash
# Crée /root/quiz_step2.sh — Docker : concepts & pourquoi
# Réponses correctes : Q1=2 Q2=2 Q3=3 Q4=3 Q5=2

cat > /root/quiz_step2.sh << 'QUIZ_EOF'
#!/bin/bash
ANSWER_FILE="/tmp/quiz_step2.txt"
> "$ANSWER_FILE"

CYAN='\033[0;36m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; NC='\033[0m'

echo -e "${CYAN}════════════════════════════════════════════════"
echo -e "  QCM Étape 2 : Docker — concepts & pourquoi"
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

ask "Q1. Quel problème Docker résout-il principalement ?" \
  "La lenteur des requêtes SQL" \
  "Le syndrome 'ça marche sur ma machine' : garantir le même environnement partout" \
  "La taille excessive des fichiers source" \
  "L'absence de documentation dans les projets"

ask "Q2. Quelle est la différence fondamentale entre une VM et un conteneur Docker ?" \
  "Docker est systématiquement plus lent qu'une machine virtuelle" \
  "Une VM embarque son propre OS complet ; un conteneur partage le noyau de l'hôte" \
  "Docker ne peut fonctionner que sur Linux x86" \
  "Une VM ne peut pas accéder à Internet, contrairement à Docker"

ask "Q3. Qu'est-ce qu'une image Docker ?" \
  "Une capture d'écran du terminal Docker" \
  "Un conteneur en cours d'exécution avec ses données" \
  "Un modèle immuable (lecture seule) qui sert de base pour instancier des conteneurs" \
  "Un fichier de configuration réseau pour relier les conteneurs"

ask "Q4. Pourquoi utilise-t-on des volumes Docker ?" \
  "Pour accélérer le démarrage des conteneurs" \
  "Pour partager du code source entre développeurs via Docker Hub" \
  "Pour persister les données même lorsque le conteneur est supprimé ou recréé" \
  "Pour limiter la consommation CPU d'un conteneur"

ask "Q5. Pourquoi Docker Compose est-il utile ?" \
  "Pour remplacer entièrement le Dockerfile" \
  "Pour définir et orchestrer plusieurs conteneurs interdépendants en un seul fichier déclaratif" \
  "Pour publier automatiquement une image sur Docker Hub" \
  "Pour compiler et optimiser le code source d'une application"

echo -e "${CYAN}✓ Quiz terminé ! Cliquez sur 'Check' pour valider.${NC}"
QUIZ_EOF

chmod +x /root/quiz_step2.sh
