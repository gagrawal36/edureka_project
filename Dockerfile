# Use an official PHP runtime as a base image
FROM php:7.4-apache

# Set the working directory to /var/www/html
WORKDIR /var/www/html

# Install any dependencies your PHP application might need
# For example, you might need to install additional PHP extensions or libraries here

# Expose port 80 to the outside world
EXPOSE 80

# Define environment variables, if needed
# ENV VARIABLE_NAME value

# Start Apache when the container runs
CMD ["apache2-foreground"]

# Update Apache configuration
#RUN sed -ri -e 's!/var/www/html!/var/www/html!g' /etc/apache2/sites-available/*.conf
#RUN echo "DirectoryIndex index.php" >> /etc/apache2/apache2.conf

# Set correct file permissions
#RUN chown -R www-data:www-data /var/www/html

# If you want to use apache2.conf from your host, copy it
#COPY apache2.conf /etc/apache2/apache2.conf
