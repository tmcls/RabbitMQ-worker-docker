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

# Install MySQL Connector
RUN docker-php-ext-install mysqli
   
# Install Composer
RUN apt-get update && \
    apt-get install curl nano && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install app dependencies
RUN composer install --no-interaction 

# Run worker
CMD [ "php", "./worker.php" ]
