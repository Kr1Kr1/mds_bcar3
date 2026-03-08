#!/bin/bash
set -e

echo "→ Installation de git..."
apt-get update -qq 2>/dev/null || true
apt-get install -y git 2>/dev/null || true

echo "→ Configuration globale de git..."
git config --global user.email "etudiant@mds.fr"
git config --global user.name "Étudiant MDS"
git config --global init.defaultBranch main

echo "→ Création du dépôt bare (simulation du remote GitHub)..."
mkdir -p /root/first-day-c.git
git init --bare /root/first-day-c.git

TMPDIR=$(mktemp -d)
git clone /root/first-day-c.git "$TMPDIR/work" 2>/dev/null
cd "$TMPDIR/work"
git config user.email "setup@killercoda.com"
git config user.name "Setup"

cat > README.md << 'EOF'
# First Day C

Dépôt d'exercices pour apprendre Git.
Bienvenue dans ce TP sur le workflow collaboratif !
EOF

cat > hello.c << 'EOF'
#include <stdio.h>

int main() {
    printf("Hello, World!\n");
    return 0;
}
EOF

printf 'all: hello\n\nhello: hello.c\n\tgcc -o hello hello.c\n\nclean:\n\trm -f hello\n' > Makefile

git add .
git commit -m "init: ajout README, hello.c et Makefile"
git push origin main 2>/dev/null

git checkout -b go

cat > main.go << 'EOF'
package main

import "fmt"

func main() {
    fmt.Println("Hello, Go!")
}
EOF

cat >> README.md << 'EOF'

## Version Go

Ce dépôt contient aussi une version Go du programme.
EOF

git add .
git commit -m "feat(go): ajout version Go du programme"
git push origin go 2>/dev/null

cd /root
rm -rf "$TMPDIR"

echo "✓ Environnement prêt ! Passez à l'étape suivante."
