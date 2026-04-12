#!/bin/bash
# Quiz step 1 — Pods, ReplicaSets, Deployments (9 questions)
# Réponses : Q1=2 Q2=f Q3=3 Q4=2 Q5=f Q6=2 Q7=3 Q8=v Q9=2

# ── set_pseudo.sh ─────────────────────────────────────────────────────────────
cat > /root/set_pseudo.sh << 'PSEUDO_EOF'
#!/bin/bash
PSEUDO_FILE="/tmp/quiz_pseudo.txt"
CYAN='\033[0;36m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; RED='\033[0;31m'; NC='\033[0m'
echo -e "${CYAN}════════════════════════════════════════════════════"
echo -e "  Bilan Fondamentaux Kubernetes"
echo -e "════════════════════════════════════════════════════${NC}"
echo -e "${YELLOW}Entrez votre prénom et nom (ex : Marie Dupont) :${NC}"
while true; do
  echo -n "> "
  read -r pseudo
  pseudo="$(echo "$pseudo" | xargs)"
  if [ -n "$pseudo" ]; then
    echo "$pseudo" > "$PSEUDO_FILE"
    echo -e "${GREEN}✓ Bonjour $pseudo !${NC}"; break
  fi
  echo -e "${RED}Nom vide.${NC}"
done
PSEUDO_EOF
chmod +x /root/set_pseudo.sh

# ── quiz_step1.sh ─────────────────────────────────────────────────────────────
cat > /root/quiz_step1.sh << 'QUIZ_EOF'
#!/bin/bash
ANSWER_FILE="/tmp/bilan_step1.txt"
> "$ANSWER_FILE"
CYAN='\033[0;36m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; NC='\033[0m'

echo -e "${CYAN}════════════════════════════════════════════════════════════════"
echo -e "  Bilan fondamentaux — Étape 1 : Pods, ReplicaSets, Deployments"
echo -e "════════════════════════════════════════════════════════════════${NC}"
echo ""

ask_qcm() {
  local q="$1"; shift; local opts=("$@"); local max=${#opts[@]}
  echo -e "${YELLOW}$q${NC}"
  for i in "${!opts[@]}"; do echo "  $((i+1))) ${opts[$i]}"; done
  local ans
  while true; do
    echo -n "Réponse [1-$max] : "; read -r ans
    if [[ "$ans" =~ ^[0-9]+$ ]] && [ "$ans" -ge 1 ] && [ "$ans" -le "$max" ]; then
      echo "$ans" >> "$ANSWER_FILE"; echo -e "${GREEN}✓${NC}"; echo ""; break
    fi
    echo "Invalide."
  done
}

ask_vf() {
  local q="$1"
  echo -e "${YELLOW}$q${NC}"
  echo "  1) Vrai   2) Faux"
  local ans
  while true; do
    echo -n "Réponse [v/f ou 1/2] : "; read -r ans
    ans=$(echo "$ans" | tr '[:upper:]' '[:lower:]')
    if [[ "$ans" == "v" || "$ans" == "1" ]]; then
      echo "v" >> "$ANSWER_FILE"; echo -e "${GREEN}✓${NC}"; echo ""; break
    elif [[ "$ans" == "f" || "$ans" == "2" ]]; then
      echo "f" >> "$ANSWER_FILE"; echo -e "${GREEN}✓${NC}"; echo ""; break
    fi
    echo "Entrez v (Vrai) ou f (Faux)."
  done
}

ask_qcm "Q1. Que se passe-t-il quand un Pod avec restartPolicy: Always crashe ?" \
  "Il est recréé sur un autre nœud par le Scheduler" \
  "Il est redémarré sur le même nœud par le Kubelet" \
  "Le Deployment crée un nouveau Pod pour le remplacer" \
  "Il reste en état Failed indéfiniment"

ask_vf "Q2. Vrai ou Faux — En Kubernetes, un Pod ne peut contenir qu'un seul conteneur."

ask_qcm "Q3. Quelle phase du cycle de vie d'un Pod indique que tous les conteneurs ont terminé avec succès (code 0) ?" \
  "Running" \
  "Completed" \
  "Succeeded" \
  "Terminated"

ask_qcm "Q4. Quel est le délai maximum entre deux redémarrages dans le backoff exponentiel de Kubernetes ?" \
  "1 minute" \
  "5 minutes" \
  "10 minutes" \
  "30 minutes"

ask_vf "Q5. Vrai ou Faux — Un ReplicaSet met à jour automatiquement les pods existants quand on change l'image dans son spec."

ask_qcm "Q6. Pourquoi ne crée-t-on jamais un ReplicaSet directement en production ?" \
  "Le ReplicaSet ne garantit pas le nombre de replicas souhaité" \
  "Le ReplicaSet ne sait pas faire de rolling update — il faut un Deployment" \
  "Le ReplicaSet ne supporte pas les labels et selectors" \
  "Le ReplicaSet ne peut gérer qu'un seul Pod à la fois"

ask_qcm "Q7. Dans un Deployment, quel champ définit le nombre de ReplicaSets conservés pour le rollback ?" \
  "rollbackLimit" \
  "historySize" \
  "revisionHistoryLimit" \
  "maxRevisions"

ask_vf "Q8. Vrai ou Faux — Sans Readiness Probe, un rolling update peut envoyer du trafic vers un pod qui n'est pas encore prêt."

ask_qcm "Q9. Comment annoter un Deployment pour garder un historique lisible des changements ?" \
  "kubectl set changelog deployment/mon-app 'message'" \
  "kubectl annotate deployment/mon-app kubernetes.io/change-cause='message'" \
  "kubectl history deployment/mon-app --message='message'" \
  "kubectl rollout note deployment/mon-app 'message'"

echo -e "${CYAN}✓ Étape 1 terminée ! Cliquez sur 'Check'.${NC}"
QUIZ_EOF
chmod +x /root/quiz_step1.sh
