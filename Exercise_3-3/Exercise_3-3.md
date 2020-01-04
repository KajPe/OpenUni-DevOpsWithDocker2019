# Exercise 3.3

## Run containers as non-root
Both containers - frontend and backend - uses the same setup to run as non-root user.

By default user <b>www-data</b> is already created so it's checked if it exists before creating.

Everything under /app has ownership changed to www-data. Also any folder under /app has
it's sticky bit set, so any file created or changed under /app is owned by www-data.
After the setup, the <b>USER www-data</b> changes the container to bootup with user www-data.

## Build and Run

<pre>
<b>$ touch logs.txt</b>
<b>$ docker-compose up</b>
</pre>

Opening another terminal and checking with <b>docker ps</b> we can see the two running containers -
back and front. We can exec into the containers and check the running user.
<pre>
<b>$ docker exec -it back bash</b>
<b>$$ whoami</b>
 www-data
<b>$$ exit</b>

<b>$ docker exec -it front bash</b>
<b>$$ whoami</b>
 www-data
<b>$$ exit</b>
</pre>
