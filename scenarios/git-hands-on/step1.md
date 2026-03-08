# Étape 1 — Initialisation et configuration

Dans cette étape, vous allez créer un dépôt Git et configurer votre identité.

## 1. Créer le répertoire de travail

`mkdir -p /root/git-practice && cd /root/git-practice`{{exec}}

## 2. Initialiser le dépôt Git

`git init`{{exec}}

> Git crée un répertoire caché `.git/` qui stocke toute l'histoire du projet.

Vérifiez qu'il existe bien :

`ls -la`{{exec}}

## 3. Configurer votre identité

Git requiert un nom et un email pour signer chaque commit.

`git config user.name "Étudiant MDS"`{{exec}}

`git config user.email "etudiant@mds.fr"`{{exec}}

## 4. Vérifier la configuration

`git config --list`{{exec}}

---

> **Pourquoi configurer son identité ?**
> Chaque commit enregistre l'auteur. Sans cette configuration, Git refusera de créer des commits.

Quand c'est fait, cliquez sur **Check** pour valider.
