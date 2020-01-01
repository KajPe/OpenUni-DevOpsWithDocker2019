FROM php:7.3.13-fpm-buster

# production OR development
ENV PHP "production"

# Setup composer
ENV COMPOSER_VER 1.9.1
ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_HOME /composer
ENV PATH /composer/vendor/bin:$PATH

# Install dev dependencies
RUN \
  # set:
  #  -e : Exit immediately if a command exits with a non-zero status.
  #  -x : Print commands and their arguments as they are executed.
  set -ex \
  \
  # Install composer
  && mkdir -p /usr/local/bin \
  && curl -o /usr/local/bin/composer https://getcomposer.org/download/$COMPOSER_VER/composer.phar \
  && mkdir /composer \
  && chmod +x /usr/local/bin/composer \
  \
  # Update apt
  && apt-get update \
  \
  # Install packages
  && apt-get install -y \
    git \
    zip unzip \
    npm \
    nodejs \
    libzip-dev zlib1g-dev \
    libpng-dev libjpeg-dev libfreetype6-dev \
    libldap2-dev \
  \
  # Update npm to newer
  && npm install npm@latest -g \
  \
  # Configure php extensions
  && docker-php-ext-configure bcmath --enable-bcmath \
  && docker-php-ext-install pdo pdo_mysql mysqli \
  && docker-php-ext-install mbstring \
  && docker-php-ext-configure zip --with-zlib-dir=/usr \
  && docker-php-ext-install zip \
  && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
  && docker-php-ext-install gd \
  && docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ \
  && docker-php-ext-install ldap \
  \
  # Copy /usr/local/etc/ into /app
  && mkdir -p /app/php \
  && cp -r /usr/local/etc/php /app

# Install script
COPY run_php.sh /app/
RUN chmod +x /app/run_php.sh

WORKDIR /var/www/html

CMD [ "/app/run_php.sh"]
