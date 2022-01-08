#!/bin/sh

set -eux

mkdir -p release

SOURCE_FOLDER=${PWD##*/}

tar -C .. -cvf release/$SOURCE_FOLDER-$TAG.tar \
    $SOURCE_FOLDER/docker-compose.yml \
    $SOURCE_FOLDER/env \
    $SOURCE_FOLDER/build/deploy.sh \
    $SOURCE_FOLDER/examples/.env.example
