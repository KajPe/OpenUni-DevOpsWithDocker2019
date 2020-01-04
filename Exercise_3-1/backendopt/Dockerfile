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
    && cd /tmp && rm -rf *

# Expose port 8000 to host
EXPOSE 8000

# Change workdir to the the backend code
WORKDIR /app/backend

# Start the webserver
CMD [ "npm", "start" ]
