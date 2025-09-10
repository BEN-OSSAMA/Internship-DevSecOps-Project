#!/bin/bash
set -e

CLUSTER_NAME="fsmicro-cluster"

echo "🔄 Création du cluster Kind..."
kind create cluster --name $CLUSTER_NAME

echo "✅ Cluster créé : $CLUSTER_NAME"
kubectl cluster-info --context kind-$CLUSTER_NAME
