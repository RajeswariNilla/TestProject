# Use an official Ubuntu base image
FROM ubuntu:latest

# Set non-interactive mode for tzdata (prevents prompt during install)
ENV DEBIAN_FRONTEND=noninteractive

# Update package lists and install tzdata and apache2
RUN apt-get update && \
    apt-get install -y tzdata apache2 && \
    apt-get clean

# Copy your custom HTML file to Apache's root directory
ADD index.html /var/www/html/

# Set an environment variable
ENV name=Rajitechsight

# Expose port 80
EXPOSE 80

# Start Apache in the foreground
ENTRYPOINT ["apachectl", "-D", "FOREGROUND"]
