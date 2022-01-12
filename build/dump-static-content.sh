#!/bin/sh

set -eux

# TODO : vérifier que la poubelle est vide
# TODO : Option -f pour forcer le dump même si la poubelle n'est pas vide
# TODO : Option -e pour vider la poubelle (e comme Empty trash)

docker-compose run --rm wp config push all_options \
    && docker-compose cp wordpress:/var/www/html/wp-content/config/all_options.json ./wordpress/config

docker-compose run --rm wp export \
    --post_type=page,nav_menu_item \
    --stdout \
    > wp/exports/all.xml

# docker-compose run --rm wp export \
#     --post_type=page \
#     --stdout \
#     > wp/exports/pages.xml

# docker-compose run --rm wp export \
#     --post_type=nav_menu_item \
#     --stdout \
#     > wp/exports/menus.xml