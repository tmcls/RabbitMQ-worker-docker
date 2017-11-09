FROM php:7.0-cli

# Install Mysqli
RUN docker-php-ext-install mysqli

# Install Libs
RUN apt-get install -y librabbitmq-dev \
    && pecl install amqp \
    && docker-php-ext-enable amqp
    
# Install dependencies
RUN apt-get update && \
    apt-get install curl nano && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Volumes
VOLUME [" www/app", "vikingdeals_app" ]

# Install app dependencies
RUN composer install --no-interaction 

# Run worker
CMD [ "php", "./worker.php" ]
