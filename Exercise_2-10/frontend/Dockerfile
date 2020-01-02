# Use node image as base
FROM node

# Set backend api URL
ENV API_URL=http://localhost:8000

# /app as main directory
WORKDIR /app

# Option 1 : Get frontend code directly from github
RUN git clone https://github.com/docker-hy/frontend-example-docker.git frontend

# Option 2 : Copy frontend code from host
# COPY frontend-example-docker/ frontend/

# Change workdir to the the frontend code
WORKDIR /app/frontend

# Install modules and build production code
RUN npm install && npm run build

# Expose port 5000 to host
EXPOSE 5000

# Start the webserver
CMD [ "npm", "start" ]
