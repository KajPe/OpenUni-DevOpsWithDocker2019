# Use Ubuntu as base image
FROM ubuntu:16.04

# Set frontend URL for cross-origin allowance
ENV FRONT_URL=http://localhost:5000

RUN apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates git curl \
    # Install nodejs
    && curl -sL https://deb.nodesource.com/setup_10.x | bash - \
    && apt-get install -y nodejs \
    # Clone frontend code
    && mkdir /app && cd /app \
    && git clone https://github.com/docker-hy/backend-example-docker.git backend \
    && cd backend \
    # Install modules
    && npm install \
    # Clean up
    && apt-get purge -y --auto-remove git curl \
    && rm -rf /var/lib/apt/lists/* \
    && npm cache clean --force \
    && cd /tmp && rm -rf * \
    #
    # Set ownership
    #
    && cd /app \
    # Create user www-data (if not exists)
    && id -u www-data >/dev/null 2>&1 || useradd -r www-data \
    # Make www-data owner of everything under /app
    && chown -R www-data:www-data * \
    # Set sticky bit on all under /app
    && chmod g+s .

# Run container as user www-data
USER www-data

# Expose port 8000 to host
EXPOSE 8000

# Change workdir to the the backend code
WORKDIR /app/backend

# Start the webserver
CMD [ "npm", "start" ]
