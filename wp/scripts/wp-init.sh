#!/bin/sh

set -eux

# Attente que la base de données soit up
until wp db check >/dev/null 2>&1; do
    echo "Waiting..."
    sleep 1
done

# Configuration
if ! wp core is-installed; then
    # Configuration initiale
    wp core install \
        --url=${URL} \
        --title="${TITLE}" \
        --admin_user=${ADMINUSER} \
        --admin_email=${ADMINEMAIL} \
        --admin_password=${ADMINPASSWORD}

    # Langue
    wp language core install fr_FR 
    wp site switch-language fr_FR

    # Plugins (wp-cfm)
    wp plugin activate wp-cfm
fi
