#!/bin/bash
# Installe Docker CE avec buildx et le support multi-arch (QEMU)

apt-get update -qq
apt-get install -y -qq ca-certificates curl gnupg 2>/dev/null

install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
  | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" \
  > /etc/apt/sources.list.d/docker.list

apt-get update -qq
apt-get install -y -qq docker-ce docker-ce-cli containerd.io \
  docker-buildx-plugin golang-go 2>/dev/null
systemctl start docker

# Activer QEMU pour les builds multi-arch
docker run --privileged --rm tonistiigi/binfmt --install all &>/dev/null || true

# Créer un builder buildx multi-plateforme
docker buildx create --name multibuilder --use &>/dev/null || true
docker buildx inspect --bootstrap &>/dev/null || true

echo "Docker Advanced TP prêt"
