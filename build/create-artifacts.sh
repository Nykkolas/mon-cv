#!/bin/sh

# Valeurs par défaut 
if [ -z ${ARTIFACTS_DIR+x} ]; then
    ARTIFACTS_DIR=/tmp/mon-cv-artifacts
fi

# Script
set -eux

mkdir -p "$ARTIFACTS_DIR"
docker save ghcr.io/nykkolas/mon-cv-wordpress -o "$ARTIFACTS_DIR/mon-cv-wordpress.tar"
docker save ghcr.io/nykkolas/mon-cv-wp -o  "$ARTIFACTS_DIR/mon-cv-wp.tar"
