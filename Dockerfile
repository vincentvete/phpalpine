FROM php:7.0.30-cli-alpine

RUN apk --repository http://dl-3.alpinelinux.org/alpine/edge/community/ \
  --repository http://dl-3.alpinelinux.org/alpine/edge/main/ \
  --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ \
  --update \
  add shadow \
  curl \
  zlib-dev \
  postgresql-dev \
  libjpeg-turbo-dev \
  libpng-dev \
  freetype-dev \
  openssl-dev \
  libmcrypt-dev \
  && docker-php-ext-install mcrypt pdo_mysql pdo_pgsql \
  && docker-php-ext-configure gd \
  --enable-gd-native-ttf \
  --with-png-dir=/usr/include/ \
  --with-jpeg-dir=/usr/include/ \
  --with-freetype-dir=/usr/include/ \
  && docker-php-ext-install gd \
  && apk del --purge make g++ autoconf libtool && \
  rm -rf /var/cache/apk/*

COPY localtime /etc/localtime

RUN apk --update add tzdata \
  && unlink /etc/localtime \
  && ln -s /usr/share/zoneinfo/Asia/Jakarta /etc/localtime