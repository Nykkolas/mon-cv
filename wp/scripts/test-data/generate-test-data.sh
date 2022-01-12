#!/bin/sh

set -eux

docker-compose run --rm wp menu list --format=csv > "$(dirname $0)/expected-menus.csv"
