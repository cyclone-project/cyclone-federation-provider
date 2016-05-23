FROM php:apache

ENV APACHE_LOG_DIR=/var/log/apache2 \
	SSP_VERSION=1.14.3

RUN apt-get update && apt-get -y install \
    git  	      \
    wget 	      \
    re2c 	      \
    file 	      \
    cron 	      \
    libgmp-dev    \
    libmhash-dev  \
    libmcrypt-dev \
    zlib1g-dev    \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* \
 && ln -s /usr/include/x86_64-linux-gnu/gmp.h /usr/local/include/ \
 && docker-php-ext-configure gmp     \
 && docker-php-ext-install gmp       \
 && docker-php-ext-configure mcrypt  \
 && docker-php-ext-install mcrypt    \
 && docker-php-ext-configure zip     \
 && docker-php-ext-install zip       \
 && echo extension=gmp.so > $PHP_INI_DIR/conf.d/gmp.ini         \
 && echo extension=mcrypt.so > $PHP_INI_DIR/conf.d/mcrypt.ini   \
 && echo extension=zip.so > $PHP_INI_DIR/conf.d/zip.ini

COPY config/apache2/000-default.conf /etc/apache2/sites-available/000-default.conf
COPY config/php/php.ini /usr/local/etc/php/php.ini
COPY config/cron/crontab.conf start.sh /var/

WORKDIR /var

RUN mkdir /var/simplesamlphp \
 && wget https://github.com/simplesamlphp/simplesamlphp/releases/download/v$SSP_VERSION/simplesamlphp-$SSP_VERSION.tar.gz \
 && tar -xvf simplesamlphp-$SSP_VERSION.tar.gz -C /var/simplesamlphp --strip-components=1 \
 && rm simplesamlphp-$SSP_VERSION.tar.gz \
 && a2ensite 000-default                        \
 && chmod +x /var/crontab.conf /var/start.sh    \
 && crontab /var/crontab.conf                   \
 && mkdir /var/simplesamlphp/data \
 && chown -R www-data:www-data /var/simplesamlphp/metadata /var/simplesamlphp/data /var/simplesamlphp/log \
 && touch                                       \
  /var/simplesamlphp/modules/cron/enable        \
  /var/simplesamlphp/modules/discopower/enable  \
  /var/simplesamlphp/modules/metarefresh/enable

CMD ["/var/start.sh"]

EXPOSE 80
EXPOSE 443

COPY config/cert/ /var/simplesamlphp/cert/
COPY config/config/ /var/simplesamlphp/config/
COPY config/metadata/ /var/simplesamlphp/metadata/
COPY modules/cyclone/ /var/simplesamlphp/modules/cyclone/
