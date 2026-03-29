#!/bin/bash
# Crée /root/set_pseudo.sh + /root/quiz_step1.sh — Terraform & OpenTofu : concepts & workflow (8 questions)
# Réponses correctes : Q1=2 Q2=3 Q3=2 Q4=2 Q5=3 Q6=2 Q7=3 Q8=2

# ── Identification de l'étudiant ───────────────────────────────────────────────
cat > /root/set_pseudo.sh << 'PSEUDO_EOF'
#!/bin/bash
PSEUDO_FILE="/tmp/quiz_pseudo.txt"
CYAN='\033[0;36m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; RED='\033[0;31m'; NC='\033[0m'

echo -e "${CYAN}════════════════════════════════════════════════"
echo -e "  Identification — QCM de positionnement IaC"
echo -e "════════════════════════════════════════════════${NC}"
echo ""
echo -e "${YELLOW}Entrez votre prénom et nom (ex : Marie Dupont) :${NC}"

while true; do
  echo -n "> "
  read -r pseudo
  pseudo="$(echo "$pseudo" | xargs)"
  if [ -n "$pseudo" ]; then
    echo "$pseudo" > "$PSEUDO_FILE"
    echo ""
    echo -e "${GREEN}✓ Bonjour $pseudo ! Vous pouvez lancer le quiz.${NC}"
    echo ""
    break
  fi
  echo -e "${RED}Nom vide. Veuillez entrer votre prénom et nom.${NC}"
done
PSEUDO_EOF

chmod +x /root/set_pseudo.sh

# ── Quiz étape 1 ───────────────────────────────────────────────────────────────
cat > /root/quiz_step1.sh << 'QUIZ_EOF'
#!/bin/bash
ANSWER_FILE="/tmp/quiz_step1.txt"
> "$ANSWER_FILE"

CYAN='\033[0;36m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; NC='\033[0m'

echo -e "${CYAN}════════════════════════════════════════════════════════"
echo -e "  QCM Étape 1 : Terraform & OpenTofu — concepts & workflow"
echo -e "════════════════════════════════════════════════════════${NC}"
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

ask "Q1. Pourquoi utilise-t-on Terraform/OpenTofu plutôt que des scripts bash pour gérer l'infrastructure ?" \
  "Les scripts bash ne fonctionnent pas sur les clouds publics" \
  "Terraform est déclaratif et idempotent : il décrit l'état désiré et maintient un état de l'infra réelle" \
  "Terraform est toujours plus rapide que bash pour créer des ressources" \
  "Les APIs cloud n'acceptent pas les scripts bash"

ask "Q2. Qu'est-ce que le 'state' (état) dans Terraform/OpenTofu ?" \
  "Le journal des erreurs d'exécution enregistré localement" \
  "La liste des providers et plugins téléchargés dans .terraform/" \
  "Le fichier qui représente l'état actuel de l'infrastructure gérée par Terraform" \
  "La configuration du backend distant (S3, GitLab...)"

ask "Q3. Qu'est-ce qu'un 'provider' dans Terraform/OpenTofu ?" \
  "Un serveur dédié qui héberge le state file en production" \
  "Un plugin qui expose les ressources d'une plateforme (AWS, GCP, Kubernetes...) et sait comment les gérer" \
  "Un module réutilisable d'infrastructure publié sur le registry" \
  "Une variable d'environnement injectée lors du plan"

ask "Q4. Dans quel ordre se déroule le workflow Terraform standard ?" \
  "apply → plan → init → validate" \
  "init → validate → plan → apply" \
  "plan → init → apply → validate" \
  "validate → apply → init → plan"

ask "Q5. Pourquoi OpenTofu a-t-il été créé en 2023 ?" \
  "Pour remplacer Terraform par une solution entièrement réécrite en Rust" \
  "Parce que HashiCorp a abandonné le support Linux de Terraform" \
  "Suite au changement de licence de Terraform (BSL), pour maintenir une alternative sous licence open source (MPL-2.0)" \
  "Pour ajouter le support de Python et JavaScript dans les fichiers de configuration"

# ── Techniques ─────────────────────────────────────────────────────────────────

ask "Q6. Quelle est la différence entre un 'resource' et un 'data source' dans Terraform ?" \
  "Un resource est en lecture seule, un data source crée et modifie des objets" \
  "Un resource crée/modifie/supprime des objets ; un data source lit des informations existantes sans les modifier" \
  "Un resource ne peut être utilisé qu'avec les providers AWS et Azure" \
  "Les data sources ne sont disponibles que dans les modules, pas dans la configuration racine"

ask "Q7. Que fait exactement la commande 'tofu plan' ?" \
  "Télécharge et installe les providers nécessaires dans .terraform/" \
  "Applique immédiatement toutes les modifications en attente à l'infrastructure" \
  "Calcule et affiche les changements qui seraient effectués sans modifier l'infrastructure réelle" \
  "Génère automatiquement la documentation HTML du projet"

ask "Q8. Pourquoi stocke-t-on le state dans un backend distant plutôt qu'en local ?" \
  "Le state local n'est pas compatible avec les providers cloud modernes" \
  "Pour permettre le travail en équipe, éviter les conflits et sécuriser le fichier d'état (+ verrouillage)" \
  "Terraform refuse de fonctionner sans backend distant explicitement configuré" \
  "Pour accélérer significativement les opérations plan et apply"

echo -e "${CYAN}✓ Quiz terminé ! Cliquez sur 'Check' pour valider.${NC}"
QUIZ_EOF

chmod +x /root/quiz_step1.sh
