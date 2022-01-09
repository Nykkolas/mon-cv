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


    # Téléchargement de la langue
    wp language core install fr_FR 
    
    # Chargement de la conf
    wp plugin activate wp-cfm
    wp config pull all_options
fi
