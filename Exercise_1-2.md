# Exercise 1.2

* We’ve left containers and a image that won’t be used anymore and are taking space, 
  as docker ps -a and docker images will reveal. Clean the docker daemon from all images and containers.
* Prove that you have completed this part of exercise by delivering the output for docker ps -a and docker images

## Output
### Containers cleanup
Check the status of the containers:
<pre>
<b>$ docker ps -a</b>
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS                      PORTS               NAMES
4a8d09e1cf4e        nginx               "nginx -g 'daemon of…"   28 minutes ago      Exited (0) 21 minutes ago                       sweet_neumann
05163245be72        nginx               "nginx -g 'daemon of…"   28 minutes ago      Up 28 minutes               80/tcp              musing_kalam
d3b91c9d1467        nginx               "nginx -g 'daemon of…"   28 minutes ago      Exited (0) 21 minutes ago                       frosty_merkle
</pre>

We have two stopped containers **4a8d09e1cf4e** and **d3b91c9d1467** which we will remove.
<pre>
<b>$ docker rm 4a8d09e1cf4e</b>
4a8d09e1cf4e
<b>$ docker rm d3b91c9d1467</b>
d3b91c9d1467
</pre>

Check the status of the containers:
<pre>
<b>$ docker ps -a</b>
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS               NAMES
05163245be72        nginx               "nginx -g 'daemon of…"   35 minutes ago      Up 34 minutes       80/tcp              musing_kalam
</pre>
Now we have only one container as we removed the stopped ones.

### Images cleanup

Check what images we have:
<pre>
<b>$ docker images</b>
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
nginx               latest              5a3221f0137b        2 weeks ago         126MB
hello-world         latest              fce289e99eb9        8 months ago        1.84kB
</pre>

As **hello-world** image is not used, lets remove it.
<pre>
<b>$ docker rmi hello-world</b>
Untagged: hello-world:latest
Untagged: hello-world@sha256:451ce787d12369c5df2a32c85e5a03d52cbcef6eb3586dd03075f3034f10adcd
Deleted: sha256:fce289e99eb9bca977dae136fbe2a82b6b7d4c372474c9235adc1741675f587e
Deleted: sha256:af0b15c8625bb1938f1d7b17081031f649fd14e6b233688eea3c5483994a66a3
</pre>

List images to check it was removed:
<pre>
<b>$ docker images</b>
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
nginx               latest              5a3221f0137b        2 weeks ago         126MB
</pre>

**hello-world** image was removed.
