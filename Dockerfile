# Use Ubuntu as the base image
FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

# Install Apache, PHP, and additional extensions
RUN apt-get update && apt-get install -y \
    apache2 \
    php7.4 \
    php7.4-cli \
    php7.4-json \
    php7.4-common \
    php7.4-mysql \
    libapache2-mod-php7.4 \
    php7.4-mbstring \
    php7.4-curl \
    php7.4-gd \
    php7.4-zip \
    php7.4-dom \
    curl \
    unzip

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install Node.js
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get install -y nodejs

# Cleanup the cache created by apt install
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Enable Apache modules and set up Apache environment
#RUN a2enmod rewrite
#COPY ./000-default.conf /etc/apache2/sites-available/000-default.conf
RUN service apache2 restart

# Expose port 80 for Apache and port 3306 for MySQL
EXPOSE 80

# Set the container's working directory
WORKDIR /var/www/html

# Start Apache in the foreground
CMD ["apachectl", "-D", "FOREGROUND"]

