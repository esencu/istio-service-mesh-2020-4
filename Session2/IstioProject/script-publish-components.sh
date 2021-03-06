#!/bin/bash
DOCKER_REPO=neciro
docker build -t $DOCKER_REPO/frontend-service:1.0 -f frontend/Dockerfile frontend
docker push $DOCKER_REPO/frontend-service:1.0

docker build -t $DOCKER_REPO/books-service:1.0 -f books/Dockerfile books
docker push $DOCKER_REPO/books-service:1.0

docker build -t $DOCKER_REPO/authors-service:1.0 -f authors/Dockerfile authors
docker push $DOCKER_REPO/authors-service:1.0