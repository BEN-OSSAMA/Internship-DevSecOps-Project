#!/bin/bash
set -e

echo "🗄️ Déploiement de MongoDB..."
kubectl apply -f k8s/mongo-auth.yaml -n data
kubectl apply -f k8s/mongo-users.yaml -n data
kubectl apply -f k8s/mongo-products.yaml -n data
kubectl apply -f k8s/mongo-orders.yaml -n data


echo "🗄️ Déploiement de Redis..."
kubectl apply -f k8s/redis.yaml -n data

echo "✅ Bases de données déployées"
