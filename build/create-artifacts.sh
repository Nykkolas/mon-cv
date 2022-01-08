#!/bin/sh

# Valeurs par défaut 
if [ -z ${ARTIFACTS_DIR+x} ]; then
    ARTIFACTS_DIR=/tmp/mon-cv-artifacts
fi

# Script
set -eux

mkdir -p "$ARTIFACTS_DIR"
docker save inconico/mon-cv-wordpress -o "$ARTIFACTS_DIR/mon-cv-wordpress.tar"
docker save inconico/mon-cv-wp -o  "$ARTIFACTS_DIR/mon-cv-wp.tar"
