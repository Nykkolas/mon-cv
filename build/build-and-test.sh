#!/bin/sh

set -ex

if [ ! -s .env ]; then
    if [ "$1" = "-d" ]; then
        echo "\
            # DATABASE
            DB_NAME=exampledb
            DB_USER=exampleuser
            DB_PASSWORD=examplepass

            # WORDPRESS
            URL=http://dummy:8080
            ADMINUSER=adminUser
            ADMINPASSWORD=secret
            ADMINEMAIL=toto@titi.net" > .env
    else 
        echo "Error : .env file doesn't exists, use -d to create a dummy file"
        exit 1
    fi
fi

docker compose build

docker compose up -d

until docker compose ps wp | grep exited >/dev/null 2>&1; do
    echo "Waiting end of wp-init..."
    sleep 1
done

docker compose run --rm wp sh /usr/src/wordpress/scripts/wp-test.sh
