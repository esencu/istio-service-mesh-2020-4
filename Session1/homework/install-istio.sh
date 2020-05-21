#!/bin/bash

set -e

echo "Download Istio" 

ISTIO_VERSION=1.5.4
source <(curl -L https://istio.io/downloadIstio)

set -u

cd "$NAME"

echo "Install Istio" 

kubectl create namespace istio-system

#Custom Resource Definitions
helm template install/kubernetes/helm/istio-init --name istio-init --namespace istio-system | kubectl apply -f -

#Wait for all Istio CRDs to be created
kubectl -n istio-system wait --for=condition=complete job --all

echo Install Istio DEMO environment

OPTIONS=""
#OPTIONS="$OPTIONS --set gateways.istio-ingressgateway.type=NodePort"
#OPTIONS="$OPTIONS --set profile=demo"
OPTIONS="$OPTIONS --set kiali.dashboard.jaegerURL=http://locahost:15031"
OPTIONS="$OPTIONS --set kiali.dashboard.grafanaURL=http://locahost:15032"

helm template install/kubernetes/helm/istio --name istio --namespace istio-system --values install/kubernetes/helm/istio/values-istio-demo.yaml $OPTIONS | kubectl apply -f -

kubectl get svc -n istio-system
kubectl get pods -n istio-system


kubectl get svc -n istio-system
kubectl get pods -n istio-system


echo Expose Grafana Gateway

cat <<EOF | kubectl apply -f -
apiVersion: networking.istio.io/v1alpha3
kind: Gateway
metadata:
  name: grafana-gateway
  namespace: istio-system
spec:
  selector:
    istio: ingressgateway
  servers:
  - port:
      number: 15031
      name: http-grafana
      protocol: HTTP
    hosts:
    - "*"
---
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: grafana-vs
  namespace: istio-system
spec:
  hosts:
  - "*"
  gateways:
  - grafana-gateway
  http:
  - match:
    - port: 15031
    route:
    - destination:
        host: grafana
        port:
          number: 3000
---
apiVersion: networking.istio.io/v1alpha3
kind: DestinationRule
metadata:
  name: grafana
  namespace: istio-system
spec:
  host: grafana
  trafficPolicy:
    tls:
      mode: DISABLE
---
EOF


echo Expose Kiali Gateway

cat <<EOF | kubectl apply -f -
apiVersion: networking.istio.io/v1alpha3
kind: Gateway
metadata:
  name: kiali-gateway
  namespace: istio-system
spec:
  selector:
    istio: ingressgateway
  servers:
  - port:
      number: 15029
      name: http-kiali
      protocol: HTTP
    hosts:
    - "*"
---
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: kiali-vs
  namespace: istio-system
spec:
  hosts:
  - "*"
  gateways:
  - kiali-gateway
  http:
  - match:
    - port: 15029
    route:
    - destination:
        host: kiali
        port:
          number: 20001
---
apiVersion: networking.istio.io/v1alpha3
kind: DestinationRule
metadata:
  name: kiali
  namespace: istio-system
spec:
  host: kiali
  trafficPolicy:
    tls:
      mode: DISABLE
---
EOF


echo Expose Prometheus Gateway

cat <<EOF | kubectl apply -f -
apiVersion: networking.istio.io/v1alpha3
kind: Gateway
metadata:
  name: prometheus-gateway
  namespace: istio-system
spec:
  selector:
    istio: ingressgateway
  servers:
  - port:
      number: 15030
      name: http-prom
      protocol: HTTP
    hosts:
    - "*"
---
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: prometheus-vs
  namespace: istio-system
spec:
  hosts:
  - "*"
  gateways:
  - prometheus-gateway
  http:
  - match:
    - port: 15030
    route:
    - destination:
        host: prometheus
        port:
          number: 9090
---
apiVersion: networking.istio.io/v1alpha3
kind: DestinationRule
metadata:
  name: prometheus
  namespace: istio-system
spec:
  host: prometheus
  trafficPolicy:
    tls:
      mode: DISABLE
---
EOF

echo "Expose Tracing (Jaeger) Gateway"

cat <<EOF | kubectl apply -f -
apiVersion: networking.istio.io/v1alpha3
kind: Gateway
metadata:
  name: tracing-gateway
  namespace: istio-system
spec:
  selector:
    istio: ingressgateway
  servers:
  - port:
      number: 15032
      name: http-tracing
      protocol: HTTP
    hosts:
    - "*"
---
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: tracing-vs
  namespace: istio-system
spec:
  hosts:
  - "*"
  gateways:
  - tracing-gateway
  http:
  - match:
    - port: 15032
    route:
    - destination:
        host: tracing
        port:
          number: 80
---
apiVersion: networking.istio.io/v1alpha3
kind: DestinationRule
metadata:
  name: tracing
  namespace: istio-system
spec:
  host: tracing
  trafficPolicy:
    tls:
      mode: DISABLE
---
EOF

GRAFANA_PORT=15031
KIALI_PORT=15029
PROMETHEUS_PORT=15030
TRACING_PORT=15032

# Only when istio-ingressgateway.type=NodePort
#GRAFANA_PORT=$(kubectl get svc/istio-ingressgateway -n istio-system | grep -oP "$GRAFANA_PORT\:\K([0-9])+")
#KIALI_PORT=$(kubectl get svc/istio-ingressgateway -n istio-system | grep -oP "$KIALI_PORT\:\K([0-9])+")
#PROMETHEUS_PORT=$(kubectl get svc/istio-ingressgateway -n istio-system | grep -oP "$PROMETHEUS_PORT\:\K([0-9])+")
#Jaeger
#TRACING_PORT=$(kubectl get svc/istio-ingressgateway -n istio-system | grep -oP "$TRACING_PORT\:\K([0-9])+")


echo "Grafana: http://locahost:$GRAFANA_PORT"
echo "Kiali: http://locahost:$KIALI_PORT"
echo "Prometheus: http://locahost:$PROMETHEUS_PORT"
echo "Tracing: http://locahost:$TRACING_PORT"
