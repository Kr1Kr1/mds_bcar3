#!/bin/bash
# Crée /root/set_pseudo.sh + /root/quiz_step1.sh — Cloud Native & orchestration (8 questions)
# Réponses correctes : Q1=3 Q2=2 Q3=1 Q4=3 Q5=2 Q6=4 Q7=3 Q8=2

# ── Identification de l'étudiant ───────────────────────────────────────────────
cat > /root/set_pseudo.sh << 'PSEUDO_EOF'
#!/bin/bash
PSEUDO_FILE="/tmp/quiz_pseudo.txt"
CYAN='\033[0;36m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; RED='\033[0;31m'; NC='\033[0m'

echo -e "${CYAN}════════════════════════════════════════════════"
echo -e "  Identification — QCM de positionnement K8s"
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

echo -e "${CYAN}══════════════════════════════════════════════════════"
echo -e "  QCM Étape 1 : Cloud Native & orchestration"
echo -e "══════════════════════════════════════════════════════${NC}"
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

ask "Q1. Quelle est la définition d'une application 'Cloud Native' ?" \
  "Une application déployée exclusivement sur AWS, GCP ou Azure" \
  "Une application écrite en Go ou Rust pour être performante sur le cloud" \
  "Une application conçue pour les environnements distribués : conteneurs, microservices, infrastructure immuable, API déclaratives" \
  "Une application qui utilise uniquement des services managés du cloud provider"

ask "Q2. Lequel de ces principes n'appartient PAS aux 6 piliers Cloud Native ?" \
  "Conteneurisation" \
  "Monolithisation" \
  "Immutabilité" \
  "Observabilité"

ask "Q3. Qu'est-ce que l'infrastructure immuable ?" \
  "On ne modifie jamais une infrastructure existante — on construit une nouvelle image, on déploie, puis on détruit l'ancienne" \
  "Une infrastructure qui ne peut pas être modifiée car elle est en production critique" \
  "Un cluster Kubernetes dont les nœuds sont en lecture seule" \
  "Une approche qui utilise uniquement des VMs sans conteneurs"

ask "Q4. Qu'est-ce qu'un service mesh ?" \
  "Un réseau de CDN qui accélère les requêtes HTTP entre microservices" \
  "Un orchestrateur alternatif à Kubernetes, spécialisé dans le routage" \
  "Une couche réseau transparente (sidecar proxy) gérant mTLS, observabilité et résilience entre services" \
  "Un plugin Kubernetes qui remplace kube-proxy pour les règles iptables"

ask "Q5. Pourquoi Docker Compose n'est-il pas un vrai orchestrateur ?" \
  "Parce qu'il ne supporte pas les fichiers YAML" \
  "Parce qu'il ne gère pas la haute disponibilité ni l'auto-scaling — il est conçu pour le dev local" \
  "Parce qu'il ne fonctionne qu'avec des images Docker Hub" \
  "Parce qu'il n'est pas compatible avec Linux"

ask "Q6. Qu'est-ce que la CNCF ?" \
  "Une certification cloud délivrée par Google et Amazon" \
  "Un framework de développement d'applications cloud" \
  "Une suite d'outils DevOps propriétaires de HashiCorp" \
  "Une fondation à but non lucratif qui héberge des projets cloud native open source (K8s, Prometheus, Helm…)"

ask "Q7. Dans quel ordre les projets CNCF progressent-ils en termes de maturité ?" \
  "Graduated → Incubating → Sandbox" \
  "Incubating → Sandbox → Graduated" \
  "Sandbox → Incubating → Graduated" \
  "Alpha → Beta → Stable"

ask "Q8. Quelle est la principale différence entre Kubernetes et Nomad ?" \
  "Nomad ne supporte pas les conteneurs Docker, uniquement les binaires natifs" \
  "Kubernetes orchestre uniquement des conteneurs, tandis que Nomad peut orchestrer des conteneurs, des binaires natifs et des scripts — plus adapté aux architectures hybrides" \
  "Nomad est une version simplifiée de Kubernetes développée par Google" \
  "Kubernetes ne fonctionne que sur le cloud public, Nomad fonctionne on-premise"

echo -e "${CYAN}✓ Quiz terminé ! Cliquez sur 'Check' pour valider.${NC}"
QUIZ_EOF

chmod +x /root/quiz_step1.sh
