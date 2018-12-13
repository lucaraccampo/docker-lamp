FROM php:7.1-apache
MAINTAINER luca raccampo

# Install some generic command line tool
RUN apt-get update -y \
    && apt-get install -y nano \
    && apt-get install -y locate \
    && apt-get install -y net-tools \
    && apt-get install git -y -q \
    && apt-get install -y curl

RUN apt-get install -y sendmail

# Install some php extensions
RUN apt-get install -y \
        zlib1g-dev \
        libicu-dev \
        g++ \
        libbz2-dev \
        libpng-dev \
        gnupg \
    && apt-get clean -y
RUN docker-php-ext-install pdo pdo_mysql mysqli bcmath bz2 calendar exif gettext intl sockets
RUN docker-php-ext-install mbstring
RUN docker-php-ext-install zip
RUN docker-php-ext-install gd

## Install xdebug extension
RUN yes | pecl install xdebug \
    && echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" > /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_enable=on" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_autostart=off" >> /usr/local/etc/php/conf.d/xdebug.ini

## Install redis extension
RUN mkdir -p /usr/src/php/ext/redis \
    && git clone --depth 1 git://github.com/nicolasff/phpredis.git /usr/src/php/ext/redis \
    && cd /usr/src/php/ext/redis \
    && phpize \
    && ./configure \
    && make \
    && make install \
    && docker-php-ext-install redis

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php && \
  mv composer.phar /usr/local/bin/composer

# Install Node.js
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - && \
  apt-get install -y nodejs

# Set the Drush version.
ENV DRUSH_VERSION 8.1.16

# Install Drush 8 with the phar file.
RUN curl -fsSL -o /usr/local/bin/drush "https://github.com/drush-ops/drush/releases/download/$DRUSH_VERSION/drush.phar" && \
  chmod +x /usr/local/bin/drush

# Test your install.
RUN drush core-status

# Print final report
RUN nodejs --version
RUN npm --version




