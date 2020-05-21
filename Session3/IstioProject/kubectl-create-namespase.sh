#!/bin/bash

kubectl create namespace istio-lessons
kubectl label namespace istio-lessons istio-injection=enabled