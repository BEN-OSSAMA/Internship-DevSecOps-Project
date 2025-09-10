#!/bin/bash
set -e

echo "🚀 Déploiement des microservices via Helm..."

helm upgrade --install ms-auth ./helm-charts/microservice -n app -f values-auth.yaml
helm upgrade --install ms-users ./helm-charts/microservice -n app -f values-users.yaml
helm upgrade --install ms-products ./helm-charts/microservice -n app -f values-products.yaml
helm upgrade --install ms-orders ./helm-charts/microservice -n app -f values-orders.yaml


echo "✅ Microservices déployés"
