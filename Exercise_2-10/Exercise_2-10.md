# Exercise 2.10

In backend Dockerfile we can see that an environment variable  - FRONT_URL - sets the frontend url.
We can find same kind of setup in the frontend Dockerfile for the backend url - API_URL.

As they are not used in the build prosess itself, but in the start of the container we dont need to
make any change in the Dockerfile's itself. All can be done in the <b>docker-compose.yml</b> by adding 
environment variables. The url's are set to reflect the nginx reverse proxy usage.

<pre>
    backend:
        environment:
        - FRONT_URL=http://localhost/

    frontend:  
        environment:
          - API_URL=http://localhost/api
</pre>

Before running create the logs.txt file and the folders
<pre>
<b>$ touch logs.txt</b>
<b>$ mkdir database</b>
<b>$ mkdir redisdata</b>
</pre>

Run it:
<pre>
<b>$ docker-compose up</b>
</pre>

With a browser open page http://localhost

