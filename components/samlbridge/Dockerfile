FROM php:apache

ENV VERSION=1.13.2 \
    APACHE_LOG_DIR=/var/log/apache2

RUN apt-get update && apt-get -y install \
    wget \
    re2c \
    file \
    cron \
    libgmp-dev \
    libmhash-dev \
    libmcrypt-dev \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN ln -s /usr/include/x86_64-linux-gnu/gmp.h /usr/local/include/ \
 && docker-php-ext-configure gmp \
 && docker-php-ext-install gmp \
 && docker-php-ext-configure mcrypt \
 && docker-php-ext-install mcrypt \
 && echo extension=gmp.so > $PHP_INI_DIR/conf.d/gmp.ini \
 && echo extension.mcrypt.so > $PHP_INI_DIR/conf.d/mcrypt.ini

WORKDIR /var

RUN wget https://simplesamlphp.org/res/downloads/simplesamlphp-$VERSION.tar.gz \
 && tar xzf simplesamlphp-$VERSION.tar.gz \
 && rm simplesamlphp-$VERSION.tar.gz \
 && mv simplesamlphp-$VERSION simplesamlphp

COPY config/apache2/000-default.conf /etc/apache2/sites-available/000-default.conf
COPY config/cron/crontab.conf cron.conf
COPY start.sh start.sh

RUN touch \
  simplesamlphp/modules/cron/enable \
  simplesamlphp/modules/discopower/enable \
  simplesamlphp/modules/metarefresh/enable \
 && rm simplesamlphp/metadata/* \
 && crontab cron.conf \
 && a2ensite 000-default \
 && chmod +x cron.conf start.sh \
 && chown -R www-data:www-data simplesamlphp/metadata

CMD ["/var/start.sh"]

EXPOSE 80
EXPOSE 443

COPY config/cert/ simplesamlphp/cert/
COPY config/config/ simplesamlphp/config/
COPY config/metadata/ simplesamlphp/metadata/
