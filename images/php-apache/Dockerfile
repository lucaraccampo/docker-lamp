FROM php:7.1-apache
MAINTAINER luca raccampo

RUN a2enmod rewrite

# Install some generic command line tool
RUN apt-get update -y \
    && apt-get install -y nano \
    && apt-get install -y locate \
    && apt-get install -y net-tools \
    && apt-get install git -y -q \
    && apt-get install -y curl \
    && apt-get install -y mysql-client

RUN apt-get install -y sendmail

# Install some php extensions
RUN mkdir -p /usr/share/man/man1 /usr/share/man/man7 \
    && apt-get install -y \
        bzip2 \
        exiftool \
        g++ \
        gnupg \
        git-core \
        imagemagick \
        libbz2-dev \
        libc-client2007e-dev \
        libjpeg-dev \
        libkrb5-dev \
        libldap2-dev \
        libmagickwand-dev \
        libmemcached-dev \
        libpng-dev \
        libpq-dev \
        libxml2-dev \
        libicu-dev \
        mysql-client \
        postgresql-client-9.6 \
        pv \
        ssh \
        unzip \
        wget \
        xfonts-base \
        xfonts-75dpi \
        zlib1g-dev \
    && pecl install apcu \
    && pecl install imagick \
    && pecl install memcached \
    && pecl install oauth-2.0.2 \
    && docker-php-ext-configure gd --with-freetype-dir=/usr --with-png-dir=/usr --with-jpeg-dir=/usr \
    && docker-php-ext-configure imap --with-imap-ssl --with-kerberos \
    && docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ \
    && docker-php-ext-enable apcu \
    && docker-php-ext-enable imagick \
    && docker-php-ext-enable memcached \
    && docker-php-ext-enable oauth \
    && docker-php-ext-install \
        bcmath \
        bz2 \
        calendar \
        exif \
        gd \
        imap \
        ldap \
        mbstring \
        mysqli \
        opcache \
        pdo \
        pdo_mysql \
        pdo_pgsql \
        soap \
        zip \
        intl \
        gettext \
        pcntl \
        sockets

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

# Print final report
RUN nodejs --version
RUN npm --version

# Set the Drush version.
ENV DRUSH_VERSION 8.1.16

# Install Drush 8 with the phar file.
RUN curl -fsSL -o /usr/local/bin/drush "https://github.com/drush-ops/drush/releases/download/$DRUSH_VERSION/drush.phar" && \
  chmod +x /usr/local/bin/drush

# Test your install.
RUN drush core-status

# Install Drupal Console Launcher
RUN curl https://drupalconsole.com/installer -L -o drupal.phar && \
    mv drupal.phar /usr/local/bin/drupal && \
    chmod +x /usr/local/bin/drupal


RUN apt-get -y clean \
  && apt-get -y autoclean \
  && apt-get -y autoremove \
  && rm -rf /var/lib/apt/lists/* && rm -rf && rm -rf /var/lib/cache/* && rm -rf /var/lib/log/* && rm -rf /tmp/*

RUN echo 'alias ll="ls -al"' >> ~/.bashrc


