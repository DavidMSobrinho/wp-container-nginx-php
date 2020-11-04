#!/bin/sh
# vim:sw=4:ts=4:et

set -e

if [ -z "${NGINX_ENTRYPOINT_QUIET_LOGS:-}" ]; then
    exec 3>&1
else
    exec 3>/dev/null
fi

php-fpm7 -D

sed -i "s/DATABASE_NAME/$DATABASE_NAME/g" /usr/share/nginx/html/wp-config.php
sed -i "s/DATABASE_USER/$DATABASE_USER/g" /usr/share/nginx/html/wp-config.php
sed -i "s/DATABASE_PASSWORD/$DATABASE_PASSWORD/g" /usr/share/nginx/html/wp-config.php
sed -i "s/DATABASE_SERVER/$DATABASE_SERVER/g"  /usr/share/nginx/html/wp-config.php
sed -i "s/DATABASE_CHATSET/$DATABASE_CHATSETovodireito/g" /usr/share/nginx/html/wp-config.php
sed -i "s/DATABASE_COLLATE/$DATABASE_COLLATE/g" /usr/share/nginx/html/wp-config.php
sed -i "s/WP_AUTH_KEY/$WP_AUTH_KEY/g" /usr/share/nginx/html/wp-config.php
sed -i "s/WP_SECURE_AUTH_KEY/$WP_SECURE_AUTH_KEY/g" /usr/share/nginx/html/wp-config.php
sed -i "s/WP_LOGGED_IN_KEY/$WP_LOGGED_IN_KEY/g" /usr/share/nginx/html/wp-config.php
sed -i "s/WP_AUTH_SALT/$WP_AUTH_SALT/g" /usr/share/nginx/html/wp-config.php
sed -i "s/WP_SECURE_AUTH_SALT/$WP_SECURE_AUTH_SALT/g" /usr/share/nginx/html/wp-config.php
sed -i "s/WP_LOGGED_IN_SALT/$WP_LOGGED_IN_SALT/g" /usr/share/nginx/html/wp-config.php
sed -i "s/WP_NONCE_SALT/$WP_NONCE_SALT/g" /usr/share/nginx/html/wp-config.php
sed -i "s/WP_PREFIX_TABLE/$WP_PREFIX_TABLE/g" /usr/share/nginx/html/wp-config.php
sed -i "s/SET_WP_DEBUG/$SET_WP_DEBUG/g" /usr/share/nginx/html/wp-config.php

if [ "$1" = "nginx" -o "$1" = "nginx-debug" ]; then
    if /usr/bin/find "/docker-entrypoint.d/" -mindepth 1 -maxdepth 1 -type f -print -quit 2>/dev/null | read v; then
        echo >&3 "$0: /docker-entrypoint.d/ is not empty, will attempt to perform configuration"

        echo >&3 "$0: Looking for shell scripts in /docker-entrypoint.d/"
        find "/docker-entrypoint.d/" -follow -type f -print | sort -n | while read -r f; do
            case "$f" in
                *.sh)
                    if [ -x "$f" ]; then
                        echo >&3 "$0: Launching $f";
                        "$f"
                    else
                        # warn on shell scripts without exec bit
                        echo >&3 "$0: Ignoring $f, not executable";
                    fi
                    ;;
                *) echo >&3 "$0: Ignoring $f";;
            esac
        done

        echo >&3 "$0: Configuration complete; ready for start up"
    else
        echo >&3 "$0: No files found in /docker-entrypoint.d/, skipping configuration"
    fi
fi

exec "$@"
