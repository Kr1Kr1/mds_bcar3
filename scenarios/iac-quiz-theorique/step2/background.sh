#!/bin/bash
# Crée /root/quiz_step2.sh — Ansible : automatisation de configuration (8 questions)
# Réponses correctes : Q1=2 Q2=2 Q3=3 Q4=2 Q5=3 Q6=2 Q7=3 Q8=2

cat > /root/quiz_step2.sh << 'QUIZ_EOF'
#!/bin/bash
ANSWER_FILE="/tmp/quiz_step2.txt"
> "$ANSWER_FILE"

CYAN='\033[0;36m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; NC='\033[0m'

echo -e "${CYAN}════════════════════════════════════════════════════════════"
echo -e "  QCM Étape 2 : Ansible — automatisation de configuration"
echo -e "════════════════════════════════════════════════════════════${NC}"
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

ask "Q1. Pourquoi dit-on qu'Ansible est 'agentless' ?" \
  "Ansible ne nécessite pas de connexion réseau pour fonctionner" \
  "Ansible n'a pas besoin d'installer de logiciel sur les machines gérées : il utilise SSH et Python" \
  "Ansible fonctionne sans fichier de configuration ni inventaire" \
  "Ansible ne gère que les conteneurs Docker, pas les serveurs physiques"

ask "Q2. Qu'est-ce qu'un inventaire dans Ansible ?" \
  "La liste des modules Ansible installés sur le nœud contrôleur" \
  "Le fichier ou répertoire qui liste les hôtes et groupes de machines à gérer" \
  "Le journal des tâches exécutées lors du dernier playbook" \
  "La configuration Vault pour le chiffrement des secrets"

ask "Q3. Qu'est-ce que l'idempotence dans le contexte d'Ansible ?" \
  "La capacité d'Ansible à corriger automatiquement les erreurs de syntaxe YAML" \
  "Le fait qu'un playbook ne peut être exécuté qu'une seule fois par hôte" \
  "Exécuter un playbook plusieurs fois donne le même résultat final sans créer d'effets indésirables" \
  "La capacité d'Ansible à fonctionner sans connexion internet une fois installé"

ask "Q4. Quel est le rôle d'un playbook Ansible ?" \
  "Un fichier de configuration qui définit les credentials SSH des hôtes cibles" \
  "Un fichier YAML qui décrit une suite ordonnée de tâches à exécuter sur des hôtes" \
  "Un plugin qui étend les fonctionnalités du contrôleur Ansible" \
  "Un répertoire qui contient les rôles installés via Ansible Galaxy"

ask "Q5. Quelle est la différence entre une commande ad-hoc et un playbook Ansible ?" \
  "Les commandes ad-hoc sont écrites en Python, les playbooks en YAML" \
  "Les commandes ad-hoc ne peuvent cibler qu'un seul hôte à la fois" \
  "Une commande ad-hoc exécute un module ponctuel en une ligne ; un playbook orchestre plusieurs tâches de façon réutilisable" \
  "Les commandes ad-hoc nécessitent obligatoirement un inventaire dynamique"

# ── Techniques ─────────────────────────────────────────────────────────────────

ask "Q6. Que sont les 'handlers' dans un playbook Ansible ?" \
  "Des variables spéciales injectées automatiquement dans toutes les tâches" \
  "Des tâches déclenchées uniquement si une autre tâche a effectué un changement (via notify)" \
  "Des fonctions Jinja2 pour transformer et filtrer les données" \
  "Des plugins de connexion alternatifs à SSH pour les environnements Windows"

ask "Q7. Qu'apporte Ansible Vault ?" \
  "Un système de monitoring des playbooks en temps réel avec alertes" \
  "Un gestionnaire de rôles et collections communautaires (comme npm pour Ansible)" \
  "Le chiffrement des données sensibles (mots de passe, clés API) stockées dans les fichiers de variables" \
  "Un accélérateur de connexion SSH pour les grands inventaires (>1000 hôtes)"

ask "Q8. Quel est l'intérêt principal d'un rôle Ansible par rapport à un playbook monolithique ?" \
  "Les rôles permettent d'utiliser Python au lieu de YAML pour décrire les tâches" \
  "Un rôle est une unité réutilisable et partageable qui organise tâches, variables, templates et handlers" \
  "Les rôles exécutent les tâches en parallèle, offrant de meilleures performances" \
  "Les rôles remplacent l'inventaire et permettent de cibler les hôtes dynamiquement"

echo -e "${CYAN}✓ Quiz terminé ! Cliquez sur 'Check' pour valider.${NC}"
QUIZ_EOF

chmod +x /root/quiz_step2.sh
