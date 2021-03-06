#!/bin/sh

set -eux

# Attente que la base de données soit up
until wp db check >/dev/null 2>&1; do
    echo "Waiting db..."
    sleep 1
done

# Initialisation
if ! wp core is-installed; then
    # Installation
    wp core install \
        --url=${URL} \
        --title="${TITLE}" \
        --admin_user=${ADMINUSER} \
        --admin_email=${ADMINEMAIL} \
        --admin_password=${ADMINPASSWORD}

    # Chargement de la conf
    wp plugin activate wp-cfm
    # TODO : essayer de push puis diff ? (wp config diff ne semble pas fonctionner)
    wp config pull all_options

    # Delete all pages then load exported pages and menus
    wp post delete $(wp post list --post_type=page --format=ids) --force 
    wp import /usr/src/wordpress/exports/all.xml --authors=create

    # Import images and regenerate thumbnails
    wp media import --preserve-filetime /usr/src/wordpress/medias/*
    wp media regenerate --yes

    # Replace URL 
    wp search-replace "http://localhost:8080" "$URL"

fi
