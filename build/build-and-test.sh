#!/bin/sh

# Valeurs par défaut 
if [ -z ${ARTIFACTS_DIR+x} ]; then
    ARTIFACTS_DIR=/tmp/mon-cv-artifacts
fi

if [ -z ${SAVE_ARTIFACTS+x} ]; then
    SAVE_ARTIFACTS=false
fi

# Script
set -eux

if [ ! -f .env ]; then
    echo "\
        # DATABASE
        DB_NAME=exampledb
        DB_USER=exampleuser
        DB_PASSWORD=examplepass

        # WORDPRESS
        URL=http://localhost:8080
        ADMINUSER=adminUser
        ADMINPASSWORD=secret
        ADMINEMAIL=toto@titi.net" > .env
fi

docker compose build

docker compose up -d

sleep 30

docker compose run --rm wp sh /usr/src/wordpress/scripts/wp-test.sh

if [ "$SAVE_ARTIFACTS" = "true" ]; then
    mkdir -p "$ARTIFACTS_DIR"
    docker save inconico/mon-cv-wordpress -o "$ARTIFACTS_DIR/mon-cv-wordpress.tar"
    docker save inconico/mon-cv-wp -o  "$ARTIFACTS_DIR/mon-cv-wp.tar"
fi
