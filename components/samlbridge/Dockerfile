FROM php:apache

ENV APACHE_LOG_DIR=/var/log/apache2 \
    SSP_VERSION=1.14.6

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
 && mkdir -p /var/simplesamlphp /var/simplesamlphp/data /var/simplesamlphp/metarefresh-edugain /var/simplesamlphp/metadata/metarefresh \
 && tar -xvf simplesamlphp-$SSP_VERSION.tar.gz -C /var/simplesamlphp --strip-components=1 \
 && chown -R www-data:www-data /var/simplesamlphp/metadata /var/simplesamlphp/data /var/simplesamlphp/log \
 && rm /var/simplesamlphp/metadata/*.php        \
 && touch                                       \
  /var/simplesamlphp/modules/cron/enable        \
  /var/simplesamlphp/modules/discopower/enable  \
  /var/simplesamlphp/modules/metarefresh/enable \
  /etc/apache2/sites-available/000-default.conf \
  /var/simplesamlphp/metarefresh-edugain/saml20-idp-remote.php \
  /var/simplesamlphp/metarefresh-edugain/shib13-idp-remote.php \
  /var/simplesamlphp/metarefresh-edugain/attributeauthority-remote.php \
 && ln -s /var/simplesamlphp/metarefresh-edugain/saml20-idp-remote.php /var/simplesamlphp/metadata/metarefresh/saml20-idp-remote.php \
 && ln -s /var/simplesamlphp/metarefresh-edugain/shib13-idp-remote.php /var/simplesamlphp/metadata/metarefresh/shib13-idp-remote.php \
 && ln -s /var/simplesamlphp/metarefresh-edugain/attributeauthority-remote.php /var/simplesamlphp/metadata/metarefresh/attributeauthority-remote.php \
 && chown -R www-data:www-data /var/simplesamlphp/metarefresh-edugain \
 && a2ensite 000-default

CMD ["apache2-foreground"]

EXPOSE 80
EXPOSE 443

COPY config/apache2/000-default.conf /etc/apache2/sites-available/000-default.conf
COPY config/apache2/mpm_prefork.conf /etc/apache2/mods-available/mpm_prefork.conf
COPY config/php/php.ini /usr/local/etc/php/php.ini
COPY config/cert/ /var/simplesamlphp/cert/
COPY config/config/ /var/simplesamlphp/config/
COPY config/metadata/ /var/simplesamlphp/metadata/
COPY modules/cyclone/ /var/simplesamlphp/modules/cyclone/

