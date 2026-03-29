#!/bin/bash
# Crée /root/quiz_step3.sh — Pulumi, SaltStack & vision d'ensemble IaC (8 questions)
# Réponses correctes : Q1=2 Q2=3 Q3=2 Q4=3 Q5=2 Q6=3 Q7=2 Q8=3

cat > /root/quiz_step3.sh << 'QUIZ_EOF'
#!/bin/bash
ANSWER_FILE="/tmp/quiz_step3.txt"
> "$ANSWER_FILE"

CYAN='\033[0;36m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; NC='\033[0m'

echo -e "${CYAN}════════════════════════════════════════════════════════════════"
echo -e "  QCM Étape 3 : Pulumi, SaltStack & vision d'ensemble IaC"
echo -e "════════════════════════════════════════════════════════════════${NC}"
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

# ── Pulumi ────────────────────────────────────────────────────────────────────

ask "Q1. Quelle est la différence fondamentale entre Pulumi et Terraform ?" \
  "Pulumi ne peut fonctionner qu'avec AWS ; Terraform est multi-cloud" \
  "Pulumi utilise des langages de programmation natifs (Python, TypeScript, Go...) ; Terraform utilise un DSL déclaratif (HCL)" \
  "Terraform maintient un state, Pulumi non" \
  "Pulumi ne supporte pas les providers Kubernetes ni les clouds privés"

ask "Q2. Dans quel cas Pulumi est-il particulièrement avantageux par rapport à Terraform ?" \
  "Quand on déploie uniquement des ressources cloud simples et statiques" \
  "Quand toute l'équipe refuse d'apprendre un nouveau langage" \
  "Quand l'infrastructure requiert une logique complexe (boucles dynamiques, conditions, abstractions) naturellement exprimée en code" \
  "Quand on veut éviter de maintenir un state file"

# ── SaltStack ─────────────────────────────────────────────────────────────────

ask "Q3. Quelle est l'architecture caractéristique de SaltStack ?" \
  "Un seul nœud centralisé qui pousse la configuration via SSH sans aucun agent" \
  "Un master qui communique avec des minions via un bus de messages (ZeroMQ/RAET)" \
  "Un réseau peer-to-peer où tous les nœuds sont équivalents et s'auto-configurent" \
  "Un agent installé uniquement sur le master pour surveiller les nœuds distants"

ask "Q4. Qu'est-ce qu'un 'state' dans SaltStack (au sens Salt, pas Terraform) ?" \
  "Le fichier de connexion et d'authentification au master Salt" \
  "Un historique horodaté des commandes exécutées sur les minions" \
  "Un fichier YAML/Jinja2 (.sls) qui décrit l'état désiré d'un système (packages, services, fichiers)" \
  "La liste des grains (informations système) collectés sur un minion"

ask "Q5. Quelle est la principale différence architecturale entre Ansible et SaltStack ?" \
  "Ansible est un outil payant, SaltStack est entièrement gratuit" \
  "Ansible est agentless (SSH) ; SaltStack utilise des agents persistants (minions) et un bus de messages" \
  "SaltStack ne peut gérer que des systèmes Linux, Ansible est cross-platform" \
  "Ansible supporte l'idempotence, SaltStack n'en garantit pas"

ask "Q6. Qu'est-ce que le 'réacteur' (reactor) dans SaltStack ?" \
  "Un module pour redémarrer automatiquement les minions en erreur" \
  "Le composant de monitoring qui surveille les performances CPU/RAM des minions" \
  "Un mécanisme event-driven qui déclenche des actions automatiquement en réponse à des événements sur le bus de messages" \
  "L'interface web d'administration et de supervision du master Salt"

# ── Vision d'ensemble IaC ─────────────────────────────────────────────────────

ask "Q7. Dans une approche IaC globale, quelle est la complémentarité entre Terraform et Ansible ?" \
  "Terraform remplace totalement Ansible dans les environnements cloud natifs modernes" \
  "Terraform provisionne l'infrastructure (VMs, réseaux, DNS, buckets...) ; Ansible configure les systèmes une fois provisionnés" \
  "Ansible provisionne les ressources cloud, Terraform configure uniquement les systèmes Linux" \
  "Les deux outils font exactement la même chose avec une syntaxe différente"

ask "Q8. Lequel de ces énoncés décrit le mieux l'Infrastructure as Code (IaC) ?" \
  "Écrire des scripts qui installent manuellement les logiciels sur chaque nouveau serveur" \
  "Utiliser uniquement Docker et Kubernetes pour déployer toutes les applications" \
  "Décrire l'infrastructure dans des fichiers texte versionnés, garantissant reproductibilité, traçabilité et collaboration" \
  "Déléguer entièrement la gestion des serveurs à un prestataire cloud sans intervention manuelle"

echo -e "${CYAN}✓ Quiz terminé ! Cliquez sur 'Check' pour valider.${NC}"
QUIZ_EOF

chmod +x /root/quiz_step3.sh

# ── Bilan final ───────────────────────────────────────────────────────────────
cat > /root/quiz_results.sh << 'RESULTS_EOF'
#!/bin/bash
WEBHOOK="https://script.google.com/macros/s/AKfycbz6m907t86qgWKbQ9kYG8VJ_eSMUatBXAOM_kkgG-016i7gFUsmNUYlFn1WrDL1SUwS/exec"
CYAN='\033[0;36m'; GREEN='\033[0;32m'; RED='\033[0;31m'; YELLOW='\033[1;33m'; NC='\033[0m'

PSEUDO=$(cat /tmp/quiz_pseudo.txt 2>/dev/null | xargs)
if [ -z "$PSEUDO" ]; then
  echo -e "${RED}⚠ Identification manquante. Retournez à l'étape 1 et lancez : bash /root/set_pseudo.sh${NC}"
  PSEUDO="anonyme"
fi

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

# Step 1 : Q1=2 Q2=3 Q3=2 Q4=2 Q5=3 Q6=2 Q7=3 Q8=2
s1=$(compute_score /tmp/quiz_step1.txt 2 3 2 2 3 2 3 2)
# Step 2 : Q1=2 Q2=2 Q3=3 Q4=2 Q5=3 Q6=2 Q7=3 Q8=2
s2=$(compute_score /tmp/quiz_step2.txt 2 2 3 2 3 2 3 2)
# Step 3 : Q1=2 Q2=3 Q3=2 Q4=3 Q5=2 Q6=3 Q7=2 Q8=3
s3=$(compute_score /tmp/quiz_step3.txt 2 3 2 3 2 3 2 3)
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
echo -e "${CYAN}╔══════════════════════════════════════════════════╗"
echo -e "║       BILAN DU QCM DE POSITIONNEMENT IaC        ║"
echo -e "╚══════════════════════════════════════════════════╝${NC}"
echo -e "  Étudiant : ${YELLOW}$PSEUDO${NC}"
echo ""
echo -e "  Étape 1 — Terraform & OpenTofu   ${YELLOW}$s1/8${NC}  $(bar $s1 8)"
echo -e "  Étape 2 — Ansible                ${YELLOW}$s2/8${NC}  $(bar $s2 8)"
echo -e "  Étape 3 — Pulumi/SaltStack/IaC   ${YELLOW}$s3/8${NC}  $(bar $s3 8)"
echo    "  ────────────────────────────────────────────────"

if   [ "$total" -ge 20 ]; then
  echo -e "  TOTAL                            ${GREEN}$total/24${NC}  ✓ Excellent"
elif [ "$total" -ge 14 ]; then
  echo -e "  TOTAL                            ${YELLOW}$total/24${NC}  ~ Satisfaisant"
else
  echo -e "  TOTAL                            ${RED}$total/24${NC}  ✗ À retravailler"
fi

echo ""
echo -ne "  Envoi des résultats au formateur... "
MACHINE=$(hostname)
PSEUDO_SAFE=$(echo "$PSEUDO" | tr -d '"\\')
HTTP=$(curl -s -o /tmp/webhook_resp.txt -w "%{http_code}" -L \
  -X POST "$WEBHOOK" \
  -H "Content-Type: application/json" \
  -d "{\"pseudo\":\"$PSEUDO_SAFE\",\"hostname\":\"$MACHINE\",\"quiz\":\"IaC-J2\",\"s1\":$s1,\"s2\":$s2,\"s3\":$s3,\"total\":$total}" \
  2>/dev/null)

if [ "$HTTP" = "200" ]; then
  echo -e "${GREEN}✓ Envoyé !${NC}"
else
  echo -e "${RED}✗ Échec réseau (code $HTTP).${NC}"
fi
echo ""
RESULTS_EOF

chmod +x /root/quiz_results.sh
