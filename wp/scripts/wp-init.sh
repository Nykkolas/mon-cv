#!/bin/sh

set -eux

# TODO : est-il possible de remplacer sleep par attente qu'il soit démarré ? (avec timeout de 30s)
sleep 30

if ! wp core is-installed; then
    wp core install \
        --url=${URL} \
        --title="${TITLE}" \
        --admin_user=${ADMINUSER} \
        --admin_email=${ADMINEMAIL} \
        --admin_password=${ADMINPASSWORD}
    wp language core install fr_FR 
    wp site switch-language fr_FR
    # TODO : activation des plugins
fi
