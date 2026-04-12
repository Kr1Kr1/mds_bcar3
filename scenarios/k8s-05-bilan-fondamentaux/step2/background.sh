#!/bin/bash
# Quiz step 2 — Services, ConfigMaps, Secrets (8 questions)
# Réponses : Q1=2 Q2=3 Q3=v Q4=2 Q5=3 Q6=f Q7=2 Q8=2

cat > /root/quiz_step2.sh << 'QUIZ_EOF'
#!/bin/bash
ANSWER_FILE="/tmp/bilan_step2.txt"
> "$ANSWER_FILE"
CYAN='\033[0;36m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; NC='\033[0m'

echo -e "${CYAN}══════════════════════════════════════════════════════════════════════"
echo -e "  Bilan fondamentaux — Étape 2 : Services, ConfigMaps, Secrets"
echo -e "══════════════════════════════════════════════════════════════════════${NC}"
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

ask_qcm "Q1. Quel type de Service expose une application uniquement à l'intérieur du cluster ?" \
  "NodePort" \
  "ClusterIP" \
  "LoadBalancer" \
  "ExternalName"

ask_qcm "Q2. Comment un Service sélectionne-t-il les Pods vers lesquels router le trafic ?" \
  "Via les noms des Pods" \
  "Via les annotations des Pods" \
  "Via les labels des Pods (selector)" \
  "Via les adresses IP des Pods"

ask_vf "Q3. Vrai ou Faux — Un Service Headless (clusterIP: None) retourne directement les IPs des Pods via DNS."

ask_qcm "Q4. Quel est le principal cas d'usage du type ExternalName ?" \
  "Exposer un service Kubernetes sur Internet" \
  "Créer un alias DNS vers un service hors du cluster" \
  "Equilibrer la charge entre plusieurs namespaces" \
  "Rendre un service accessible sur tous les nœuds"

ask_qcm "Q5. Quelle méthode d'injection d'un ConfigMap permet une mise à jour automatique (~60s) sans redémarrer le pod ?" \
  "Variables d'environnement avec env:" \
  "Variables d'environnement avec envFrom:" \
  "Volume monté (sans subPath)" \
  "Volume monté avec subPath"

ask_vf "Q6. Vrai ou Faux — base64 est un chiffrement — les Secrets Kubernetes sont donc protégés par défaut dans etcd."

ask_qcm "Q7. Quel type de Secret Kubernetes est utilisé pour stocker des certificats TLS ?" \
  "Opaque" \
  "kubernetes.io/tls" \
  "kubernetes.io/dockerconfigjson" \
  "kubernetes.io/basic-auth"

ask_qcm "Q8. Pour vraiment protéger les Secrets dans etcd, que faut-il activer ?" \
  "L'encodage base64 renforcé" \
  "Le chiffrement at-rest d'etcd (EncryptionConfiguration)" \
  "Le flag --secret-encryption sur kubelet" \
  "Le mode RBAC sur kube-apiserver"

echo -e "${CYAN}✓ Étape 2 terminée ! Cliquez sur 'Check'.${NC}"
QUIZ_EOF
chmod +x /root/quiz_step2.sh
