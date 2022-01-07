#!/bin/sh

set -eux

# URL
[ "$(wp option get siteurl)" == "$URL" ] || exit 1

# Nom du site 
[ "$(wp option get blogname)" == "CV de Nicolas Fournier" ] || exit 1

# Langue
[ "$(wp option get WPLANG)" == "fr_FR" ] || exit 1

# plugins
ACTIVE_PLUGINS_EXPECTED="wp-cfm"
ACTIVE_PLUGINS_LIST="$(wp plugin list --status=active --field=name)"

diff <(echo $ACTIVE_PLUGINS_LIST) <(echo $ACTIVE_PLUGINS_EXPECTED) || exit 1

echo "Tests OK"
