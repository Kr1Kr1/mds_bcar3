#!/bin/bash
# Crée /root/quiz_step2.sh — Docker : concepts & pourquoi (8 questions)
# Réponses correctes : Q1=2 Q2=2 Q3=3 Q4=3 Q5=2 Q6=2 Q7=2 Q8=2

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

# ── Conceptuelles ──────────────────────────────────────────────────────────────

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

# ── Techniques ─────────────────────────────────────────────────────────────────

ask "Q6. Que signifie l'instruction 'FROM ubuntu:22.04' dans un Dockerfile ?" \
  "Télécharger Ubuntu 22.04 sur le système hôte" \
  "Définir l'image de base à partir de laquelle cette image sera construite" \
  "Lancer un conteneur Ubuntu au démarrage du service" \
  "Mettre à jour l'OS Ubuntu du serveur hôte"

ask "Q7. À quoi sert le flag '-p 8080:80' dans la commande 'docker run -p 8080:80 monimage' ?" \
  "Limiter le conteneur à 80 Mo de RAM et 8080 Ko de CPU" \
  "Mapper le port 80 du conteneur sur le port 8080 de la machine hôte" \
  "Créer deux conteneurs sur les ports 80 et 8080 simultanément" \
  "Restreindre l'accès au conteneur aux ports 80 et 8080"

ask "Q8. Que se passe-t-il si on fait 'docker rm' sur un conteneur sans volume configuré ?" \
  "L'image de base est supprimée du système" \
  "Les données écrites à l'intérieur du conteneur sont définitivement perdues" \
  "Docker sauvegarde automatiquement les données avant la suppression" \
  "Seul le nom du conteneur est libéré, les données restent intactes"

echo -e "${CYAN}✓ Quiz terminé ! Cliquez sur 'Check' pour valider.${NC}"
QUIZ_EOF

chmod +x /root/quiz_step2.sh
