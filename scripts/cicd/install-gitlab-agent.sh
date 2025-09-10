#!/bin/bash
set -e

echo "🤖 Installation de l'agent GitLab..."
helm upgrade --install gitlab-agent gitlab/gitlab-agent \
  --namespace gitlab-agent \
  --create-namespace \
  --set config.token=$GITLAB_AGENT_TOKEN \
  --set config.kasAddress=wss://kas.gitlab.com

echo "✅ Agent GitLab installé"
