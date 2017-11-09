FROM php:7.0-cli

RUN docker-php-ext-install mysqli

WORKDIR /app

CMD [ "php", "./worker.php" ]
