#!/bin/sh
if [ "$SHOW_WELCOME_MESSAGE" = "false" ] || [ "$LOG_OUTPUT_LEVEL" = "off" ] || [ "$DISABLE_DEFAULT_CONFIG" = "true" ]; then
    if [ "$LOG_OUTPUT_LEVEL" = "debug" ]; then
        echo "👉 $0: Container info was display was skipped."
    fi
    # Skip the rest of the script
    return 0
fi

echo '
--------------------------------------------------------------------
🚀 Welcome to the Server  Docker container!
--------------------------------------------------------------------'

PHP_OPCACHE_STATUS=$(php -r 'echo ini_get("opcache.enable");')

if [ "$PHP_OPCACHE_STATUS" = "1" ]; then
    PHP_OPCACHE_MESSAGE="✅ Enabled"
else
    PHP_OPCACHE_MESSAGE="❌ Disabled"
fi

echo '
🙌 

-------------------------------------
ℹ️ Container Information
-------------------------------------'
echo "
OS:            $(. /etc/os-release; echo "${PRETTY_NAME}")
Docker user:   $(whoami)
Docker uid:    $(id -u)
Docker gid:    $(id -g)
OPcache:       $PHP_OPCACHE_MESSAGE
PHP Version:   $(php -r 'echo phpversion();')
Image Version: $(cat /etc/serversideup-php-version)
"

if [ "$PHP_OPCACHE_STATUS" = "0" ]; then
    echo "👉 [NOTICE]: Improve PHP performance by setting PHP_OPCACHE_ENABLE=1 (recommended for production)."
fi