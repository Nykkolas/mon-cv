#!/bin/sh

set -eux

if [ -f tag ]; then
    TAG=$(cat version)
fi

if [ ! -f .env ]; then
    echo "Merci de créer un fichier .env"
    EXIT_CODE=1
else
    docker compose pull
    docker compose up -d
    docker compose logs wp -f
    EXIT_CODE=0
fi

exit $EXIT_CODE
