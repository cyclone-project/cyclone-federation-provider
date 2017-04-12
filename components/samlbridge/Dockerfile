FROM php:apache

ENV SSP_VERSION=1.14.12
ENV SSP_CHECKSUM=349ca4c4dd8f5cbd991dc291d859363568f0081fe368736b5d9d9d4cceeb1c59

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

EXPOSE 80

CMD ["apache2-foreground"]

