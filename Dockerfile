FROM ubuntu:16.04

ARG BUILD_DATE
ARG BUILD_VERSION 

LABEL org.label-schema.schema-version="1.0"	
LABEL org.label-schema.schema-url="http://label-schema.org/rc1/"	
LABEL org.label-schema.name="Ubuntu-Apache-PHP"
LABEL org.label-schema.author="Oliver Guo <oliverguo@outlook.com>"
LABEL org.label-schema.maintainer="Oliver Guo <oliverguo@outlook.com>"
LABEL org.label-schema.version="0.0.1"
LABEL org.label-schema.create-date="2018-12-25T13:11:04Z"
LABEL org.label-schema.build-version=$BUILD_VERSION
LABEL org.label-schema.build-date=$BUILD_DATE

RUN rm -rf /var/lib/apt/lists/*

RUN apt-get update \
&& apt-get -y install \
		nano \
		net-tools \
		iputils-ping \
		openssl \
		apache2 \
		php7.0 \
		libapache2-mod-php7.0 \
		php7.0-mysql \
		php7.0-curl \
		php7.0-gd \
		php7.0-intl \
		php7.0-imap \
		php7.0-mcrypt \
		php7.0-pspell \
		php7.0-recode \
		php7.0-sqlite3 \
		php7.0-tidy \
		php7.0-xmlrpc \
		php7.0-xsl \
		php7.0-mbstring \
		php-imagick \
		php-memcache \
		php-pear \
		php-gettext \
		php-apcu \
		--no-install-recommends \
&& rm -rf /var/lib/apt/lists/*

RUN mkdir /var/ssl && cd /var/ssl \
&& openssl req -x509 -newkey rsa:4096 \
  -subj "/C=HK/ST=HongKong/L=HongKong/O=Demo/CN=localhost" \
  -keyout "/var/ssl/key.pem" \
  -out "/var/ssl/cert.pem" \
  -days 3650 -nodes -sha256
    
RUN a2enmod rewrite
RUN a2enmod ssl rewrite 
RUN a2ensite default-ssl 

COPY ./default.conf /etc/apache2/sites-enabled/default.conf
COPY ./default-ssl.conf /etc/apache2/sites-enabled/default-ssl.conf

RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

RUN service apache2 restart

RUN apt-get autoclean
RUN apt-get clean
RUN apt-get autoremove
RUN rm -rf /tmp/*

ENTRYPOINT ["apache2ctl", "-D", "FOREGROUND"]
