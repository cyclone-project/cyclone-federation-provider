FROM php:apache

ENV SSP_VERSION=1.14.14
ENV SSP_CHECKSUM=2ff76d8b379141cdd3340dbd8e8bab1605e7a862d4a31657cc37265817463f48

RUN apt-get update && apt-get -y install libgmp-dev libmcrypt-dev wget zlib1g-dev \
 && apt-get clean && rm -rf /var/lib/apt/lists/* \
 && ln -s /usr/include/x86_64-linux-gnu/gmp.h /usr/local/include/ \
 && docker-php-ext-configure gmp     \
 && docker-php-ext-install gmp       \
 && docker-php-ext-configure mcrypt  \
 && docker-php-ext-install mcrypt    \
 && docker-php-ext-configure zip     \
 && docker-php-ext-install zip       \
 && mkdir -p /var/simplesamlphp \
 && wget https://github.com/simplesamlphp/simplesamlphp/releases/download/v$SSP_VERSION/simplesamlphp-$SSP_VERSION.tar.gz \
 && echo "$SSP_CHECKSUM simplesamlphp-$SSP_VERSION.tar.gz" | sha256sum -c - \
 && tar -xvf simplesamlphp-$SSP_VERSION.tar.gz -C /var/simplesamlphp --strip-components=1 \
 && rm /var/simplesamlphp/metadata/*.php

WORKDIR /var/simplesamlphp

RUN mkdir -p data metarefresh-edugain metadata/metarefresh &&\
  ln -s /var/simplesamlphp/metarefresh-edugain/saml20-idp-remote.php metadata/metarefresh/saml20-idp-remote.php &&\
  ln -s /var/simplesamlphp/metarefresh-edugain/shib13-idp-remote.php metadata/metarefresh/shib13-idp-remote.php &&\
  ln -s /var/simplesamlphp/metarefresh-edugain/attributeauthority-remote.php metadata/metarefresh/attributeauthority-remote.php &&\
  chown -R www-data:www-data data metadata &&\
  chown -R www-data:www-data metarefresh-edugain

COPY samlbridge-config /var/simplesamlphp/config
COPY modules/cyclone /var/simplesamlphp/modules/cyclone
COPY saml20-idp-hosted.php /var/simplesamlphp/metadata/saml20-idp-hosted.php
COPY 000-default.conf /etc/apache2/sites-available/000-default.conf
COPY mpm_prefork.conf /etc/apache2/mods-enabled/mpm_prefork.conf
COPY php.ini /usr/local/etc/php/conf.d/php.ini

EXPOSE 80

CMD ["apache2-foreground"]

