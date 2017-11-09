FROM php:7.0-cli
MAINTAINER Tom Claus <mail@tomclaus.be>

# RabbitMQ Environment Vars
ENV RABBITMQ_HOST='127.0.0.1'
ENV RABBITMQ_PORT='5672'
ENV RABBITMQ_USERNAME='guest'
ENV RABBITMQ_PASSWORD='guest'
ENV RABBITMQ_PASSWORD='task_queue'

# Workdir
ADD . /app
WORKDIR /app

# Install PHP Extensions
RUN docker-php-ext-install mcrypt zip bcmath pdo_mysql mysql mysqli mbstring opcache soap
   
# Install Composer
RUN apt-get update && \
    apt-get install -y --no-install-recommends git zip

RUN curl --silent --show-error https://getcomposer.org/installer | php

# Install app dependencies
RUN php composer.phar install --no-interaction 

# Run worker
CMD [ "php", "./worker.php" ]
