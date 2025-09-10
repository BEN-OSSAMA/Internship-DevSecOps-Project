#!/bin/bash
set -e

echo "🌐 Déploiement de l'API Gateway..."
helm upgrade --install api-gateway ./helm-charts/api-gateway -n app

echo "🌐 Application des règles Ingress..."
kubectl apply -f k8s/ingress.yaml -n app

echo "✅ API Gateway et Ingress configurés"
