#!/bin/sh

set -eux

# Nom du site 
[ "$(wp option get blogname)" == "CV de Nicolas Fournie" ] || exit 1

echo "Tests OK"
