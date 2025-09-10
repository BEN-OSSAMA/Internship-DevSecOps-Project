#!/bin/bash
set -e

echo "📊 Installation de Prometheus et Grafana..."
helm install prometheus prometheus-community/kube-prometheus-stack -n monitoring

echo "📊 Configuration des dashboards..."
kubectl apply -f monitoring/dashboards/ -n monitoring

echo "✅ Monitoring configuré"
