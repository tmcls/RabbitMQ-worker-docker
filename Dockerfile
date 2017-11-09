FROM php:7.0-cli

RUN docker-php-ext-install mysqli

RUN apt-get install -y librabbitmq-dev \
    && pecl install amqp \
    && docker-php-ext-enable amqp

CMD [ "php", "./worker.php" ]
