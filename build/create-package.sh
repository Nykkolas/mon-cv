#!/bin/sh

set -eux

mkdir -p release

SOURCE_FOLDER=${PWD##*/}

# TODO : utiliser le TAG
tar -C .. -cvf release/mon-cv-$TAG.tar \
    $SOURCE_FOLDER/docker-compose.yml \
    $SOURCE_FOLDER/env \
    $SOURCE_FOLDER/build \
    $SOURCE_FOLDER/examples
