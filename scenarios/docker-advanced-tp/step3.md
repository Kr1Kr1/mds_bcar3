# Étape 3 — Optimisation du cache Docker

## Contexte

Votre projet Node.js met beaucoup de temps à builder en CI/CD car npm install est relancé à chaque modification du code.

## Objectifs

1. Créez un projet Node.js minimal (un `package.json` + un fichier `app.js`)
2. Écrivez un **Dockerfile naïf** (COPY tout d'abord, puis npm install), buildez et mesurez le temps
3. Modifiez un fichier source et rebuildez — observez que **tout le cache saute**
4. Réécrivez le Dockerfile de façon **optimisée** : copiez d'abord `package*.json`, installez, puis copiez le code
5. Testez les 4 scénarios de build et comparez les temps :
   - Build initial (full)
   - Sans changement (cache total)
   - Modification du code source seulement
   - Modification de `package.json` (deps changent)
6. Créez un **`.dockerignore`** pour exclure `node_modules`, `.git`, etc.

> 🎯 Le build "code only" doit être **beaucoup plus rapide** que le build initial.

<details>
<summary>💡 Indice : structure de projet minimale</summary>

```
/root/node-app/
├── package.json
├── app.js
└── Dockerfile
```

`package.json` minimal :
```json
{
  "name": "hello",
  "version": "1.0.0",
  "dependencies": { "express": "^4.18.0" }
}
```

`app.js` :
```js
const express = require('express');
const app = express();
app.get('/', (req, res) => res.send('Hello World'));
app.listen(3000);
```
</details>

<details>
<summary>💡 Indice : Dockerfile naïf vs optimisé</summary>

**Naïf (lent) :**
```dockerfile
FROM node:18
WORKDIR /app
COPY . .          # ← tout copié d'abord
RUN npm install   # ← cache invalidé à chaque changement de fichier
CMD ["node", "app.js"]
```

**Optimisé (cache npm préservé) :**
```dockerfile
FROM node:18
WORKDIR /app
COPY package*.json ./   # ← seulement les deps d'abord
RUN npm install         # ← cache préservé si package.json n'a pas changé
COPY . .                # ← code copié après
CMD ["node", "app.js"]
```
</details>

<details>
<summary>💡 Indice : mesurer le temps de build</summary>

```bash
time docker build --no-cache -t node-app-naif -f Dockerfile.naif .
time docker build --no-cache -t node-app-opti -f Dockerfile.opti .

# Modifier app.js puis :
time docker build -t node-app-opti -f Dockerfile.opti .
# → npm install doit rester en cache !
```
</details>

Cliquez sur **Check** quand vous avez un Dockerfile optimisé avec `COPY package*.json` avant `COPY . .` et une image buildée.
