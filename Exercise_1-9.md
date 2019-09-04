# Exercise 1.9

...

Pull the image
<pre>
<b>$ docker pull devopsdockeruh/ports_exercise</b>
Using default tag: latest
latest: Pulling from devopsdockeruh/ports_exercise
...
Status: Downloaded newer image for devopsdockeruh/ports_exercise:latest
docker.io/devopsdockeruh/ports_exercise:latest
</pre>

Next we start a container from the image and expose port 80 to the host as port 80.
<pre>
<b>$ docker run -d -p 80:80 devopsdockeruh/ports_exercise</b>
548e613cddd310e04ea58dff44a7c8a2c4f7eabe3cd5034184bb18f1d949ad6d
</pre>

Lets check what containers is running:
<pre>
<b>$ docker ps</b>
CONTAINER ID        IMAGE                           COMMAND             CREATED             STATUS              PORTS                NAMES
548e613cddd3        devopsdockeruh/ports_exercise   "npm start"         7 seconds ago       Up 3 seconds        0.0.0.0:80->80/tcp   relaxed_ardinghelli
</pre>

We can see that in ports we have mapped port 80 from host to port 80 inside container.

We can open a web-browser on the host and navigate to http://127.0.0.1:80 or make a curl request:
<pre>
<b>$ curl http://127.0.0.1:80</b>
Ports configured correctly!!
</pre>
