#!/bin/sh

set -eux

# URL
[ "$(wp option get siteurl)" = "$URL" ] || exit 1

# Tous les URL ont été mis à jour
if [ "$URL" != "http://localhost:8080" ]; then
    [ 0 -eq $(wp search-replace "http://localhost:8080" "$URL" --dry-run --format=count) ] || exit 1
fi

# Nom du site 
EXPECTED_TITLE="Nicolas Fournier"
EXPECTED_DESCRIPTION=""
[ "$(wp option get blogname)" = "$EXPECTED_TITLE" ] || exit 1
[ "$(wp option get blogdescription)" = "$EXPECTED_DESCRIPTION" ] || exit 1

# Langue
[ "$(wp option get WPLANG)" = "fr_FR" ] || exit 1

# Plugins
ACTIVE_PLUGINS_EXPECTED="equal-height-columns wordpress-importer wp-cfm"
ACTIVE_PLUGINS_LIST="$(wp plugin list --status=active --field=name)"

diff <(echo $ACTIVE_PLUGINS_LIST) <(echo $ACTIVE_PLUGINS_EXPECTED) || exit 1

## Pages
# Vérifier que les bonnes pages sont publiées
PAGES_EXPECTED="Me contacter Le bénévolat Bonjour, Mon expérience Mes compétences"
PAGES_LIST="$(wp post list --post_type=page --post_status=publish --field=post_title)"

diff <(echo $PAGES_EXPECTED) <(echo $PAGES_LIST) || exit 1

# Vérifier qu'aucun post n'est à la poubelle
[ 0 -eq $(wp post list --post_type=page --post_status=trash --format=count) ] || exit 1

# Menus
diff /usr/src/wordpress/scripts/test-data/expected-menus.csv <(wp menu list --format=csv) || exit 1

# TODO : test des dates des images ou d'affichage correct des images (lien par lien ?)

echo "Tests OK"
