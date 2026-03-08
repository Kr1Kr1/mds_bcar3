#!/bin/bash
# Setup : crée un dépôt "remote" local simulant un dépôt GitHub
# Structure : branche main (README + hello.c) + branche go (main.go)

set -e

apt-get install -y git 2>/dev/null | tail -1

git config --global user.email "etudiant@mds.fr"
git config --global user.name "Étudiant MDS"
git config --global init.defaultBranch main

# ── Créer le bare repo (équivalent du dépôt GitHub distant) ──────────────────
mkdir -p /root/first-day-c.git
git init --bare /root/first-day-c.git

# ── Peupler le bare repo via un clone de travail temporaire ──────────────────
TMPDIR=$(mktemp -d)
git clone /root/first-day-c.git "$TMPDIR/work" 2>/dev/null

cd "$TMPDIR/work"
git config user.email "setup@killercoda.com"
git config user.name "Setup"

# Branche main
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

cat > Makefile << 'EOF'
all: hello

hello: hello.c
	gcc -o hello hello.c

clean:
	rm -f hello
EOF

git add .
git commit -m "init: ajout README, hello.c et Makefile"
git push origin main 2>/dev/null

# Branche go
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

# Nettoyage
cd /root
rm -rf "$TMPDIR"
