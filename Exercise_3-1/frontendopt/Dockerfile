# Use Ubuntu as base image
FROM ubuntu:16.04

# Set backend api URL
ENV API_URL=http://localhost:8000

RUN apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates git curl \
    # Install nodejs
    && curl -sL https://deb.nodesource.com/setup_10.x | bash - \
    && apt-get install -y nodejs \
    # Clone frontend code
    && mkdir /app && cd /app \
    && git clone https://github.com/docker-hy/frontend-example-docker.git frontend \
    && cd frontend \
    # Install modules and build production code
    && npm install && npm run build \
    # Clean up
    && apt-get purge -y --auto-remove git curl \
    && rm -rf /var/lib/apt/lists/* \
    && npm cache clean --force \
    && cd /tmp && rm -rf *

# Expose port 5000 to host
EXPOSE 5000

# Change workdir to the the frontend code
WORKDIR /app/frontend

# Start the webserver
CMD [ "npm", "start" ]
