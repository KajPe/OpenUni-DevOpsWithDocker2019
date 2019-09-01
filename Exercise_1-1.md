# Exercise 1.1

* Start 3 containers from image that does not automatically exit, such as nginx, detached.  
* Stop 2 of the containers leaving 1 up.  
* Prove that you have completed this part of exercise by delivering the output for docker ps -a.  

## Output
Check if any containers exist (running or stopped):
<pre>
<b>$ docker ps -a</b>
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
</pre>

Start three nginx containers:
<pre>
<b>$ docker run -d nginx</b>
d3b91c9d1467c89ca3382838170f25ca60a7e3ad480e98786c64df3647fdbeba
<b>$ docker run -d nginx</b>
05163245be72600f65c01e2308ee1acbfb5c536b2e93b6afa864adf6c5114317
<b>$ docker run -d nginx</b>
4a8d09e1cf4e8dd1be53130803215330b614a9bca31d421a4be225d1f5f34229
</pre>

Check the status of the containers:
<pre>
<b>$ docker ps -a</b>
CONTAINER ID        IMAGE               COMMAND                  CREATED              STATUS              PORTS               NAMES
4a8d09e1cf4e        nginx               "nginx -g 'daemon of…"   About a minute ago   Up About a minute   80/tcp              sweet_neumann
05163245be72        nginx               "nginx -g 'daemon of…"   About a minute ago   Up About a minute   80/tcp              musing_kalam
d3b91c9d1467        nginx               "nginx -g 'daemon of…"   About a minute ago   Up About a minute   80/tcp              frosty_merkle
</pre>
The image is **nginx** and all have status **Up** which means they are running.
  
  
Stop two containers:
<pre>
<b>$ docker stop 4a8d09e1cf4e</b>                           # Using long id
4a8d09e1cf4e
<b>$ docker stop d3b</b>                                    # Using shorter id which matches one container
d3b
</pre>

Check the status of the containers:
<pre>
<b>$ docker ps -a</b>
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS                          PORTS               NAMES
4a8d09e1cf4e        nginx               "nginx -g 'daemon of…"   7 minutes ago       Exited (0) About a minute ago                       sweet_neumann
05163245be72        nginx               "nginx -g 'daemon of…"   8 minutes ago       Up 7 minutes                    80/tcp              musing_kalam
d3b91c9d1467        nginx               "nginx -g 'daemon of…"   8 minutes ago       Exited (0) About a minute ago                       frosty_merkle
</pre>

Checking status we see that one if still running (Up) and two has been stopped (Exited) as expected.
