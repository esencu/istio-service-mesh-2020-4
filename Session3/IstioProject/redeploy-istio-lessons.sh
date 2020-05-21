#!/bin/bash

NS=istio-lessons

echo Clean-up already deployed resources
kubectl delete all -lproject=istio-course --all-namespaces
#Note kubectl delete all does not remove istio resources
kubectl delete virtualservices.networking.istio.io -lproject=istio-course --all-namespaces
kubectl delete destinationrules.networking.istio.io -lproject=istio-course --all-namespaces
kubectl delete gateways.networking.istio.io -lproject=istio-course --all-namespaces

echo Create namespace and mark it with istio-injection=enabled
kubectl get namespaces $NS > /dev/null 2>&1 || kubectl create namespace $NS
kubectl label namespace $NS --overwrite=true istio-injection=enabled

echo Create ingress gateway
kubectl apply -n $NS -f gateway/course-ingress-controller.yml
kubectl apply -n $NS -f gateway/course-gateway-controller.yml

echo Deploy
kubectl apply -n $NS -f frontend/deployment/deployment.yml
kubectl apply -n $NS -f books/deployment/deployment.yml
kubectl apply -n $NS -f authors/deployment/deployment.yml
