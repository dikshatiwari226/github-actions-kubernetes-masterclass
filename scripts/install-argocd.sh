#!/bin/bash

set -e

echo "Installing Argo CD..."

kubectl create namespace argocd --dry-run=client -o yaml | kubectl apply -f -

kubectl apply -n argocd \
  -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

echo "Waiting for Argo CD server..."
kubectl rollout status deployment/argocd-server -n argocd --timeout=180s

echo "Exposing Argo CD UI (NodePort)..."
kubectl patch svc argocd-server -n argocd \
  -p '{"spec":{"type":"NodePort","ports":[{"port":443,"targetPort":8080,"nodePort":30088}]}}'

echo "--------------------------------------"
echo "Argo CD installed!"
echo "UI: https://<EC2-IP>:30088"
echo "Username: admin"

echo -n "Password: "
kubectl -n argocd get secret argocd-initial-admin-secret \
  -o jsonpath="{.data.password}" | base64 -d
echo ""
echo "--------------------------------------"
