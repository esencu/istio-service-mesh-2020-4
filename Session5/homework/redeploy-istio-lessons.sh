#!/bin/bash

ISTIO_LESSONS_NS="${1-${ISTIO_LESSONS_NS-istio-lessons}}"

echo Clean-up already deployed resources

kubectl delete all -lproject=istio-course --all-namespaces
#Note kubectl delete all does not remove istio resources
kubectl delete virtualservices.networking.istio.io -lproject=istio-course --all-namespaces
kubectl delete destinationrules.networking.istio.io -lproject=istio-course --all-namespaces
kubectl delete gateways.networking.istio.io -lproject=istio-course --all-namespaces
kubectl delete gateways.networking.istio.io -lproject=istio-course --all-namespaces
kubectl delete authorizationpolicy.security.istio.io -lproject=istio-course --all-namespaces
kubectl delete requestauthentication.security.istio.io -lproject=istio-course --all-namespaces
kubectl delete peerauthentication.security.istio.io -lproject=istio-course --all-namespaces

echo Create namespace and mark it with istio-injection=enabled
kubectl get namespaces $ISTIO_LESSONS_NS > /dev/null 2>&1 || kubectl create namespace $ISTIO_LESSONS_NS
kubectl label namespace $ISTIO_LESSONS_NS --overwrite=true istio-injection=enabled

echo Create ingress gateway
kubectl apply -n $ISTIO_LESSONS_NS -f gateway/course-ingress-controller.yml
kubectl apply -n $ISTIO_LESSONS_NS -f gateway/course-gateway-controller.yml
kubectl apply -n $ISTIO_LESSONS_NS -f ./course-security.yaml

echo Deploy
kubectl apply -n $ISTIO_LESSONS_NS -f frontend/deployment/deployment.yml
kubectl apply -n $ISTIO_LESSONS_NS -f books/deployment/deployment.yml
kubectl apply -n $ISTIO_LESSONS_NS -f authors/deployment/deployment.yml
