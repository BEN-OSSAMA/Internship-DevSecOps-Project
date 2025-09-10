#!/bin/bash

# ------------------------------
# Script de déploiement Kubernetes
# ------------------------------

# Variables à adapter
NAMESPACE="app"
DOCKER_SERVER="registry.gitlab.com"
DOCKER_USERNAME="gitlab-ci-token"
DOCKER_PASSWORD="glptt-b2167626ad3a9b21d61f531a69f9be438a9272e3" # Remplace par ton token si besoin
DOCKER_EMAIL="oussama.benkacem@etu.uae.ac.ma"
K8S_MANIFEST_DIR="./k8s"

# ------------------------------
# Vérification des prérequis
# ------------------------------
echo "🔍 Vérification des prérequis..."
for cmd in kubectl docker; do
    if ! command -v $cmd &> /dev/null; then
        echo "❌ $cmd n'est pas installé. Veuillez l'installer avant de continuer."
        exit 1
    fi
done
echo "✅ Tous les outils requis sont installés."

# ------------------------------
# Création du namespace
# ------------------------------
echo "📂 Vérification du namespace '$NAMESPACE'..."
kubectl get namespace $NAMESPACE &> /dev/null
if [ $? -ne 0 ]; then
    echo "➡️ Création du namespace '$NAMESPACE'..."
    kubectl create namespace $NAMESPACE
else
    echo "✅ Le namespace '$NAMESPACE' existe déjà."
fi

# Switch vers le namespace
kubectl config set-context --current --namespace=$NAMESPACE

# ------------------------------
# Création du secret Docker
# ------------------------------
echo "🔑 Gestion du secret Docker..."
kubectl delete secret regcred --ignore-not-found -n $NAMESPACE

kubectl create secret docker-registry regcred \
    --docker-server=$DOCKER_SERVER \
    --docker-username=$DOCKER_USERNAME \
    --docker-password=$DOCKER_PASSWORD \
    --docker-email=$DOCKER_EMAIL \
    -n $NAMESPACE

echo "✅ Secret Docker créé avec succès."

# ------------------------------
# Déploiement des manifests
# ------------------------------
echo "🚀 Déploiement de l'application..."
kubectl apply -f $K8S_MANIFEST_DIR -n $NAMESPACE

echo "✅ Déploiement terminé !"
kubectl get all -n $NAMESPACE
