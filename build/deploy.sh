#!/bin/sh

# TODO : test pour savoir si on est logué à GHCR.io

usage () {
    echo ""
    echo "Usage : sh $0"
    echo ""
    echo "This script pulls and starts the containers."
    echo "It requires 2 files : "
    echo "  - .env with the various parameters (see example folder)"
    echo "  - tag containing the version to deploy"
}

if [ "-h" = $1 ]; then
    usage
    exit 0
fi

set -eu

if [ -s tag ]; then
    export TAG=$(cat tag)
else
    echo "ERROR : no \"tag\" file available"
    usage
    exit 1
fi

if [ ! -s .env ]; then
    echo "ERROR : Merci de créer un fichier .env"
    usage
    exit 1
else
    docker compose pull
    docker compose up -d
    docker compose logs wp -f
fi
