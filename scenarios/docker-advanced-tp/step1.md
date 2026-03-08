# Étape 1 — La plus petite image possible

## Contexte

Vous devez conteneuriser un petit serveur HTTP "Hello World". L'objectif est de produire l'image **la plus légère possible** sans sacrifier le fonctionnement.

## Objectifs

1. Écrivez le code source d'un mini serveur HTTP qui répond "Hello World" (Go, Python ou Node.js au choix)
2. Écrivez un **premier Dockerfile naïf** (ex. `FROM golang:1.21`), buildez, notez la taille
3. **Optimisez** l'image en appliquant une ou plusieurs techniques :
   - Image de base plus légère (alpine, distroless, scratch…)
   - **Multi-stage build** pour séparer la compilation du runtime
   - En Go : compilez un binaire statique (`CGO_ENABLED=0`) pour utiliser `FROM scratch`
4. Ajoutez un **HEALTHCHECK** à l'image finale
5. Comparez les tailles (`docker images`) entre la version naïve et la version optimisée

> 🎯 Objectif : image finale **< 20 Mo** pour Go, **< 150 Mo** pour Python/Node.

<details>
<summary>💡 Indice : serveur HTTP minimal en Go</summary>

```go
// main.go
package main

import (
    "fmt"
    "net/http"
)

func main() {
    http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
        fmt.Fprintln(w, "Hello World")
    })
    http.ListenAndServe(":8080", nil)
}
```
</details>

<details>
<summary>💡 Indice : Dockerfile multi-stage Go → scratch</summary>

```dockerfile
# Stage 1 : compilation
FROM golang:1.21-alpine AS build
WORKDIR /src
COPY . .
RUN CGO_ENABLED=0 go build -o app

# Stage 2 : image minimale
FROM scratch
COPY --from=build /src/app /app
EXPOSE 8080
HEALTHCHECK --interval=5s --timeout=2s CMD ["/app"]
ENTRYPOINT ["/app"]
```

`CGO_ENABLED=0` produit un binaire **statique** qui n'a pas besoin de libc → compatible avec `scratch`.
</details>

<details>
<summary>💡 Indice : vérifier la taille et tester</summary>

```bash
docker images | grep -E "REPOSITORY|hello"
docker run -d -p 8080:8080 --name hello-test mon-hello
curl http://localhost:8080
```
</details>

Cliquez sur **Check** quand vous avez une image `hello-optimise` de moins de 150 Mo qui répond sur le port 8080.
