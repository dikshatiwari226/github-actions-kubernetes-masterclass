#!/bin/bash

set -e

CLUSTER_NAME="skillpulse"

echo "Starting Docker..."
sudo systemctl start docker

echo "Creating Kind cluster..."

if kind get clusters | grep -q "$CLUSTER_NAME"; then
  echo "Cluster already exists"
else
  kind create cluster --name "$CLUSTER_NAME"
fi

echo "Setting kubectl context..."
kubectl config use-context "kind-$CLUSTER_NAME"

echo "Verifying cluster..."
kubectl get nodes
