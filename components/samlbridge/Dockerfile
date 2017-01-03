FROM php:apache

ENV SSP_VERSION=1.14.11

EXPOSE 80
EXPOSE 443

RUN apt-get update && apt-get -y install wget libgmp-dev libmcrypt-dev zlib1g-dev \
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
 && tar -xvf simplesamlphp-$SSP_VERSION.tar.gz -C /var/simplesamlphp --strip-components=1 \
 && rm /var/simplesamlphp/metadata/*.php

WORKDIR /var/simplesamlphp

RUN mkdir -p data metarefresh-edugain metadata/metarefresh &&\
  ln -s /var/simplesamlphp/metarefresh-edugain/saml20-idp-remote.php metadata/metarefresh/saml20-idp-remote.php &&\
  ln -s /var/simplesamlphp/metarefresh-edugain/shib13-idp-remote.php metadata/metarefresh/shib13-idp-remote.php &&\
  ln -s /var/simplesamlphp/metarefresh-edugain/attributeauthority-remote.php metadata/metarefresh/attributeauthority-remote.php &&\
  chown -R www-data:www-data data metadata &&\
  chown -R www-data:www-data metarefresh-edugain

CMD ["apache2-foreground"]

