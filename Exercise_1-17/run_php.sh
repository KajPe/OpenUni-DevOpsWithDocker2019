#!/usr/bin/env sh

# Get mode
[ -z "$PHP" ] && export PHP="production"

# Do we have php.ini
if [ ! -f "/usr/local/etc/php/php.ini" ]; then
  # Not found, copy the docker supplied
  cp /app/php/php.ini-$PHP /usr/local/etc/php/php.ini
fi
if [ ! -d "/usr/local/etc/php/conf.d" ]; then
  # Directory not found, copy the docker supplied
  mkdir -p /usr/local/etc/php/conf.d
  cp -r /app/php/conf.d/* /usr/local/etc/php/conf.d/
fi

# Start php-fpm
exec php-fpm
