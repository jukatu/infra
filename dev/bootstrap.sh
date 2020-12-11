#!/bin/bash

GITHUB_USER=$1
GITHUB_TOKEN=$2
CLUSTER=dev

# kind create cluster --name $CLUSTER --config cluster.yaml

# kubectl cluster-info --context kind-$CLUSTER

# flux bootstrap github \
#   --owner=$GITHUB_USER \
#   --repository=infra \
#   --branch=main \
#   --path=dev-cluster \
#   --context kind-$CLUSTER \
#   --personal
