#!/bin/sh

set -eux

if [ -s tag ]; then
    TAG=$(cat tag)
fi

if [ ! -s .env ]; then
    echo "Merci de créer un fichier .env"
    EXIT_CODE=1
else
    docker-compose pull
    docker-compose up -d
    docker-compose logs wp -f
    EXIT_CODE=0
fi

exit $EXIT_CODE
