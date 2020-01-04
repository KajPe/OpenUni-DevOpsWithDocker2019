# Exercise 3.2

## Building image
<pre>
<b>$ docker build -t yledl .</b>
</pre>

## Usage
The docker container maps (-v) the containers /download folder to the host. The container
has an ENTRYPOINT to yle-dl so the url can be added as an argument to docker run command.
After the download the container is automatically removed (--rm).

For example podcast at https://areena.yle.fi/1-50198110 can be downloaded as following:
<pre>
<b>$ mkdir download</b>
<b>$ docker run --rm -v $(pwd)/download:/download yledl https://areena.yle.fi/1-50198110</b>
</pre>

Now when you check the download folder it will have the downloaded podcast.

## Image size
<pre>
<b>$ docker images yledl</b>
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
yledl               latest              e538ef80dd44        12 seconds ago      482MB

<b>$ docker history yledl</b>
IMAGE               CREATED             CREATED BY                                      SIZE                COMMENT
e538ef80dd44        27 seconds ago      /bin/sh -c #(nop)  ENTRYPOINT ["yle-dl"]        0B
13e05ac3504b        28 seconds ago      /bin/sh -c #(nop) WORKDIR /download             0B
78512d62a963        29 seconds ago      /bin/sh -c apt-get update   && apt-get insta…   362MB
5e13f8dd4c1a        5 months ago        /bin/sh -c #(nop)  CMD ["/bin/bash"]            0B
&lt;missing&gt;           5 months ago        /bin/sh -c mkdir -p /run/systemd && echo 'do…   7B
&lt;missing&gt;           5 months ago        /bin/sh -c set -xe   && echo '#!/bin/sh' &gt; /…   745B
&lt;missing&gt;           5 months ago        /bin/sh -c rm -rf /var/lib/apt/lists/*          0B
&lt;missing&gt;           5 months ago        /bin/sh -c #(nop) ADD file:603693e48cdc7f0c5…   120MB
</pre>
