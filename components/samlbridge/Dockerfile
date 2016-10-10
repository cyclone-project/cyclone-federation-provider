FROM php:apache

ENV SSP_DIR=/var/simplesamlphp \
    SSP_VERSION=1.14.8

RUN apt-get update && apt-get -y install wget libgmp-dev libmcrypt-dev zlib1g-dev \
 && apt-get clean && rm -rf /var/lib/apt/lists/* \
 && ln -s /usr/include/x86_64-linux-gnu/gmp.h /usr/local/include/ \
 && docker-php-ext-configure gmp     \
 && docker-php-ext-configure mcrypt  \
 && docker-php-ext-configure zip     \
 && docker-php-ext-install gmp       \
 && docker-php-ext-install mcrypt    \
 && docker-php-ext-install zip       \
 && wget https://github.com/simplesamlphp/simplesamlphp/releases/download/v$SSP_VERSION/simplesamlphp-$SSP_VERSION.tar.gz \
 && mkdir -p $SSP_DIR $SSP_DIR/data $SSP_DIR/metarefresh-edugain $SSP_DIR/metadata/metarefresh \
 && tar -xvf simplesamlphp-$SSP_VERSION.tar.gz -C $SSP_DIR --strip-components=1 \
 && chown -R www-data:www-data $SSP_DIR/data $SSP_DIR/metadata \
 && rm $SSP_DIR/metadata/*.php        \
 && touch                                       \
  $SSP_DIR/metarefresh-edugain/saml20-idp-remote.php \
  $SSP_DIR/metarefresh-edugain/shib13-idp-remote.php \
  $SSP_DIR/metarefresh-edugain/attributeauthority-remote.php \
 && ln -s $SSP_DIR/metarefresh-edugain/saml20-idp-remote.php $SSP_DIR/metadata/metarefresh/saml20-idp-remote.php \
 && ln -s $SSP_DIR/metarefresh-edugain/shib13-idp-remote.php $SSP_DIR/metadata/metarefresh/shib13-idp-remote.php \
 && ln -s $SSP_DIR/metarefresh-edugain/attributeauthority-remote.php $SSP_DIR/metadata/metarefresh/attributeauthority-remote.php \
 && chown -R www-data:www-data $SSP_DIR/metarefresh-edugain

CMD ["apache2-foreground"]

EXPOSE 80
EXPOSE 443

COPY config/apache2/000-default.conf /etc/apache2/sites-available/000-default.conf
COPY config/apache2/mpm_prefork.conf /etc/apache2/mods-available/mpm_prefork.conf
COPY config/php/php.ini /usr/local/etc/php/php.ini
COPY config/cert/ $SSP_DIR/cert/
COPY config/config/ $SSP_DIR/config/
COPY config/metadata/ $SSP_DIR/metadata/
COPY modules/cyclone/ $SSP_DIR/modules/cyclone/

