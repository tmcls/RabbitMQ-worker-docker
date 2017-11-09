FROM php:7.0-cli
MAINTAINER Tom Claus <mail@tomclaus.be>

# Install Mysqli
RUN docker-php-ext-install mysqli
   
# Install dependencies // Composer
RUN apt-get update && \
    apt-get install curl nano && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Workdir
ADD . /app
WORKDIR /app

# Install app dependencies
RUN composer install --no-interaction 

# Run worker
CMD [ "php", "./worker.php" ]
