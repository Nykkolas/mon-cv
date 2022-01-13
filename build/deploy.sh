#!/bin/sh

set -eux

if [ -s tag ]; then
    export TAG=$(cat tag)
else
    echo "ERROR : no \"tag\" file available"
    exit 1
fi

if [ ! -s .env ]; then
    echo "ERROR : Merci de créer un fichier .env"
    exit 1
else
    docker compose pull
    docker compose up -d
    docker compose logs wp -f
fi
