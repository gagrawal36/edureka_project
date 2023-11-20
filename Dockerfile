# Use an official PHP runtime as a base image
FROM php:7.4-apache

# Set the working directory to /var/www/html
WORKDIR /var/www/html

# Copy the current directory contents into the container at /var/www/html
COPY . /var/www/html

# Set correct permissions for the copied files
RUN chown -R www-data:www-data /var/www/html

# Install any dependencies your PHP application might need
# For example, you might need to install additional PHP extensions or libraries here

# Expose port 80 to the outside world
EXPOSE 80

# Define environment variables, if needed
# ENV VARIABLE_NAME value

# Start Apache when the container runs
CMD ["apache2-foreground"]