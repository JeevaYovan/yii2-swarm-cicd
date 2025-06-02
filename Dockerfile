# Base Image of PHP
FROM php:7.4-fpm

# Install dependencies
RUN apt-get update && apt-get install -y \
    nginx \
    git \
    && rm -rf /var/lib/apt/lists/*

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Copy application code
COPY . /var/www/html

# Set working directory for Docker to listen
WORKDIR /var/www/html

# Install Yii2 dependencies
RUN composer install --no-interaction

# Configure NGINX as a Reverse Proxy
COPY nginx.conf /etc/nginx/sites-available/default

# Expose port 80
EXPOSE 80

# Start NGINX and PHP-FPM from the startup script
COPY start.sh /start.sh
RUN chmod +x /start.sh
CMD ["/start.sh"]
