#!/usr/bin/env sh

DT=$(date +"%Y%m%d")
GIT=${DT}.git.$(git rev-parse --short HEAD)
VERSION="0.0.4"

GROUP=scotthaleen
NAME=marmalade
IMAGE="${GROUP}/${NAME}"

docker build \
       -t "${IMAGE}:latest" \
       -t "${IMAGE}:${VERSION}" \
       -t "${IMAGE}:${GIT}" \
       -t "${NAME}:${VERSION}" \
       .
