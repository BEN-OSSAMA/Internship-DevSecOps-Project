#!/bin/bash
set -e

echo "🔒 Lancement des scans de sécurité..."
trivy image --severity HIGH,CRITICAL my-image:latest
kubectl apply -f k8s/networkpolicy.yaml -n app
checkov -d . --quiet

echo "✅ Scans de sécurité terminés"
