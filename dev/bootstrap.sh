#!/bin/bash

GITHUB_USER=$1
GITHUB_TOKEN=$2
CLUSTER=dev
BASE_DIR=$(realpath $(dirname $0))

echo "BASE_DIR=$BASE_DIR"

kind create cluster --name $CLUSTER --config $BASE_DIR/cluster.yaml

kubectl cluster-info --context kind-$CLUSTER

flux bootstrap github \
  --owner=$GITHUB_USER \
  --repository=infra \
  --branch=main \
  --path=dev-cluster \
  --context kind-$CLUSTER \
  --personal

flux create source git ingress-nginx \
  --url=https://github.com/jukatu/ingress-nginx.git \
  --branch=master \
  --interval=30s \
  --export > ./$CLUSTER-cluster/ingress-nginx-source.yaml

flux create kustomization ingress-nginx \
  --source=ingress-nginx \
  --path="./" \
  --prune=true \
  --validation=client \
  --interval=1h \
  --export > ./$CLUSTER-cluster/ingress-nginx.yaml
