#!/bin/sh

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
