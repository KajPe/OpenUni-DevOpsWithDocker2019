# Use node image as base
FROM node

# /app as main directory
WORKDIR /app

# Option 1 : Get backend code directly from github
RUN git clone https://github.com/docker-hy/backend-example-docker.git backend

# Option 2 : Copy backend code from host
# COPY backend-example-docker/ backend/

# Change workdir to the the backend code
WORKDIR /app/backend

# Install modules
RUN npm install

# Expose port 8000 to host
EXPOSE 8000

# Start the webserver
CMD [ "npm", "start" ]
