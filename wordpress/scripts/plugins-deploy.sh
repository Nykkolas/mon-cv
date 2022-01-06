#!/bin/sh

set -eux

cp -rf /usr/src/wordpress/wp-content/plugins/* /var/www/html/wp-content/plugins/
