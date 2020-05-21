#!/bin/bash

kubectl delete -f ./generated-istio-manifest.yaml
kubectl delete namespace istio-system
kubectl delete -f install/kubernetes/helm/istio-init/files
