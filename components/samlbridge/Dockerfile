FROM php:apache

ENV APACHE_LOG_DIR=/var/log/apache2

RUN apt-get update && apt-get -y install \
    git  	        \
    wget 	        \
    re2c 	        \
    file 	        \
    cron 	        \
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
COPY config/cron/crontab.conf start.sh /var/

ARG commit=294c0363173cb60557909c4acd05ae877002b52e

RUN git clone https://github.com/simplesamlphp/simplesamlphp.git /var/simplesamlphp \
 && a2ensite 000-default   \
 && chmod +x /var/crontab.conf /var/start.sh \
 && crontab /var/crontab.conf     \
 && mkdir /var/simplesamlphp/data \
 && chown -R www-data:www-data /var/simplesamlphp/metadata /var/simplesamlphp/data \
 && touch                                       \
  /var/simplesamlphp/modules/cron/enable        \
  /var/simplesamlphp/modules/discopower/enable  \
  /var/simplesamlphp/modules/metarefresh/enable \
 && cd /var/simplesamlphp                       \
 && git checkout $commit                        \
 && wget https://getcomposer.org/installer      \
 && php installer                               \
 && php composer.phar install

CMD ["/var/start.sh"]

EXPOSE 80
EXPOSE 443

COPY config/cert/ /var/simplesamlphp/cert/
COPY config/config/ /var/simplesamlphp/config/
COPY config/metadata/ /var/simplesamlphp/metadata/
COPY modules/cyclone/ /var/simplesamlphp/modules/cyclone/
