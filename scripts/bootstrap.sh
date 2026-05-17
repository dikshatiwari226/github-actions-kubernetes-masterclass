#!/bin/bash

set -euo pipefail

echo "🚀 Starting FULL DevOps Setup..."

# 1. Docker
echo "👉 Starting Docker..."
sudo systemctl start docker

# 2. Kind cluster
echo "👉 Creating Kubernetes cluster..."
./scripts/install-kind.sh

# 3. Argo CD
echo "👉 Installing Argo CD..."
./scripts/install-argocd.sh

# 4. Deploy application
echo "👉 Deploying Argo CD application..."
kubectl apply -f k8s/argocd-app.yaml

echo "============================"
echo "🎉 ALL SETUP COMPLETE"
echo "============================"
