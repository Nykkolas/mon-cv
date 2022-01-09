#!/bin/sh

set -eux

# URL
[ "$(wp option get siteurl)" = "$URL" ] || exit 1

# Nom du site 
EXPECTED_TITLE="Coach et Coach Agile"
[ "$(wp option get blogname)" = "$EXPECTED_TITLE" ] || exit 1
[ "$(wp option get blogdescription)" = "$EXPECTED_TITLE" ] || exit 1

# Langue
[ "$(wp option get WPLANG)" = "fr_FR" ] || exit 1

# Plugins
ACTIVE_PLUGINS_EXPECTED="wordpress-importer wp-cfm"
ACTIVE_PLUGINS_LIST="$(wp plugin list --status=active --field=name)"

diff <(echo $ACTIVE_PLUGINS_LIST) <(echo $ACTIVE_PLUGINS_EXPECTED) || exit 1

# Pages
PAGES_EXPECTED="Compétences"
PAGES_LIST="$(wp post list --post_type=page --field=post_title)"

diff <(echo $PAGES_EXPECTED) <(echo $PAGES_LIST) || exit 1

# Menus
diff /usr/src/wordpress/scripts/test-data/expected-menus.csv <(wp menu list --format=csv) || exit 1

echo "Tests OK"
