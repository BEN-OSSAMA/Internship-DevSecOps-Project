#!/bin/bash
# setup_grafana_dashboard.sh
# Script pour créer un dashboard Grafana pour Prometheus sans relancer les conteneurs

# Configuration
GRAFANA_URL="http://localhost:3000"
GRAFANA_USER="admin"
GRAFANA_PASSWORD="admin"
PROMETHEUS_URL="http://host.docker.internal:4000"  # ou http://localhost:4000 si Grafana est sur la même VM
DASHBOARD_NAME="Prometheus Metrics"

echo "🔹 Vérification de l'accès à Grafana..."
curl -s -o /dev/null -w "%{http_code}" -u $GRAFANA_USER:$GRAFANA_PASSWORD $GRAFANA_URL/api/health | grep -q "200"
if [ $? -ne 0 ]; then
    echo "❌ Grafana inaccessible. Vérifie que Grafana tourne et les credentials."
    exit 1
fi
echo "✅ Grafana accessible."

# 1️⃣ Ajouter Prometheus comme data source
echo "🔹 Ajout de la data source Prometheus..."
curl -s -X POST -H "Content-Type: application/json" \
    -u $GRAFANA_USER:$GRAFANA_PASSWORD \
    -d "{
        \"name\": \"Prometheus\",
        \"type\": \"prometheus\",
        \"url\": \"$PROMETHEUS_URL\",
        \"access\": \"proxy\",
        \"basicAuth\": false
    }" \
    $GRAFANA_URL/api/datasources | grep -q "name"
echo "✅ Data source Prometheus configurée."

# 2️⃣ Créer un dashboard de base
echo "🔹 Création d'un dashboard de test..."
DASHBOARD_JSON=$(cat <<EOF
{
  "dashboard": {
    "id": null,
    "uid": null,
    "title": "$DASHBOARD_NAME",
    "tags": ["auto-generated"],
    "timezone": "browser",
    "panels": [
      {
        "type": "graph",
        "title": "Uptime des cibles Prometheus",
        "targets": [
          {
            "expr": "up",
            "legendFormat": "{{instance}}",
            "refId": "A"
          }
        ],
        "gridPos": {"x": 0,"y": 0,"w": 24,"h": 8}
      },
      {
        "type": "graph",
        "title": "CPU total processus Prometheus",
        "targets": [
          {
            "expr": "process_cpu_seconds_total",
            "legendFormat": "{{job}}",
            "refId": "B"
          }
        ],
        "gridPos": {"x": 0,"y": 8,"w": 24,"h": 8}
      }
    ]
  },
  "overwrite": true
}
EOF
)

curl -s -X POST -H "Content-Type: application/json" \
    -u $GRAFANA_USER:$GRAFANA_PASSWORD \
    -d "$DASHBOARD_JSON" \
    $GRAFANA_URL/api/dashboards/db

echo "🚀 Dashboard '$DASHBOARD_NAME' créé avec succès !"
echo "📌 Connecte-toi à Grafana pour le visualiser."
