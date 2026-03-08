#!/bin/bash
# Vérifie : git init dans /root/git-practice + git config user.name + user.email

REPO="/root/git-practice"

if [ ! -d "$REPO/.git" ]; then
  echo "ERREUR : $REPO n'est pas un dépôt Git."
  echo "Lancez : mkdir -p $REPO && cd $REPO && git init"
  exit 1
fi

name=$(git -C "$REPO" config user.name 2>/dev/null)
if [ -z "$name" ]; then
  echo "ERREUR : git config user.name non configuré."
  echo "Lancez : git config user.name \"Votre Nom\""
  exit 1
fi

email=$(git -C "$REPO" config user.email 2>/dev/null)
if [ -z "$email" ]; then
  echo "ERREUR : git config user.email non configuré."
  echo "Lancez : git config user.email \"votre@email.com\""
  exit 1
fi

echo "✓ Dépôt Git initialisé dans $REPO"
echo "✓ Identité configurée : $name <$email>"
exit 0
