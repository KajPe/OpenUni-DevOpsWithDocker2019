# Exercise 1.11

...


## The Dockerfile

Use node image as base
> FROM node

/app as work directory
> WORKDIR /app

We have two options:
* Make a git clone inside the image
* Copy the backend from the host to the image

Option 1 : Get backend code directly from github
> RUN git clone https://github.com/docker-hy/backend-example-docker.git backend

Option 2 : Copy backend code from host
> COPY backend-example-docker/ backend/

Change workdir to the the backend code
> WORKDIR /app/backend

Install modules
> RUN npm install

Expose port 8000 to host
> EXPOSE 8000

Start the webserver
> CMD [ "npm", "start" ]

## Building the image
> $ docker build -t mybackend .

## Starting the container
* Map port 8000 inside container
* Map file logs.txt in host inside container

Create an empty log file for first run
> $ touch logs.txt

Start the container from the image (named as backend)
> $ docker run --name backend -p 8000:8000 -v $(pwd)/logs.txt:/app/backend/logs.txt mybackend

When the container shows the info line
> Started on port 8000

we can with a browser navigate to http://localhost:8000 and see the message
> **Port configured correctly, generated message in logs.txt**

If we now open a new terminal and check the logs.txt file on the docker host itself
> $ cat logs.txt

We can see a line as 
> 9/5/2019, 6:21:54 PM: Connection received in root

Every time we refresh the browser window a new line will appear in the log.

When the container is stopped with CTRL + C the logs.txt file stays on the host. When the
container is started again with
> $ docker start backend

we can again check that logs.txt kept the existing lines and every refresh in the browser
add's a new line to the log.
