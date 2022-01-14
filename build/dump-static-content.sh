#!/bin/sh

set -eux

# TODO : vérifier que la poubelle est vide
# TODO : Option -f pour forcer le dump même si la poubelle n'est pas vide
# TODO : Option -e pour vider la poubelle (e comme Empty trash)
# TODO : Option pour remplacer l'url par http://localhost:8000 (ou <SITE_URL> ?)

if [ "$(docker compose run --rm wp option get siteurl)" != "http://localhost:8080" ]; then
    echo "ERROR : l'url du site doit être \"http://localhost:8080\""
    exit 1
fi

docker compose run --rm wp config push all_options \
    && docker compose cp wordpress:/var/www/html/wp-content/config/all_options.json ./wordpress/config

docker compose run --rm wp export \
    --post_type=page,nav_menu_item \
    --stdout \
    > wp/exports/all.xml

# docker compose run --rm wp export \
#     --post_type=page \
#     --stdout \
#     > wp/exports/pages.xml

# docker compose run --rm wp export \
#     --post_type=nav_menu_item \
#     --stdout \
#     > wp/exports/menus.xml