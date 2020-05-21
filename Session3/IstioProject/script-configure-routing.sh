#!/bin/bash

kubectl apply -f gateway/course-ingress-controller.yml
kubectl apply -f gateway/course-gateway-controller.yml