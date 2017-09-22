FROM php:7.0.4-fpm

RUN apt-get update && apt-get install -y libmcrypt-dev \
    unzip git mysql-client libmagickwand-dev --no-install-recommends \
    && pecl install imagick \
    && docker-php-ext-enable imagick \
    && docker-php-ext-install mcrypt pdo_mysql mbstring pcntl zip \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir /var/composer
WORKDIR /var/composer

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
&& php -r "if (hash_file('SHA1', 'composer-setup.php') === '43ac9d1da84cb7147ad7cf2b1796de8c2be51d5a') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
&& php composer-setup.php \
&& php -r "unlink('composer-setup.php');"
