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
