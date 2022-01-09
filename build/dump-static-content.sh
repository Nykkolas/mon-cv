#!/bin/sh

set -eux

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